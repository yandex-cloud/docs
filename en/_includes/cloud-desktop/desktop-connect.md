# Connecting to a desktop

Desktops are connected to using the [Remote Desktop Protocol](https://en.wikipedia.org/wiki/Remote_Desktop_Protocol) (RDP).


## Setting up for a connection {#prepare-connect}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the desktop was created.
   1. In the list of services, select **Cloud Desktop**.
   1. On the left-hand panel, select ![image](../../_assets/cloud-desktop/desktops.svg) **Desktops**.
   1. Select the previously created desktop.
   1. Under **Access**, click ![image](../../_assets/options.svg) next to the user account and select **Reset password**.
      A temporary password is copied to the clipboard. Save it for a future step.
   1. Click **Download RDP file**.
   1. [Connect to the desktop](#connect-desktop).

{% endlist %}


## Connecting to a desktop {#connect-desktop}

{% list tabs %}

- Windows

   1. Run the downloaded RDP file and click **Connect**.
   1. To connect, use the temporary password you saved earlier.
   1. After logging in, the user needs to come up with a new password and enter it. This password will be used for further operations.

- macOS

   1. Install and run [Microsoft Remote Desktop](https://itunes.apple.com/ru/app/microsoft-remote-desktop/id1295203466) (official free RDP client for Mac).
   1. Run the downloaded RDP file and click **Connect**.
   1. To connect, use the temporary password you saved earlier.
   1. After logging in, the user needs to come up with a new password and enter it. This password will be used for further operations.

   #### For details, see also {#mac-see-also}

   * [Getting started with a remote desktop in macOS](https://docs.microsoft.com/en-us/windows-server/remote/remote-desktop-services/clients/remote-desktop-mac).

- Linux

   1. Install Remmina (a free RDP client for Linux) using the commands:

      ```bash
      sudo apt-add-repository ppa:remmina-ppa-team/remmina-next
      sudo apt-get update
      sudo apt-get install remmina remmina-plugin-rdp
      ```

   1. Run the downloaded RDP file and click **Connect**.
   1. To connect, use the temporary password you saved earlier.
   1. After logging in, the user needs to come up with a new password and enter it. This password will be used for further operations.

   #### For details, see also {#lin-see-also}

   * [Installing Remmina on Linux distributions other than Ubuntu](https://remmina.org/how-to-install-remmina/).

{% endlist %}