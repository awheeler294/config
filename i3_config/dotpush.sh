#!/bin/bash

#cp ~/.vimrc vim/
#cp ~/.tmux.conf tmux/

#cp ~/powersettings.sh ../scripts/
#cp ~/bat.sh ../scripts/


mkdir -p bash
cp ~/.bashrc bash/

mkdir -p i3_kde/i3_files
cp ~/.config/plasma-workspace/env/set_window_manager.sh i3_kde/

for file in $( ls ~/.i3 )
do
	#echo file: $file
	cp ~/.i3/$file i3_kde/i3_files/
done

mkdir -p xfce4_terminal/color_schemes
cp ~/.config/xfce4/terminal/terminalrc xfce4_terminal/

for file in $( ls ~/.local/share/xfce4/terminal/colorschemes/ )
do
	#echo file: $file
	cp ~/.local/share/xfce4/terminal/colorschemes/$file xfce4_terminal/color_schemes/
done

# push changes
git add .
git status
read -p "Commit message? " answer
git commit -m "$answer"
git push