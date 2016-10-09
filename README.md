### packages
sudo apt-get install vim emacs git zsh tmux rxvt-unicode-256color ruby scala ack-grep htop meld pidgin

### install chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get -f install

### store github password
sudo apt-get install libgnome-keyring-dev
cd /usr/share/doc/git/contrib/credential/gnome-keyring
sudo make
git config --global credential.helper /usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnome-keyring

### checkout RC files
git clone https://github.com/dgopstein/rc.git .rc

### emacs keybindings everywhere
gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs"

### change to urxvt
sudo update-alternatives --config x-terminal-emulator

### install fonts
mkdir ~/.fonts && cd ~/.fonts/ && git clone https://github.com/scotu/ubuntu-mono-powerline.git && cd ~

### use zsh
chsh -s $(which zsh)

### oh-my-zsh
curl -L http://install.ohmyz.sh | sh

### install xmonad
sudo apt-get install xmonad xmobar
