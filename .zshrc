  QT_IM_MODULE=fcitx
  XMODIFIERS=@im=fcitx

  dsi() { docker stop $(docker ps -a | awk -v i="^$1.*" '{if($2~i){print$1}}'); }

  GIT_PROMPT_END=" [\${AWS_PROFILE}]\n\A $ "

  export NVM_DIR=~/.nvm
  export JAVA_HOME="/opt/android-studio/jbr"
  export PIPEWIRE_CONFIG_FILE="$HOME/.config/pipewire/pipewire.conf"

  #ANDROID
  export ANDROID_HOME=$HOME/Android/Sdk
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
ZSH_THEME="robbyrussell"
plugins=(git npm zsh-autosuggestions zsh-syntax-highlighting 1password aws)

## SOURCE

source $ZSH/oh-my-zsh.sh
#source /usr/share/nvm/init-nvm.sh
source /etc/profile.d/google-cloud-cli.sh
source ~/.nvm/nvm.sh
## ALIAS

alias rando='openssl rand -base64 32'
alias vim='nvim'
alias cat="bat"
alias find-file="find . -type f -name"              ## Find a file with the given name
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
alias poly="~/scripts/polybar/lauch.sh"
alias nitrogen="nitrogen $HOME/wallpapers"
alias i3conf="vim $HOME/.config/i3/config"
alias ls='lsd'
alias grep="rg --color=auto"


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

# pnpm
export PNPM_HOME="/home/$USER/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Created by `pipx` on 2023-12-14 10:03:22
export PATH="$PATH:/home/$USER/.local/bin"
