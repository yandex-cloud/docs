The recommended method for connecting to a virtual machine over SSH is based on using a key pair: the open key is placed on the virtual machine, and the private key is stored on the user's device. Connecting with a key pair is more secure than connecting with a username and password.

[!INCLUDE [vm-connect-ssh-linux-note](vm-connect-ssh-linux-note.md)]

You can connect to the virtual machine over SSH when it starts. You can use the `ssh` tool on Linux and macOS and [PuTTy](https://www.chiark.greenend.org.uk/~sgtatham/putty/) for Windows. Don't forget to set up the created key pair: the private key must match the public key sent to the VM.

To connect, you have to specify the address of the VM. This can be its IP address or the FQDN. Access via FQDN is possible from another Yandex.Cloud VM, if it is connected to the same virtual network. You can find out the IP address in the management console. Go to the **Network** section on the virtual machine's page.
