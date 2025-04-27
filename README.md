# My Dotfiles

This repository contains my personal dotfiles and configuration files for various tools and applications. These configurations are optimized for macOS and include settings for:

- Zsh shell configuration
- Vim editor configuration
- Git configuration
- iTerm2 terminal settings

## Contents

- `zsh/`: Zsh configuration files
  - `.zshrc`: Main Zsh configuration file
  - `.zsh_plugins.txt`: List of Zsh plugins
- `vim/`: Vim configuration
  - `.vimrc`: Vim configuration file
- `git/`: Git configuration
  - `.gitconfig`: Git global configuration
- `iTerm2/`: iTerm2 terminal settings
- `install.sh`: Installation script

## Installation

To install these dotfiles, follow these steps:

1. **Clone the Repository**: Open your terminal and run the following command to clone the repository to your local machine:
   ```bash
   git clone https://github.com/alexandergharibian/dotfiles.git
   ```

2. **Navigate to the Directory**: Change into the newly cloned directory:
   ```bash
   cd dotfiles/
   ```

3. **Run the Installation Script**: Execute the installation script to create symbolic links from your home directory to the configuration files in this repository:
   ```bash
   ./install.sh
   ```

This process will set up your environment with the configurations specified in this repository. Make sure you have the necessary permissions to create symbolic links in your home directory.

## Features

### Zsh Configuration
- Custom prompt
- Plugin management
- Aliases and functions
- Environment variables

### Vim Configuration
- Custom key mappings
- Plugin management
- Syntax highlighting
- File type detection

### Git Configuration
- User information
- Aliases
- Core settings
- Color settings

### iTerm2 Configuration
- Color schemes
- Window settings
- Keyboard shortcuts

## Requirements

- macOS
- Zsh
- Git
- Vim
- iTerm2