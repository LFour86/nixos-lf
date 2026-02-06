{ pkgs, inputs, config, ... }:
{
  # install package
  home.packages = with pkgs; [
    inputs.noctalia-shell.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  # configure options
  programs.noctalia-shell = {
    enable = true;
    settings = {
      settingsVersion = 45;
      
      # Bar Configuration
      bar = {
        barType = "simple";
        position = "top";
        monitors = [];
        density = "standard";
        showOutline = false;
        showCapsule = false;
        capsuleOpacity = 1;
        backgroundOpacity = 0.8;
        useSeparateOpacity = true;
        floating = false;
        marginVertical = 6;
        marginHorizontal = 4;
        frameThickness = 8;
        frameRadius = 12;
        outerCorners = true;
        exclusive = true;
        hideOnOverview = false;
        
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
              colorizeDistroLogo = false;
              colorizeSystemIcon = "none";
              customIconPath = "";
              enableColorization = false;
              icon = "noctalia";
            }
            { id = "plugin:mpvpaper"; }
            {
              id = "Network";
              displayMode = "onhover";
            }
            {
              id = "plugin:network-indicator";
            }
            {
              id = "Bluetooth";
              displayMode = "onhover";
            }
            {
              id = "Tray";
              blacklist = [];
              colorizeIcons = false;
              drawerEnabled = true;
              hidePassive = false;
              pinned = [];
            }
          ];
          center = [
            {
              id = "Workspace";
              characterCount = 2;
              colorizeIcons = false;
              emptyColor = "secondary";
              enableScrollWheel = true;
              focusedColor = "primary";
              followFocusedScreen = false;
              groupedBorderOpacity = 1;
              hideUnoccupied = false;
              iconScale = 1.0;
              labelMode = "none";
              occupiedColor = "secondary";
              showApplications = false;
              showBadge = true;
              showLabelsOnlyWhenOccupied = true;
              unfocusedIconsOpacity = 1;
            }
          ];
          right = [
            { id = "plugin:catwalk"; }
            { id = "plugin:assistant-panel"; }
            { id = "plugin:timer"; }
            { id = "plugin:simple-notes"; }
            { id = "plugin:todo"; }
            { id = "plugin:clipper"; }
            { id = "plugin:weather-indicator"; }
            { id = "plugin:weekly-calendar"; }
            {
              id = "Clock";
              customFont = "";
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              tooltipFormat = "HH:mm ddd, MMM dd";
              useCustomFont = false;
              usePrimaryColor = true;
            }
            {
              id = "Battery";
              deviceNativePath = "";
              displayMode = "onhover";
              hideIfIdle = false;
              hideIfNotDetected = true;
              showNoctaliaPerformance = false;
              showPowerProfiles = false;
              warningThreshold = 30;
            }
          ];
        };
        screenOverrides = [];
      };

      # General Settings
      general = {
        avatarImage = "${config.home.homeDirectory}/.face";
        dimmerOpacity = 0.2;
        showScreenCorners = false;
        forceBlackScreenCorners = false;
        scaleRatio = 1.0;
        radiusRatio = 0.2;
        iRadiusRatio = 1;
        boxRadiusRatio = 1;
        screenRadiusRatio = 1;
        animationSpeed = 1;
        animationDisabled = false;
        compactLockScreen = false;
        lockOnSuspend = true;
        showSessionButtonsOnLockScreen = true;
        showHibernateOnLockScreen = false;
        enableShadows = true;
        shadowDirection = "bottom_right";
        shadowOffsetX = 2;
        shadowOffsetY = 3;
        language = "";
        allowPanelsOnScreenWithoutBar = true;
        showChangelogOnStartup = true;
        telemetryEnabled = false;
        enableLockScreenCountdown = true;
        lockScreenCountdownDuration = 30000;
        autoStartAuth = false;
      };

      # UI Settings
      ui = {
        fontDefault = "Maple Mono NF CN";
        fontFixed = "Maple Mono NF CN";
        fontDefaultScale = 1;
        fontFixedScale = 1;
        tooltipsEnabled = true;
        panelBackgroundOpacity = 0.8;
        panelsAttachedToBar = true; 
        settingsPanelMode = "attached";
        wifiDetailsViewMode = "grid";
        bluetoothDetailsViewMode = "grid";
        networkPanelView = "wifi";
        bluetoothHideUnnamedDevices = false;
        boxBorderEnabled = false;
      };

      # Location & Weather
      location = {
        name = "Shanghai, China";
        weatherEnabled = true;
        weatherShowEffects = true;
        useFahrenheit = false;
        use12hourFormat = false;
        showWeekNumberInCalendar = false;
        showCalendarEvents = true;
        showCalendarWeather = true;
        analogClockInCalendar = false;
        firstDayOfWeek = -1;
        hideWeatherTimezone = false;
        hideWeatherCityName = false;
      };

      # Calendar Cards
      calendar = {
        cards = [
          { enabled = true; id = "calendar-header-card"; }
          { enabled = true; id = "calendar-month-card"; }
          { enabled = true; id = "weather-card"; }
        ];
      };

      # Wallpaper Configuration
      wallpaper = {
        enabled = true;
        overviewEnabled = false;
        directory = "${config.home.homeDirectory}/Pictures/Wallpapers";
        monitorDirectories = [];
        enableMultiMonitorDirectories = false;
        showHiddenFiles = false;
        viewMode = "single";
        setWallpaperOnAllMonitors = true;
        fillMode = "crop";
        fillColor = "#000000";
        useSolidColor = false;
        solidColor = "#1a1a2e";
        automationEnabled = false;
        wallpaperChangeMode = "random";
        randomIntervalSec = 300;
        transitionDuration = 1500;
        transitionType = "random";
        transitionEdgeSmoothness = 0.05;
        panelPosition = "follow_bar";
        hideWallpaperFilenames = false;
        useWallhaven = false;
        wallhavenQuery = "";
        wallhavenSorting = "relevance";
        wallhavenOrder = "desc";
        wallhavenCategories = "111";
        wallhavenPurity = "100";
        wallhavenRatios = "";
        wallhavenApiKey = "";
        wallhavenResolutionMode = "atleast";
        wallhavenResolutionWidth = "";
        wallhavenResolutionHeight = "";
      };

      # App Launcher
      appLauncher = {
        enableClipboardHistory = false;
        autoPasteClipboard = false;
        enableClipPreview = true;
        clipboardWrapText = true;
        position = "center";
        pinnedApps = [];
        useApp2Unit = false;
        sortByMostUsed = true;
        terminalCommand = "xterm -e";
        customLaunchPrefixEnabled = false;
        customLaunchPrefix = "";
        viewMode = "list";
        showCategories = true;
        iconMode = "tabler";
        showIconBackground = false;
        enableSettingsSearch = true;
        ignoreMouseInput = false;
        screenshotAnnotationTool = "";
      };

      # Control Center
      controlCenter = {
        position = "close_to_bar_button";
        diskPath = "/";
        shortcuts = {
          left = [
            { id = "Network"; }
            { id = "Bluetooth"; }
            { id = "WallpaperSelector"; }
            { id = "NoctaliaPerformance"; }
          ];
          right = [
            { id = "Notifications"; }
            { id = "PowerProfile"; }
            { id = "KeepAwake"; }
            { id = "NightLight"; }
          ];
        };
        cards = [
          { enabled = true; id = "profile-card"; }
          { enabled = true; id = "shortcuts-card"; }
          { enabled = true; id = "audio-card"; }
          { enabled = false; id = "brightness-card"; }
          { enabled = true; id = "weather-card"; }
          { enabled = true; id = "media-sysmon-card"; }
        ];
      };

      # System Monitor
      systemMonitor = {
        cpuWarningThreshold = 80;
        cpuCriticalThreshold = 90;
        tempWarningThreshold = 80;
        tempCriticalThreshold = 90;
        gpuWarningThreshold = 80;
        gpuCriticalThreshold = 90;
        memWarningThreshold = 80;
        memCriticalThreshold = 90;
        swapWarningThreshold = 80;
        swapCriticalThreshold = 90;
        diskWarningThreshold = 80;
        diskCriticalThreshold = 90;
        cpuPollingInterval = 3000;
        tempPollingInterval = 3000;
        gpuPollingInterval = 3000;
        enableDgpuMonitoring = false;
        memPollingInterval = 3000;
        diskPollingInterval = 30000;
        networkPollingInterval = 3000;
        loadAvgPollingInterval = 3000;
        useCustomColors = false;
        warningColor = "";
        criticalColor = "";
        externalMonitor = "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor";
      };

      # Dock
      dock = {
        enabled = false;
        position = "bottom";
        displayMode = "auto_hide";
        backgroundOpacity = 1;
        floatingRatio = 1;
        size = 1;
        onlySameOutput = true;
        monitors = [ "eDP-1" ];
        pinnedApps = [];
        colorizeIcons = false;
        pinnedStatic = false;
        inactiveIndicators = false;
        deadOpacity = 0.6;
        animationSpeed = 1;
      };

      # Network
      network = {
        wifiEnabled = true;
        bluetoothRssiPollingEnabled = false;
        bluetoothRssiPollIntervalMs = 10000;
        wifiDetailsViewMode = "grid";
        bluetoothDetailsViewMode = "grid";
        bluetoothHideUnnamedDevices = false;
      };

      # Session Menu
      sessionMenu = {
        enableCountdown = true;
        countdownDuration = 10000;
        position = "center";
        showHeader = true;
        largeButtonsStyle = false;
        largeButtonsLayout = "grid";
        showNumberLabels = true;
        powerOptions = [
          { action = "lock"; command = ""; countdownEnabled = true; enabled = true; }
          { action = "suspend"; command = ""; countdownEnabled = true; enabled = true; }
          { action = "hibernate"; command = ""; countdownEnabled = true; enabled = true; }
          { action = "reboot"; command = ""; countdownEnabled = true; enabled = true; }
          { action = "logout"; command = ""; countdownEnabled = true; enabled = true; }
          { action = "shutdown"; command = ""; countdownEnabled = true; enabled = true; }
        ];
      };

      # Notifications
      notifications = {
        enabled = true;
        monitors = [];
        location = "top_right";
        overlayLayer = true;
        backgroundOpacity = 1;
        respectExpireTimeout = false;
        lowUrgencyDuration = 3;
        normalUrgencyDuration = 8;
        criticalUrgencyDuration = 15;
        enableKeyboardLayoutToast = true;
        saveToHistory = {
          low = true;
          normal = true;
          critical = true;
        };
        sounds = {
          enabled = false;
          volume = 0.5;
          separateSounds = false;
          criticalSoundFile = "";
          normalSoundFile = "";
          lowSoundFile = "";
          excludedApps = "discord,firefox,chrome,chromium,edge";
        };
        enableMediaToast = false;
      };

      # OSD
      osd = {
        enabled = true;
        location = "top_right";
        autoHideMs = 2000;
        overlayLayer = true;
        backgroundOpacity = 1;
        enabledTypes = [ 0 1 2 ];
        monitors = [ "eDP-1" ];
      };

      # Audio
      audio = {
        volumeStep = 5;
        volumeOverdrive = false;
        cavaFrameRate = 30;
        visualizerType = "linear";
        mprisBlacklist = [];
        preferredPlayer = "";
        volumeFeedback = false;
      };

      # Brightness
      brightness = {
        brightnessStep = 5;
        enforceMinimum = true;
        enableDdcSupport = false;
      };

      # Color Schemes
      colorSchemes = {
        useWallpaperColors = false;
        predefinedScheme = "Ayu";
        darkMode = true;
        schedulingMode = "off";
        manualSunrise = "06:30";
        manualSunset = "18:30";
        generationMethod = "tonal-spot";
        monitorForColors = "";
      };

      # Templates
      templates = {
        activeTemplates = [];
        enableUserTheming = false;
      };

      # Night Light
      nightLight = {
        enabled = false;
        forced = false;
        autoSchedule = true;
        nightTemp = "4000";
        dayTemp = "6500";
        manualSunrise = "06:30";
        manualSunset = "18:30";
      };

      # Hooks
      hooks = {
        enabled = false;
        wallpaperChange = "";
        darkModeChange = "";
        screenLock = "";
        screenUnlock = "";
        performanceModeEnabled = "";
        performanceModeDisabled = "";
        startup = "";
        session = "";
      };

      # Desktop Widgets
      desktopWidgets = {
        enabled = false;
        gridSnap = false;
        monitorWidgets = [];
      };
    };

# Plugin Configuration
    plugins = {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];

      states = {
        catwalk = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        network-indicator = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        timer = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        simple-notes = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        todo = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        clipper = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        weekly-calendar = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        mpvpaper = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        weather-indicator = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        assistant-panel = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
      version = 1;
    };

    pluginSettings = {
      catwalk = {
        minimumThreshold = 25;
        hideBackground = true;
      };
    };
  };

  # State file
  home.file.".cache/noctalia/wallpapers.json" = {
    text = builtins.toJSON {
      defaultWallpaper = "${../../wallpapers/atri.png}";
      wallpapers = {
        "eDP-1" = "${../../wallpapers/atri.png}";
      };
    };
  };
}

