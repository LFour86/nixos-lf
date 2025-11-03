final: prev: let
  version = "1.17.2-2";
  fname = "io.github.msojocs.bilibili_${version}_amd64.deb";
  absPath = "/etc/nixos/overlays/LocalApps/${fname}";
in {
  bilibili-local = prev.bilibili.overrideAttrs (old: {
    version = version;
    src = prev.fetchurl {
      url = "file://${absPath}";
      # nix-prefetch-url file:///etc/nixos/overlays/LocalApps/io.github.msojocs.bilibili_1.17.2-2_amd64.deb
      # 👇
      sha256 = "0xvhg731629jz24a92qg9ls67glwibfsa2ja1kdxbyj3f1nkan55";
    };
  });
}
