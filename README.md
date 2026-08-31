# Seanime Denshi for nix

The [seanime](https://github.com/5rahim/seanime) desktop AppImage
**Seanime Denshi**, packaged for nix.

## INSTALL

First add this flake to your inputs,
then add it to your `environment.systemPackages` or `home.packages`:

```nix flake.nix
## flake.nix

inputs = {
  ## ... your other inputs
  seanime-denshi = {
    url = "github:LibereCode/seanime-denshi.nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  ## ... your other inputs
  };

  ## ... outputs ...
};
```

Another file that is imported into your config:

```nix modules/nixos/seanime-denshi.nix
## For NixOS
{ inputs, pkgs, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  config = {
    environment.systemPackages = [
      inputs.seanime-denshi.packages.${system}.seanime-denshi
    ];
  };
}
```

```nix modules/nixos/seanime-denshi.nix
## For Home-manager
{ inputs, pkgs, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
in
  config = {
    home.packages = [
      inputs.seanime-denshi.packages.${system}.seanime-denshi
    ];
  };
}
```
