{% list tabs group=operating_system %}

- Windows {#windows}

  1. Right-click the downloaded RDP file and select **Edit** (in Windows 11, select **Show more options** → **Edit**).
  1. In the **Remote Desktop Connection** window, open the **General** tab, select **Allow me to save credentials**, and click **Connect**.
  1. In the security window that opens, select **Don't ask me again for connections to this computer** and click **Yes**.
  1. Enter the password you saved previously, select **Remember me**, and click **OK**.
  
  To reconnect to the desktop, run the RDP file you saved.

- macOS {#macos}

  1. Install and run [Microsoft Remote Desktop](https://itunes.apple.com/ru/app/microsoft-remote-desktop/id1295203466), the official free RDP client for macOS.
  1. Open the **Connections** menu amd click **Import from RDP file**.
  1. In the window that opens, select the downloaded RDP file and click **Import**.
  1. In the **Microsoft Remote Desktop** menu, select **Settings**.
  1. In the window that opens, navigate to the **User Accounts** tab.
  1. Select the account you want to connect to from the list on the left, and paste the previously saved password into the **Password** field.
  1. Close the settings window.
  1. In the **PCs** tab, run the desktop you added.
  1. In the security window that opens, click **Continue**.

  To reconnect to the desktop, run it from the **PCs** tab in the Microsoft Remote Desktop client. In the security window that opens, click **Continue**.

  #### See also {#mac-see-also}

  * [Getting started with a remote desktop in macOS]({{ ms.docs }}/windows-server/remote/remote-desktop-services/clients/remote-desktop-mac)

- Linux {#linux}

  1. Install [Remmina](https://remmina.org), a free RDP client for Linux, by running the following commands in the terminal:

      ```bash
      sudo apt-add-repository ppa:remmina-ppa-team/remmina-next
      sudo apt-get update
      sudo apt-get install remmina remmina-plugin-rdp
      ```

  1. Start Remmina.
  1. In the top menu, click ![image](../../_assets/console-icons/bars.svg) and select **Import**. Select the downloaded RDP file and click **Import**.
  1. Right-click the added desktop and select **Edit**.
  1. In the **Remote Connection Profile** window, set up the connection:

     * In the **Username** field, remove the first two characters: `.\`.
     * In the **Password** field, enter the previously saved password.
  1. Click **Save and Connect**.

  To reconnect to the desktop, run it in the Remmina client.

  #### See also {#lin-see-also}

  * [Installing Remmina on non-Ubuntu Linux distributions](https://remmina.org/how-to-install-remmina/)

{% endlist %}
