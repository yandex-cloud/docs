# Connection

#### How do I connect to a Linux VM? {#conn-vm-linux}

Use this guide: [{#T}](../../compute/operations/vm-connect/ssh.md). If the computer you are connecting from runs Windows 7, 8, or early releases of Windows 10 without a built-in console SSH client, use [PuTTY](https://www.putty.org/).

Linux images provided by {{ yandex-cloud }} come without a GUI shell by default. SSH authentication with a username and password is disabled by default, as this method is outdated and poses security risks.

#### I cannot login to my VM after creating it. What should I do? {#fail-connection}

Your device must have [network](../../vpc/concepts/network.md#network) connectivity to the VM:
* If you are connecting externally, your VM must have a [public IP address](../../vpc/concepts/address.md#public-addresses) or be accessible through another VM with a public IP address, e.g., through a [NAT instance](../../tutorials/routing/nat-instance/index.md).
* Your device must allow outgoing traffic to the VM and incoming traffic from it.

Do not shut down or reboot the VM immediately after creating it. VMs with low guaranteed vCPU performance may take a long time to boot for the first time, up to half an hour. If the VM is terminated prematurely, the initialization scripts might have failed to complete. In this case, delete the VM and create a new one.

#### How do I use root on a Linux VM? {#use-root-linux}

When [creating a Linux VM](../../compute/operations/vm-create/create-linux-vm.md), do not use usernames reserved by the system, such as `root`, `admin`, etc., because `cloud-init` will not be able to add a user with such a username. Try creating a VM, specifying `user` for username.

To upgrade your permissions to `root`, use `sudo`. The user specified when creating the VM is a member of the `sudo` group. `root` has no password, so you can simply connect to the VM over SSH (see [{#T}](../../compute/operations/vm-connect/ssh.md)) and run this command:

```bash
sudo su
```

You can also run various commands without switching to `root`. For example, to shut down a VM from within the guest OS, use this command:

```bash
sudo poweroff
```

#### I can no longer login to my VM. What should I do? {#new-fail-connection}

Your login details have likely been compromised, resulting in unauthorized access to the VM. Create a [disk snapshot](../../compute/concepts/snapshot.md) of your VM (see [{#T}](../../compute/operations/disk-control/create-snapshot.md) this guide for details) and use it to create a new VM (see [{#T}](../../compute/operations/vm-create/create-from-snapshots.md) this guide for details). If you succeeded connecting to the new VM, make sure to use stronger passwords and do not share your private data.

If you cannot access the VM you created from the snapshot either, see [How do I retrieve important data from a failed VM](#get-data-from-fail-vm).

#### What should I do if I cannot connect to a VM created from a {{ marketplace-name }} image? {#fail-connection-marketplace}

Some {{ marketplace-name }} images have service usernames reserved, e.g., `bitrix` in the [1C-Bitrix](/marketplace/products/yc/bitrix-1c-centos-7) image. When creating a VM and connecting to it, use a username not reserved in the system, such as `user`. Do not use `root`, `admin`, or other system usernames.

Later on, you will be able to change the `bitrix` user password by running the `sudo passwd bitrix` command.

#### What do I do if the _Permission denied_ error occurs? {#permission-denied}

When [connecting](../../compute/operations/vm-connect/ssh.md#vm-connect) to a VM via SSH, you may get the following errors:

```bash
Permission denied (publickey)
Permission denied (publickey,gssapi-keyex,gssapi-with-mic)
```

Here are common causes of these errors:

* Mistyped public key specified when creating a VM.
* Invalid private key provided when attempting to establish a connection.
* Invalid data in the `authorized_keys` file.

To solve the connection issue, try providing the valid private key using the `-i` flag:

  ```bash
  ssh -i <key_path/key_file_name> <username>@<VM_public_IP_address>
  ```

#### How do I set up an RDP/VNC connection to a Linux VM? {#set-rdp-vnc-to-linux}

To enable the GUI on Linux VMs, consider one of these two options:
* Use RDP or VNC. To do this:
  1. Install the desktop environment on the Linux VM (Ubuntu/CentOS).
  1. Install the `xrdp` or VNC server to connect through RDP or VNC, respectively.
  1. Configure the software.

     We recommend using a combination of a VNC server that only listens to localhost and an SSH tunnel. This way, you will both eliminate the risk of attackers connecting to your VM through VNC and encrypt the VNC traffic.
* Configure X11 forwarding to the local computer. For Windows, use [Xming](https://sourceforge.net/projects/xming/).
  1. Install the desktop environment.
  1. Configure X11 forwarding and connect over SSH.
  1. Start the application from the terminal.

#### I can no longer login to my VM. What should I do? {#new-fail-connection}

Your login details have likely been compromised, resulting in unauthorized access to the VM. Create a disk snapshot of your VM (see [{#T}](../../compute/operations/disk-control/create-snapshot.md) this guide for details) and use it to create a new VM (see [{#T}](../../compute/operations/vm-create/create-from-snapshots.md) this guide for details). If you succeeded connecting to the new VM, make sure to use stronger passwords and do not share your private data.

If you cannot access the VM you created from the snapshot either, see [How do I retrieve important data from a failed VM](#get-data-from-fail-vm).

#### How do I use a serial console? How do I connect to my VM directly? {#connection-linux-via-console}

If you have issues while connecting to your VM over a network, you can use the serial console. For more information about a serial console, see [{#T}](../../compute/operations/serial-console/index.md).

You can enable serial console access when creating or updating your VM. The serial console will be available in the {{ yandex-cloud }} [management console]({{ link-console-main }}) from the VM menu.

For a Linux VM, you need to additionally configure password access for the user in advance by connecting over SSH and setting the password using the `sudo passwd user` command (replace `user` with the username you specified when creating the VM).

#### What should I do if I lose my SSH key? {#lost-ssh}

{% include [new-connect-ssh](new-connect-ssh.md) %}

#### Why is my VM not working after a reboot? {#why-fail-after-reboot}

The VM may fail to start after a reboot for one of the following reasons:
* The VM was forcibly restarted while writing to the system disk. This could have damaged the file system.
* Either the firewall or the network, or both, were not properly configured.
* `cloud-init` settings were updated.
* The Python system version, which is also used by `cloud-init`, was modified.
* There was an issue with the service.

If you performed one of these actions, see [How do I retrieve important data from a failed VM](#get-data-from-fail-vm). Otherwise, submit a support request.

#### How do I retrieve important data from a failed VM? {#get-data-from-fail-vm}

When a VM fails:
1. Create a snapshot of the faulty disk (see [{#T}](../../compute/operations/disk-control/create-snapshot.md) this guide for details).
1. Create a new VM with a secondary (non-bootable) disk recovered from the snapshot (see [{#T}](../../compute/operations/vm-create/create-from-snapshots.md) for details).
1. Connect to the VM (see [{#T}](../../compute/operations/index.md#vm-use) for details).
1. Mount the disk (see [{#T}](../../compute/operations/vm-control/vm-attach-disk.md#mount-disk-and-fix-uuid) for details).
1. Run a check of the disk file system.
1. Transfer the data you need to the boot disk of your new VM.
