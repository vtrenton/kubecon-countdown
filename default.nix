{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation {
  name = "kubecon";

  src = ./.;

  buildInputs = [ pkgs.go ];

  # Set the Go build cache to a writable directory
  buildPhase = ''
    export GOCACHE=$(mktemp -d)
    go build -o kubecon kubecon.go
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp kubecon $out/bin/
  '';
}
