{
  config,
  pkgs,
  nix-vscode-extensions,
  ...
}: let
  overlay-extensions = nix-vscode-extensions.overlays.default;
in {
  nixpkgs.overlays = [overlay-extensions];
  environment.systemPackages = with pkgs; [
    (vscode-with-extensions.override {
      vscode = vscodium;
      vscodeExtensions = with vscode-marketplace; [
        denoland.vscode-deno
        angular.ng-template
        johnpapa.angular2
        bradlc.vscode-tailwindcss
        xabikos.javascriptsnippets
        xabikos.reactsnippets
        adpyke.codesnap
        formulahendry.auto-rename-tag
        christian-kohler.path-intellisense
        christian-kohler.npm-intellisense
        dsznajder.es7-react-js-snippets
        planbcoding.vscode-react-refactor
        esbenp.prettier-vscode
        wix.vscode-import-cost
        burkeholland.simple-react-snippets
        stylelint.vscode-stylelint
        ms-vscode.vscode-typescript-next
        rbbit.typescript-hero
        stringham.move-ts
	bbenoist.nix
	pinage404.nix-extension-pack
	jnoortheen.nix-ide
        gregorbiswanger.json2ts
	mshr-h.veriloghdl
	leafvmaple.verilog
	gtylcara-gewinn.verilog
#	ms-vscode.cpptools
	ms-vscode.cpptools-extension-pack
	austin.code-gnu-global
      ];
    })
    nodejs-18_x
    nodePackages."@angular/cli"
    yarn
    deno
    verilog
    gtkwave
  ];
}
