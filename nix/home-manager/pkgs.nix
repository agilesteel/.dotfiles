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
      # These track the frequently updated nixpkgs rather than the pinned one.
      # The nodejs injection is claude-code's; herdr takes no nodejs argument.
      frequentUpdatesOverlay =
        final: prev:
        let
          overlays = [ (_: _: { nodejs = final.${mangling.nodejs}; }) ];
          pkgsForFrequentUpdates = import nixpkgsForFrequentUpdates {
            inherit system overlays;
            config.allowUnfree = true;
          };
        in
        {
          inherit (pkgsForFrequentUpdates) claude-code herdr;
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
      direnvInstantOverlay
      direnvOverlay
      frequentUpdatesOverlay
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
