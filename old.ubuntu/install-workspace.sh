# Install Basic´s
sudo apt-get update
sudo apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  git \
  gnupg-agent \
  software-properties-common \
  terminator \
  xclip \
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

# Install Visual Studio Code Editor
curl -L -o visual_studio_code.deb https://go.microsoft.com/fwlink/?LinkID=760868
sudo dpkg -i ./visual_studio_code.deb
sudo apt --fix-broken install
rm ./visual_studio_code.deb

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

mkdir -p ~/.oh-my-zsh/completions
chmod -R 755 ~/.oh-my-zsh/completions
curl -fsSL https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/kubectx.zsh > ~/.oh-my-zsh/completions/_kubectx.zsh
curl -fsSL https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/kubens.zsh > ~/.oh-my-zsh/completions/_kubens.zsh

# Install docker from 19.04 Disco Dingo package
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   disco \
   stable"
sudo apt-get update
sudo apt-get install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io

# Fixing Docker permissions
sudo usermod -aG docker $USER

# Install Docker Qemu User for building arm docker images.
sudo apt install -y \
  qemu \
  qemu-user-static

git clone https://github.com/computermouth/qemu-static-conf.git
sudo cp qemu-static-conf/qemu-{aarch64,arm}-static.conf  /etc/binfmt.d
sudo systemctl restart systemd-binfmt.service

# creating own docker build environment
docker buildx install
docker buildx create --name konkube
docker buildx use konkube
docker buildx inspect --bootstrap

# Create SSH Keys
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
#eval "$(ssh-agent -s)"
#ssh-add ~/.ssh/id_rsa

# Create stash directory
mkdir -p ~/stash/{github,konkube}
mkdir -p ~/stash/github/forks
