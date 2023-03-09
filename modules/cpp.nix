{
  pkgs,
  config,
  ...
}: {
  # enables docker
  environment.systemPackages = with pkgs; [
    clang_14
    clang-tools_14
    lldb_14
    gcc
    cmake
    gnumake
    raylib
    valgrind
    musl
    boost.dev
  ];
}