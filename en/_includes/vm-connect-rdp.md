Remote Desktop Protocol (RDP) with Network Level Authentication (NLA) is enabled for images of all versions and editions of the Windows operating system prepared for {{ yandex-cloud }}. Before connecting to a VM, make sure that NLA is enabled in your desktop settings. When the VM starts (its status is `RUNNING`), you can connect to it using RDP.

[Make sure the VM's security groups](../vpc/concepts/security-groups.md) allow incoming TCP traffic to port 3389.

  {% include [security-groups-note](../compute/_includes_service/security-groups-note.md) %}

To connect using RDP, specify the public IP address or the FQDN of the VM. Access using FQDN is possible from another {{ yandex-cloud }} VM if it's connected to the same network. You can find out the IP address and FQDN in the management console. Go to the **Network** section on the virtual machine's page.

To connect to the VM:

{% list tabs %}

- Windows
  1. Click **Start**.
  1. In the search box, type **Remote Desktop Connection** and select the appropriate item.
  1. In the **Remote Desktop Connection** window, enter the public IP address of the VM to connect to in the **Computer** field.
  1. Click **Connect**.
  1. Specify the account settings:
     * **User name** `Administrator`.
     * **The password** you set when creating the VM.
  1. Press **OK**.

  {% include [initialization-windows-vm](initialization-windows-vm.md) %}

  #### See also
  * [Remote Desktop Connection](https://support.microsoft.com/en-us/windows/how-to-use-remote-desktop-5fe128d5-8fb1-7a23-3b8a-41e636865e8c).

- macOS
  1. Install and run [Microsoft Remote Desktop](https://itunes.apple.com/app/microsoft-remote-desktop/id1295203466) (free official RDP client for Mac).
  1. Press ![image](../_assets/plus.svg) → **Desktop**.
  1. In the **Add Desktop** dialog enter the public IP address of the virtual machine to connect to in the field **PC Name**.
  1. In the **User Account** field select **Add User Account**.
  1. In the **Add User Account** dialog specify the account settings:
     * **User Name** `Administrator`.
     * **Password**: The password that you set when creating the VM.
  1. Press **Save** twice.
  1. Connect to the remote machine by double-clicking the connection you created in the main Microsoft Remote Desktop window.

  #### See also
  * [Getting started with Remote Desktop on Mac](https://docs.microsoft.com/en-us/windows-server/remote/remote-desktop-services/clients/remote-desktop-mac).

- Linux

  1. Install Remmina (a free RDP client for Linux) using the commands:

     ```bash
     sudo apt-add-repository ppa:remmina-ppa-team/remmina-next
     ```

     ```bash
     sudo apt-get update
     ```

     ```bash
     sudo apt-get install remmina remmina-plugin-rdp
     ```

  1. Start Remmina.

  1. Click ![image](../_assets/plus.svg).

  1. Fill in the **Profile** block as follows:
     * **Name**: a name for the connection.
     * **Protocol**: **RDP - Remote Desktop Protocol**.

  1. In the **Basic** tab specify the details for connection and authorization:
     * **Server**: the public IP address of the virtual machine to connect to.
     * **User Name**: `Administrator`.
     * **Password**: the password that you set when you created the virtual machine.

  1. Click **Save**.

  1. Connect to the remote machine by double-clicking the connection you created in the quick access connection list.

  #### See also
  * [Installing Remmina on Linux distributions other than Ubuntu](https://remmina.org/how-to-install-remmina/).

{% endlist %}

