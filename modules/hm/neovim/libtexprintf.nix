{
  lib,
  stdenv,
  fetchFromGitHub,
  autoreconfHook,
}:
stdenv.mkDerivation {
  pname = "libtexprintf";
  version = "1.31";

  src = fetchFromGitHub {
    owner = "bartp5";
    repo = "libtexprintf";
    rev = "18977837b20649d56a651eb6bf846f1c914db77a"; # v1.31
    hash = "sha256-OXDcohfSfik0H1MpoznN267OVTYkW75N+TIF6lRRvZ0=";
  };

  nativeBuildInputs = [ autoreconfHook ];
  postPatch = ''
    patchShebangs *.sh
  '';
  enableParallelBuilding = true;
  # The test scripts share temporary files in the test directory.
  enableParallelChecking = false;
  doCheck = true;

  meta = {
    description = "Render TeX-like math as Unicode text with utftex";
    homepage = "https://github.com/bartp5/libtexprintf";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.unix;
    mainProgram = "utftex";
  };
}
