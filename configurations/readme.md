# Device configurations

Individual config files which are immediately referred by `./flake.nix`

The folder contains personalized config files for setting up individual devices or device groups.

* Dellrax - Dell XPS 13 9370 laptop
  * it's a development device, focused on Development, the configuration on this device mostly applies to all other devices
* Tron - ASUS Zephyrus M laptop (formerly Lorax, v2 config)
  * it's a performance device, focused on Gaming and Rendering
* Amnesix - HP Workstation Server
  * it's a light-weight device, focused on Server tasks
* Geryones - HP Workstation PC (work profile)
  * it's a combined device, focuses on Development and HPC

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
  * more strict separation of personal and work related things
    * personal data is encrypted
      * personal data will be unlocked when logging in
    * work data is left unencrypted, work data can be accessed by using emergency login
* Ryuk - old Lenovo laptop (it's shitty)
  * partial derivation of Amnesiac, no further plans yet
* Tijuana - universal VirtualBox image
  * contains all the essential things for deploying Dellrax as a portable VM
  * won't use Gnome, instead it will use LXDE or other DWM
* Ryuichi - secret management/update server
  * contains Bento or other known secret manager
  * collocated somewhere secretly (TM)
  * contains BitwardenRS server
  * either deployable as a container service (for Amnesiac) or as a separate NixOS image (for cloud)

Former:
* Lorax - prototype deployment of NixOS, it was written with old NixOS deployment specification (non-Flake), code is lost
