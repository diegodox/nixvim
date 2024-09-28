{nightly ? false, ...}:
let
  nightly_module = if nightly then [ ./nightly.nix ] else [];
in
{
  # Import all your configuration modules here
  imports = [
  ] ++ nightly_module;

  wrapRc = true;
}
