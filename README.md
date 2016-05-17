# Installing

```
git clone git@github.com-cloudartisan:cloudartisan/dotvim.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/vimrc ~/.gvimrc
```

# Updating submodules

```
cd ~/.vim
git submodule init
git submodule update
```

# Adding submodules

E.g. adding `vim-hashicorp-tools`:

```
git submodule add git@github.com:hashivim/vim-hashicorp-tools.git bundle/vim-hashicorp-tools
git commit -m "Added vim-hashicorp-tools submodule"
git push
```
