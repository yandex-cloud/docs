---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Restoring access to a VM

You may need to restore access to a VM in the following cases:

* [{#T}](#cloud-init).
* [{#T}](#serial-console).
* [{#T}](#os-recovery).

## VM user credentials are lost {#cloud-init}

If you lost your SSH private key for Linux or your Windows user password:

1. [Create a snapshot](../disk-control/create-snapshot.md) of the disk of the VM that you want to restore access to.
1. [Create a VM with the disk from the snapshot](../disk-control/create-snapshot.md) specifying it as the boot disk. When creating a VM, enter your new credentials under **Access**.
1. Connect to the VM via SSH or RDP using the new credentials.

If the 'cloud-init' or network configuration was changed for the VM, the described method may not work. In this case, see [{#T}](#os-recovery).

## Unable to connect to a VM via SSH or RDP {#serial-console}

The problem may occur due to an error in the SSH, RDP, or network settings. To restore access, connect to the VM using the [serial console](../serial-console/index.md) and adjust the settings.

{% list tabs %}

- Linux

  {% note info %}

  You may use the serial console only if the user password is set. Otherwise, see [{#T}](#os-recovery).

  {% endnote %}
  
  1. [Enable access](../serial-console/index.md#turn-on-for-current-instance) to the VM serial console.
  1. [Connect](../serial-console/connect-cli.md#connect-to-serial-console) to the serial console.
  1. Change the SSH or network settings.
  1. Connect to the VM via SSH.

- Windows

  1. [Enable access](../serial-console/index.md#turn-on-for-current-instance) to the VM serial console.
  1. [Connect](../serial-console/connect-cli.md#connect-to-serial-console) to the serial console.
  1. Change the RDP or network settings.
  1. Connect to the VM via RDP.

{% endlist %}

## A VM fails to start {#os-recovery}

If you can't start a VM, gain access to data on the disk as follows:

1. [Create a snapshot](../disk-control/create-snapshot.md) of the disk of the VM that you want to restore access to.
1. [Create a disk](../disk-create/empty.md) from the snapshot. When creating a disk, choose `Snapshot` in the **Content** field and specify the created snapshot.
1. [Attach the disk](../vm-control/vm-attach-disk.md) as secondary to the auxiliary VM.
1. Change the configuration files that affect the VM startup or copy important data.
1. [Detach the disk](../vm-control/vm-detach-disk.md) from the auxiliary VM.
1. If you found and fixed the startup issue, create a new VM. When creating a VM, specify `Custom` under **Image/boot disk selection** and select the fixed disk as the boot disk.

