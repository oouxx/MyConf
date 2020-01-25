#!/bin/bash
rmdir $HOME/.config/i3
rmdir $HOME/.config/omf
rmdir $HOME/.config/rofi
rmdir $HOME/.config/ranger
rmdir $HOME/.config/termite
rmdir $HOME/.config/zathura
rmdir $HOME/.config/ibus
ln -srf ./i3 $HOME/.config/
ln -srf ./omf $HOME/.config/
ln -srf ./rofi $HOME/.config/
ln -srf ./ranger $HOME/.config/
ln -srf ./termite $HOME/.config/
ln -srf ./zathura $HOME/.config/
ln -srf ./ibus $HOME/.config/
ln -srf ./.spacemacs.d $HOME/
ln -srf ./.SpaceVim.d $HOME/
