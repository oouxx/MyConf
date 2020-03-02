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
set -xg PAGER less
set -xg GTAGSLABEL ctags
# go env
set -xg GOROOT /usr/lib/go
set -xg GOPATH ~/go
set -xg GOBIN $GOPATH/gobin
set -xg PATH $HOME/.cargo/bin $GOROOT/bin $GOBIN $HOME/.local/bin $PATH
set -xg GOPROXY "https://goproxy.io"

# input
set -xg GTK_IM_MODULE fcitx
set -xg XMODIFIERS @im=fcitx
set -xg QT_IM_MODULE fcitx
set -xg LC_CTYPE zh_CN.UTF-8

# alias
alias ht="htop"
alias dk="sudo docker"
alias dkc="sudo docker-compose"
alias vim="nvim"

# command
command setxkbmap -option ctrl:nocaps
command setxkbmap -option altwin:swap_lalt_lwin

# disable greeting message
set fish_greeting
