{
  description = "MySQL example with Vlang 0.5";

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
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            # herramientas del compilador
            pkgs.gcc
            pkgs.cmake
            pkg-config
            #vlang # V 0.4.11
            libmysqlclient
            # pkgs.mariadb.client
            mariadb-connector-c
            ];

          packages = with pkgs; [
            # utilidades
            git
          ];

          shellHook = ''
            echo "⚙️  Entorno V configurado con GCC"
          '';

        };
      });
}
