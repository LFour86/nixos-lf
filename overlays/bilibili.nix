final: prev: let
  version = "1.17.4-1";
  fname = "io.github.msojocs.bilibili_${version}_amd64.deb";
in {
  bilibili-local = prev.bilibili.overrideAttrs (old: {
    version = version;
    src = ./local_apps/${fname};
    # nix-prefetch-url file:///etc/nixos/overlays/local_apps/io.github.msojocs.bilibili_{$version}_amd64.deb
    # 👇
    sha256 = "1bz7b1yb7gs7n7mb7dx74807wycwm068ccr8d6wygswy7fi7fc3a";
  });
}

