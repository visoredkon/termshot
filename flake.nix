{
  description = "termshot - Creates screenshots based on terminal command output";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.buildGoModule {
          pname = "termshot";
          version = "0.6.0";
          src = pkgs.fetchFromGitHub {
            owner = "visoredkon";
            repo = "termshot";
            rev = "main";
            hash = "sha256-z4ODmMUK3sMkxA4Eogm7Pgw5P55Lb1P/WJHU/6AzGpw=";
          };
          vendorHash = "sha256-hr8APRaM/ur9gtRsGIsthhrGnDm7j0fE1aqiwKZKL7s=";

          checkFlags = [
            "-skip=^TestPtexec$"
          ];

          meta = {
            description = "Creates screenshots based on terminal command output";
            homepage = "https://github.com/visoredkon/termshot";
            license = pkgs.lib.licenses.mit;
            mainProgram = "termshot";
          };
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            go
            golangci-lint
          ];
        };
      }
    );
}
