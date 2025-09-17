{pkgs, ...}:
{
  home.packages = with pkgs;[
	# Daily Applications
	bilibili
	element-desktop
	google-chrome
	firefox
	kitty
	motrix
	peazip
	spotify
	scrcpy
	sillytavern
	#todesk
	vlc
	wpsoffice-cn

	# Chat
	qq
	telegram-desktop
	wechat-uos
	wemeet

	# Ventoy
	#ventoy-full
	#ventoy-full-gtk

	# Network Proxy
	clash-rs
	clash-verge-rev
	v2ray
	v2rayn

	# Editor
	zed-editor

	# C/C++
	arduino-ide
	jetbrains.clion

	# CAD
	#kicad
	#kicadAddons.kikit
	
	# Java
	#jetbrains.idea-ultimate

	# Python
	jetbrains.pycharm-professional

	# Qt
	#qtcreator

	# Game
	#hmcl
	melonDS
	mgba
	prismlauncher
  ];
}

