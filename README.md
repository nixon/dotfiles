# Dotfiles for python test driven development

This is a minimal set of dotfiles that re-create the environment I use
for Python development.  It features vim plugins that mimic the
red/green test driven development demonstrated in Gary Bernhardt's
String Calculator screencast:

 * https://vimeo.com/8569257


## Requirements

 * Python 2.7+
 * Vim 7.4+

The vim 7.4 binary that ships with Ubuntu 14.04 generates an annoying
"Press Enter to continue" message after running tests.  I recommend
compiling the latest vim from github.  The latest version behaves
correctly.

```
sudo apt-get install python-dev || sudo yum install python-devel
umask 022
git clone https://github.com/vim/vim.git
cd vim
./configure --prefix=/usr/local --enable-cscope --enable-pythoninterp --disable-gui --with-features=huge
make
sudo make install
```


## Clone dotfiles repo

```
cd
git clone --recursive https://github.com/nixon/dotfiles.git
```


## Create symlinks to dotfiles

### With GNU stow

```
cd ~/dotfiles
stow bash vim git
```

### Manually

```
cd
ln -sf ~/dotfiles/bash/.bashrc
ln -sf ~/dotfiles/vim/.vimrc
ln -sf ~/dotfiles/vim/.vim
ln -sf ~/dotfiles/git/.gitconfig
ln -sf ~/dotfiles/git/.gitignore
```


## Install python dependencies

Vim won't find modules installed in a virtualenv, so install Rope as
global Python modules.

(depending on where your python version lives, you may need sudo)

```
umask 022
pip install virtualenvwrapper rope ropemode ropevim
```


## Pick up the new bash environment

```
source ~/.bashrc
```


## Create virtualenv

```
mkvirtualenv string-kata
mkcd $VIRTUAL_ENV/stringcalc
pip install nose
```


## Create a failing testcase

Start `vim test_calc.py` and create a testcase using UltiSnips with `i`
to enter Insert mode, then expand the initial testcase with
`1stst<tab>`.  Use `<ctrl-j>` and `<ctrl-k>` to move between the snippet
fields.  The last field will be the `pass` statement in the body of the
test method.  Use `ae<tab>` to create a test body of
`self.assertEqual(add(""), 0)`.  Save the file with `<esc>:w<enter>`,
then run the testcases with `,t`.  The tests will run and a red bar will
display `NameError: global name 'add' is not defined` indicating that
the test fails.

Red, green, refactor!
