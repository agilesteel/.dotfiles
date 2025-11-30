nixpkgs: nixpkgsForJava: nixpkgsForFrequentUpdates: system: let
  mangling = {
    java = "graalvm-ce";
    nodejs = "nodejs_24";
  };

  overlays = let
    bloopOverlay = final: prev: {
      bloop = prev.bloop.override {
        jre = final.jre;
      };
    };

    claudeCodeOverlay = final: prev: let
      overlays = [ (_: _: { nodejs = final.${mangling.nodejs}; }) ];
      pkgsForFrequentUpdates = import nixpkgsForFrequentUpdates {
        inherit system overlays;
        config.allowUnfree = true;
      };
    in {
      claude-code = pkgsForFrequentUpdates.claude-code;
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
    claudeCodeOverlay
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
