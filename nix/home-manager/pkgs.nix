nixpkgs: nixpkgsForJava: system: let
  mangling = {
    java = "graalvm-ce";
    nodejs = "nodejs_20";
  };

  overlays = let
    armOverlay = _: prev: let
      pkgsForx86 = import nixpkgs {
        localSystem = "x86_64-darwin";
      };
    in
      prev.lib.optionalAttrs (prev.stdenv.isDarwin && prev.stdenv.isAarch64) {
        inherit (pkgsForx86) bloop;
      };

    bloopOverlay = final: prev: {
      bloop = prev.bloop.override {
        jre = final.jre;
      };
    };

    millOverlay = final: prev: {
      mill = prev.mill.override {
        jre = final.jre;
      };
    };

    nodejsOverlay = final: _: {
      nodejs = final.${mangling.nodejs};
    };

    javaOverlay = _: _: let
      pkgsForJava = import nixpkgsForJava {
        inherit system;
      };
    in {
      jdk = pkgsForJava.${mangling.java};
      jre = pkgsForJava.${mangling.java};
    };

    scalaCliOverlay = _: prev: let
      pkgsForJava = import nixpkgsForJava {
        inherit system;
      };
    in {
      scala-cli = prev.scala-cli.override {
        jre = pkgsForJava.${mangling.java};
      };
    };
  in [
    armOverlay
    bloopOverlay
    javaOverlay
    scalaCliOverlay
    millOverlay
    nodejsOverlay
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
