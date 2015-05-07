# ubuntu install
sudo apt-get update
sudo apt-get upgrade
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim

# Inside of ~/.vim make /tmp, inside of which mkdir swap backup undo
cd ~/.vim
mkdir tmp
cd tmp/
mkdir swap backup undo
cd

# install vundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
nvim +BundleInstall

# install YCM
cd ~/.vim/bundle/YouCompleteMe
./install.sh --clang-completer
cd
