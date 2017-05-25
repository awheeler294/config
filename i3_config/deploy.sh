#!/bin/bash
VER=$(date "+%Y.%m.%d-%H.%M.%S").ver

safe_copy () {
	local src_dir=$1
	local file=$2
	local dest_dir=$3

	mkdir -p $dest_dir
	if [ -f $dest_dir/$file ]
	then
		mv $dest_dir/$file $dest_dir/$file.$VER
		echo Backup $dest_dir/$file as $dest_dir/$file.$VER
	fi
	cp $src_dir/$file $dest_dir/$file
	echo Copy $file to $dest_dir/$file
}

enviroment_options='KDE i3 Cancel'

PS3='Select Environment: '
select environment in $enviroment_options
do
	if [ $environment == 'KDE' ]
	then

		distro_packages='i3-default-artwork i3-gaps i3-help i3-scripts i3exit i3lock i3status-manjaro artwork-i3 conky-i3 perl-anyevent-i3 dmenu-manjaro rofi xfce4-terminal pamac'  
		for package in $distro_packages
		do
			if [ ! $(sudo pacman -Qi $package > /dev/null) ]
			then
				to_install=${to_install:+$to_install }$package
			fi
		done	
		sudo pacman -S --noconfirm $to_install

		AUR_packages='unclutter-xfixes-git micro google-chrome vivaldi'
		for package in $AUR_packages
		do
			if [ ! $(sudo pacman -Qi $package > /dev/null) ]
			then
				to_install=${to_install:+$to_install }$package
			fi
		done
		sudo yaourt -Syua --noconfirm $to_install
		
		safe_copy i3_kde set_window_manager.sh ~/.config/plasma-workspace/env
		 
		safe_copy xfce4_terminal terminalrc ~/.config/xfce4/terminal

		safe_copy bash .bashrc ~
		
		git config --global user.email "awheeler294@gmail.com"
		git config --global user.name "awheeler294"
		
		for file in $( ls i3_kde/i3_files )
		do
			safe_copy i3_kde/i3_files $file ~/.i3
		done
		
		for file in $( ls xfce4_terminal/color_schemes )
		do
			safe_copy xfce4_terminal/color_schemes $file ~/.local/share/xfce4/terminal/colorschemes
		done
		
		break
		
	elif [ $environment == 'i3' ]
	then
		echo TODO

		break
		
	else
		echo Exit

		break
		
	fi	
done
