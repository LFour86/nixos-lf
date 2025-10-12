final: prev: let
  version = "1.17.2-1";
  fname = "io.github.msojocs.bilibili_${version}_amd64.deb";
  path = "/home/lfour/LocalApps/${fname}";
  shaHash = "0jmid5miq5a4f306sxkxdgranvnb9h8s0902355jccb44k7r4w3i";
in {
  bilibili-local = prev.bilibili.overrideAttrs (old: {
    src = prev.fetchurl {
      url = "file://${path}";
      sha256 = shaHash;
    };
  });
}
