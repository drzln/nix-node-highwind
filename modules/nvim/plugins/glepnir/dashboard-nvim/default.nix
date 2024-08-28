{ lib, config, ... }:
with lib;
let
  author = "glepnir";
  name = "dashboard-nvim";
  url = "https://github.com/${author}/${name}";
  ref = "master";
  rev = "669536db27ea411217f633ee54b63be41ecff300";
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
