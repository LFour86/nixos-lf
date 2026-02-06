final: prev: let
  version = "1.17.5-1";
  fname = "io.github.msojocs.bilibili_${version}_amd64.deb";
in {
  bilibili-local = prev.bilibili.overrideAttrs (old: {
    version = version;
    src = ./local_apps/${fname};
  });
}

