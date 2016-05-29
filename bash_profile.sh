# bits for .bash_profile

# function to send man page to preview
manp()
{
man -t $* | open -f -a /Applications/Preview.app/
}

# if we're going to view man pages in the Terminal, at least let's
# colour highlight them
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;37m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# syntax highlighting for less
# brew install source-highlight
export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
export LESS=" -R "

