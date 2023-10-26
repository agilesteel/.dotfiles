nixpkgs: system: let
  mangling = {
    java = "graalvm-ce";
  };

  overlays = let
    bloopOverlay = final: prev: {
      bloop = prev.pkgsx86_64Darwin.bloop.override {
        jre = final.jre;
      };
    };

    millOverlay = final: prev: {
      mill = prev.mill.override {
        jre = final.jre;
      };
    };

    javaOverlay = final: _: {
      jdk = final.${mangling.java};
      jre = final.${mangling.java};
    };

    scalaCliOverlay = final: prev: {
      scala-cli = prev.scala-cli.override {
        # hardcoded because scala-cli requires 17 or above
        jre = final.${mangling.java};
      };
    };
  in [
    bloopOverlay
    javaOverlay
    scalaCliOverlay
    millOverlay
  ];

  pkgs = import nixpkgs {
    inherit system overlays;

    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
in
  pkgs
