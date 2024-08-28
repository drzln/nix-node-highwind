{ lib, config, ... }:
with lib;
let
  author = "chaoren";
  name = "vim-wordmotion";
  url = "https://github.com/${author}/${name}";
  ref = "master";
  rev = "81d9bd298376ab0dc465c85d55afa4cb8d5f47a1";
  plugPath = ".local/share/nvim/site/pack/${author}/start/${name}";
  cfg = config.blackmatter.programs.nvim.plugins.${author}.${name};
in
{
  options.blackmatter.programs.nvim.plugins.${author}.${name}.enable =
    mkEnableOption "${author}/${name}";

  config = mkMerge [
    (mkIf cfg.enable {
      home.file."${plugPath}".source =
        builtins.fetchGit { inherit ref rev url; };
    })
  ];
}
