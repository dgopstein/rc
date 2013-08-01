init_env() {
  export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
  export TRHOME=${TRHOME:-'/home/site'}
  export TRDATA_DIR="$TRHOME/tr-data"
  export NO_TR=1
  export JRUBY_HOME=$MY_RUBY_HOME
  export JRUBY_OPTS=--1.8
  export EDITOR=vim
  export JAVA_HOME=/usr/jdk1.7

  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
  rvm use jruby-1.7.2@commerce
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
  alias ack='ack-grep'

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
  export PATH=/home/dgopstein/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$PATH
}

init_prompt() {
  PROMPT="%{`echo "\a"`%}[%D{%H:%M:%S}] %n@%m:%~%# "
  RPROMPT="%(?,%F{green}:%),%F{yellow}%? %F{red}:()%f \$CMD_TIME_STR"
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
}

init_env
init_history
init_aliases
init_themes
init_prompt
init_keybindings

# Userland commands
function t {
  DIR=$TRHOME
  GLOB="$DIR/trsrc-*${1:-?}*"

  BRANCH_STR=`echo "ls -d $GLOB"`
  BRANCH_STR2=`eval $BRANCH_STR | head -1`

  BRANCH=$( basename `echo $BRANCH_STR2 | awk '{print $1}'` )

  echo BRANCH: $BRANCH

  if [ -z $BASEPATH ]; then
    export BASEPATH=$PATH
  fi

  export TRTOP=/$DIR/$BRANCH # Prefix with a second / so that zsh won't autocomplete with TRTOP
  export let $BRANCH[7,-1]=$TRTOP[2,-1] # Generate a variabled named the title of the branch so zsh will autocomplete it
  export PT=$TRTOP/rails/provider_tool
  export let $BRANCH[7,-1]_PT=$PT[2,-1] # Generate a variabled named the title of the branch so zsh will autocomplete it
  export PATH=$BASEPATH:$TRTOP/scripts
  cd $TRTOP
}

function p {
  #BRANCH=
  #DIR=${1:-`basename $TRTOP`}

  t $1 #$DIR
  cd rails/provider_tool
}

function ph {
   egrep -ih ${1:-.*} ~/.psql_history | sed -e's/\\040/ /g' | sed 's/\\012/\
   /g'
}


function dingo {
  db='mysql -h crawfish -u reader --password=reader lemming'

  echo $db

  read -r -d '' query <<EOS
  set @search:='%$1%';
  SELECT p.id, group_concat(concat(c.username,':',r.name) separator ', ') AS user, p.created, p.name
  FROM project_assignments pa JOIN projects p ON pa.project_id=p.id JOIN contacts c ON pa.contact_id=c.id JOIN roles r ON pa.role_id=r.id
  WHERE p.active=1 AND (c.username LIKE @search OR p.name LIKE @search) GROUP BY p.id;
EOS

 echo $query | eval ${db}
}


