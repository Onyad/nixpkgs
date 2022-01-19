{ lib
, buildPythonPackage
, fetchFromGitHub
, requests
#, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "pynut2";
  version = "2.1.2";

  src = fetchFromGitHub {
    owner = "mezz64";
    repo = "python-nut2";
    rev = version;
    sha256 = "1lg7n1frndfgw73s0ssl1h7kc6zxm7fpiwlc6v6d60kxzaj1dphx";
  };

  propagatedBuildInputs = [
    requests
  ];

  # tests are completely broken, wrong imports and old api
  #checkInputs = [
  #  pytestCheckHook
  #];

  pythonImportsCheck = [ "pynut2.nut2" ];

  meta = with lib; {
    description = "API overhaul of PyNUT, a Python library to allow communication with NUT (Network UPS Tools) servers.";
    homepage = "https://github.com/mezz64/python-nut2";
    license = with licenses; [ gpl3Plus ];
    maintainers = [ maintainers.luker ];
  };
}
