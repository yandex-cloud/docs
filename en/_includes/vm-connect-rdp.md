Remote Desktop Protocol (RDP) is enabled for images of all versions and editions of the Windows operating system prepared for Yandex.Cloud. You can connect to a VM using the RDP protocol when it is running (with the "RUNNING" status).

To connect using RDP, specify the public IP address or the FQDN of the VM. Access via FQDN is possible from another Yandex.Cloud VM, if it is connected to the same network. You can find out the IP address and FQDN in the management console. Go to the **Network** section on the virtual machine's page.

To connect to a VM:

{% list tabs %}

- Windows
  
  1. Click **Start**.
  2. In the search box, enter <q>remote desktop connection</q> and choose **Remote Desktop Connection**.
  3. In the window **Remote Desktop Connection** enter the public IP address of the virtual machine to connect to in the **Computer** field.
  4. Click **Connect**.
  5. Specify the account settings:
      - **User name**: `Administrator`.
      - **Password**: the password that you set when you created the virtual machine.
  6. Press **OK**.
  
  #### See also
  
  - [Remote Desktop Connection](https://support.microsoft.com/en-US/help/17463/windows-7-connect-to-another-computer-remote-desktop-connection)
  
- macOS
  
  1. Install and run [Microsoft Remote Desktop](https://itunes.apple.com/app/microsoft-remote-desktop/id1295203466) (free official RDP client for Mac).
  2. Press ![image](../_assets/plus.svg) → **Desktop**.
  3. In the **Add Desktop** dialog enter the public IP address of the virtual machine to connect to in the field **PC Name**.
  4. In the **User Account** field select **Add User Account**.
  5. In the **Add User Account** dialog specify the account settings:
      - **User Name**: `Administrator`.
      - **Password**: the password that you set when you created the virtual machine.
  6. Press **Save** twice.
  7. Connect to the remote machine by double-clicking the connection you created in the main Microsoft Remote Desktop window.
  
  #### See also
  
  - [Getting started with Remote Desktop on Mac](https://docs.microsoft.com/en-US/windows-server/remote/remote-desktop-services/clients/remote-desktop-mac)
  
- Linux
  
  1. Install Remmina (a free RDP client for Linux) using the commands:
  
      ```
      $ sudo apt-add-repository ppa:remmina-ppa-team/remmina-next
      $ sudo apt-get update
      $ sudo apt-get install remmina remmina-plugin-rdp
      ```
  
  2. Start Remmina.
  
  3. Click ![image](../_assets/plus.svg).
  
  4. Fill in the **Profile** block as follows:
      - **Name**: a name for the connection.
      - **Protocol**: **RDP - Remote Desktop Protocol**.
  
  5. In the **Basic** tab specify the details for connection and authorization:
      - **Server**: the public IP address of the virtual machine to connect to.
      - **User Name**: `Administrator`.
      - **Password**: the password that you set when you created the virtual machine.
  
  6. Click **Save**.
  
  7. Connect to the remote machine by double-clicking the connection you created in the quick access connection list.
  
  #### See also
  
  - [Installing Remmina on Linux distributions other than Ubuntu](https://remmina.org/how-to-install-remmina/)
  
{% endlist %}

