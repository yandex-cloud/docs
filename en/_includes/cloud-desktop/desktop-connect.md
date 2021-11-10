# Connecting to a desktop

Desktops are connected to using the [Remote Desktop Protocol]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Remote_Desktop_Protocol){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Remote_Desktop_Protocol){% endif %} (RDP).

1. In the [management console]({{ link-console-main }}), select the folder where the desktop was created.

1. In the list of services, select **Cloud Desktop**.

1. Go to the **Desktops** tab and select the desktop you created earlier.

1. Under **Access**, next to the user account, click ![image](../../_assets/options.svg) and choose **Reset password**.

    A temporary password is copied to the clipboard. Save it for a future step.

1. Click **Download RDP file**.

1. Connect to the desktop:

    {% list tabs %}

    - Windows

      1. Run the downloaded RDP file and click **Connect**.

      1. To connect, use the temporary password you saved earlier.

      1. After logging in, the user needs to come up with a new password and enter it. This password will be used for further operations.

    - macOS

      1. Install and run [Microsoft Remote Desktop](https://itunes.apple.com/app/microsoft-remote-desktop/id1295203466) (free official RDP client for Mac).

      1. Run the downloaded RDP file and click **Connect**.

      1. To connect, use the temporary password you saved earlier.

      1. After logging in, the user needs to come up with a new password and enter it. This password will be used for further operations.

      #### See also

      * [Getting started with the Remote Desktop on macOS]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/windows-server/remote/remote-desktop-services/clients/remote-desktop-mac){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/windows-server/remote/remote-desktop-services/clients/remote-desktop-mac){% endif %}.

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

      #### See also

      * [Installing Remmina on Linux distributions other than Ubuntu](https://remmina.org/how-to-install-remmina/).

    {% endlist %}
