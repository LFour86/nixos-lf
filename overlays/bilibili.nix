final: prev: let
  version = "1.17.3-1";
  fname = "io.github.msojocs.bilibili_${version}_amd64.deb";
in {
  bilibili-local = prev.bilibili.overrideAttrs (old: {
    version = version;
    src = ./LocalApps/${fname};
    # nix-prefetch-url file:///etc/nixos/overlays/LocalApps/io.github.msojocs.bilibili_{$version}_amd64.deb
    # 👇
    sha256 = "0dg0f1rsw1m9q5s8crbzjg8m3lp004a0gchs63ghwsqbxws3a9ql";
  });
}

