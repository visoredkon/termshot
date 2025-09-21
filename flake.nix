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
            rev = "0bd0ffe7288357e302221c5de35598d2f9e859d5";
            hash = "sha256-CEk3GnrSjcyOX6gvhM90bHlJGk+FF+Xqf6OB40v6HC8=";
          };
          vendorHash = "sha256-hr8APRaM/ur9gtRsGIsthhrGnDm7j0fE1aqiwKZKL7s=";

          doCheck = false;

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
