{ stdenv, fetchurl, lib }:

# Note: this package is used for bootstrapping fetchurl, and thus
# cannot use fetchpatch! All mutable patches (generated by GitHub or
# cgit) that are needed here should be included directly in Nixpkgs as
# files.

stdenv.mkDerivation rec {
  pname = "expat";
  version = "2.4.5";

  src = fetchurl {
    url = "https://github.com/libexpat/libexpat/releases/download/R_${lib.replaceStrings ["."] ["_"] version}/${pname}-${version}.tar.xz";
    sha256 = "sha256-8q+Px83GOoeSDaOM1tEssRPDw6P0N0lbG2VB4M/zJXk=";
  };

  outputs = [ "out" "dev" ]; # TODO: fix referrers
  outputBin = "dev";

  configureFlags = lib.optional stdenv.isFreeBSD "--with-pic";

  outputMan = "dev"; # tiny page for a dev tool

  doCheck = true; # not cross;

  preCheck = ''
    patchShebangs ./configure ./run.sh ./test-driver-wrapper.sh
  '';

  # CMake files incorrectly calculate library path from dev prefix
  # https://github.com/libexpat/libexpat/issues/501
  postFixup = ''
    substituteInPlace $dev/lib/cmake/expat-${version}/expat-noconfig.cmake \
      --replace "$"'{_IMPORT_PREFIX}' $out
  '';

  meta = with lib; {
    homepage = "https://libexpat.github.io/";
    description = "A stream-oriented XML parser library written in C";
    platforms = platforms.all;
    license = licenses.mit; # expat version
  };
}
