{ system ? builtins.currentSystem # TODO: Get rid of this system cruft
, iosSdkVersion ? "10.2"
}:
with import ./.obelisk/impl { inherit system iosSdkVersion; };
project ./. ({ ... }: {
  android.applicationId = "ca.srid.heed";
  android.displayName = "Heed";
  ios.bundleIdentifier = "ca.srid.heed";
  ios.bundleName = "Heed";
})
