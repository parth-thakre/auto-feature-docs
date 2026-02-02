#!/bin/bash
# AI Dev Commands - Auto Installer
# Usage: ./install.sh [tool] [destination]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
TOOL=${1:-opencode}
DEST=${2:-}

# Tool configurations
declare -A TOOL_CONFIGS=(
    ["opencode"]=".opencode/commands"
    ["claude-code"]=".claude/commands"
    ["claude"]=".claude/commands"
)

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Function to show usage
show_usage() {
    cat << EOF
AI Dev Commands Installer

Usage: ./install.sh [tool] [destination]

Arguments:
  tool         AI tool to install for (default: opencode)
               Options: opencode, claude-code
  destination  Custom installation path (optional)

Examples:
  ./install.sh                    # Install for OpenCode
  ./install.sh claude-code        # Install for Claude Code
  ./install.sh opencode ./custom  # Install to custom path

EOF
}

# Function to validate tool
validate_tool() {
    local tool=$1
    if [[ -z "${TOOL_CONFIGS[$tool]}" ]]; then
        print_error "Unknown tool: $tool"
        echo ""
        echo "Supported tools:"
        for t in "${!TOOL_CONFIGS[@]}"; do
            echo "  - $t"
        done
        echo ""
        show_usage
        exit 1
    fi
}

# Function to get source directory
get_source_dir() {
    local tool=$1
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    echo "$script_dir/commands/$tool"
}

# Function to get destination directory
get_destination() {
    local tool=$1
    local custom_dest=$2
    
    if [[ -n "$custom_dest" ]]; then
        echo "$custom_dest"
    else
        echo "${TOOL_CONFIGS[$tool]}"
    fi
}

# Function to count commands
count_commands() {
    local source_dir=$1
    local count=$(find "$source_dir" -name "*.md" -type f 2>/dev/null | wc -l)
    echo "$count"
}

# Function to install commands
install_commands() {
    local tool=$1
    local dest=$2
    local source_dir=$(get_source_dir "$tool")
    
    # Check if source directory exists
    if [[ ! -d "$source_dir" ]]; then
        print_error "Source directory not found: $source_dir"
        print_status "Make sure you're running this from the ai-dev-commands repository root"
        exit 1
    fi
    
    # Count available commands
    local cmd_count=$(count_commands "$source_dir")
    
    if [[ $cmd_count -eq 0 ]]; then
        print_warning "No commands found for $tool"
        exit 0
    fi
    
    # Create destination directory
    print_status "Creating directory: $dest"
    mkdir -p "$dest"
    
    # Copy commands
    print_status "Installing $cmd_count command(s) for $tool..."
    cp "$source_dir"/*.md "$dest/"
    
    # Verify installation
    local installed_count=$(count_commands "$dest")
    
    if [[ $installed_count -eq $cmd_count ]]; then
        print_success "Successfully installed $installed_count command(s) to $dest"
        echo ""
        echo "Installed commands:"
        ls -1 "$dest"/*.md | xargs -n1 basename | sed 's/^/  - /'
    else
        print_error "Installation incomplete. Expected $cmd_count, found $installed_count"
        exit 1
    fi
}

# Function to show next steps
show_next_steps() {
    local tool=$1
    local dest=$2
    
    echo ""
    print_status "Next steps:"
    echo ""
    
    case $tool in
        opencode)
            echo "  1. Open your project in OpenCode"
            echo "  2. Type / to see available commands"
            echo "  3. Run /save-feature to test"
            ;;
        claude-code|claude)
            echo "  1. Open your project in Claude Code"
            echo "  2. Type / to see available commands"
            echo "  3. Run /save-feature to test"
            ;;
    esac
    
    echo ""
    echo "  Commands installed at: $dest"
    echo ""
}

# Main execution
main() {
    # Show help if requested
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        show_usage
        exit 0
    fi
    
    print_status "AI Dev Commands Installer"
    print_status "========================"
    echo ""
    
    # Validate tool
    validate_tool "$TOOL"
    
    # Get destination
    DEST=$(get_destination "$TOOL" "$DEST")
    
    print_status "Tool: $TOOL"
    print_status "Destination: $DEST"
    echo ""
    
    # Confirm installation
    if [[ -d "$DEST" ]]; then
        print_warning "Directory already exists: $DEST"
        read -p "Continue and overwrite existing commands? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_status "Installation cancelled"
            exit 0
        fi
    fi
    
    # Install commands
    install_commands "$TOOL" "$DEST"
    
    # Show next steps
    show_next_steps "$TOOL" "$DEST"
    
    print_success "Installation complete! 🎉"
}

# Run main function
main "$@"
