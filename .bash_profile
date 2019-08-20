#
# ~/.bash_profile
#
PATH=$PATH:$HOME/.cargo/bin
PATH=$PATH:$HOME/go/bin
export PATH

[[ -f ~/.bashrc ]] && . ~/.bashrc

source ~/.setup/.bash_profile.local
