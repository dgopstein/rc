init_env() {
  PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
  TRHOME=${TRHOME:-'/home/site'}
  NO_TR=1
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

  # Databases
  alias riv='psql -h rivendell -U tripmaster'
  alias rov='psql -h rivendell -U tripmaster_ro -d tripmaster'
  alias div='psql -h rivendell-dev -U tripmaster'
  alias dev='psql -h dev-db -U tripmaster'
}

init_prompt() {
  PROMPT="[%D{%H:%M:%S}] %n@%m:%~%# "
  RPROMPT=""
}

init_env
init_history
init_aliases
init_prompt

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

  export TRTOP=$DIR/$BRANCH
  export PT=$TRTOP/rails/provider_tool
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

 echo $query | $db 
}
