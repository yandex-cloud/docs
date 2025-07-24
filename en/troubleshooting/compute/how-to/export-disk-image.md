# How to export disk images of virtual machines {{ compute-name }}



## Task description {#case-description}

You need to upload an image of one or more VM disks to the local storage.

## Solution {#case-resolution}

Disk images or snapshots of Compute Cloud instances can only be used within {{ yandex-cloud }}.
It is impossible to download it to your computer directly from the [Management Console]({{ link-console-main }}) interface or using the YC CLI tools.

You can use third-party software or standard OS tools to create an image or backup copy of your disk.
For example, run the `dd` utility on the temporary Linux instance with an attached copy of the target disk, and then download resulting image to your local computer.
To do this, follow these steps:

 {% note warning "**Note**" %}
  
  `dd` utility treats disks as block devices, not as file systems.

  If you run a disk copy operation on a virtual machine that is currently booted directly from this disk, there may be data inconsistency in its image file.
  To avoid this, we strongly recommend stopping the VM and creating a new image from its system disk.

 {% endnote %}

1. Stop the VM with the disk you want to copy. You can do this in the management console or by the command in the YC CLI:

   ```bash
   yc compute instance stop <instance_name>
   ```

2. Create the VM disk image that you want to copy [following these instructions](../../../compute/operations/image-create/create-from-disk).

3. Create a temporary Linux-based VM. You will run a disk image copy operation on it.

4. While creating a VM, [connect an additional disk to it](../../../compute/operations/vm-control/vm-attach-disk).\
Then specify the previously created image as disk contents.

5. [Connect to the created temporary VM via SSH](../../../compute/operations/vm-connect/ssh).

6. Attach an additional disk, which you want to copy, to the temporary instance, [following these instructions](../../../compute/operations/vm-control/vm-attach-disk#mount-disk-and-fix-uuid).

7. Create a new SSH session and copy the additional disk to the local machine with the command:

   ```bash
   ssh <username>@<ip_address> "sudo dd if=/dev/sdb status=progress | gzip -c" > sda.img.gz
   ```

   In a result, your disk image will be saved to a directory on the local machine from where the SSH session was started.

If you need to transfer a disk image within {{yandex-cloud }}, you can provide public access to the disk image. 
To do this, assign the role `{{roles-image-user }}` to the system group `{{subjects-allAuthenticatedUsers }}`. The role `{{roles-image-user }}` does not grant the authority to delete or modify your images.
