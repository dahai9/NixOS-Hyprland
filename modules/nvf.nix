{ config, lib, ... }:

let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.binds) mkKeymap;
inherit (lib.options) mkEnableOption;
  inherit (lib.nvim.binds) mkMappingOption;

  # 当前插件的配置
  cfg = config.vim.plugin.customKeyMap;

  # 键绑定的定义
  keys = cfg.mappings;
  inherit (config.vim.lsp.trouble) mappings;
in {
  options.vim.plugin.customKeyMap= {
    enable = mkEnableOption "Enable Customs plugin";

    # 键绑定映射
    mappings = {
      copy = mkMappingOption "Copy select text [text edit]" "<C-c>";
      paste = mkMappingOption "Paste select text [text edit]" "<C-v>";

    };
  };

  config = mkIf cfg.enable {
      vim.keymaps = [
      (mkKeymap "v" keys.copy "\"+y" {desc = mappings.copy.description;})
      (mkKeymap "n" keys.paste "\"+p" {desc = mappings.paste.description;})
    ];
  };
}
