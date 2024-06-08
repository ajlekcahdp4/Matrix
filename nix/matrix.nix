{ pkgs, stdenv, ... }:
stdenv.mkDerivation {
  src = ../.;
  pname = "Matrix";
  version = "1.0.0";
  nativeBuildInputs = with pkgs; [
    cmake
    Vector
    gtest
  ];
  installPhase = ''
    mkdir -p $out/include
    install -Dm=rw-r-r $src/lib/include/* $out/include/
  '';
  doCheck = true;
  checkPhase = ''
    ctest
  '';
}
