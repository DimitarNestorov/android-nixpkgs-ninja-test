{
  pkgs ? import <nixpkgs> { },
  android-nixpkgs ? pkgs.callPackage (import (
    builtins.fetchGit { url = "https://github.com/tadfisher/android-nixpkgs.it"; }
  )) { channel = "stable"; },
}:

pkgs.mkShellNoCC {
  shellHook = ''
    export IN_PROJECT_DEV_SHELL=1
  '';

  buildInputs =
    let
      android-sdk = android-nixpkgs.sdk (
        sdkPkgs: with sdkPkgs; [
          (cmake-3-22-1.overrideAttrs (oldAttrs: {
            dontAutoPatchelf = true;

            postFixup =
              (oldAttrs.postFixup or "")
              + pkgs.lib.optionalString pkgs.stdenv.hostPlatform.isLinux ''
                autoPatchelf $out/bin/cmake $out/bin/ctest $out/bin/cpack
              '';
          }))
          cmdline-tools-latest
        ]
      );
    in
    [
      android-sdk
    ];
}
