{
  description = "Banque d’exercices Typst";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "aarch64-darwin" "x86_64-darwin" "aarch64-linux" "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
      packagesFor = system: import nixpkgs { inherit system; };
    in {
      devShells = forAllSystems (system:
        let pkgs = packagesFor system; in {
          default = pkgs.mkShellNoCC {
            packages = [ pkgs.typst pkgs.gnumake pkgs.python3 ];
          };
        });
      checks = forAllSystems (system:
        let pkgs = packagesFor system; in {
          documents = pkgs.runCommand "exercices-typst" {
            nativeBuildInputs = [ pkgs.typst pkgs.gnumake pkgs.python3 ];
          } ''
            cp -R ${self} source
            chmod -R u+w source
            cd source
            make clean
            make check
            mkdir -p "$out"
            cp -R build/. "$out/"
          '';
        });
    };
}
