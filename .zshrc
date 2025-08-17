export PATH=$PATH:$HOME/flutter/bin
export PATH=$PATH:$HOME/android-studio/bin
export MANPATH="/usr/local/man:$MANPATH"

dsi() { docker stop $(docker ps -a | awk -v i="^$1.*" '{if($2~i){print$1}}'); }

export ZSH="$HOME/.oh-my-zsh"

GIT_PROMPT_END=" [\${AWS_PROFILE}]\n\A $ "
ZSH_THEME="xiong-chiamiov-plus"
export NVM_DIR=~/.nvm

  export PIPEWIRE_CONFIG_FILE="$HOME/.config/pipewire/pipewire.conf"

  # GO
  #export GOPATH=$HOME/go 
  #export PATH=$PATH:$GOPATH/bin

# SOUND
export PIPEWIRE_CONFIG_FILE="$HOME/.config/pipewire/pipewire.conf"


# ANDROID
export JAVA_HOME="/opt/android-studio/jbr"
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

export SSH_LOCATION=$HOME/.ssh
export PATH=$PATH:$HOME/scripts
export PATH=$PATH:$HOME/.cargo/bin

export IDEA_JDK=/usr/lib/jvm/jre-jetbrains
export PHPSTORM_JDK=/usr/lib/jvm/jre-jetbrains
export WEBIDE_JDK=/usr/lib/jvm/jre-jetbrains
export PYCHARM_JDK=/usr/lib/jvm/jre-jetbrains
export RUBYMINE_JDK=/usr/lib/jvm/jre-jetbrains
export CL_JDK=/usr/lib/jvm/jre-jetbrains
export DATAGRIP_JDK=/usr/lib/jvm/jre-jetbrains
export GOLAND_JDK=/usr/lib/jvm/jre-jetbrains
export STUDIO_JDK=/usr/lib/jvm/jre-jetbrains


export MANPAGER="sh -c 'col -bx | bat -l man -p'"

## Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="$( echo $(which nvim) || echo $(which vim) || echo $(which vi) )"
else
  export EDITOR="$( echo $(which nvim) || echo $(which vim) || echo $(which vi) )"
fi

## OH_MY
plugins=(git sudo dnf zsh-256color zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
#source /etc/profile.d/google-cloud-cli.sh
source ~/.nvm/nvm.sh

## ALIAS
alias open="thunar"
alias rando='openssl rand -base64 32'
alias vim='nvim'
alias cat="bat"
alias find-file="find . -type f -name"  ## Find a file with the given name

## Find a file & open it with neovim
alias ff='nvim $(fzf)'
alias fzf="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
alias vim=nvim
alias mouse=piper
alias doc=zathura
alias calendar=calcurse
alias vim=nvim
alias vi=nvim
alias top=btop
alias grep="rg --color=auto"
alias tmux='tmux -f ~/.config/tmux/tmux.conf'


function switch-profile() {
  identity=$(aws sts get-caller-identity --profile $1)
  if [ "$?" -eq 0 ]; then
    export AWS_PROFILE=$1
    echo $identity
  else
    echo "Profile not active! Logging in..."
    aws sso login --profile $1
    aws sts get-caller-identity --profile $1
    export AWS_PROFILE=$1
  fi
}

# check the dnf plugins commands here
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/dnf

# pnpm
export PNPM_HOME="/home/$USER/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Created by `pipx` on 2023-12-14 10:03:22
export PATH="$PATH:/home/$USER/.local/bin"

if [ -f $HOME/.zshenv ]; then
         source $HOME/.zshenv
fi

# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

eval $(thefuck --alias)
# Set-up icons for files/folders in terminal using eza
alias ls='eza -a --icons'
alias ll='eza -al --icons'
alias lt='eza -a --tree --level=1 --icons'
alias orca-slicer='__GLX_VENDOR_LIBRARY_NAME=mesa __EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json MESA_LOADER_DRIVER_OVERRIDE=zink GALLIUM_DRIVER=zink WEBKIT_DISABLE_DMABUF_RENDERER=1 orca-slicer'

# bun completions
[ -s "/home/melty/.bun/_bun" ] && source "/home/melty/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
#eval "$(pyenv virtualenv-init -)"

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[[ -s "/home/melty/.gvm/scripts/gvm" ]] && source "/home/melty/.gvm/scripts/gvm"
