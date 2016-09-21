# Installation

## Installing/Updating VIM

The plugins depend on vim 7.4.

On Mac:

```
brew update
brew install vim
```

Make sure `/usr/local/bin/vim` is in your $PATH before system `vim` or that you
alias `vim` to `/usr/local/bin/vim`:

```
alias vim=/usr/local/bin/vim
alias vi=/usr/local/bin/vim
```

## Configuration

```
git clone git@github.com:cloudartisan/dotvim.git ${HOME}/.vim
ln -s ${HOME}/.vim/vimrc ${HOME}/.vimrc
ln -s ${HOME}/.vim/vimrc ${HOME}/.gvimrc
```

## Submodules

This will install `Vundle` as a submodule in the bundle, which is
then used to install other plugins:

```
cd ${HOME}/.vim
git submodule init
git submodule update
```

## Plugins

This will tell `Vundle` to install all plugins and then quit.

```
vim +PluginInstall +qall
```

## Compiling YouCompleteMe

```
cd $HOME/bundle/YouCompleteMe
./install.py --clang-completer
```

# Maintenance

## Adding Plugins

Add them to `vimrc` between these lines:

```
call vundle#begin()
[...]
call vundle#end()
```

## Adding Submodules

E.g. adding `vim-hashicorp-tools`:

```
git submodule add git@github.com:hashivim/vim-hashicorp-tools.git bundle/vim-hashicorp-tools
git commit -m "Added vim-hashicorp-tools submodule"
git push
```
