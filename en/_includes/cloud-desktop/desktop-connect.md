{% list tabs %}

- Windows

   1. Right-click the downloaded RDP file and select **Edit** (in Windows 11, select **Show more options** → **Edit**).
   1. In the **Remote Desktop Connection** window, the **General** tab, select **Allow me to save credentials** and click **Connect**.
   1. In the security window, select **Don't ask me again for connections to this computer** and click **Yes**.
   1. Enter the previously saved password, select **Remember me**, and click **OK**.

   To reconnect to the desktop, run the RDP file you saved.

- macOS

   1. Install and run [Microsoft Remote Desktop](https://itunes.apple.com/ru/app/microsoft-remote-desktop/id1295203466), an official free RDP client for macOS.
   1. Open the **Connections** menu amd click **Import from RDP file**.
   1. In the window that opens, select the downloaded RDP file and click **Import**.
   1. Open the **Microsoft Remote Desktop** menu and select **Settings**.
   1. In the window that opens, go to the **User Accounts** tab.
   1. In the list of accounts on the left, select the account to connect and paste the previously saved password into the **Password** field.
   1. Close the settings window.
   1. In the **PCs** tab, run the desktop added.
   1. In the security window, click **Continue**.

   To reconnect to the desktop, run it in the Microsoft Remote Desktop client in the **PCs** tab. In the security window, click **Continue**.

   #### See also {#mac-see-also}

   * [Getting started with Remote Desktop on macOS]({{ ms.docs }}/windows-server/remote/remote-desktop-services/clients/remote-desktop-mac)

- Linux

   1. Install [Remmina](https://remmina.org), a free RDP client for Linux. Run the following commands in the terminal:

      ```bash
      sudo apt-add-repository ppa:remmina-ppa-team/remmina-next
      sudo apt-get update
      sudo apt-get install remmina remmina-plugin-rdp
      ```

   1. Start Remmina.
   1. In the top menu, click ![image](../../_assets/console-icons/bars.svg) and select **Import**. Run the downloaded RDP file and click **Import**.
   1. Right-click the added desktop and select **Edit**.
   1. In the **Remote Connection Profile** window, set up the connection:

      * In the **Username** field, remove the first two characters: `.\`.
      * In the **Password** field, type the previously saved password.
   1. Click **Save and Connect**.

   To reconnect to the desktop, run it in the Remmina client.

   #### See also {#lin-see-also}

   * [Installing Remmina on Linux distributions other than Ubuntu](https://remmina.org/how-to-install-remmina/)

{% endlist %}
