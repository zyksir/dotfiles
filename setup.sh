#!/bin/sh

# Install zsh: apt on Linux, Oh My Zsh installer elsewhere (e.g. macOS)
if [[ "$(uname)" = "Linux" ]]; then
  apt install -y zsh
else
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

export MY_DOTFILES_DIR="$HOME/.my_dotfiles"
export ZSH="$HOME/.zsh"
export ZSH_CUSTOM="$ZSH/custom"
if [[ ! -d ${ZSH_CUSTOM}/plugins/autoupdate ]]; then
    git clone --depth=1 https://github.com/TamCore/autoupdate-oh-my-zsh-plugins ${ZSH_CUSTOM}/plugins/autoupdate
fi
if [[ ! -d ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting ]]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
fi
if [[ ! -d ${ZSH_CUSTOM}/plugins/zsh-autosuggestions ]]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
fi
if [[ ! -d ${ZSH_CUSTOM}/plugins/zsh-completions ]]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM}/plugins/zsh-completions
fi
if [[ ! -d ${ZSH_CUSTOM}/plugins/zsh-z ]]; then
    git clone --depth=1 https://github.com/agkozak/zsh-z.git ${ZSH_CUSTOM}/plugins/zsh-z
fi
if [[ ! -d ${ZSH_CUSTOM}/themes/powerlevel10k ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k
fi

cp $MY_DOTFILES_DIR/dotfiles/zshrc ~/.zshrc
cp $MY_DOTFILES_DIR/dotfiles/vimrc ~/.vimrc
cp $MY_DOTFILES_DIR/dotfiles/tmux.conf.ini ~/.tmux.conf
cp $MY_DOTFILES_DIR/dotfiles/gitconfig.ini ~/.gitconfig
cp $MY_DOTFILES_DIR/dotfiles/gitignore.ini ~/.gitignore