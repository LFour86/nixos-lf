{pkgs, ...}:
{
  home.packages = with pkgs;[
	# Daily Applications
	bilibili-local
	google-chrome
	firefox
	motrix
	spotify
	scrcpy
	sillytavern
	wpsoffice-cn

	# Chat
	qq
	wechat
	wemeet

	# Ventoy
	#ventoy-full

	# Network Proxy
	clash-rs
	clash-verge-rev

	# Editor
	#zed-editor

	# C/C++
	jetbrains.clion

	# STM32
	stm32cubemx

	# Arduino/ESP32
	arduino-ide
	
	# EDA
	#kicad
	#kicadAddons.kikit

	# CAD
	freecad
	
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

