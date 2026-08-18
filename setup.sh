#!/bin/bash

# if zsh is not installed, install it
apt update
apt install -y zsh
export ZSH="$HOME/.zsh"
if [[ -d $ZSH ]]; then
    mv $ZSH $ZSH.old
fi
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

export MY_DOTFILES_DIR="$HOME/.my_dotfiles"
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

if [[ ! -d ${ZSH_CUSTOM}/.fzf ]]; then
    git clone --depth=1 https://github.com/junegunn/fzf.git ${ZSH_CUSTOM}/.fzf
    ${ZSH_CUSTOM}/.fzf/install --all --bin
    mv ${ZSH_CUSTOM}/.fzf/bin/* /usr/local/bin/
fi

export PATH="$HOME/.local/bin:$PATH"
if ! command -v claude >/dev/null 2>&1; then
    curl -fsSL https://claude.ai/install.sh | bash
fi
claude --version

cp $MY_DOTFILES_DIR/dotfiles/zshrc ~/.zshrc
cp $MY_DOTFILES_DIR/dotfiles/vimrc ~/.vimrc
cp $MY_DOTFILES_DIR/dotfiles/tmux.conf.ini ~/.tmux.conf
cp $MY_DOTFILES_DIR/dotfiles/gitconfig.ini ~/.gitconfig
cp $MY_DOTFILES_DIR/dotfiles/gitignore.ini ~/.gitignore
mkdir -p "$HOME/.claude/skills" "$HOME/.cursor/skills"
cp $MY_DOTFILES_DIR/dotfiles/claude ~/.claude/CLAUDE.md
# Remove the previous skill name so agents do not load both versions.
rm -rf -- \
    "$HOME/.claude/skills/python-object-design" \
    "$HOME/.cursor/skills/python-object-design"
cp -R "$MY_DOTFILES_DIR/skills/." "$HOME/.claude/skills/"
cp -R "$MY_DOTFILES_DIR/skills/." "$HOME/.cursor/skills/"
