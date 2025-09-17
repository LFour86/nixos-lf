{ ... }:
{
  home.file.".config/waybar/config".text = ''
    {
      "layer": "top",
      "position": "top", 
      "height": 30, 
      "spacing": 5,
      "modules-left": ["hyprland/workspaces","idle_inhibitor", "backlight", "tray"],
      "modules-center": ["hyprland/window"],
      "modules-right": ["pulseaudio", "memory", "cpu", "temperature", "battery", "clock"],
    
      "wlr/workspaces": {
          "format": "{icon}",
          "sort-by-number": true,
          "on-click": "activate",
          "on-scroll-up": "hyprctl dispatch workspace e+1",
          "on-scroll-down": "hyprctl dispatch workspace e-1"
      },
    
      "battery": {
        "states": {
            // "good": 95,
            "warning": 30,
            "critical": 15
        },
        "format": " {capacity}% {icon}  ",
        "format-full": "  {capacity}% {icon}  ",
        "format-charging": "  {capacity}%   ",
        "format-plugged": "  {capacity}%   ",
        "format-alt": "{time} {icon}",
        // "format-good": "", // An empty format will hide the module
        // "format-full": "",
        "format-icons": [  " "  ,  " "  ,   " "  ,  " "  ,  " "  ]
      },
      "battery#bat2": {
         "bat": "BAT2"
      },
    
      // Workspaces
      "hyprland/workspaces" : {
          "on-click": "activate",
          "active-only": false,
          "all-outputs": true,
          "format": "{}",
          "format-icons": {
			      "urgent": "",
			      "active": "",
			      "default": ""
          },
        "persistent-workspaces": {
             "*": 10
        }
      },

      "idle_inhibitor": {
            "format": "{icon}",
            "format-icons": {
                "activated": "     ",
                "deactivated": "     "
            }
      },

      "backlight": {
          //"device": "amd_backlight",
          "format": " {percent}%{icon} ",
          "format-icons": ["  ", "  "]
      },

      "tray": {
        "icon-size": 16,
        "spacing": 10
      },
     
	"hyprland/window": {
    	"format": "{:.50}",
    	"tooltip": true
	},

      // Clock
      "clock": {
         "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
         "format": " {:%a %d, %b %I:%M %p }",
         "format-alt": "{:%Y-%m-%d}"
      },
    
      "cpu": {
         "interval": 1,
         "format": "  {usage}%",
         "tooltip": false
      },

      "temperature": {
		      // "thermal-zone": 2,
		      // "hwmon-path": "/sys/class/hwmon/hwmon2/temp1_input",
		      // "critical-threshold": 80,
		      // "format-critical": "{temperatureC}C ",
		      "format": " {temperatureC}°C  "
	    },

      "memory": {
         "interval": 1,
         "format": "  {used}G",
         "tooltip": false
      },
      
      "pulseaudio": {
         "scroll-step": 5,
         "format": "{icon} {volume}%",
         "format-muted": "  ",
         "format-bluetooth": "{icon} {volume}%",
         "format-bluetooth-muted": "  {icon}",
         "format-icons": {
            "headphone": " ",
            "hands-free": " ",
            "headset": " ",
            "phone": " ",
            "portable": " ",
            "car": " ",
            "default": [" ", " ", "  "]
         },
        "on-click-right": "pavucontrol"
      }
   }
'';
}

