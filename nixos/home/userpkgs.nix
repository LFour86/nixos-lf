{pkgs, ...}:
{
  home.packages = with pkgs;[
	# Daily Applications
	#bilibili
	element-desktop
	google-chrome
	firefox
	kitty
	llama-cpp
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
	#wechat-uos
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
	#zed-editor

	# C/C++
	jetbrains.clion

	# STM32
	stm32cubemx

	# Arduino/ESP32
	arduino-ide
	
	# CAD
	#kicad
	#kicadAddons.kikit
	
	# Java
	jetbrains.idea-ultimate

	# Python
	jetbrains.pycharm-professional

	# Qt
	qtcreator

	# Game
	melonDS
	mgba
	prismlauncher
  ];
}

