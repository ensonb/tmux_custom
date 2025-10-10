#!/bin/bash

# ==============================================================================
# TMUX_CUSTOM - Complete Tmux Customization Script
# Repository: https://github.com/ensonb/tmux_custom
# For Debian-based systems (Ubuntu, Pop!_OS, Debian, Mint, etc.)
# ==============================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Print functions
print_status() { echo -e "${GREEN}[✓]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[!]${NC} $1"; }
print_error() { echo -e "${RED}[✗]${NC} $1"; }
print_header() { echo -e "${BLUE}$1${NC}"; }
print_info() { echo -e "${CYAN}[i]${NC} $1"; }

# Backup existing configuration
backup_tmux_config() {
    print_header "=== Backing up existing tmux configuration ==="
    
    if [[ -f ~/.tmux.conf ]]; then
        BACKUP_FILE="$HOME/.tmux.conf.backup.$(date +%Y%m%d_%H%M%S)"
        cp ~/.tmux.conf "$BACKUP_FILE"
        print_status "Backed up existing .tmux.conf to $BACKUP_FILE"
    fi
    
    if [[ -d ~/.tmux ]]; then
        BACKUP_DIR="$HOME/.tmux.backup.$(date +%Y%m%d_%H%M%S)"
        mv ~/.tmux "$BACKUP_DIR"
        print_status "Backed up existing .tmux directory to $BACKUP_DIR"
    fi
}

# Install tmux and dependencies
install_dependencies() {
    print_header "=== Installing tmux and dependencies ==="
    
    print_info "Updating package list..."
    sudo apt update
    
    print_info "Installing required packages..."
    sudo apt install -y \
        tmux \
        git \
        curl \
        xclip \
        powerline \
        fonts-powerline \
        build-essential \
        pkg-config \
        libevent-dev \
        libncurses5-dev \
        bison
    
    print_status "All dependencies installed"
}

# Install TPM (Tmux Plugin Manager)
install_tpm() {
    print_header "=== Installing Tmux Plugin Manager (TPM) ==="
    
    if [[ -d ~/.tmux/plugins/tpm ]]; then
        print_warning "TPM already installed, updating..."
        cd ~/.tmux/plugins/tpm && git pull
    else
        print_info "Cloning TPM repository..."
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
        print_status "TPM installed successfully"
    fi
}

# Create custom tmux configuration
create_tmux_config() {
    print_header "=== Creating custom tmux configuration ==="
    
    cat > ~/.tmux.conf << 'TMUXCONF'
# ==============================================================================
# TMUX CONFIGURATION - Fully Customized for Linux
# ==============================================================================

# ==============================================================================
# GENERAL SETTINGS
# ==============================================================================

# Set true color support
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",xterm-256color:Tc"

# Enable mouse support
set -g mouse on

# Set scrollback buffer size
set -g history-limit 50000

# Start windows and panes at 1, not 0
set -g base-index 1
setw -g pane-base-index 1

# Renumber windows when one is closed
set -g renumber-windows on

# Set escape time to 0 for faster command sequences
set -sg escape-time 0

# Focus events enabled for terminals that support them
set -g focus-events on

# Aggressive resize
setw -g aggressive-resize on

# Enable clipboard
set -g set-clipboard on

# ==============================================================================
# KEY BINDINGS
# ==============================================================================

# Change prefix from Ctrl+b to Ctrl+a (more ergonomic)
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# Reload configuration
bind r source-file ~/.tmux.conf \; display "Configuration reloaded!"

# Split panes using | and -
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"
unbind '"'
unbind %

# Create new window in current path
bind c new-window -c "#{pane_current_path}"

# Switch panes using Alt-arrow without prefix
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

# Switch panes using vim keys
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# Resize panes using vim keys
bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5

# Toggle pane zoom
bind -r z resize-pane -Z

# Kill pane without confirmation
bind x kill-pane

# Kill window without confirmation
bind X kill-window

# Toggle mouse mode
bind m set -g mouse \; display "Mouse mode toggled"

# Synchronize panes toggle
bind s setw synchronize-panes \; display "Synchronize panes toggled"

# ==============================================================================
# COPY MODE (VI STYLE)
# ==============================================================================

# Use vi mode
setw -g mode-keys vi

# Enter copy mode
bind Escape copy-mode

# Copy mode vim bindings
bind -T copy-mode-vi v send-keys -X begin-selection
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -selection clipboard"
bind -T copy-mode-vi r send-keys -X rectangle-toggle

# Paste
bind p paste-buffer

# ==============================================================================
# VISUAL SETTINGS
# ==============================================================================

# Pane borders
set -g pane-border-style fg=colour238
set -g pane-active-border-style fg=colour39

# Message style
set -g message-style bg=colour235,fg=colour166

# Window status style
setw -g window-status-style fg=colour244,bg=default
setw -g window-status-current-style fg=colour166,bg=default,bold

# ==============================================================================
# STATUS BAR
# ==============================================================================

# Status bar position
set -g status-position bottom

# Status bar colors
set -g status-style bg=colour235,fg=colour137

# Status bar length
set -g status-left-length 40
set -g status-right-length 100

# Status bar refresh interval
set -g status-interval 5

# Left status: Session name
set -g status-left "#[fg=colour232,bg=colour39,bold] #S #[fg=colour39,bg=colour235,nobold]"

# Right status: Date, time, hostname, load average
set -g status-right "#[fg=colour244]%Y-%m-%d #[fg=colour39,bold]%H:%M #[fg=colour244]| #[fg=colour166]#h #[fg=colour244]| #[fg=colour39]Load: #(cat /proc/loadavg | cut -d' ' -f1-3)"

# Window status format
setw -g window-status-format " #I:#W "
setw -g window-status-current-format "#[fg=colour235,bg=colour39]#[fg=colour232,bg=colour39,bold] #I:#W #[fg=colour39,bg=colour235,nobold]"

# Activity monitoring
setw -g monitor-activity on
set -g visual-activity off

# ==============================================================================
# TMUX PLUGIN MANAGER (TPM)
# ==============================================================================

# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'
set -g @plugin 'tmux-plugins/tmux-yank'
set -g @plugin 'tmux-plugins/tmux-copycat'
set -g @plugin 'tmux-plugins/tmux-open'
set -g @plugin 'tmux-plugins/tmux-cpu'

# Plugin settings
set -g @resurrect-strategy-vim 'session'
set -g @resurrect-capture-pane-contents 'on'
set -g @continuum-restore 'on'
set -g @continuum-save-interval '15'

# CPU plugin in status bar
set -g status-right "#{cpu_bg_color} CPU: #{cpu_percentage} | #{ram_bg_color} RAM: #{ram_percentage} #[fg=colour244]| %Y-%m-%d #[fg=colour39,bold]%H:%M #[fg=colour244]| #[fg=colour166]#h"

# Initialize TMUX plugin manager (keep this line at the very bottom)
run '~/.tmux/plugins/tpm/tpm'

# ==============================================================================
# END OF CONFIGURATION
# ==============================================================================
TMUXCONF

    print_status "Custom tmux configuration created at ~/.tmux.conf"
}

# Create tmux local customization file
create_local_config() {
    print_header "=== Creating local customization file ==="
    
    cat > ~/.tmux.conf.local << 'LOCALCONF'
# ==============================================================================
# TMUX LOCAL CUSTOMIZATION
# Add your personal customizations here
# This file won't be overwritten by updates
# ==============================================================================

# Example: Change prefix key
# unbind C-a
# set -g prefix C-b
# bind C-b send-prefix

# Example: Custom status bar colors
# set -g status-style bg=colour234,fg=colour137

# Example: Additional key bindings
# bind Space last-window

# Your customizations below:
LOCALCONF

    print_status "Local customization file created at ~/.tmux.conf.local"
    
    # Source local config in main config
    echo "" >> ~/.tmux.conf
    echo "# Source local customizations" >> ~/.tmux.conf
    echo "source-file ~/.tmux.conf.local" >> ~/.tmux.conf
}

# Install plugins using TPM
install_plugins() {
    print_header "=== Installing tmux plugins ==="
    
    print_info "Starting tmux server and installing plugins..."
    
    # Start tmux server if not running
    if ! tmux info &> /dev/null; then
        tmux start-server
    fi
    
    # Install plugins
    ~/.tmux/plugins/tpm/scripts/install_plugins.sh
    
    print_status "Plugins installed successfully"
}

# Setup clipboard integration
setup_clipboard() {
    print_header "=== Setting up clipboard integration ==="
    
    # Check if xclip is installed
    if command -v xclip &> /dev/null; then
        print_status "xclip is installed and configured"
    else
        print_warning "xclip not found, installing..."
        sudo apt install -y xclip
    fi
    
    # Create clipboard helper script
    mkdir -p ~/.local/bin
    
    cat > ~/.local/bin/tmux-clipboard << 'CLIPSCRIPT'
#!/bin/bash
# Tmux clipboard helper script
if command -v xclip &> /dev/null; then
    xclip -selection clipboard "$@"
else
    cat "$@"
fi
CLIPSCRIPT
    
    chmod +x ~/.local/bin/tmux-clipboard
    print_status "Clipboard integration configured"
}

# Create quick reference guide
create_reference_guide() {
    print_header "=== Creating quick reference guide ==="
    
    cat > ~/tmux-reference.sh << 'REFGUIDE'
#!/bin/bash

echo "======================================================================="
echo "                    TMUX QUICK REFERENCE GUIDE"
echo "======================================================================="
echo ""
echo "PREFIX KEY: Ctrl+a (changed from default Ctrl+b)"
echo ""
echo "=== SESSION MANAGEMENT ==="
echo "  tmux                    - Start new session"
echo "  tmux new -s <name>      - Start named session"
echo "  tmux a                  - Attach to last session"
echo "  tmux a -t <name>        - Attach to named session"
echo "  tmux ls                 - List sessions"
echo "  tmux kill-session -t <name> - Kill named session"
echo "  Ctrl+a d                - Detach from session"
echo "  Ctrl+a (                - Previous session"
echo "  Ctrl+a )                - Next session"
echo "  Ctrl+a s                - Show session list"
echo ""
echo "=== WINDOW MANAGEMENT ==="
echo "  Ctrl+a c                - Create new window"
echo "  Ctrl+a n                - Next window"
echo "  Ctrl+a p                - Previous window"
echo "  Ctrl+a 0-9              - Switch to window number"
echo "  Ctrl+a ,                - Rename window"
echo "  Ctrl+a X                - Kill window (no confirmation)"
echo "  Ctrl+a f                - Find window"
echo "  Ctrl+a w                - List windows"
echo ""
echo "=== PANE MANAGEMENT ==="
echo "  Ctrl+a |                - Split vertically"
echo "  Ctrl+a -                - Split horizontally"
echo "  Ctrl+a h/j/k/l          - Navigate panes (vim style)"
echo "  Alt+Arrow               - Navigate panes (no prefix needed)"
echo "  Ctrl+a H/J/K/L          - Resize panes"
echo "  Ctrl+a z                - Toggle pane zoom"
echo "  Ctrl+a x                - Kill pane (no confirmation)"
echo "  Ctrl+a s                - Toggle synchronize panes"
echo ""
echo "=== COPY MODE (VI STYLE) ==="
echo "  Ctrl+a Esc              - Enter copy mode"
echo "  v                       - Begin selection"
echo "  y                       - Copy selection (to clipboard)"
echo "  r                       - Rectangle toggle"
echo "  Ctrl+a p                - Paste"
echo "  q                       - Exit copy mode"
echo ""
echo "=== MOUSE MODE ==="
echo "  Ctrl+a m                - Toggle mouse mode"
echo "  Mouse Features:"
echo "    • Click to switch panes/windows"
echo "    • Scroll to navigate history"
echo "    • Drag borders to resize panes"
echo "    • Select text to copy"
echo ""
echo "=== PLUGINS & FEATURES ==="
echo "  Ctrl+a I                - Install plugins"
echo "  Ctrl+a U                - Update plugins"
echo "  Ctrl+a alt+u            - Uninstall plugins"
echo ""
echo "  tmux-resurrect:"
echo "    Ctrl+a Ctrl+s         - Save session"
echo "    Ctrl+a Ctrl+r         - Restore session"
echo ""
echo "  tmux-copycat:"
echo "    Ctrl+a /              - Search"
echo "    Ctrl+a Ctrl+f         - File search"
echo "    Ctrl+a Ctrl+u         - URL search"
echo ""
echo "=== CONFIGURATION ==="
echo "  Ctrl+a r                - Reload configuration"
echo "  vim ~/.tmux.conf        - Edit main config"
echo "  vim ~/.tmux.conf.local  - Edit local config"
echo ""
echo "=== SYSTEM INFO IN STATUS BAR ==="
echo "  • CPU usage and percentage"
echo "  • RAM usage and percentage"
echo "  • Load average (1, 5, 15 min)"
echo "  • Current date and time"
echo "  • Hostname"
echo "  • Session name"
echo ""
echo "======================================================================="
echo "For more help, visit: https://github.com/tmux/tmux/wiki"
echo "======================================================================="
REFGUIDE
    
    chmod +x ~/tmux-reference.sh
    print_status "Quick reference guide created at ~/tmux-reference.sh"
}

# Create useful aliases
create_aliases() {
    print_header "=== Creating tmux aliases ==="
    
    SHELL_RC="$HOME/.bashrc"
    if [[ -f "$HOME/.zshrc" ]]; then
        SHELL_RC="$HOME/.zshrc"
    fi
    
    if ! grep -q "# Tmux Aliases" "$SHELL_RC"; then
        cat >> "$SHELL_RC" << 'ALIASES'

# Tmux Aliases
alias t='tmux'
alias ta='tmux attach'
alias tat='tmux attach -t'
alias tn='tmux new -s'
alias tl='tmux list-sessions'
alias tk='tmux kill-session -t'
alias tmux-reload='tmux source-file ~/.tmux.conf'
alias tmux-help='~/tmux-reference.sh'
ALIASES
        print_status "Aliases added to $SHELL_RC"
    else
        print_status "Aliases already exist"
    fi
}

# Main installation function
main() {
    print_header "======================================================================="
    print_header "           TMUX COMPLETE CUSTOMIZATION SCRIPT"
    print_header "              For Debian-based Linux Systems"
    print_header "======================================================================="
    echo ""
    
    echo -e "${CYAN}This script will:${NC}"
    echo "  • Install tmux and all dependencies"
    echo "  • Install Tmux Plugin Manager (TPM)"
    echo "  • Create fully customized tmux configuration"
    echo "  • Setup useful plugins (resurrect, continuum, yank, etc.)"
    echo "  • Configure clipboard integration"
    echo "  • Add helpful aliases and reference guide"
    echo ""
    
    read -p "Continue with installation? (y/N): " -n 1 -r
    echo ""
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_status "Installation cancelled."
        exit 0
    fi
    
    echo ""
    backup_tmux_config
    echo ""
    install_dependencies
    echo ""
    install_tpm
    echo ""
    create_tmux_config
    echo ""
    create_local_config
    echo ""
    setup_clipboard
    echo ""
    install_plugins
    echo ""
    create_reference_guide
    echo ""
    create_aliases
    
    echo ""
    print_header "======================================================================="
    print_header "                   INSTALLATION COMPLETE!"
    print_header "======================================================================="
    echo ""
    print_status "Tmux has been fully customized with:"
    echo "  ✓ Custom key bindings (Ctrl+a prefix)"
    echo "  ✓ Mouse support enabled"
    echo "  ✓ Vi-style copy mode"
    echo "  ✓ Beautiful status bar with system info"
    echo "  ✓ Plugin manager (TPM) installed"
    echo "  ✓ Session persistence (resurrect/continuum)"
    echo "  ✓ Clipboard integration"
    echo "  ✓ Smart pane navigation"
    echo "  ✓ Useful aliases"
    echo ""
    print_info "Quick Start:"
    echo "  • Start tmux: tmux or t"
    echo "  • Show help: ~/tmux-reference.sh or tmux-help"
    echo "  • Reload config: Ctrl+a r"
    echo ""
    print_warning "Important: Restart your shell or run 'source ~/.bashrc' (or ~/.zshrc)"
    print_warning "Then start tmux with: tmux"
    echo ""
    print_info "Customize further by editing: ~/.tmux.conf.local"
    echo ""
}

# Run main function
main "$@"
