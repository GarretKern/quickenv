# -------------------------------
# 1. ENVIRONMENT CONFIGURATION
# -------------------------------

#--- Path Management ---
export PATH=$PATH:~/.devenv/bin # Add devenv bin to path

#--- Terminal Colors ---
export TERM=xterm-256color
export CLICOLOR=1
if [ -x /usr/bin/dircolors ]; then # Enable color support for ls
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

#--- Terminal History ---
# Undocumented feature which sets the size to "unlimited".
# https://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
export HISTCONTROL=ignoreboth # ignore blanks and duplicated
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

#--- Prompt ---
#export PS1="\[\e[1;32m\]\W \[\e[1;35m\]> \[\e[0m\]" # Single line prompt (only current folder)
export PS1="\[\e[1;35m\]┬─\[\e[1;32m\][\w]\n\[\e[1;35m\]╰> \[\e[0m\]" # Multiline prompt (full current path)

#--- Commands ---
shopt -s cdspell # Fix minor spelling mistakes when changing directories
shopt -s checkwinsize # Update window values based on size after a command


# -----------------------------
# 2. ALIASES
# -----------------------------

#--- Navigation ---
# Folder shortcuts
alias doc='cd ~/Documents'
alias down='cd ~/Downloads'
alias desk='cd ~/Desktop'
alias devenv='cd ~/.devenv'
# CD shortcuts
alias ~='cd ~'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
# LS shortcuts
alias ll='ls -la' # Include hidden folders
alias lh='ls -lh' # Display  human-readable file sizes

#--- Display ---
alias sane='stty sane' # Restore terminal settings
alias tmux="tmux -2" # Tmux with colors forced
alias tas='tmux attach-session' # Open most recent tmux session
alias cls='clear'

# --- Networks ---
alias tun0=$'echo `hostname -I` off | awk \'{print $2}\'' # Get secondary IP address (usually tun0)(print off if only 1 interface up)
alias listen="nc -nvlp 8000" # Catch a reverse shell
alias serve="sudo python -m SimpleHTTPServer 80" # Create a local fileserver
alias ports="netstat -tulanp" # List open ports
alias forest='ps -eax --forest'

# --- Development ---
alias tag='ctags -R .' # Run recursive ctags on current dir
alias spaceuse='du / -ka 2>/dev/null | sort -n -r | head -n 30' # Get top 30 largest folders
alias kali='cd ~/.devenv/docker/astral-kali && ./run.sh'
alias src='source ~/.bashrc'
alias bashrc='nvim ~/.bashrc'
alias tmuxconf='nvim ~/.tmux.conf'
alias colors='for i in {0..255}; do printf "\x1b[38;5;${i}mcolour${i}\x1b[0m\n"; done' # Show 256 colours

# --- Applications ---
alias finder='open -a Finder ./' # Open finder in current dir
alias msfconsole='sudo msfconsole' # For listening to reverse shells on low ports


# -----------------------------
# 3. FUNCTIONS
# -----------------------------

# If given an argument set working directory, otherwise jump to working directory
wd() {
    if [ $# -eq 0 ]; then
        cd `cat ~/.workdir`
    else
        echo $1 > ~/.workdir
    fi
}

# Recursive word find
r() { 
    grep "$1" ${@:2} -R . 2>/dev/null
}

# Recursive file find
f() { 
    find . -iname "*$1*" ${@:2} 2>/dev/null
}

# Grep in history
hg() {
    history | grep "$1" ${@:2}
}

# Make and cd into a directory
mkcd() {
    mkdir -p "$@" && cd "$_";
}

# Git add, commit, and push
gitterdone() {
    git add -A; git commit -m "$1"; git push
}

# Extract files based on file type
extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}


# -----------------------------
# 4. LOCAL
# -----------------------------

# Prioritize local configurations
if [ -f ~/.bash_local ]; then 
    source ~/.bash_local
fi
