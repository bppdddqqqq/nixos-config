{ config, pkgs, ... }:
let bitwig-jar = ./bitwig.jar;
in {
  environment.systemPackages = with pkgs; [
    # videoprod
    projectm
    pulseeffects-legacy

    # Audio prod
    ardour
    lenmus
    unstable.lmms
    
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
    #open-music-kontrollers.sherlock
    #open-music-kontrollers.synthpod
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

    opnplug
    adlplug
    sonivox
    padthv1
    geonkick
    zynaddsubfx-ntk
    freepats
    aeolus
    yoshimi
    gnaural
    samplv1
    sunvox
    industrializer
  ];
}

