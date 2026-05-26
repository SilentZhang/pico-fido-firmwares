{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  cmake,
  gcc-arm-embedded,
  picotool,
  python3,
  pico-sdk,
  pico-lib ? import ../../lib {
    inherit
      lib
      stdenvNoCC
      fetchFromGitHub
      cmake
      gcc-arm-embedded
      picotool
      python3
      pico-sdk
      ;
  },
  picoBoard ? "pico",
  vidpid ? "",
  usbVID ? "",
  usbPID ? "",
  enableEdDSA ? false,
  secureBootPKey ? null,
  extraCmakeFlags ? [ ],
}:
assert lib.assertMsg (
  (vidpid == "") || (usbVID == "" && usbPID == "")
) "pico-openpgp: Arguments 'vidpid' and 'usbVID/usbPID' could not be set at the same time.";
pico-lib.mkPicoDerivation rec {
  pname = "pico-fido";
  version = "7.4.2-librekeys";

  src = fetchFromGitHub {
    owner = "SilentZhang";
    repo = "pico-fido";
    rev = "v${version}";
    hash = "sha256-ztAW51Zjx37rFlPJqkRfMH/Gv/aV7TvbXJSEPslENek=";
    fetchSubmodules = true;
  };

  repo = "SilentZhang/pico-fido";
  installName = "pico-fido";
  installPath = "pico_fido.uf2";

  inherit
    picoBoard
    vidpid
    usbVID
    usbPID
    enableEdDSA
    secureBootPKey
    extraCmakeFlags
    ;
}
