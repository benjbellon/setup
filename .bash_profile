#
# ~/.bash_profile
#
PATH=$PATH:$HOME/.cargo/bin
PATH=$PATH:$HOME/go/bin
PATH=$PATH:$HOME/.local/bin

export PATH

[[ -f ~/.bashrc ]] && . ~/.bashrc

source ~/.setup/.bash_profile.local

# opam configuration
test -r /home/benj/.opam/opam-init/init.sh && . /home/benj/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
