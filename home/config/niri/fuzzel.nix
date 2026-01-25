{ ... }:

{
  xdg.configFile."fuzzel/fuzzel.ini".text = ''
    [main]
    font=Maple Mono NF CN:size=12
    icons-enabled=yes
    horizontal-pad=40
    vertical-pad=20
    inner-pad=10
    width=40
    anchor=center

    [colors]
    background=FBD0B520
    text=4A3E37ff
    selection=F6BF8C80
    selection-text=4A3E37ff
    border=E6D6A8ff
    match=E06C75ff
    selection-match=E06C75ff

    [border]
    width=1
    radius=12
  '';
}

