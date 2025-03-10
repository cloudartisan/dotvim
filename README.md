# DotVim Configuration

A modern, organized Vim configuration with sensible defaults and carefully selected plugins.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Installation](#installation)
  - [Requirements](#requirements)
  - [Installation Steps](#installation-steps)
  - [Plugin Installation](#plugin-installation)
  - [Compiling YouCompleteMe](#compiling-youcompleteme)
- [Usage](#usage)
  - [Key Mappings](#key-mappings)
- [Customization](#customization)
  - [Adding Plugins](#adding-plugins)
  - [Language Configuration](#language-configuration)

## Overview

This Vim configuration provides a clean, efficient environment for coding with modern features like:
- Code completion
- Syntax checking and linting
- Git integration
- File navigation
- Snippets
- And more...

## Features

- **Organized plugin structure** categorized by functionality
- **Documented key mappings** for easy reference
- **Modern plugin management** with vim-plug
- **Language-specific settings** for consistent formatting
- **Productivity enhancements** for faster coding

## Installation

### Requirements

- Vim 8.0+ recommended (minimum 7.4)
- Git
- Node.js (for some language servers)
- Python (for YouCompleteMe)

### Installation Steps

```bash
# Clone the repository
git clone git@github.com:cloudartisan/dotvim.git ${HOME}/.vim

# Create symlinks
ln -s ${HOME}/.vim/vimrc ${HOME}/.vimrc
ln -s ${HOME}/.vim/vimrc ${HOME}/.gvimrc
```

### Plugin Installation

This repository uses vim-plug for plugin management:

```bash
# Install all plugins
vim +PlugInstall +qall
```

### Compiling YouCompleteMe

The YouCompleteMe plugin requires compilation:

```bash
cd $HOME/.vim/bundle/YouCompleteMe
./install.py --clang-completer
```

## Usage

### Key Mappings

Key mappings are documented in the vimrc file. Here's a quick reference:

| Mapping | Description |
|---------|-------------|
| `\<tab>` | Toggle NERDTree file browser |
| `\n` | Toggle line numbers |
| `\p` | Toggle paste mode |
| `\s` | Toggle sign column |
| `\l` | Toggle location list |
| `\q` | Toggle quickfix list |
| `\t` | Toggle tag browser |
| `\j` | Go to next error/warning |
| `\k` | Go to previous error/warning |
| `Ctrl+h/j/k/l` | Navigate splits (left/down/up/right) |

## Customization

### Adding Plugins

Add plugins to `vimrc` between these lines:

```vim
call plug#begin()
[...]
call plug#end()
```

Plugin format:

```vim
Plug 'username/repo-name'
```

### Language Configuration

Language-specific settings for indentation, syntax highlighting, etc. are included in the vimrc.
Add or modify as needed for your preferred languages.
