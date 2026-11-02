# 🚀 tmux_custom

A comprehensive, one-command tmux customization script for Linux (Debian-based systems). Transform your tmux into a powerful, beautiful, and efficient terminal multiplexer with modern features and intelligent defaults.

## ✨ Features

### 🎨 **Beautiful Interface**
- **Powerline-style status bar** with system information
- **256-color support** with proper terminal detection
- **Gruvbox color theme** (set in `~/.tmux.conf.local`)
- **Visual pane borders** with active pane highlighting

### ⌨️ **Ergonomic Key Bindings**
- **Ctrl+b prefix** - tmux default
- **Intuitive splits** - `|` for vertical, `-` for horizontal
- **Vim-style navigation** - h/j/k/l for pane movement
- **Quick resize** - H/J/K/L for pane resizing
- **Alt+Arrow navigation** - No prefix needed

### 🖱️ **Mouse Support**
- **Click to switch** panes and windows
- **Scroll through history** with mouse wheel
- **Drag to resize** pane borders
- **Select and copy** text with mouse
- **Toggle on/off** with Ctrl+b m

### 📋 **Clipboard Integration**
- **Vi-style copy mode** - Familiar for Vim users
- **System clipboard** integration via xclip
- **Quick paste** - Ctrl+b p
- **Visual selection** - v to select, y to copy

### 🔌 **Powerful Plugins (via TPM)**
- **tmux-yank** - Enhanced clipboard operations
- **tmux-copycat** - Advanced regex search
- **tmux-open** - Open files and URLs from tmux
- **tmux-cpu** - CPU and RAM monitoring

### 📊 **System Monitoring**
- **CPU usage** and percentage
- **RAM usage** and percentage
- **Load average** (1, 5, 15 min)
- **Date and time** display
- **Hostname** in status bar
- **Real-time updates** every 5 seconds

## 🛠️ Installation

### One-Command Installation
```bash
curl -fsSL https://raw.githubusercontent.com/ensonb/tmux_custom/main/tmux_custom.sh | bash
```

### Manual Installation
```bash
# Clone the repository
git clone https://github.com/ensonb/tmux_custom.git
cd tmux_custom

# Make executable and run
chmod +x tmux_custom.sh
./tmux_custom.sh
```

## 🎮 Key Bindings Reference

### Session Management
| Key | Action |
|-----|--------|
| `Ctrl+b d` | Detach from session |
| `Ctrl+b (` | Previous session |
| `Ctrl+b )` | Next session |
| `Ctrl+b s` | Session list |

### Window Management
| Key | Action |
|-----|--------|
| `Ctrl+b c` | New window |
| `Ctrl+b n` | Next window |
| `Ctrl+b p` | Previous window |
| `Ctrl+b 0-9` | Switch to window number |
| `Ctrl+b ,` | Rename window |
| `Ctrl+b X` | Kill window |
| `Ctrl+b w` | List windows |

### Pane Management
| Key | Action |
|-----|--------|
| `Ctrl+b \|` | Split vertically |
| `Ctrl+b -` | Split horizontally |
| `Ctrl+b h/j/k/l` | Navigate panes (vim) |
| `Alt+Arrow` | Navigate panes (no prefix) |
| `Ctrl+b H/J/K/L` | Resize panes |
| `Ctrl+b z` | Toggle pane zoom |
| `Ctrl+b x` | Kill pane |
| `Ctrl+b s` | Synchronize panes |

### Copy Mode (Vi-style)
| Key | Action |
|-----|--------|
| `Ctrl+b Esc` | Enter copy mode |
| `v` | Begin selection |
| `y` | Copy to clipboard |
| `r` | Rectangle toggle |
| `Ctrl+b p` | Paste |
| `q` | Exit copy mode |

### Plugins
| Key | Action |
|-----|--------|
| `Ctrl+b I` | Install plugins |
| `Ctrl+b U` | Update plugins |
| `Ctrl+b /` | Search (copycat) |

### Utilities
| Key | Action |
|-----|--------|
| `Ctrl+b r` | Reload configuration |
| `Ctrl+b m` | Toggle mouse mode |
| `Ctrl+b ?` | Show all keybindings |

## 🖥️ System Requirements

- **Operating System**: Debian-based Linux (Ubuntu, Pop!_OS, Linux Mint, Debian, etc.)
- **Tmux**: Version 2.1 or higher (automatically installed)
- **Git**: For cloning repositories
- **xclip**: For clipboard integration (automatically installed)

## 📦 What Gets Installed

The script automatically installs:
- ✅ **tmux** - The terminal multiplexer
- ✅ **git** - Version control
- ✅ **xclip** - Clipboard utilities
- ✅ **powerline** - Status line plugin
- ✅ **fonts-powerline** - Powerline fonts
- ✅ **build-essential** - Build tools
- ✅ **TPM** - Tmux Plugin Manager
- ✅ **All configured plugins** - Via TPM

## 🎯 Useful Aliases

After installation, these aliases are available:

```bash
t              # Start tmux
ta             # Attach to last session
tat <name>     # Attach to named session
tn <name>      # New named session
tl             # List sessions
tk <name>      # Kill session
tmux-reload    # Reload tmux config
tmux-help      # Show quick reference
```

## 📚 Quick Reference

After installation, run:
```bash
~/tmux-reference.sh
# or
tmux-help
```

This displays a comprehensive reference guide with all keybindings and features.

## 🔧 Customization

### Edit Configuration
```bash
# Main configuration (overwrites on update)
vim ~/.tmux.conf

# Local customization (persists through updates)
vim ~/.tmux.conf.local
```

### Example Local Customizations

```bash
# ~/.tmux.conf.local

# Switch prefix to Ctrl+a
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# Change status bar colors
set -g status-style bg=colour234,fg=colour137

# Additional key bindings
bind Space last-window

# Disable mouse mode by default
set -g mouse off
```

## 🛡️ Safety Features

- **Automatic backups** - Existing configs backed up with timestamps
- **Non-destructive** - Preserves your current setup
- **Confirmation prompt** - Interactive mode asks before proceeding
- **Error handling** - Graceful exits on errors
- **Rollback support** - Backup files retained for manual restoration

## 🔄 Maintenance

### Update Plugins
```bash
# Inside tmux
Ctrl+b U

# Or from terminal
~/.tmux/plugins/tpm/scripts/update_plugins.sh
```

### Reload Configuration
```bash
# Inside tmux
Ctrl+b r

# Or from terminal
tmux source-file ~/.tmux.conf
```

## 💡 Tips & Tricks

### Session Persistence (optional)
tmux-resurrect and tmux-continuum are off by default. To turn them on, uncomment their `@plugin` and settings lines in `~/.tmux.conf`, then press `Ctrl+b I`.

### Search in Copy Mode
- **Regex search**: `Ctrl+b /`
- **File search**: `Ctrl+b Ctrl+f`
- **URL search**: `Ctrl+b Ctrl+u`

### Working with Multiple Panes
1. Split your window: `Ctrl+b |` and `Ctrl+b -`
2. Navigate: `Alt+Arrow` or `Ctrl+b h/j/k/l`
3. Resize: `Ctrl+b H/J/K/L`
4. Zoom one pane: `Ctrl+b z`

### Synchronized Panes
Run the same command in all panes:
1. Split panes as needed
2. Enable sync: `Ctrl+b s`
3. Type your commands (appears in all panes)
4. Disable sync: `Ctrl+b s`

## 🐛 Troubleshooting

### Colors not displaying correctly
```bash
# Check TERM variable
echo $TERM

# Should be: screen-256color or tmux-256color
# Add to ~/.bashrc or ~/.zshrc:
export TERM=screen-256color
```

### Mouse mode not working
```bash
# Ensure mouse support in terminal
# Most modern terminals support it by default

# Toggle mouse mode
Ctrl+b m
```

### Plugins not loading
```bash
# Manually install plugins
cd ~/.tmux/plugins/tpm
./scripts/install_plugins.sh

# Or inside tmux
Ctrl+b I
```

### Clipboard not working
```bash
# Install xclip
sudo apt install xclip

# Test clipboard
echo "test" | xclip -selection clipboard
xclip -selection clipboard -o
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⭐ Show Your Support

If this project helped you, please consider giving it a star! ⭐

## 🔗 Related Projects

- [vimplug](https://github.com/ensonb/vimplug) - Companion Vim setup script
- [tmux](https://github.com/tmux/tmux) - Official tmux repository
- [TPM](https://github.com/tmux-plugins/tpm) - Tmux Plugin Manager

## 📖 Resources

- [Official tmux documentation](https://github.com/tmux/tmux/wiki)
- [tmux cheat sheet](https://tmuxcheatsheet.com/)
- [Awesome tmux](https://github.com/rothgar/awesome-tmux)

---

**Made with ❤️ for the Linux community**

> *Transform your terminal experience with a single command.*
