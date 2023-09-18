{ lib, stdenv
, fetchurl
, gettext
, gnome
, itstool
, libxml2
, yelp-tools
}:

stdenv.mkDerivation rec {
  pname = "gnome-user-docs";
  version = "45.0";

  src = fetchurl {
    url = "mirror://gnome/sources/gnome-user-docs/${lib.versions.major version}/${pname}-${version}.tar.xz";
    sha256 = "/xy73A4Qnpm4YKj74zW3OUjgvpzbftnDhKuSyCQ9POE=";
  };

  nativeBuildInputs = [
    gettext
    itstool
    libxml2
    yelp-tools
  ];

  enableParallelBuilding = true;

  passthru = {
    updateScript = gnome.updateScript {
      packageName = pname;
    };
  };

  meta = with lib; {
    description = "User and system administration help for the GNOME desktop";
    homepage = "https://help.gnome.org/users/gnome-help/";
    license = licenses.cc-by-30;
    maintainers = teams.gnome.members;
    platforms = platforms.all;
  };
}
