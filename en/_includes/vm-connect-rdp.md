Remote Desktop Protocol (RDP) with Network Level Authentication (NLA) is enabled for images of all versions and editions of the Windows operating system prepared for {{ yandex-cloud }}. Before connecting to a VM, make sure that NLA is enabled in your desktop settings.

You can connect to a virtual machine with the `RUNNING` status over RDP. Some time may be required to initialize all the services after the VM [starts](../compute/operations/vm-control/vm-stop-and-start.md#start). If there is a connection error, retry after a few minutes.

Virtual machine [security groups](../vpc/concepts/security-groups.md) must allow incoming TCP traffic to port 3389.

To connect using RDP, specify the public IP address or the FQDN of the VM. Access using FQDN is possible from another {{ yandex-cloud }} VM if it is connected to the same network. You can find out the IP address and FQDN in the management console. Go to the **{{ ui-key.yacloud.compute.instance.overview.section_network }}** section on the virtual machine's page.


To connect to the VM:

{% list tabs group=operating_system %}

- Windows {#windows}

   1. Click **Start**.
   1. In the search box, type **Remote Desktop Connection** and select the appropriate item.
   1. In the **Remote Desktop Connection** window, enter the public IP address of the VM to connect to in the **Computer** field.
   1. Click **Connect**.
   1. Specify the account settings:
      * **User name**: `Administrator`
      * **Password**
   1. Click **OK**.

   {% include [initialization-windows-vm](initialization-windows-vm.md) %}

   #### See also

   * [Remote Desktop Connection](https://support.microsoft.com/en-us/windows/how-to-use-remote-desktop-5fe128d5-8fb1-7a23-3b8a-41e636865e8c).

- macOS {#macos}

   1. Install and run [Microsoft Remote Desktop](https://itunes.apple.com/ru/app/microsoft-remote-desktop/id1295203466) (official free RDP client for Mac).
   1. Click ![image](../_assets/plus.svg) → **Add PC**.
   1. In the **Add PC** dialog, enter the public IP address of the virtual machine to connect to in the **PC name** field.
   1. In the **User account** field, select **Add User Account**.
   1. In the **Add a User Account** dialog, specify the account settings:
      * **Username**: `Administrator`
      * **Password**
   1. Click **Add** twice.
   1. Connect to the remote machine by double-clicking the connection you created in the main Microsoft Remote Desktop window.

   #### See also

   * [Getting started with Remote Desktop on Mac]({{ ms.docs }}/windows-server/remote/remote-desktop-services/clients/remote-desktop-mac).

- Linux {#linux}

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
      * **Name**: Name for the connection.
      * **Protocol**: **RDP - Remote Desktop Protocol**.
   1. In the **Basic** tab specify the details for connection and authorization:
      * **Server**: Public IP address of the virtual machine to connect to.
      * **User Name**: `Administrator`.
      * **Password**.
   1. Click **Save**.
   1. Connect to the remote machine by double-clicking the connection you created in the quick access connection list.

   #### See also

   * [Installing Remmina on Linux distributions other than Ubuntu](https://remmina.org/how-to-install-remmina/).

{% endlist %}
