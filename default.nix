{ nixpkgs ? import <nixpkgs> { }
, stdenv ? nixpkgs.stdenv
, fetchFromGitHub ? nixpkgs.fetchFromGitHub
, nix ? nixpkgs.nix
, gcc ? nixpkgs.gcc
}:
let homepage = stdenv.mkDerivation {
  name = "homepage";
  src = fetchFromGitHub {
    owner = "fkz";
    repo = "nixos-homepage";
    rev = "770a5a60ceb5c9cf211d3e3657b2480b112dda66";
    sha256 = "1m15pgnqzi1vr7kdxwvx8dyi3i25mr8ri6n1h1jpzb3fc2cj9fiq";
  };
  buildInputs = [ gcc nix ];
  NIX_PATH="nixpkgs=${<nixpkgs>}";
  SSL_CERT_FILE="/etc/pki/tls/certs/ca-bundle.crt";
  buildPhase = ''
    pushd ..
    mkdir home
    mkdir home/nixpkgs
    export HOME=$(pwd)/home
    popd
    nix-shell --command make
  '';
  installPhase = ''
    cp -R . $out
  '';
};
in stdenv.mkDerivation {
  name = "uberspace";
  phases = "installPhase";
  installPhase = ''
    mkdir -p $out
    ln -s ${homepage} $out/html
  '';
}
