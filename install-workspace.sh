# Install Basic´s
sudo apt-get update
sudo apt-get install -y &&\
  curl &&\
  git &&\
  terminator &&\
  xclip &&\
  zsh

# Install Google Chome Browser
curl -LO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i ./google-chrome-stable_current_amd64.deb
rm ./google-chrome-stable_current_amd64.deb

# Install Atom Editor
wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
sudo apt-get update
sudo apt-get install atom
sudo apt --fix-broken install
sudo apt-get -f install

# Install Slack
curl -LO https://downloads.slack-edge.com/linux_releases/slack-desktop-4.1.2-amd64.deb
sudo dpkg -i ./slack-desktop-4.1.2-amd64.deb
sudo apt --fix-broken install
rm ./slack-desktop-4.1.2-amd64.deb

# Install Discord
curl -o discord.deb -LO https://discordapp.com/api/download\?platform\=linux\&format\=deb
sudo dpkg -i ./discord.deb
sudo apt --fix-broken install
rm ./discord.deb

# Get Ubuntu Color-Scheme for Terminator
# https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/terminator/Ubuntu.config

# Create home/bin directory
mkdir -p ~/bin

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install Powerlevel10k and fonts
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf

mkdir -p ~/.local/share/fonts/
mkdir -p ~/.config/fontconfig/conf.d/

mv PowerlineSymbols.otf ~/.local/share/fonts/
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

fc-cache -vf ~/.local/share/fonts/

# Install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl ~/bin/kubectl

# Install helm
curl -LO https://get.helm.sh/helm-v3.0.0-linux-amd64.tar.gz
tar zxvf ./helm-v3.0.0-linux-amd64.tar.gz
chmod +x ./linux-amd64/helm
mv ./linux-amd64/helm ~/bin/helm
rm ./helm-v3.0.0-linux-amd64.tar.gz
rm -rf ./linux-amd64

# Install kail
curl -LO https://github.com/boz/kail/releases/download/v0.12.0/kail_0.12.0_linux_amd64.tar.gz
tar zxvf ./kail_0.12.0_linux_amd64.tar.gz
chmod +x ./kail
mv ./kail ~/bin/kail
rm ./README.md ./LICENSE.txt ./kail_0.12.0_linux_amd64.tar.gz

# Install kubectx and kubens
git clone git@github.com:ahmetb/kubectx.git
chmod +x ./kubectx/kube*
mv ./kubectx/kube* ~/bin/
rm -rf ./kubectx

# Create SSH Keys
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
#eval "$(ssh-agent -s)"
#ssh-add ~/.ssh/id_rsa

# Create stash directory
mkdir -p ~/stash/{github,konkube}
mkdir -p ~/stash/github/forks
