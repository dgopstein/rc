### install chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get -f install

### install editors
sudo apt-get install vim emacs

### checkout RC files
sudo apt-get install git
git clone https://github.com/dgopstein/rc.git .rc

### install terminal stuff
sudo apt-get install zsh tmux rxvt-unicode-256color

### change to urxvt
sudo update-alternatives --config x-terminal-emulator

### install fonts
mkdir ~/.fonts && cd ~/.fonts/ && git clone https://github.com/scotu/ubuntu-mono-powerline.git && cd ~

### use zsh
chsh -s $(which zsh)

### oh-my-zsh
curl -L http://install.ohmyz.sh | sh

### install window manager
sudo apt-get install xmonad xmobar

### install languages
sudo apt-get install ruby scala

### install random
sudo apt-get install ack-grep htop meld pidgin
