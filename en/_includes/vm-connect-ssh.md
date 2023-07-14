The recommended method for connecting to a [VM](../compute/concepts/vm.md) over SSH is based on using a key pair: the public key is placed on the VM, while the private one is stored on the user's device. Connecting with a key pair is more secure than doing so with a username and password.

{% include [vm-connect-ssh-linux-note](vm-connect-ssh-linux-note.md) %}

## Creating an SSH key pair {#creating-ssh-keys}

{% include [vm-ssh-prepare-key](vm-ssh-prepare-key.md) %}

## Connecting to a VM {#vm-connect}

You can connect to a VM over SSH once it is started (i.e., has the `RUNNING` status). You can use the `ssh` utility in Linux or macOS, or [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) in Windows.

To connect, specify the VM address. This can be either its [IP address](../vpc/concepts/address.md) or [FQDN](../vpc/concepts/address.md#fqdn). You can also connect from another {{ yandex-cloud }} using FQDN if this VM is connected to the same [virtual network](../vpc/concepts/network.md#network). You can find out the IP address in the [management console]({{ link-console-main }}) by going to the **{{ ui-key.yacloud.compute.instance.overview.section_network }}** section on the VM's page.