{ lib, config, ... }:
with lib;
let
  author = "chrisgrieser";
  name = "nvim-various-textobjs";
  url = "https://github.com/${author}/${name}";
  ref = "main";
  rev = "0b2a34d3281fc065cf19042c2f15aea8b38af18a";
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
