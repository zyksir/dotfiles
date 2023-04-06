# ZSH config

First we need to install zsh and [oh-my-zsh](https://ohmyz.sh/).
Then we need to download some plugins. [refer from here](https://lazyren.github.io/devlog/oh-my-zsh-setup.html#autoupdate-pushpin)

```bash
git clone --depth=1 https://github.com/TamCore/autoupdate-oh-my-zsh-plugins ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/autoupdate
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone --depth=1 https://github.com/agkozak/zsh-z.git ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-z
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```
