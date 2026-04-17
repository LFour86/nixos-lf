final: prev: let
  version = "1.17.6-1";
  fname = "io.github.msojocs.bilibili_${version}_amd64.deb";
in 
{
  bilibili-local = prev.bilibili.overrideAttrs (old: {
    version = version;
    src = ./local-apps/${fname};
    postInstall = (old.postInstall or "") + ''
      substituteInPlace $out/share/applications/*.desktop \
        --replace-fail "StartupWMClass=" "StartupWMClass=bilibili" || true
      echo "StartupWMClass=bilibili" >> $out/share/applications/*.desktop
    '';
  });
}

