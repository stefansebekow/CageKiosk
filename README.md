# CageKiosk
A (secure) Kioskbrowser based on a caged wayland compositor and Chromium !


This project implements a secure browser kiosk solution for unattended operation based on on NixOS 24.11, which runs “cage” after startup. Cage is a Wayland compositor for kiosk applications and was originally a project by Jente Hidskes. 
Within this sandbox, a Chromium browser is then launched in kiosk mode. The goal by combining the above projects was a secure, controlled environment for accessing authorized websites while maintaining system security and preventing unauthorized access to system resources even by skilled users. The implementation aims to balance accessibility with security requirements, creating a reliable platform for unattended operation.

All thanks go to:

[https://github.com/cage-kiosk/cage]

In Chromium, a Chrome Store add-on called “Kiosk-Extension” runs, which manages a whitelist of allowed websites and also provides an overlay with three buttons that allow users to easily switch between the three pages. Replace all FOOBAR entrys by your desired Page(s).
The tab bar and address bar are disabled in kiosk mode.

[https://chromewebstore.google.com/detail/kiosk-extension/hbpkaaahpgfafhefiacnndahmanhjagi]

The ISO for NixOS can be downloaded from the website:

[https://nixos.org/download/]  

The installation requires internet access. NixOS can be installed from the live ISO using the Installationskript in this repo. You can also find config files for Chromium here.
To perform the setup, you'll need a current NixOS image on a USB drive, onto which you'll copy the configuration files from this repository.Once followed the Installation you install the extension from the Chrome Web Store, make any additional adjustments to the browser config if needed, and close the browser. Using [CTRL]+[ALT]+[F2], switch to tty2, log in with credentials, and edit the configuration file so the system will be properly configured next time. Then start once, install the KIOSK AddOn in Chromium, and load the configuration file.

With `nixos-rebuild switch`, you can activate the changes afterward. This procedure is also the only way to maintain the computer- 

**
*Important!!!***

**Before proceeding, you must modify the admin password in the kiosk-configuration.json file!**

Installation can be initiated using the commands from the installation script. Note that while running the script manually is recommended (as automated execution may encounter errors), all individual commands are correct. After completing the initial setup, launch once, install the KIOSK AddOn in Chromium, and load the configuration file. If there is any trouble with the installscript (tested a while ago and cant remember how well it ran) just use the skript as a guide and follow the commands one by one. 



Happy for any Feedback!


