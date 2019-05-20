{ system ? builtins.currentSystem # TODO: Get rid of this system cruft
, iosSdkVersion ? "10.2"
}:
with import ./.obelisk/impl { inherit system iosSdkVersion; };
project ./. ({ pkgs, hackGet, ... }: {
  android.applicationId = "ca.srid.heed";
  android.displayName = "Heed";
  ios.bundleIdentifier = "ca.srid.heed";
  ios.bundleName = "Heed";

  packages = let
    beam = hackGet ./dep/beam;
    obelisk-oauth = hackGet ./dep/obelisk-oauth;
  in {
    clay = pkgs.fetchFromGitHub {
      owner = "sebastiaanvisser";
      repo = "clay";
      rev = "54dc9eaf0abd180ef9e35d97313062d99a02ee75";
      sha256 = "0y38hyd2gvr7lrbxkrjwg4h0077a54m7gxlvm9s4kk0995z1ncax";
    };
    beam-core = beam + /beam-core;
    beam-migrate = beam + /beam-migrate;
    beam-sqlite = beam + /beam-sqlite;
    obelisk-oauth-common = obelisk-oauth + /common;
    obelisk-oauth-backend = obelisk-oauth + /backend;
  };

  overrides = self: super: with pkgs.haskell.lib;
  {
    clay = dontCheck super.clay;
    beam-core = dontCheck super.beam-core;
    beam-migrate = dontCheck super.beam-migrate;
    beam-sqlite = dontCheck super.beam-sqlite;
  };
})
