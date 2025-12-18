# How to export {{ compute-name }} VM images



## Issue description {#case-description}

You need to download an image of one or multiple VM disks to your local storage.

## Solution {#case-resolution}

You can only use an image or snapshot of a VM disk within {{ yandex-cloud }}.
You cannot directly download it to your computer via the [management console]({{ link-console-main }}) or the YC CLI.

To resolve this issue, you can use third-party software or native OS tools to create an image or backup of your disk, e.g., `dd` on Linux machines, and then download the image to your local storage.
To do this, follow these steps:

 {% note warning "**Please note**" %}
  
  The `dd` utility treats disk images as block devices rather than file systems.

  If you run a disk copy operation on a VM that is running on that particular disk, you may encounter data inconsistency in the image file you get. To avoid it, we highly recommend that you stop the VM and create a new image from its system disk instead of running a disk copy operation on a running system.

 {% endnote %}

1. Stop the VM whose disk image you need to copy. You can do this via the management console or the YC CLI:

   ```bash
   yc compute instance stop <VM_name>
   ```

1. Create a VM disk image to copy following [this guide](../../../compute/operations/image-create/create-from-disk).

1. Create a temporary Linux VM to run a copy operation.

1. When creating a VM, [attach a secondary disk to it](../../../compute/operations/vm-control/vm-attach-disk).
   Then, specify the image you created earlier as its contents.

1. [Connect to the temporary VM over SSH](../../../compute/operations/vm-connect/ssh).

1. Mount the secondary disk (the one you need to copy) to it following [this guide](../../../compute/operations/vm-control/vm-attach-disk#mount-disk-and-fix-uuid).

1. Create a new SSH session and copy the secondary disk to your local machine using this command:

   ```bash
   ssh <username>@<VM_IP_address> "sudo dd if=/dev/sdb status=progress | gzip -c" > sda.img.gz
   ```

   The disk image will be saved to your local directory where the SSH session was established.

If you need to transfer the disk image within {{ yandex-cloud }}, you can provide public access to it. 
To do this, assign the `{{ roles-image-user }}` role to the `{{ subjects-allAuthenticatedUsers }}` system group. This role does not grant permissions to delete or modify your images.
