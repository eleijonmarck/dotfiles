# Repeat speed
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 11
gsettings set org.gnome.desktop.peripherals.keyboard delay 300

# Tweak tool for caps esc remap, compose key (shift + " + a -> ae)
sudo apt install -y gnome-tweak-tool

# Necessities
sudo apt-get install -y \
    build-essential \
    curl \
    libssl-dev \
    git \
    docker.io \
    tmux \
    silversearcher-ag \
    gitk \
    htop

# installing fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Neovim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install -y neovim

# Create swap file
# (https://linuxize.com/post/how-to-add-swap-space-on-ubuntu-18-04/)
sudo fallocate -l 32G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo bash -c "echo '/swapfile swap swap defaults 0 0' >> /etc/fstab"
sudo swapon --show

# Minimal swapiness recommended
sysctl vm.swappiness=1

# Hibernate after 10 minutes
# echo "[Sleep]
# HibernateDelaySec=600" >> /etc/systemd/sleep.conf

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir $HOME/.config
mkdir $HOME/.config/nvim
ln -sv $HOME/.vimrc $HOME/.config/nvim/init.vim
# then run :PlugInstall from neovim

sudo apt-get install exuberant-ctags

# zsh
sudo apt-get update && sudo apt-get -y install zsh
chsh -s $(which zsh)

# install language specifics

# pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

# nvm
git clone https://github.com/nvm-sh/nvm.git ~/.nvm

# goenv
git clone https://github.com/syndbg/goenv.git ~/.goenv

# docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $(whoami)

# docker-compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
