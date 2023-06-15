{% list tabs %}

- Windows

   1. Run the downloaded RDP file and click **Connect**.
   1. Enter the password you previously saved.
   1. Change the default user password.

- macOS

   1. Install and run [Microsoft Remote Desktop](https://itunes.apple.com/ru/app/microsoft-remote-desktop/id1295203466), an official free RDP client for macOS.
   1. Run the downloaded RDP file and click **Continue**.
   1. Enter the password you previously saved.
   1. Change the default user password.

   #### See also {#mac-see-also}

   * [Getting started with Remote Desktop on macOS]({{ ms.docs }}/windows-server/remote/remote-desktop-services/clients/remote-desktop-mac)

- Linux

   1. Install [Remmina](https://remmina.org), a free RDP client for Linux. Run the following commands in the terminal:

      ```bash
      sudo apt-add-repository ppa:remmina-ppa-team/remmina-next
      sudo apt-get update
      sudo apt-get install remmina remmina-plugin-rdp
      ```

   1. Run the downloaded RDP file.
   1. Enter the password you previously saved.
   1. Change the default user password.

   #### See also {#lin-see-also}

   * [Installing Remmina on Linux distributions other than Ubuntu](https://remmina.org/how-to-install-remmina/)

{% endlist %}
