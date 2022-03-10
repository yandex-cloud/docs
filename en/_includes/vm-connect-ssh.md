The recommended method for connecting to a virtual machine over SSH is based on using a key pair: the open key is placed on the virtual machine, and the private key is stored on the user's device. Connecting with a key pair is more secure than connecting with a username and password.

{% include [vm-connect-ssh-linux-note](vm-connect-ssh-linux-note.md) %}

## Creating an SSH key pair {#creating-ssh-keys}

{% include [vm-ssh-prepare-key](vm-ssh-prepare-key.md) %}

## Connecting to a VM {#vm-connect}

You can connect to a VM using the SSH protocol when it is running (the VM's status is `RUNNING`). You can use the `ssh` tool in Linux and macOS or [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) for Windows.

To connect, you have to specify the address of the VM. This can be its IP address or the FQDN. Access via FQDN is possible from another {{ yandex-cloud }} VM, if it is connected to the same virtual network. You can find out the IP address in the management console. Go to the **Network** section on the virtual machine's page.

