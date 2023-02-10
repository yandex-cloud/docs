# Connecting to a Linux VM via SSH

The recommended method for connecting to a virtual machine over SSH is based on using a key pair: the public key is placed on the virtual machine, and the private key is stored on the user's device. Connecting with a key pair is more secure than connecting with a username and password.

## Creating an SSH key pair {#creating-ssh-keys}

{% include [vm-ssh-prepare-key](../../../_includes/vm-ssh-prepare-key.md) %}

{% note warning %}

Save the private key in a secure location: you won't be able to connect to the VM without it.

{% endnote %}

## Connecting to a VM {#vm-connect}

You can connect to a virtual machine with the `RUNNING` status over SSH. Some time may be required to initialize all the services after the VM [starts](../vm-control/vm-stop-and-start.md#start). If there is a connection error, retry after several minutes.

To connect, you can use the `ssh` utility on Linux/macOS/Windows 10 and [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) on Windows 7/8.

Virtual machine [security groups](../../../vpc/concepts/security-groups.md) must allow incoming TCP traffic on port 22.

{% include [security-groups-note](../../_includes_service/security-groups-note.md) %}

To connect to the VM, specify its public address. You can find out the public IP address in the management console. On the VM's page, go to the **Network** section and find the **Public IPv4** field. If you created a virtual machine with a private address only, [bind it to a public address](../vm-control/vm-attach-public-ip.md).

You can also use the internal IP addresses and FQDNs to establish an SSH connection between the VMs on a single {{ yandex-cloud }} cloud network.

{% list tabs %}

- Linux/macOS

   In the terminal, run the command:

   ```bash
   ssh <username>@<VM_public_IP_address>
   ```

   If you have multiple private keys, specify the one you need:

   ```bash
   ssh -i <key_path/key_file_name><username>@<VM_public_IP_address>
   ```

   If this is the first time you connect to a VM, you'll see a warning about an unknown host:

   ```
   The authenticity of host '130.193.40.101 (130.193.40.101)' can't be established.
   ECDSA key fingerprint is SHA256:PoaSwqxRc8g6iOXtiH7ayGHpSN0MXwUfWHkGgpLELJ8.
   Are you sure you want to continue connecting (yes/no)?
   ```

   Type `yes` in the terminal and press **Enter**.

- Windows 10

   Make sure that the Windows account has read privileges on the folder containing the keys.

   To connect to the virtual machine, execute the following command in the command line:

   ```powershell
   ssh <username>@<VM_public_IP_address>
   ```

   If you have multiple private keys, specify the one you need:

   ```powershell
   ssh -i <key_path\key_file_name> <username>@<VM_public_IP_address>
   ```

   If this is the first time you connect to a VM, you'll see a warning about an unknown host:

   ```
   The authenticity of host '130.193.40.101 (130.193.40.101)' can't be established.
   ECDSA key fingerprint is SHA256:PoaSwqxRc8g6iOXtiH7ayGHpSN0MXwUfWHkGgpLELJ8.
   Are you sure you want to continue connecting (yes/no)?
   ```

   Type `yes` in the command prompt and press **Enter**.


- Windows 7/8

   In Windows, a connection is established using the PuTTY application.

   1. Run the Pageant application.
      1. Right-click on the Pageant icon in the task bar.
      1. In the context menu, select **Add key**.
      1. Select a PuTTY-generated private key in the `.ppk` format. If a password is set for the key, enter it.
   1. Run PuTTY.
      1. In the **Host Name (or IP address)** field, enter the public IP address of the VM you want to connect to. Specify port `22` and **SSH** as the connection type.

         ![ssh_add_ip](../../../_assets/compute/ssh-putty/ssh_add_ip.png)

      1. In the tree on the left, select **Connection** - **SSH** - **Auth**.
      1. Set the **Allow agent forwarding** option.
      1. In the **Private key file for authentication** field, select the file with the private key.

         ![ssh_choose_private_key](../../../_assets/compute/ssh-putty/ssh_choose_private_key.png)

      1. Go back to the **Sessions** menu. In the **Saved sessions** field, enter any session name and click **Save**. The session settings are saved under the specified name. You can use this session profile to connect using Pageant.

         ![ssh_save_session](../../../_assets/compute/ssh-putty/ssh_save_session.png)

      1. Click **Open**. If this is the first time you connect to a VM, you might see a warning about an unknown host:

         ![ssh_unknown_host_warning](../../../_assets/compute/ssh-putty/ssh_unknown_host_warning.png)

         Click **Yes**. A terminal window opens suggesting that you enter the login of the user on whose behalf the connection is being established. Type the user name that you specified when creating the VM and press **Enter**. If everything is configured correctly, the connection with the server will be established.

         ![ssh_login](../../../_assets/compute/ssh-putty/ssh_login.png)

   If you saved the session profile in PuTTY, you can use Pageant to establish a connection in the future:

   1. Right-click on the Pageant icon in the task bar.
   1. Select the **Saved sessions** menu item.
   1. In the saved sessions list, select the necessary session.

{% endlist %}

## Adding SSH keys for other users {#vm-authorized-keys}

You can add SSH keys for another VM user. To do this, create a new user and add a file with the authorized keys for this user.

1. Log in to the VM under the username that you specified when creating the VM in the management console. If the VM is created via the CLI, the default `yc-user` user will be used.

   {% note info %}

   To get information about a VM with user metadata, run the command:

   ```bash
   yc compute instance get --full <VM-name>
   ```

   {% endnote %}

1. Create a new user and specify a default `bash` wrapper for this user:

   ```bash
   sudo useradd -m -d /home/testuser -s /bin/bash testuser
   ```

1. Switch to the new user:

   ```bash
   sudo su - testuser
   ```

1. Create the `.ssh` folder in the new user's home directory:

   ```bash
   mkdir .ssh
   ```

1. In the `.ssh` folder, create the `authorized_keys` file:

   ```bash
   touch .ssh/authorized_keys
   ```

1. Add the new user's public key to the `authorized_keys` file:

   ```bash
   echo "<public_key>" > /home/testuser/.ssh/authorized_keys
   ```

1. Change the access rights `authorized_keys` to the file and `.ssh` folder:

   ```bash
   chmod 700 ~/.ssh
   chmod 600 ~/.ssh/authorized_keys
   ```

1. Disconnect from the VM using the `exit` command.
1. Restart the VM.
1. Check the connection for the new user:

   ```bash
   ssh testuser@<VM_public_IP_address>
   ```

#### What's next {#what-is-next}

* [Learn how to work with {{ yandex-cloud }} from inside a VM](auth-inside-vm.md)
