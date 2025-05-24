nixpkgs: nixpkgsForJava: system: let
  mangling = {
    java = "graalvm-ce";
    nodejs = "nodejs_22";
  };

  overlays = let
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
