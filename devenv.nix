{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  # https://devenv.sh/basics/
  env.GREET = "devenv";

  # https://devenv.sh/packages/
  packages = [
    pkgs.git
  ];

  files.".editorconfig" = {
    ini = {
      "*" = {
        indent_size = 2;
        indent_type = "space";
      };
    };
    copyMode = "copy";
  };

  # https://devenv.sh/languages/
  languages.nix.enable = true;

  # https://devenv.sh/processes/
  # processes.dev.exec = "${lib.getExe pkgs.watchexec} -n -- ls -la";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo hello from $GREET
  '';

  # https://devenv.sh/basics/
  enterShell = ''
    hello         # Run scripts directly
    git --version # Use packages
  '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  treefmt = {
    enable = true;
    config = {
      settings.formatter = {
        nixfmt-rfc = {
          command = "${lib.getExe pkgs.nixfmt-rfc-style}";
          options = [
            "--indent"
            "2"
          ];
          includes = [ "*.nix" ];
          excludes = [
            ".devenv/*"
            ".git/*"
          ];
        };
      };
    };
  };
  # https://devenv.sh/git-hooks/
  git-hooks.hooks = {
    treefmt.enable = true;
  };

  # See full reference at https://devenv.sh/reference/options/
}
