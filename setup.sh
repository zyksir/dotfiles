#!/bin/sh

# Install zsh: apt on Linux, Oh My Zsh installer elsewhere (e.g. macOS)
if [ "$(uname)" = "Linux" ]; then
  apt install zsh
else
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

export ZSH="$HOME/.zsh"
export ZSH_CUSTOM="$ZSH/custom"
git clone --depth=1 https://github.com/TamCore/autoupdate-oh-my-zsh-plugins ${ZSH_CUSTOM}/plugins/autoupdate
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM}/plugins/zsh-completions
git clone --depth=1 https://github.com/agkozak/zsh-z.git ${ZSH_CUSTOM}/plugins/zsh-z
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k

cp dotfiles/zshrc ~/.zshrc
cp dotfiles/vimrc ~/.vimrc
cp dotfiles/tmux.conf.ini ~/.tmux.conf
cp dotfiles/gitconfig.ini ~/.gitconfig
cp dotfiles/gitignore.ini ~/.gitignore