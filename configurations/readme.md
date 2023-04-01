# Device configurations

Individual config files which are immediately referred by `./flake.nix`

The folder contains personalized config files for setting up individual devices or device groups.

* Dellrax - Dell XPS 13 9370 laptop
  * it's a development device, focused on Development, the configuration on this device mostly applies to all other devices
* Tron - ASUS Zephyrus M laptop (formerly Lorax, v2 config)
  * it's a performance device, focused on Gaming and Rendering
* Amnesix - HP Workstation server
* Geryones - HP Workstation desktop PC (work profile)

Soon(TM):
* Amnesiac - HP Workstation Server V2
  * as the definition says, the server is an amnesiac
  * server will have strictly defined persistent storage
  * otherwise everything gets wiped on boot
  * strict security
    * defined firewall
    * defined network policy
    * meant primarily for secure storage
* Geryones V2
  * inspired from Amnesiac
  * implemented tunneling for remote access by other NixOS devices
  * implemented automatic backup
* Ryuk - old Lenovo laptop (it's shitty)
  * partial derivation of Amnesiac, 
* Tijuana - universal VirtualBox image

Former:
* Lorax - prototype deployment of NixOS, it was written on old Nix deployment specification (non-Flake), code is lost
