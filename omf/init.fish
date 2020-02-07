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
set -xg PATH $HOME/.cargo/bin $GOROOT/bin $GOBIN $HOME/.local/bin $PATH
set -xg GOPROXY "https://goproxy.io"

# input
set -xg GTK_IM_MODULE ibus
set -xg XMODIFIERS @im ibus
set -xg QT_IM_MODULE ibus

# alias
alias ht="htop"
alias vim="nvim"

# command
# command ibus-daemon -d -x -r
# command setxkbmap -option ctrl:nocaps
# command setxkbmap -option altwin:swap_lalt_lwin

# disable greeting message
set fish_greeting
