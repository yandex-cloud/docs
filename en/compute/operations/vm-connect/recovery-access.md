# Restoring access to a VM

You may need to restore access to a VM in the following cases:
* [{#T}](#cloud-init).
* [{#T}](#ssh-recovery).
* [{#T}](#serial-console).
* [{#T}](#os-recovery).

## VM user credentials are lost {#cloud-init}

If you lost your SSH private key for Linux or your Windows user password:
1. [Create a snapshot](../disk-control/create-snapshot.md) of the disk of the VM that you want to restore access to.
1. [Create a VM with the disk from the snapshot](../vm-create/create-from-snapshots.md) specifying it as the boot disk. When creating a VM, enter your new credentials under **Access**.
1. Connect to the VM via SSH or RDP using the new credentials.

If the 'cloud-init' or network configuration was changed for the VM, the described method may not work. In this case, see [{#T}](#os-recovery).

## An SSH key's public part was changed {#ssh-recovery}

You may have problems accessing a Linux-based VM over SSH if the public part of your SSH key was changed or deleted on the side of the VM.

You can restore access to a Linux-based VM over SSH using the [serial console](#serial-console) if you have a valid pair of SSH keys.

If you can't access the serial console, do the following to recover the public part of your SSH key:

1. [Stop](../vm-control/vm-stop-and-start.md) the VM.
1. [Take a snaphost](../disk-control/create-snapshot.md) of the VM's boot disk.
1. [Create](../vm-create/create-from-snapshots.md) an auxiliary Linux-based VM. Use the disk from the previously created snapshot as the data disk.
1. [Connect over SSH](../vm-connect/ssh.md) to the auxiliary VM and [mount the disk](../vm-control/vm-attach-disk.md#mount-disk-and-fix-uuid) you created from the snapshot.
1. Replace the SSH key that is stored on this disk with a valid key:
   1. Go to the directory that stores the public part of the SSH key in the mounted partition. For example:

      ```bash
      cd /mnt/home/<username>/.ssh
      ```

      By default, a user's SSH keys are stored in the `~/.ssh` directory of this user.
   1. Open the `authorized_keys` file, for example, using the `nano` text editor:

      ```bash
      nano authorized_keys
      ```

      If the file is missing, this command will create it.
   1. Replace the contents of the file with the public part of the valid SSH key pair.
1. Unmount the disk with the fixed SSH key from the VM:

   ```bash
   sudo umount /mnt
   ```

1. [Stop](../vm-control/vm-stop-and-start.md) the auxiliary VM and [detach](../vm-control/vm-detach-disk.md) the disk with the fixed SSH key from it.
1. [Create](../vm-create/create-from-disks.md) a new VM. Under **Image/boot disk selection**, go to the **Custom** tab and select the disk with the fixed SSH key as the boot disk.

   {% note info %}

   Make sure the new VM and the disk with the fixed SSH key are in the same availability zone.

   {% endnote %}

1. [Connect](../vm-connect/ssh.md) to the new VM over SSH.
1. [Delete the disk snapshot](../snapshot-control/delete.md) and [delete](../vm-control/vm-delete.md) the auxiliary and old VMs.

## Unable to connect to a VM via SSH {% if product == "cloud-il" %}or RDP{% endif %} {#serial-console}

The problem may occur due to an error in the SSH, {% if product == "cloud-il" %}RDP, {% endif %}[security group](../../../vpc/concepts/security-groups.md), or network settings. To restore access, connect to the VM using the [serial console](../serial-console/index.md) and adjust the settings.

{% list tabs %}

- Linux

   {% note info %}

   You may use the serial console only if the user password is set. Otherwise, see [{#T}](#os-recovery).

   {% endnote %}

   1. [Enable access](../serial-console/index.md#turn-on-for-current-instance) to the VM serial console.
   1. [Connect](../serial-console/connect-cli.md#connect-to-serial-console) to the serial console.
   1. Change the SSH or network settings. If you have [security groups](../../../vpc/concepts/security-groups.md) set up, make sure that their rules allow incoming TCP traffic to port 22.
   1. Connect to the VM via SSH.

{% if product == "cloud-il" %}

- Windows

   1. [Enable access](../serial-console/index.md#turn-on-for-current-instance) to the VM serial console.
   1. [Connect](../serial-console/connect-cli.md#connect-to-serial-console) to the serial console.
   1. Change the RDP or network settings. If you have [security groups](../../../vpc/concepts/security-groups.md) set up, make sure that their rules allow incoming TCP traffic to port 3389.
   1. Connect to the VM via RDP.

{% endif %}

{% endlist %}

## A VM fails to start {#os-recovery}

If you can't start a VM, gain access to data on the disk as follows:
1. [Create a snapshot](../disk-control/create-snapshot.md) of the disk of the VM that you want to restore access to.
1. [Create a disk](../disk-create/empty.md) from the snapshot. When creating a disk, choose `Snapshot` in the **Content** field and specify the created snapshot.
1. [Attach the disk](../vm-control/vm-attach-disk.md) as secondary to the auxiliary VM.
1. Change the configuration files that affect the VM startup or copy important data.
1. [Detach the disk](../vm-control/vm-detach-disk.md) from the auxiliary VM.
1. If you found and fixed the startup issue, create a new VM. When creating a VM, specify `Custom` under **Image/boot disk selection** and select the fixed disk as the boot disk.