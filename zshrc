init_env() {
  export EDITOR=vim
  export ZSH_THEME_GIT_PROMPT_NOCACHE=t


  source ~/.ongoingrc

  echo "Hi Dan, your code sucks. -Graham"
}

init_history() {
  HISTFILE=$HOME/.zhistory       # enable history saving on shell exit
  setopt INC_APPEND_HISTORY          # append rather than overwrite history file.
  HISTSIZE=10000                 # lines of history to maintain memory
  SAVEHIST=100000                # lines of history to maintain in history file.
  setopt HIST_EXPIRE_DUPS_FIRST  # allow dups, but expire old ones when I hit HISTSIZE
  setopt EXTENDED_HISTORY        # save timestamp and runtime information
}

init_aliases() {
  alias ll='ls -l'
  alias ack='ack-grep -G "target|FileStore" --invert-file-match'

  # Databases
  alias riv='psql -h rivendell -U tripmaster'
  alias rov='psql -h rivendell -U tripmaster_ro -d tripmaster'
  alias div='psql -h rivendell-dev -U tripmaster'
  alias dev='psql -h dev-db -U tripmaster'
  alias cdb='psql -h commerce-db.tripadvisor.com -U provider_tool_test'
  alias loc='psql provider_tool_test'
  alias whs='sqsh -U CommerceWHReports -S statistics -P whReports -D Commerce -m pretty'
  alias mon='psql -h tripmonster -U tripmonster'

  alias stat='svntr stat | grep -v "^?"'
  alias pt='commerce-jruby -C $TRTOP/rails/provider_tool --debug -J-Xmx8g -J-Xdebug -J-Xrunjdwp:transport=dt_socket,address=1044,server=y,suspend=n script/server'

}

init_keybindings() {
  # Make C-w go until back to the last space
  tcsh-backward-kill-word () {
    local WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
    zle backward-kill-word
  }
  zle -N tcsh-backward-kill-word
  bindkey '^W' tcsh-backward-kill-word
}

init_themes() {
  ZSH=$HOME/.oh-my-zsh
  plugins=(git)
  source $ZSH/oh-my-zsh.sh
  source ~/.zsh/git-prompt/zsh-git-prompt.sh # https://github.com/olivierverdier/zsh-git-prompt
  unsetopt correctall

  export PATH=/home/dan/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$PATH
}

init_prompt() {
  #PROMPT="%{`echo "\a"`%}[%D{%H:%M:%S}] %n@%m:%~%# "
  PROMPT="%{`echo "\a"`%}" # bell at prompt to light up xmobar on command completion
  PROMPT+='$(git_super_status)%B%~%b %# ' # git status
}

preexec() {
  export CMD_START_TIME=`date +'%s'`
}

precmd() {
  declare CMD_END_TIME=`date +'%s'`
  declare CMD_TIME_SEC=$(( $CMD_END_TIME - ${CMD_START_TIME:-CMD_END_TIME} ))
  declare -Z2 CMD_TIME_SECONDS_PART=$(($CMD_TIME_SEC%60))
  declare -Z2 CMD_TIME_MINUTES_PART=$(($CMD_TIME_SEC/60))
  export CMD_TIME_STR="$CMD_TIME_MINUTES_PART:$CMD_TIME_SECONDS_PART" 
  CMD_START_TIME=`date +'%s'`

  if [ $CMD_TIME_SEC -gt 3 ]; then
    RPROMPT="%(?,%F{green}:%),%F{yellow}%? %F{red}:()%f \$CMD_TIME_STR"
  else
    unset RPROMPT
  fi
}

init_history
init_aliases
init_env
init_themes
init_prompt
init_keybindings

# Userland commands

