{ config, pkgs, overlay-unstable, tidalcycles,... }:
let
  bitwig-jar = ./bitwig.jar;
in
{
  users.users.root = {
    shell = pkgs.fish;    
  };

  nixpkgs.overlays = [ (self: super: { 
    ardour = (super.ardour.overrideAttrs (old: {
      version = "7.1";
      src = super.fetchgit {
        url = "git://git.ardour.org/ardour/ardour.git";
        rev = "7.1";
        sha256 = "11ca9xpzmzafl8xl0r0w32lxjqwy532hfd2bzb0d73bdpngpvcbq";
      };
    }));
    bitwig-studio = (super.bitwig-studio.overrideAttrs (old: {
      version = "4.3";
      src = super.fetchurl {
        url = "https://downloads.bitwig.com/stable/4.3/${old.pname}-4.3.deb";
        # sha256 = "sha256-UCafrjrEwwHkhPum7sTOjtXzy7PNeK5/aeKg+b3CGJU=";
        sha256 = "04psgrxyvhdrh1lgg1frx9vcgq0s9v2syqa52z2x98zm61inr6k8";
      };
      patchPhase = ''
        cp ${bitwig-jar} opt/bitwig-studio/bin/bitwig.jar
      '';
    }));
    }
  )];

  environment.systemPackages = with pkgs; [
    # wine
    wineWowPackages.stable
    winetricks

    # console utils
    xorg.xhost
    wget
    git
    byobu
    zip
    unzip
    tmux
    zeal
    unstable.youtube-dl
    vim-flaked

    # clangd
    clang_14 clang-tools_14 lldb_14

    # pidgin
    pidgin
    pidgin-otr
    pidgin-indicator
    pidgin-opensteamworks
    purple-slack
    purple-discord
    purple-signald
    purple-plugin-pack
    purple-facebook

    # pdf
    zathura

    # ASSIST
    tldr

    # davinci
#    davinci-resolve

    # videoprod
    projectm
    pulseeffects-legacy


    # Audio prod
    ardour
    lenmus
    unstable.lmms
    unstable.sonic-pi

    # Ardour plugins
    CHOWTapeModel
    artyFX
    bchoppr
    bespokesynth-with-vst2
    bjumblr
    boops
    bschaffl
    bsequencer
    bshapr
    bslizr
    distrho
    eq10q
    faustPhysicalModeling
    fmsynth
    fomp
    fverb
    gxmatcheq-lv2
    gxplugins-lv2
    helm
    hydrogen
    infamousPlugins
    ingen
    kapitonov-plugins-pack
    lsp-plugins
    magnetophonDSP.CompBus
    #NOT WORKING - magnetophonDSP.ConstantDetuneChorus
    magnetophonDSP.LazyLimiter
    magnetophonDSP.MBdistortion
    magnetophonDSP.pluginUtils
    mod-distortion
    molot-lite
    mooSpace
    ninjas2
    noise-repellent
    odin2
    open-music-kontrollers.eteroj
    open-music-kontrollers.jit
    open-music-kontrollers.mephisto
    open-music-kontrollers.orbit
    open-music-kontrollers.router
    open-music-kontrollers.sherlock
    open-music-kontrollers.synthpod
    open-music-kontrollers.vm
    oxefmsynth
    plujain-ramp
    sorcer
    speech-denoiser
    # broken surge
    surge-XT
    talentedhack
    tunefish
    vocproc
    x42-avldrums
    x42-gmsynth
    x42-plugins
    zam-plugins

    # DJing
    mixxx

    # LMMS
    unstable.lmms

    # nixos development
    nixos-generators
    atom

    # fluff
    blender
    vlc
    qutebrowser
    libreoffice-qt
    gimp
    unstable.obsidian
  ];
}

