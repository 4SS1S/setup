GREEN='\033[0;32m'
CYAN='\033[0;036m'
YELLOW='\033[1;33m'
NORMAL='\033[0m'

macos() {
  echo -e "${GREEN}using MacOS${NORMAL}"

  input='macos/ascii.code'

  while IFS= read -r line; do
    echo -e "$line"
  done < "${input}"

  echo -e "\033]0;MacOS\007"
  echo -e "${CYAN}=> Starting instalation${NORLMAL}"

  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  brew tap homebrew/dupes
  brew tap homebrew/versions
  brew tap homebrew/homebrew-php
  brew tap homebrew/completions
  brew tap caskroom/fonts
  brew tap homebrew/bundle

  echo -e "${CYAN}=> Installing brew apps ${NC} "
  brew install $(grep . command-line-apps.ini | xargs)

  echo -e "${CYAN}=> Installing brew cask apps${NC}"
  brew cask install $(grep . apps.ini | xargs)

  brew upgrade
}

linux() {
  echo -e "${GREEN}using Linux${NORMAL}"

  input='linux/ascii.code'

  while IFS= read -r line; do
    echo -e "$line"
  done < "${input}"

  echo -e "${GREEN} => Updating System... ${NORMAL}"
  sudo apt-get update && sudo apt-get upgrade
}

windows() {
  echo -e "${GREEN}using Windows${NORMAL}"
}

if [[ $OSTYPE == "darwin"* ]]; then
  macos
elif [[ $OSTYPE == "linux"* ]]; then
  linux
elif [[ $OSTYPE == "win32"* ]]; then
  windows
fi