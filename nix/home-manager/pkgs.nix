nixpkgs: nixpkgsForJava: nixpkgsForFrequentUpdates: direnv-instant: system:
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

      direnvInstantOverlay = _: _: {
        direnv-instant = direnv-instant.packages.${system}.default;
      };

      direnvOverlay = _: prev: {
        direnv = prev.direnv.overrideAttrs (_: {
          doCheck = false;
        });
      };

      nodejsOverlay = final: _: {
        nodejs = final.${mangling.nodejs};
      };

      # Every scala tool in nixpkgs takes a `jre` argument resolved against the
      # final package set, so setting jdk/jre here is enough: bloop, coursier,
      # giter8, metals, sbt, scala-cli and scalafmt all run on graal.
      javaOverlay = _: _: {
        jdk = graalvm;
        jre = graalvm;
      };
    in
    [
      claudeCodeOverlay
      direnvInstantOverlay
      direnvOverlay
      javaOverlay
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
