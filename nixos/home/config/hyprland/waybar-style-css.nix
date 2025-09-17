{ ... }:
{
  home.file.".config/waybar/style.css".text = ''
* {
	  font-family: "Maple Mono NF CN";
	  font-weight: 600;
	  font-size: 12px;
  	  border-radius: 10px;
	  text-shadow: none;
	  transition-property: background;
	  transition-duration: 0.2s;
  }

  window#waybar {
	 background-color: rgba(0, 0, 0, 0);
	 border: none;
	 min-height: 30px;
  	 padding: 0 10px; 
  	 font-size: 12px; 
  }

  window#waybar.hidden {
	  background-color: rgba(0, 0, 0, 0);
  }

  #workspaces {
	  margin-top: 6px;
	  background: rgba(16, 20, 24, 0.5);
	  transition: none;
	  font-size: 12px;
  }

  #workspaces button {
	  border: none;
	  padding: 0 10px;
	  background-color: transparent;
	  color: #ffffff;
  }

  #workspaces button:hover {
	  background: rgba(255, 255, 255, 0.5);
  }

  #workspaces button.active {
	  background: #fff9bb;
	  color: #000000;
  }

  #workspaces button.active:hover {
	  background: #fffcdf;
  }

  #workspaces button.urgent {
	  background-color: #eb4d4b;
  }

  #mode {
	  background-color: #64727d;
	  border-bottom: 3px solid #ffffff;
  }

  #clock,
  #cpu,
  #memory,
  #network,
  #pulseaudio,
  #tray,
  #mode,

  #window {
	  margin-top: 6px;
	  padding: 0 12px;
	  color: #ffffff;
  }

  /* If workspaces is the leftmost module, omit left margin */
  .modules-left > widget:first-child > * {
  	margin-left: 16px;
  }

  /* If workspaces is the rightmost module, omit right margin */
  .modules-right > widget:last-child > * {
	  margin-right: 16px;
  }

  #clock {
	  background-color: #eefff1;
	  color: #000000;
	  padding: 0 8px; 
  }

  #cpu {
	  background-color: #ff0000;
	  color: #000000;
  }

  #memory {
	  background-color: #d2b48c;
	  color: #000000;
  }

  #pulseaudio {
	  background-color: #b0f5e5;
	  color: #000000;
  }

  #network {
	  background-color: #87ddff;
	  color: #000000;
  }

  #battery {
  	margin-top: 6px;
	  background-color: #1e90ff;
	  color: #000000;
  }

  #battery.charging,
  #battery.plugged {
  	  margin-top: 6px;
	  background-color: #7cfc00;
	  color: #000000;
  }

  #tray {
	  background-color: rgba(16, 20, 24, 0.5);
	  color: #000000;
  }

  #idle_inhibitor {
	  margin-top: 6px;
  	background-color: #ee82ee;
  	color: #000000;
  }

  #idle_inhibitor.activated {
  	margin-top: 6px;
  	background-color: #ff00ff;
  	color: #000000;
  }

  #backlight {
	  margin-top: 6px;
	  background-color: #ffff00;
	  color: #000000;
  }

  #temperature {
	  margin-top: 6px;
	  background-color: #e6c345;
	  color: #000000;
  }

  #window {
	  font-family: "Fira Mono", "Noto Sans CJK SC", sans-serif;
	  font-weight: 400;
	  background-color: #cbecff;
	  color: #000000;
  }  
'';
}

