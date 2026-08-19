#!/bin/zsh

function gpt() {
  pids=$(pgrep -f "next-server")

  if [[ -z "$pids" && ($1 == --logs || $1 == -l) ]]; then
    echo "No next-server process found."
  fi

  for pid in $pids
  do
      full_command=$(ps -fp $pid | awk 'NR>1 {$1=$2=$3=$4=$5=$6=$7=""; print $0}' | tr -s ' ' x)
      if [[ $1 == --logs || $1 == -l ]]; then
          echo "PID: $pid, Command: $full_command"
      fi
      
      if [[ $full_command == *"next-server"* ]]
      then
          read "?Service is already running. Do you want to terminate it? (y/n) " REPLY
          echo
          if [[ $REPLY =~ ^[Yy]$ ]]
          then
              kill -9 $pid
              echo "Service terminated."
              return
          fi
      fi
  done

  dir=$(pwd)
  cd /Users/anderneo/dev/ai/big-AGI/
  nohup npm run start >output.log 2>&1 &
  cd $dir
  echo "Service started."
}

function clamscan-full () {
	clamscan -a -o -r -z --detect-structured --structured-ssn-format=2 --detect-broken --enable-stats --stdout --exclude=metasploit.* -l /var/log/custom/clamscan.log
}

function hist-rofi(){ 
  fc -lnr 1 | uniq --unique | rofi -dmenu -p 'Select a command: ' | xclip  
}

dir() {
  # Define color codes    
  BLUE='\033[0;34m'
  RED='\033[0;31m'
  YELLOW='\033[1;33m'
  NC='\033[0m' # No color
  orig_colors=$LS_COLORS

  if [ $# -lt 2 ]; then
    echo "Invalid usage!!" 
    echo "Create: dir -c dirname"
    echo "Remove: dir -r dirname"
    echo "Rename: dir -u oldname newname"
    echo "Move: dir -m source dest"
    1
  fi

  local operation=$1
  shift

  case $operation in
    -c)
        mkdir -p "$@"
        if [ $? -eq 0 ]; then
            echo -e "Directory ${BLUE}$1${NC} created successfully:"
            parent_dir=$(dirname "$1")
            lsd --group-dirs first "$parent_dir"
        fi
        ;;
    -r)
        if [ ! -d "$1" ]; then
            echo -e "Error: ${BLUE}$1NC} is not a directory or does not exist."
            return 1
        fi
        if [ -n "$(ls -A $1)" ]; then
            echo "Directory $1 is not empty!"
            export LS_COLORS='di=0;34:'; lsd --tree "$1"; unset LS_COLORS
            read "response?Do you want to remove this directory and all its content? [y/N] "
            if [[ "$response" =~ ^([yY][eE][sS]|[yY]) ]]; then
                echo -e "Directory ${RED}$1${NC} and its content removed successfully."
                rm -r "$@"
            else
                echo "Operation cancelled."
                return
            fi
        else
            rm -i "$@"
        fi
        ;;
    -u)
        if [ $# -ne 2 ]; then
            echo "Invalid usage. Example: dir -u oldname newname"
            return 1
        fi
        mv "$@"
        if [ $? -eq 0 ]; then
            echo -e "Directory renamed from ${BLUE}$1${NC} to ${YELLOW}$2${NC} successfully:"
            parent_dir=$(dirname "$2")
            lsd --group-dirs first "$parent_dir"
        fi
        ;;
    -m)
        if [ $# -ne 2 ]; then
            echo "Invalid usage. Example: dir -m source dest"
            return 1
        fi
        mv "$@"
        if [ $? -eq 0 ]; then
            echo -e "Directory moved from ${BLUE}$1${NC} to ${YELLOW}$2${NC} successfully:"
            parent_dir=$(dirname "$2")
            lsd --tree "$parent_dir"
        fi
        ;;
    *)
        echo "Invalid operation. Use -c for create, -r for remove, -u for rename, and -m for move."
        ;;
  esac

  export LS_COLORS=$orig_colors
}

function getfile() {
    if [ $# -lt 1 ]; then
        echo "Usage: getfile <filename> [destination]"
        return 1
    fi

    local file=$1
    local dest=$2

    if [ -z "$dest" ]; then
        dest=$(pwd)
    fi

    if [ ! -e "~/Downloads/$file" ]; then
        echo "File $file does not exist in ~/Downloads"
        return 1
    fi

    cp "~/Downloads/$file" "$dest"
}



function err(){ echo >&2 `tput bold; tput setaf 1`"[-] ERROR: ${*}"`tput sgr0`;exit 1 }

function warn(){ echo >&2 `tput bold; tput setaf 1`"[!] WARNING: ${*}"`tput sgr0` }

function msg(){ echo `tput bold; tput setaf 2`"[+] ${*}"`tput sgr0` }

function git-home(){ git rev-parse --show-toplevel }

function git-ignore(){ repo_home=$(git rev-parse --show-toplevel); for filename in ${@}; do echo $filename >> $repo_home/.gitignore; done }

function decrypt() { gpg2 --output ${1:0:-4} --decrypt $1 }

function find_symlinks(){ ls -lR "${@}" | grep ^ }

function git-ignore(){ repo_home=$(git rev-parse --show-toplevel); for filename in ${@}; do echo $filename >> $repo_home/.gitignore; done }

function decrypt() { gpg2 --output ${1:0:-4} --decrypt $1 }

function find_symlinks(){ ls -lR "${@}" | grep ^ }

function mkquickcd(){ 
    alias cd.="cd ~/.dotfiles"
    for f in ~/.dotfiles/*
    do if [[ -d "$f" ]]
    then x=($(echo "$f" | tr "/" " "))
        x=$x[-1]
        alias "cd.$x"="cd $f"
    fi; done ; unset x ; unset f
}

function codi() {
    local syntax="${1:-python}"
    shift
    vim -c \
        "let g:startify_disable_at_vimenter = 1 |\
        set bt=nofile ls=0 noru nonu nornu |\
        hi ColorColumn ctermbg=NONE |\
        hi VertSplit ctermbg=NONE |\
        hi NonText ctermfg=0 |\
        Codi $syntax" "$@"
}

function untar(){ while [ ${#} != 0 ]; do if [ -f "${1}" ]; then case "${1}" in
    *.tar.xz); tar xfv "${1}";shift;;
    *.tar.bz2); tar xjvf "${1}";shift;;
    *.tar.gz); tar xzvf "${1}";shift;;
    *.bz2); bunzip2 "${1}";shift;;
    *.rar); rar x "${1}";shift;;
    *.gz); gunzip "${1}";shift;;
    *.tar); tar xf "${1}";shift;;
    *.tbz2); tar xjvf "${1}";shift;;
    *.tgz); tar xzvf "${1}";shift;;
    *.zip); unzip "${1}";shift;;
    *.Z); uncompress "${1}";shift;;
    *.7z); 7z x "${1}";shift;;
    *) echo "$1 cannot be extracted via extract-file"; shift
esac; else; echo "$1 is not a valid file"; shift; fi; done}

function git-rm-from-repo(){
    cwd=$pwd
    repo_home=$(git rev-parse --show-toplevel)
    #cd $repo_home
    for filename in ${@}; do
        cp $filename $filename.bak
        git filter-branch --force --index-filter "git update-index --remove $filename" 
        # --prune-empty --tag-name-filter cat -- --all
        echo $filename >> $repo_home/.gitignore
        mv $filename.bak $filename
        git add $repo_home/.gitignore
        git commit -m '[!] repo rewrite'
        git push --force
    done
    cat $repo_home/.gitignore | uniq > $repo_home/._gitignore
    rm $repo_home/.gitignore
    mv $repo_home/._gitignore $repo_home/.gitignore
    unset repo_home ; unset cwd
}

function checksums () {
	checkers=(md5sum sha1sum sha256sum) 
    for checker in $checkers
    do
        which $checker &>/dev/null
        if [[ $? -eq 0 ]]; then
            for file in "${@}"
            do
                echo "$checker $($checker $file)"
            done
        fi
    done
}

function cs(){
  cd $1 && lsd --group-dirs first
}


function cpath() {
    if [[ -z "$1" ]]; then
        pwd | tr -d "\r\n" | pbcopy
    else
        $1 | tr -d "\r\n" | pbcopy
    fi
}

function copyfile {
  emulate -L zsh
  clipcopy $1
  echo "File content copied to clipboard"
}

function .jupyter {
  jupyter notebook &
  sleep 5  # Wait for 5 seconds
  open "http://localhost:8888/tree?token=303a88c7bb253ede8a575d206c2ff46947a0e99e42ef57"
}

function .open() {
  if [[ -z "$1" ]]; then
    # find . -maxdepth 1 -type f -print0 | tr '\0' '\n' | peco | xargs /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl
    fd --type file --follow $hidden --exclude .git . | fzf -1 -0 --preview 'bat -n --style=numbers --color=always {}' | xargs /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl
  else
    # find $1 -maxdepth 1 -type f -print0 | tr '\0' '\n' | fzf -1 -0 --preview 'bat -n --style=numbers --color=always {}' | xargs /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl
    # fd --type file --follow $hidden --exclude .git "$1" | fzf -1 -0 --preview 'bat -n --style=numbers --color=always {}' | xargs /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl
    if [[ -f "$1" ]]; then
      find $1 -maxdepth 1 -type f -print0 | tr '\0' '\n' | fzf -1 -0 --preview 'bat -n --style=numbers --color=always {}' | xargs /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl
    else
      echo "File not found..."
      lsd -a --group-dirs last
      fd --type file -d 2 --follow $hidden --exclude .git . | fzf -1 -0 --preview 'bat -n --style=numbers --color=always {}' | xargs /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl
    fi
  fi
}

function ch() {
    fc -l $1 -1000 | tac | cut -d " " -f 3- | awk '!x[$0]++' | peco | pbcopy
}

function cmdup(){
    # List executables in $PATH
    echo $PATH | tr : '\n' |
    while IFS= read -r e; do
       setopt NO_NOMATCH
       for i in $e/*(N); do
           if [[ -x "$i" && -f "$i" ]]; then
               basename "$i"
           fi
       done
       unsetopt NO_NOMATCH
    done > /tmp/path_commands.txt

    # List Zsh native commands
    compctl -k '*' > /tmp/native_commands.txt

    # Combine the two lists
    sort -u /tmp/path_commands.txt /tmp/native_commands.txt >| ~/.cmdlist

    echo "Commands saved to ~/.cmdlist:"
    bat ~/.cmdlist

    # Clean up temporary files
    rm /tmp/path_commands.txt /tmp/native_commands.txt
}


fzf-man-widget() {
  batman="man {1} | col -bx | bat --language=man --plain --color always --theme=\"Monokai Extended\""
   man -k . | sort \
   | awk -v cyan=$(tput setaf 6) -v blue=$(tput setaf 4) -v res=$(tput sgr0) -v bld=$(tput bold) '{ $1=cyan bld $1; $2=res blue;} 1' \
   | fzf  \
      -q "$1" \
      --ansi \
      --tiebreak=begin \
      --prompt=' Man > '  \
      --preview-window '50%,rounded,<50(up,85%,border-bottom)' \
      --preview "${batman}" \
      --bind "enter:execute(man {1})" \
      --bind "alt-c:+change-preview(cht.sh {1})+change-prompt(ﯽ Cheat > )" \
      --bind "alt-m:+change-preview(${batman})+change-prompt( Man > )" \
      --bind "alt-t:+change-preview(tldr --color=always {1})+change-prompt(ﳁ TLDR > )"
  zle reset-prompt
}

# `Ctrl-H` keybinding to launch the widget (this widget works only on zsh, don't know how to do it on bash and fish (additionaly pressing`ctrl-backspace` will trigger the widget to be executed too because both share the same keycode)
bindkey '^h' fzf-man-widget
zle -N fzf-man-widget
# Icon used is nerdfont

function cmdlist(){
  count=0
  while IFS= read -r command; do
    what=$(whatis "$command" 2>/dev/null | head -n1 | awk -F'- ' '{print $2}')
    if [[ -n $what ]]; then
      printf "[%d] %s - %s\n" "$((++count))" "$command" "$what"
    fi
  done < "cmdlist" > "cmddescribe.txt"
}

function .new(){
  if [[ -n $1 ]]; then
    mkdir ~/dev/$1 && cs ~/dev/$1 && code -n ~/dev/$1
  else
    echo "Please provide a directory name"  
  fi
}

function git() {
  local cmd="$GIT_COMMAND"

  for arg in "$@"; do
    case "$arg" in
      hub) cmd="hub"; export GIT_COMMAND="$cmd";  export GIT_DIRECTORY="$PWD"; echo "Current alias: git=$GIT_COMMAND"; return;;
      lab) cmd="lab"; export GIT_COMMAND="$cmd";  export GIT_DIRECTORY="$PWD"; echo "Current alias: git=$GIT_COMMAND"; return;;
      git) cmd="git"; export GIT_COMMAND="$cmd";  export GIT_DIRECTORY="$PWD"; echo "Current alias: git=$GIT_COMMAND"; return;;
      check-alias) echo "Current alias: git=$GIT_COMMAND"; return;;
    esac
  done

  if [ "$PWD" != "$GIT_DIRECTORY" ]; then
    unset GIT_COMMAND
    cmd=""
  fi

  if [ -n "$cmd" ]; then
    command $cmd "$@"
    return
  fi

  local cmd="hub"
  if [[ "$remote_url" == *"://gitlab.com/"* || "$remote_url" == "git@gitlab.com:"* ]]; then
    cmd="lab"
  elif [[ "$remote_url" == *"://bitbucket.org/"* || "$remote_url" == "git@bitbucket.org:"* ]]; then
    cmd="git"
  fi

  export GIT_COMMAND="$cmd"
  export GIT_DIRECTORY="$PWD"

  /usr/bin/git "$@"
  
  if [[ ${PIPESTATUS[0]} -ne 0 ]]; then
    /usr/bin/git "$@"
    unset GIT_COMMAND
    unset GIT_DIRECTORY
  fi
}

function gpb {
    git fetch --prune
    local temp_file="/tmp/branches.txt"
    echo "| Local |" > $temp_file
    git branch --format='%(refname:short)' >> $temp_file
    echo "| Remote |" >> $temp_file
    git branch -r --format='%(refname:short)' | sed 's/^origin\///' >> $temp_file

    local branch=$(cat $temp_file | fzf \
        --preview-window=right:80% \
        --preview '
            if [[ {} == "| Local |" || {} == "| Remote |" ]]; then
                echo ""
            elif [[ {} == "main" || {} == "master" ]]; then
                echo "Branch: {}"
                echo "────────────────────────────────────────"
                git log --oneline --color=always --first-parent {} 2>/dev/null
            else
                echo "Branch: {}"
                echo "────────────────────────────────────────"
                base=$(git merge-base {} origin/HEAD 2>/dev/null || git merge-base {} main 2>/dev/null)
                result=$(git log --oneline --color=always --first-parent ${base}..{} 2>/dev/null)
                [ -z "$result" ] && echo "No unique commits on this branch" || echo "$result"
            fi
        ')

    if [[ -n $branch && $branch != "| Local |" && $branch != "| Remote |" ]]; then
        if ! git show-ref --verify --quiet refs/heads/$branch; then
            git fetch origin $branch:$branch
        fi

        git switch "$branch"
    else
        echo "No branch selected."
    fi

    rm $temp_file
}

function gsm {
  git switch main
}

function gcam() {
  if [[ ! -z $1 ]]; then
    git add . && git commit -m "$1"
    echo "pushing commit..."
    git push
  else
    echo "Git commit needs a message"
  fi
}

# function gdb {
#     local temp_file="/tmp/branches.txt"

#     echo "| Local |" > $temp_file
#     git branch --format='%(refname:short)' >> $temp_file

#     local branch=$(cat $temp_file | fzf --no-preview)

#     if [[ -n $branch && $branch != "Local" ]]; then
#         # check if the branch is 'main' or 'master'
#         if [[ $branch == "main" || $branch == "master" ]]; then
#             echo "Cannot delete main or master branch."
#             return
#         fi

#         # delete branch locally
#         git branch -D $branch
#         echo "Deleted the branch: $branch"
#     else
#         echo "No branch selected."
#     fi

#     rm $temp_file
# }

function gdb {
    # Fetch local branches
    local branch=$(git branch --format='%(refname:short)' | fzf --no-multi \
        --preview '
            if [[ {} == "main" || {} == "master" ]]; then
                git log --oneline --color=always --first-parent {} 2>/dev/null
            else
                base=$(git merge-base {} origin/HEAD 2>/dev/null || git merge-base {} main 2>/dev/null)
                result=$(git log --oneline --color=always --first-parent ${base}..{} 2>/dev/null)
                [ -z "$result" ] && echo "No unique commits on this branch" || echo "$result"
            fi
        ')

    # Trim 'local/' if it's part of the branch name
    branch=${branch#local/}

    # If no branch is selected
    if [[ -z $branch ]]; then
        echo "No branch selected."
        return
    fi

    # If 'main' or 'master' branch is selected
    if [[ $branch == "main" || $branch == "master" ]]; then
        echo "Cannot delete main or master branch."
        return
    fi

    # Check if branch exists
    if ! git show-ref --verify --quiet refs/heads/$branch; then
        echo "Branch '$branch' does not exist."
        return
    fi

    # Ask for confirmation before deleting
    read -rk1 "REPLY?Are you sure you want to delete the branch '$branch'? [y/N] "
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # Delete locally
        git branch -D $branch
        echo "Deleted the branch: '$branch'"
    else
        echo "Operation cancelled."
    fi
}

function gls {
    # Fetch local branches
    local branch=$(git branch --format='%(refname:short)' | fzf --no-multi \
        --preview '
            if [[ {} == "main" || {} == "master" ]]; then
                git log --oneline --color=always --first-parent {} 2>/dev/null
            else
                base=$(git merge-base {} origin/HEAD 2>/dev/null || git merge-base {} main 2>/dev/null)
                result=$(git log --oneline --color=always --first-parent ${base}..{} 2>/dev/null)
                [ -z "$result" ] && echo "No unique commits on this branch" || echo "$result"
            fi
        ')

    # Trim 'local/' if it's part of the branch name
    branch=${branch#local/}

    # If no branch selected (Esc pressed)
    if [[ -z $branch ]]; then
        echo "No branch selected."
        return
    fi

    # Show full colored log for selected branch
    if [[ $branch == "main" || $branch == "master" ]]; then
        git log --first-parent \
            --color=always \
            --pretty=format:"%C(yellow)%h%Creset %C(bold blue)%an%Creset %C(green)%ad%Creset %s%C(auto)%d" \
            --date=short \
            $branch | less -R
    else
        local base=$(git merge-base $branch origin/HEAD 2>/dev/null || git merge-base $branch main 2>/dev/null)
        git log --first-parent \
            --color=always \
            --pretty=format:"%C(yellow)%h%Creset %C(bold blue)%an%Creset %C(green)%ad%Creset %s%C(auto)%d" \
            --date=short \
            ${base}..${branch} | less -R
    fi
}


function dallb {
  git branch | grep -v "main" | xargs git branch -D
}

function jdk() {
  # If no argument is supplied, list available versions.
  if [ -z "$1" ]
  then
    echo "Select a Java version:"
    version=$(asdf list java | fzf --no-preview | tr -d '[:space:]')
    if [ -z "$version" ]
    then
      echo "No version selected."
      return 1
    fi
  else
    version=$1
  fi

  # Switch the Java version
  asdf global java $version

  # Get the new Java home
  export JAVA_HOME=$(asdf where java)

  # Update the VS settings
  sed -i '' "s|\"java.jdt.ls.java.home\": \".*\"|\"java.jdt.ls.java.home\": \"$JAVA_HOME\"|g" ~/Library/Application\ Support/Code/User/settings.json

  echo "JAVA_HOME: $JAVA_HOME"
}

function ndk() {
  local version="$1"

  # Check if fzf is installed
  if ! command -v fzf &> /dev/null; then
    echo "Error: fzf is not installed. Please install it first."
    return 1
  fi

  # If no argument is supplied, list available versions using fzf
  if [ -z "$version" ]; then
    echo "Select a Node version:"
    version=$(asdf list nodejs | fzf --no-preview | tr -d '[:space:]')
    
    # Check if a version was selected
    if [ -z "$version" ]; then
      echo "No version selected."
      return 1
    fi
  fi

  # Switch the Node.js version
  if ! asdf global nodejs "$version"; then
    echo "Error: Failed to set Node.js version"
    return 1
  fi

  # Get the new Node.js home
  export NODE_HOME=$(asdf where nodejs)

  # Update VS Code settings
  local vscode_settings_file="$HOME/Library/Application Support/Code/User/settings.json"
  sed -i '' "s|\"node.npm.path\": \".*\"|\"node.npm.path\": \"$NODE_HOME\"|g" "$vscode_settings_file"

  echo "NODE_HOME: $NODE_HOME"
}

##Docker

function sps() {
    git stash
    git pull 
    git stash pop
}

# Select a docker container to start and attach to
function da() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf -1 -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker start "$cid" && docker attach "$cid"
}
# Select a running docker container to stop
function ds() {
  local cid
  cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker stop "$cid"
}
# Select a docker container to remove
function drm() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker rm "$cid"
}
# Same as above, but allows multi selection:
function drm() {
  docker ps -a | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $1 }' | xargs -r docker rm
}
# Select a docker image or images to remove
function drmi() {
  docker images | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $3 }' | xargs -r docker rmi
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cs)           find . -type d | fzf --preview 'tree -C {} | head -200' ;;
    *)            fzf "$@" ;;
  esac
}

funtion s() {
  git status -sb "$@"
  return 0
}

function git.new() {
  # Fetch and display all the available .gitignore templates
  echo "Fetching the available .gitignore templates..."
  templates=$(curl -s https://api.github.com/gitignore/templates | jq -r '.[]')
  echo "Available .gitignore templates are:"
  echo $templates

  echo "Enter the type of .gitignore template you want: "
  read gitignore_type

  echo "Enter the visibility of the repository (public, private, or internal): "
  read repo_visibility

  # Check if repo_visibility is empty, if so, set it to public
  if [ -z "$repo_visibility" ]
  then
    repo_visibility="public"
  fi

  if [ $# -eq 0 ]
  then
    # No arguments, use the current directory name
    repo_name=$(basename `pwd`)
    # Check if the repository exists
    if ! gh repo view andersonnardi/$repo_name > /dev/null 2>&1
    then
      gh repo create $repo_name --$repo_visibility
    fi
    git init
    git remote add origin https://github.com/andersonnardi/$repo_name.git
    curl "https://api.github.com/gitignore/templates/$gitignore_type" -s | jq -r '.source' > .gitignore
    git add .gitignore &&
    git commit -m "Add .gitignore."
    git push -u origin main
  else
    # Argument is provided, use it as the directory and repository name
    repo_name=$1
    mkdir -p $repo_name &&
    cd $repo_name &&
    # Check if the repository exists
    if ! gh repo view andersonnardi/$repo_name > /dev/null 2>&1
    then
      gh repo create $repo_name --$repo_visibility
    fi
    git init
    git remote add origin https://github.com/andersonnardi/$repo_name.git
    curl "https://api.github.com/gitignore/templates/$gitignore_type" -s | jq -r '.source' > .gitignore
    git add .gitignore &&
    git commit -m "Add .gitignore."
    git push -u origin main
  fi
  ls -a
}

# Query `glog` with regex query.
function glx() {
  query="$1"
  shift
  glog --pickaxe-regex "-S$query" "$@"
}

function .zsh(){
  fun=$1

  case $fun in

    "") /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl .zshrc
    ;;

    alias*) /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl .dotfiles/zsh/aliases.zsh
    ;;

    export*) /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl .dotfiles/zsh/exports.zsh
    ;;

    function*) /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl .dotfiles/zsh/functions.zsh
    ;;

    oh*) /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl .dotfiles/zsh/oh-my-zsh.zsh
    ;;

    style*) /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl .dotfiles/zsh/style.zsh
    ;;

    *) print -P "%F{yellow}Warning:%f options are %F{green}alias%f, %F{green}exports%f, %F{green}functions%f, %F{green}oh-my-zsh%f, %F{green}style%f or %F{green}blank%f for .zshrc"

    ;;

  esac
}

prettyjson() {
  local command=$1
  shift

  case "$command" in
    s)           echo "$1" | python -m json.tool ;;
    f)           python -m json.tool "$1" ;;
    w)           curl "$1" | python -m json.tool ;;
    *) echo "Invalid command. Use 's' for string, 'f' for file, or 'w' for web." ;;
  esac

}

function hist() {
  local selected_command=$(fc -l 1 | fzf -e -1 -0 --tac +s --preview 'echo {}' --preview-window=wrap)
  if [[ -n $selected_command ]]; then
      print -z "${selected_command#*  }"
  fi
}

function fzf_ag_search() {
  if [[ -z "$1" ]]; then
   echo "Usage: fzf_ag_search <search_term>"
   return 1
  fi

  local search_term_start="$1\b"
  local search_term_end="\b$1"

  # Run ag to search for the term
  ag --nocolor --nogroup --ignore-dir Library --ignore-dir System --ignore-dir Application "$search_term_start|$search_term_end" |

  # Pipe the results to fzf for interactive filtering    
  fzf --delimiter : --preview 'echo {1} && echo "\n---\nDirectory Tree:\n---\n" && tree -C -L 2 $(dirname {1}) && echo "\n---\nPreview File:\n---\n" && bat --color=always --style=numbers,changes {1}' --preview-window=right:60%:wrap --query="$1" |
 
  # Use awk to get the first field which is the file path, then xargs to open the file with Sublime
  awk -F : '{print $1}' | xargs /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl
}

function talisman.switch() {

  # Check if Talisman is enabled globally
  if [ -f "${HOME}/.talisman" ]; then
    # Talisman is enabled, so disable it
    echo "Talisman is currently enabled. Disabling it now."
    curl --silent  https://raw.githubusercontent.com/thoughtworks/talisman/main/global_install_scripts/uninstall.bash > /tmp/uninstall_talisman.bash && /bin/bash /tmp/uninstall_talisman.bash
    sed -i '/export TALISMAN_HOME=$HOME\/.talisman\/bin/d' ~/.dotfiles/zsh/exports.zshrc
    ls -a
  else
    # Talisman is disabled, so enable it
    echo "Talisman is currently disabled. Enabling it now..."
    curl --silent  https://raw.githubusercontent.com/thoughtworks/talisman/main/global_install_scripts/install.bash > /tmp/install_talisman.bash && /bin/bash /tmp/install_talisman.bash
    if [ -f "${HOME}/.talisman" ]; then
      # export TALISMAN\_HOME=$HOME/.talisman/bin
      echo 'export TALISMAN_HOME=$HOME/.talisman/bin' >> ~/.dotfiles/zsh/exports.zsh
      echo "Talisman is successfully installed!"
    else
      echo "Talisman was not been installed!"
    fi
  fi
}

# Override fzf function, use $(ag) instead of $(find)
function _fzf_compgen_path() {
    ag -g "" "$1"
}
