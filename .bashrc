#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTSIZE=-1
export HISTTIMEFORMAT="[%F %H:%M] "

# generic setup
function parse_git_branch () {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

function show_opam_switch () {
    current_switch="$(opam switch show)"
    if [ ! -z "$current_switch" ] && [ "$current_switch" != "default" ]; then
        echo $(echo $current_switch | rev | cut -d'/' -f1 | rev) "← "
    fi
}

function idf_venv() {
    if [ ! -z "$IDF_PATH" ]; then
        echo "(idf-env) "
    fi
}

# mkdir and follow into dir
function mkdirf () {
    mkdir -p $1 && cd $1
}

# get some random bytes
function random () {
    head -c$1 /dev/urandom | tr -dc 'a-zA-Z0-9~!@#$%^&*(_-'
}

# Customize prompt
if [ -n "$SSH_CLIENT" ]; then
    ssh_text="ssh"
fi
if [ -z $STY ]; then
    export PS1="\[\033[1;32m\]\$(idf_venv)\[\033[0;34m\]\$(show_opam_switch)\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h\[\033[36;1m\]#$ssh_text\[\033[32m\]:\[\033[33;1m\]\W\[\033[m\]\[\033[34;1m\]\$(parse_git_branch)\[\033[m\]$ "
else
    export PS1="\[\033[1;32m\]\$(idf_venv)\[\033[0;34m\]\$(show_opam_switch)\[\033[36m\]\u\[\033[m\]@\[\033[32m\]$STY\[\033[36;1m\]#$ssh_text\[\033[32m\]:\[\033[33;1m\]\W\[\033[m\]\[\033[34;1m\]\$(parse_git_branch)\[\033[m\]$ "
fi

# Alias
alias sr='screen -r'
alias sls='screen -ls'
alias diff='colordiff'
alias e='emacsclient -t'
alias se='sudo emacs -nw'
alias vi='vim'
alias wip='git add -A && git commit -m \"wip\"'
alias etags='etags .*{c,C,cc,cpp,h,hh,hpp,cpp}'
alias r='rg'
alias grep='grep --color'
alias g='googler'
alias pt='prototool'
alias t='tmux'
alias idf='. /usr/local/esp-idf/export.sh'

export ALTERNATE_EDITOR=""
export EDITOR="vim"
export VISUAL="vim"

# NOTE: These env vars happen to be wanted. This also happens to fix a weird bug (just for reference):
# This is a hack to avoid sbt/scala jline error introduced in the latest ncurses update
# Ticket: https://github.com/sbt/sbt/issues/3240
#export TERM=xterm-256color
#export TERMCAP=


# if Mac
if [ "$(uname)" = "Darwin" ]; then
export HADOOP_HOME="`brew --prefix hadoop`"
export MONO_GAC_PREFIX="/usr/local"
export BASH_SILENCE_DEPRECATION_WARNING=1
setjdk() { # Set java version on the fly
    export JAVA_HOME=$(/usr/libexec/java_home -v $1)
}
export CLICOLOR=1
export LSCOLORS=DxFxCxAxBxegedabagacad
alias ls=' ls -GFh'

# if Linux
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    export LS_COLORS="di=1;33:ln=1;35:so=1;32:pi=1;30:ex=1;31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
    alias pbcopy='xsel --clipboard --input'
    alias c=pbcopy
    alias pbpaste='xsel --clipboard --output'
    alias v=pbpaste
    alias open='xdg-open'
    alias ls='ls --color=auto'

    # Setup keychain
    /usr/bin/keychain $HOME/.ssh/id_rsa $HOME/.ssh/id_ed25519
    /usr/bin/keychain --agents gpg AE38865D
    . $HOME/.keychain/${HOSTNAME}-sh
    . $HOME/.keychain/${HOSTNAME}-sh-gpg
    # . $HOME/.keychain/${HOSTNAME}-sh-gpg # gpg keychain
    # Flush all cached keys in memory. Any agent(s) will continue to run.
    # Rationale: any user logging in should be assumed to be an intruder
    # Passphrase is needed upon login, but cron jobs (etc...) will still
    # run when logging out
    # /usr/bin/keychain --clear

fi

# if Arch Linux
if [ -f "/etc/arch-release" ]; then
    alias cower='cower -c'
    alias mc=minio-client
    alias wifi='sudo wifi-menu'
fi

source ~/.setup/.git-completion.bash
source ~/.setup/.bashrc.local
[ -f "/home/benj/.ghcup/env" ] && source "/home/benj/.ghcup/env" # ghcup-env

complete -cf sudo
complete -C /usr/bin/vault vault
complete -C /usr/bin/aws_completer aws
complete -C /usr/bin/terraform terraform
complete -C /usr/bin/packer packer
