{
  description = "A flake to build the kubecon Go application";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in
    {
      packages.x86_64-linux.kubecon = pkgs.stdenv.mkDerivation {
        pname = "kubecon";
        version = "1.0.0";

        src = ./.;

        buildInputs = [ pkgs.go ];

        buildPhase = ''
          export GOCACHE=$(mktemp -d)
          go build -o kubecon kubecon.go
        '';

        installPhase = ''
          mkdir -p $out/bin
          cp kubecon $out/bin/
        '';

        meta = with pkgs.lib; {
          description = "A simple Go application for Kubernetes";
          license = licenses.mit;
          maintainers = [ "YourName" ];
        };
      };
    };
}
