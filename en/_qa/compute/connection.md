# Connection


#### How do I connect to a Linux VM? {#conn-vm-linux}

See [{#T}](../../compute/operations/vm-connect/ssh.md). If the computer you are connecting from has an older version of Windows (7, 8, or the first releases of Windows 10) and there is no built-in SSH console client, use [PuTTY](https://www.putty.org/).

The Linux images from {{ yandex-cloud }} are initially supplied without a graphical shell. Connection via SSH using a username and a password is disabled by default because this method is outdated and unsafe.

#### What should I do if I can't connect after creating a VM? {#fail-connection}

Your device should see the VM over the [network](../../vpc/concepts/network.md#network):
* If you are connecting from the outside, you need to have a [public IP address](../../vpc/concepts/address.md#public-addresses) assigned to the VM or configure connectivity through another VM with a public IP address (e.g., through a [NAT instance](../../tutorials/routing/nat-instance.md)).
* Outgoing traffic to and from the VM must be allowed on your device.

Do not turn off or restart the VM immediately after creating it. For VMs with a small guaranteed vCPU performance, the initial launch process may take a long time (up to half an hour). If the VM is terminated prematurely, the initialization scripts might not have time to execute. In this case, delete the VM and create a new one.

#### How do I use root on a Linux VM? {#use-root-linux}

When [creating a Linux VM](../../compute/operations/vm-create/create-linux-vm.md), do not use usernames reserved by the system, such as `root`, `admin`, etc, because `cloud-init` will not be able to add a user with this kind of username. Try creating a VM by specifying the `user` username instead.

To upgrade your rights to `root`, use `sudo`. The user specified when creating the VM is a member of the `sudo` group. `root` doesn't have a password, so you can simply connect to the VM via SSH (see [{#T}](../../compute/operations/vm-connect/ssh.md)) and enter the command:

```bash
sudo su
```

You can also execute various commands without switching to `root`. For example, to shut down a VM from the guest OS, just enter the command:

```bash
sudo poweroff
```

#### What should I do if I can't connect to the VM, even though the connection was working before? {#new-fail-connection}

Your data was likely taken over and third parties gained access to the VM. Take a [snapshot](../../compute/concepts/snapshot.md) of the VM's disk (see [{#T}](../../compute/operations/disk-control/create-snapshot.md)) and create a new VM from it (see [{#T}](../../compute/operations/vm-create/create-from-snapshots.md)). If you were able to connect to the new VM, use stronger passwords and don't share your private data.

If the VM created from the snapshot is also unavailable for connection, see [How do I get important data from a broken VM](#get-data-from-fail-vm).

#### What should I do if I cannot connect to a VM from a {{ marketplace-name }} image? {#fail-connection-marketplace}

Some {{ marketplace-name }} images have service usernames reserved, such as `bitrix` in the [1C-Bitrix](/marketplace/products/yc/bitrix-1c-centos-7) image. When creating a VM and connecting to it, use a username not reserved in the system, e.g., `user`. Do not use `root`, `admin`, or other system usernames.

You can later change the `bitrix` user password by running the `sudo passwd bitrix` command.

#### What do I do if the _Permission denied_ error occurs? {#permission-denied}

When [connecting](../../compute/operations/vm-connect/ssh.md#vm-connect) to a VM via SSH, the following errors may occur:

```bash
Permission denied (publickey)
Permission denied (publickey,gssapi-keyex,gssapi-with-mic)
```

Common causes of errors include:

* Mistyped public key specified when creating a virtual machine.
* Invalid private key provided when attempting to establish a connection.
* Invalid data in the `authorized_keys` file.

To solve the issue, try to specify the appropriate private key using the `-i` flag when connecting to your VM:

```bash
ssh -i <key_path/key_file_name> <username>@<VM_public_IP_address>
```

#### How do I set up an RDP/VNC connection to a Linux VM? {#set-rdp-vnc-to-linux}

There are two options for enabling the graphical interface on Linux VMs:
* Use RDP or VNC. To do this:
   1. Install the desktop environment on a Linux-based VM (Ubuntu/CentOS).
   1. Install the xrdp or VNC server to connect via RDP or VNC, respectively.
   1. Configure the software.

      We recommend using a combination of a VNC server that only listens to localhost and an SSH tunnel. In this case, you eliminate the risk of attackers connecting to your VM via VNC and also encrypt the VNC traffic.
* Configure X11 forwarding onto the local computer. For Windows, use [Xming](https://sourceforge.net/projects/xming/).
   1. Install the desktop environment.
   1. Configure X11 forwarding and connect via SSH.
   1. Launch the application from the terminal.

#### What should I do if I can't connect to the VM, even though the connection was working before? {#new-fail-connection}

Your data was likely taken over and third parties gained access to the VM. Take a snapshot of the VM's disk (see [{#T}](../../compute/operations/disk-control/create-snapshot.md)) and create a new VM from it (see [{#T}](../../compute/operations/vm-create/create-from-snapshots.md)). If you were able to connect to the new VM, use stronger passwords and don't share your private data.

If the VM created from the snapshot is also unavailable for connection, see [How do I get important data from a broken VM](#get-data-from-fail-vm).

#### How do I use a serial console? How do I connect directly to a VM? {#connection-linux-via-console}

If you have issues while connecting to a VM over a network, you can use the serial console. For more information about charts, see [{#T}](../../compute/operations/serial-console/index.md).

You can enable access to the serial console when creating or modifying a VM. The serial console is available in the {{ yandex-cloud }} [management console]({{ link-console-main }}) in the VM menu.

For a Linux VM, you need to additionally configure password access for the user in advance by connecting via SSH and setting a password with the `sudo passwd user` command, where `user` is the username you set when creating the VM.

#### What do I do if an SSH key is lost? {#lost-ssh}

{% include [new-connect-ssh](new-connect-ssh.md) %}

#### Why does the VM not work after a reboot? {#why-fail-after-reboot}

The VM may stop working after a reboot for one of the following reasons:
* The VM was forcibly restarted while writing to the system disk. In this case, the file system could be damaged.
* The firewall and/or network was incorrectly configured.
* Changes were made to the `cloud-init` settings.
* Changes were made to the Python system version, which is also used by `cloud-init`.
* There was a problem with the service.

If you performed one of these actions, see [How do I get important data from a broken VM](#get-data-from-fail-vm). Otherwise, contact support.

#### How do I get important data from a VM that crashed? {#get-data-from-fail-vm}

When a VM crashes:
1. Take a snapshot of the problematic disk (see [{#T}](../../compute/operations/disk-control/create-snapshot.md) for details).
1. Create a new VM with an additional (non-bootable) disk that was restored from the snapshot (see [{#T}](../../compute/operations/vm-create/create-from-snapshots.md) for details).
1. Connect to the VM (see [{#T}](../../compute/operations/index.md#vm-use) for details).
1. Mount the disk (see [{#T}](../../compute/operations/vm-control/vm-attach-disk.md#mount-disk-and-fix-uuid) for details).
1. Run a check of the disk file system.
1. Transfer the data you need to the boot disk of your new VM.
