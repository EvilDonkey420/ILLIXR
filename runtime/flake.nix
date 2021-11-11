{
  outputs = { self, nixpkgs }:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    packages.x86_64-linux.illixr-runtime = pkgs.clangStdenv.mkDerivation {
      pname = "illixr-runtime";
      version = "2.2.0-latest";
      src = ./.;
      phases = "buildPhase";

      buildPhase = ''
        cd $src
	make
        # TODO: build goes here
      '';

      installPhase = ''
        mkdir -p $out/bin
      '';

      # only available at compile-time
      buildInputs = [
        ../common
	# TODO: common headers (will have to make a flake for ../common)
	# TODO: ... other stuff
      ];

      # available at compile- and run-time
      propagatedBuildInputs = [
        # TODO: dynamic libraries
	# TODO: ... other stuff

	# plugins, dataset, monado, and OpenXR app, will be pulled in by a parent package;
	# No need for them here.
      ];
    };

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.illixr-runtime;
  };
}
