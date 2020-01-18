if status is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx -- -keeptty
    end
end
#if status is-interactive
#and not set -q TMUX
#    exec tmux
#end

set -xg EDITOR nvim
set -xg TERMINAL termite
# go env
set -xg GOROOT /usr/lib/go
set -xg GOPATH ~/gopath/go
set -xg GOBIN $GOPATH/gobin
set -xg PATH $GOROOT/bin $GOBIN:/usr/local/bin $PATH
set -xg GOPROXY "https://goproxy.io"

# input
set -xg GTK_IM_MODULE ibus
set -xg XMODIFIERS @im ibus
set -xg QT_IM_MODULE ibus

# alias
alias ht="htop"
alias vim="nvim"

# command
command ibus-daemon -d -x
command setxkbmap -option ctrl:nocaps

# disable greeting message
set fish_greeting

# highlight
set hilite (which highlight)
set -xg LESSOPEN "| $hilite %s --out-format xterm256 --quiet --force "
set -xg LESS " -R"

function less
    command less -m -N -g -i -J --underline-special --SILENT $argv
end
