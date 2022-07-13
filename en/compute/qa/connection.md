# Connection


#### How do I connect to a VM running Windows Server {#conn-vm-windows-server}

See: [{#T}](../operations/vm-connect/rdp.md).

For the first connection, use the `Administrator` account. It's a good idea to choose a strong password for this account and create another account for everyday work and connect via the latter in the future.

For images without [additional Remote Desktop Services licenses](../pricing.md#prices-os), a maximum of two simultaneous RDP connections are possible.



#### How do I connect to a Linux VM {#conn-vm-linux}

See: [{#T}](../operations/vm-connect/ssh.md). If the computer you're connecting from has an older version of Windows (7, 8, and the first releases of Windows 10) and there is no built-in SSH console client, use [PuTTY](https://www.putty.org/).

The Linux images from {{ yandex-cloud }} are initially supplied without a graphical shell. Connection via SSH using a username and a password is disabled by default because this method is outdated and unsafe.

#### What do I do if I can't connect after creating the VM {#fail-connection}

Your device should "see" the VM over the network:
* If you're connecting from the outside, a public IP address must be assigned to the VM or connectivity must be configured via another VM with a public IP address (for example, via an [NAT instance](../../tutorials/routing/nat-instance.md)).
* Outgoing traffic to and from the VM must be allowed on your device.

You shouldn't turn off or restart the VM immediately after creating it. For VMs with a small guaranteed vCPU performance, the initial launch process may take a long time (up to half an hour). If the VM is terminated prematurely, the initialization scripts might not have time to execute. In this case, delete the VM and create a new one.



#### How do I use root on a Linux VM {#use-root-linux}

When creating a Linux VM, don't use usernames reserved by the system, such as `root`, `admin`, and so on, because `cloud-init` can't add a user with this kind of username. Try creating a VM by specifying the username `user`.

To upgrade your rights to `root`, use `sudo`. The user specified when creating the VM is a member of the `sudo` group. `root` doesn't have a password, so you can simply connect to the VM via SSH (see [{#T}](../operations/vm-connect/ssh.md)) and enter the command:

```bash
sudo su
```

You can also execute various commands without switching to `root`. For example, to shut down a VM from the guest OS, just enter the command:

```bash
sudo poweroff
```

#### What do I do if I can't connect to the VM, even though the connection was working before {#new-fail-connection}

Your data was likely taken over and third parties gained access to the VM. Take a snapshot of the VM's disk (see [{#T}](../operations/disk-control/create-snapshot.md)) and create a new VM from it (see [{#T}](../operations/vm-create/create-from-snapshots.md)). If you were able to connect to the new VM, use stronger passwords and don't share your private data.

If the VM created from the snapshot is also unavailable for connection, see [How do I get important data from a broken VM](#get-data-from-fail-vm).

#### How do I set up an RDP/VNC connection to a Linux VM {#set-rdp-vnc-to-linux}

There are two options for enabling the graphical interface on Linux VMs:
* Use RDP or VNC. To do this:
   1. Install the desktop environment on a Linux-based VM (Ubuntu/CentOS).
   1. Install the xrdp or VNC server to connect via RDP or VNC, respectively.
   1. Configure the software.

      We recommend using a combination of a VNC server that listens only to localhost and an SSH tunnel. In this case, you eliminate the risk of attackers connecting to your VM via VNC and also encrypt the VNC traffic. You may find it useful to read this [Habr article](https://habr.com/ru/company/ua-hosting/blog/273201/).
* Configure X11 forwarding onto the local computer. For Windows, use [Xming](https://sourceforge.net/projects/xming/).
   1. Install the desktop environment.
   1. Configure X11 forwarding and connect via SSH.
   1. Launch the application from the terminal.
      

#### How do I use the serial console / How do I directly connect to a VM {#connection-linux-via-console}

If you have problems connecting to a VM over a network, you can use the serial console. For more information about charts, see [{#T}](../operations/serial-console/index.md).

You can enable access to the serial console when creating or modifying a VM. The serial console is available in the {{ yandex-cloud }} [management console]({{ link-console-main }}) in the VM menu.

For a Linux VM, you additionally need to configure password access for the user in advance by connecting via SSH and setting a password with the `sudo passwd user` command (instead of `user`, specify the username that was set when creating the VM).


#### Why may the VM not work after a reboot {#why-fail-after-reboot}

The VM may stop working after a reboot for one of the following reasons:
* The VM was forcibly restarted while writing to the system disk. In this case, the file system could be damaged.
* The firewall and/or network was incorrectly configured.
* Changes were made to the `cloud-init` settings.
* Changes were made to the python system version, which is used by `cloud-init` as well.
* There was a problem with the service.

If you performed one of these actions, see [How do I get important data from a broken VM](#get-data-from-fail-vm). Otherwise, contact support.


#### How do I get important data from a broken VM {#get-data-from-fail-vm}


When a VM malfunctions:
1. Take a snapshot of the problem disk: see [{#T}](../operations/disk-control/create-snapshot.md).
1. Create a new VM with an additional (non-bootable) disk that was restored from the snapshot: see  [{#T}](../operations/vm-create/create-from-snapshots.md).
1. Connect to the VM: see [{#T}](../operations/index.md#vm-use).
1. Mount the disk: see [{#T}](../operations/vm-control/vm-attach-disk.md#mount-disk-and-fix-uuid).
1. Run a check of the disk's file system.
1. Transfer the necessary data to the boot disk of the new VM.
