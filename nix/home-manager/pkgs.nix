nixpkgs: nixpkgsForJava: nixpkgsForFrequentUpdates: system:
let
  mangling = {
    java = "graalvm-ce";
    nodejs = "nodejs_24";
  };

  pkgsForJava = import nixpkgsForJava {
    inherit system;
  };

  graalvm = pkgsForJava.graalvmPackages.${mangling.java};

  overlays =
    let
      bloopOverlay = final: prev: {
        bloop = prev.bloop.override {
          jre = final.jre;
        };
      };

      claudeCodeOverlay =
        final: prev:
        let
          overlays = [ (_: _: { nodejs = final.${mangling.nodejs}; }) ];
          pkgsForFrequentUpdates = import nixpkgsForFrequentUpdates {
            inherit system overlays;
            config.allowUnfree = true;
          };
        in
        {
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

      javaOverlay = _: _: {
        jdk = graalvm;
        jre = graalvm;
      };

      scalaCliOverlay = final: prev: {
        scala-cli = prev.scala-cli.override {
          jre = final.jre;
        };
      };
    in
    [
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
