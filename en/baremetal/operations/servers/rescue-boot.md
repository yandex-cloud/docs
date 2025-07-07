---
title: How to boot a {{ baremetal-full-name }} server using a Rescue CD
description: In this tutorial, you will learn how to use diagnostics and recovery tools available in the standard bootable {{ baremetal-name }} Rescue CD image.
---

# Using the Rescue CD diagnostics and recovery tools

If you cannot boot the main server OS, you can start the server using the [SystemRescue](https://www.system-rescue.org/) CD that includes essential utilities and is accessible via the KVM console.

## Boot the server from a Rescue CD {#boot-up}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your server.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Find the server you need in the list, click ![image](../../../_assets/console-icons/ellipsis.svg) in its row, and select **KVM console**.
  1. Click the CD icon or select **Media** → **Virtual Media Wizard...** in the top menu of the KVM console window. In the window that opens:

      1. In the **CD/DVD Media1** section, click **Browse** and select the `systemrescue<...>.iso` image in the `common-iso` directory.
      1. Click **Connect CD/DVD**.
      1. Check the **Virtual CD 1** device **Status** section to make sure the **Connected To** field now shows your selected CD image path, then click **Close**.
  1. To boot the server from the selected Rescue CD image, click **Reboot to CD-ROM** in the top-right corner of the KVM console.
  1. Wait for the server to restart and for the main SystemRescue menu to load. Select the required menu item using the **up and down arrow** keys, then press **Enter**.

      {% cut "SystemRescue main menu elements" %}

      * **Boot SystemRescue using default options**

          Launches the SystemRescue recovery interface with default settings.
      * **Boot SystemRescue and copy system to RAM (copyram)**

          Launches the SystemRescue recovery interface, copying the essential utilities and OS system files to RAM for operation.
      * **Boot SystemRescue and verify integrity of the medium (checksum)**

          Launches the SystemRescue recovery interface with Rescue CD media integrity verification.
      * **Boot SystemRescue using basic display drivers (nomodeset)**

          Launches the SystemRescue recovery interface with basic video drivers for GUI mode.
      * **Boot SystemRescue with serial console (ttyS0,115200n8)**

          Launches the SystemRescue recovery interface in text mode via serial console.
      * **Boot SystemRescue, do not activate md raid or lvm (nomdlvm)**

          Launches the SystemRescue recovery interface with RAID support disabled.
      * **Boot a Linux operating system installed on the disk (findroot)**

          Boots the Linux installation from the server’s primary boot disk.
      * **Stop during the boot process before mounting the root filesystem**

          Boots the OS installed on the server's primary boot disk, stopping the boot process before root filesystem mount.
      * **Boot existing OS**

          Boots the OS installed on the server. Use the **Tab** key to pre-select the disk and partition number containing the OS installation.
      * **Run Memtest86+ (RAM test)**

          Runs the Memtest86+ RAM testing utility.
      * **Reboot**

          Reboots the server.
      * **Power Off**

          Powers off the server.

      {% endcut %}

{% endlist %}

## Using SystemRescue toolkit {#use-tools}

Use SystemRescue tools to restore or configure your server:

{% list tabs %}

- SystemRescue documentation

  1. [Boot the server](#boot-up) using the Rescue CD.
  1. In the main SystemRescue menu, select **Boot SystemRescue using default options**.
  1. Once you launch SystemRescue, a terminal session will open in the KVM console. In the terminal, enter `Manual`.

      You will access the ELinks browser allowing you to browse SystemRescue documentation and explore its features.

      To exit ELinks, press **Esc**, use the **up and down arrow** keys to select **Exit** in the menu, then press **Enter**. Confirm the exit.

  You can also access [SystemRescue documentation](https://www.system-rescue.org/) using graphical user interface.

- Mounting a disk

  1. [Boot the server](#boot-up) using the Rescue CD.
  1. In the main SystemRescue menu, select **Boot SystemRescue using default options**.

      Once you launch SystemRescue, a terminal session will open in the KVM console. Run the following commands in the terminal.
  1. Identify the label of the server partition you need to mount:

      ```bash
      blkid
      ```

      Result:

      ```
      /dev/md127: LABEL="/" UUID="97e4ad6e-edd9-4574-b4b3-23a86f2a701e" BLOCK_SIZE="4096" TYPE="ext4"
      /dev/sdb4: UUID="29395ea9-a41c-c71c-2807-2f5889e52967" UUID_SUB="287cdff0-ba68-6981-f46e-e52e0bf2d799" LABEL="3" TYPE="linux_raid_member" PARTLABEL="primary" PARTUUID="d6ad0b56-8291-4e0b-ad93-85d98e078ecf"
      /dev/sdb2: UUID="557a2516-47d1-a676-2cad-fa629a418c1f" UUID_SUB="27dfdf6c-c521-c0f3-e52c-46e2b728c0c1" LABEL="1" TYPE="linux_raid_member" PARTLABEL="primary" PARTUUID="b4483bff-0bb2-4077-a530-b64daa4b6fff"
      /dev/sdb3: UUID="20426859-f357-0447-6123-af035e85ca01" UUID_SUB="4dd828b0-4b6d-ea13-a9b9-cbeb5aaa0917" LABEL="2" TYPE="linux_raid_member" PARTLABEL="primary" PARTUUID="8e624512-5665-4c11-aa0b-ecbcdb7b1d7a"
      /dev/sdb1: PARTLABEL="primary" PARTUUID="b152360c-3157-482e-9804-36620f654ec1"
      /dev/md125: LABEL="/boot" UUID="58a6d4a4-d20a-4125-b52c-f76529a398f4" BLOCK_SIZE="4096" TYPE="ext3"
      ...
      /dev/sda1: PARTLABEL="primary" PARTUUID="1a1c7c88-4cce-429f-984f-1626587626c3"
      ```

      For example, the server OS partition has the `md127` label. Save this value as it will be required for mounting the disk later.

  1. Create a local directory to serve as the mount point for the partition:

      ```bash
      mkdir /mnt/serverdisk
      ```

  1. Mount the selected partition using the label you saved earlier:

      ```bash
      mount /dev/<partition_label> /mnt/serverdisk
      ```

  1. Navigate to the mounted disk:

      ```bash
      cd /mnt/serverdisk
      ```

      Here you can access the operating system directory tree:

      ```bash
      ls -l
      ```

      Result:

      ```bash
      total 64
      lrwxrwxrwx   1 root root     7 Jul  8 10:47 bin -> usr/bin
      drwxr-xr-x   4 root root  4096 Oct 23 12:09 boot
      drwxr-xr-x  21 root root  4360 Oct 24 05:43 dev
      drwxr-xr-x  91 root root  4096 Oct 23 12:09 etc
      drwxr-xr-x   2 root root  4096 Apr 18  2022 home
      lrwxrwxrwx   1 root root     7 Jul  8 10:47 lib -> usr/lib
      lrwxrwxrwx   1 root root     9 Jul  8 10:47 lib32 -> usr/lib32
      lrwxrwxrwx   1 root root     9 Jul  8 10:47 lib64 -> usr/lib64
      lrwxrwxrwx   1 root root    10 Jul  8 10:47 libx32 -> usr/libx32
      drwx------   2 root root 16384 Oct 18 14:33 lost+found
      drwxr-xr-x   2 root root  4096 Jul  8 10:47 media
      drwxr-xr-x   2 root root  4096 Oct 23 20:08 mnt
      drwxr-xr-x   2 root root  4096 Jul  8 10:47 opt
      dr-xr-xr-x 482 root root     0 Oct 24 05:43 proc
      drwx------   5 root root  4096 Oct 23 12:05 root
      drwxr-xr-x  25 root root   800 Oct 24 05:43 run
      lrwxrwxrwx   1 root root     8 Jul  8 10:47 sbin -> usr/sbin
      drwxr-xr-x   2 root root  4096 Oct 18 14:43 snap
      drwxr-xr-x   2 root root  4096 Jul  8 10:47 srv
      dr-xr-xr-x  13 root root     0 Oct 24 05:43 sys
      drwxrwxrwt  12 root root  4096 Oct 24 05:43 tmp
      drwxr-xr-x  14 root root  4096 Jul  8 10:47 usr
      drwxr-xr-x  14 root root  4096 Oct 18 14:38 var
      ```

- GUI SystemRescue

  1. [Boot the server](#boot-up) using the Rescue CD.
  1. In the main SystemRescue menu, select **Boot SystemRescue using default options**.

      Once you launch SystemRescue, a terminal session will open in the KVM console.
  1. To launch the SystemRescue GUI, run the `startx` command in the terminal.

      This command starts the SystemRescue graphical user interface, which includes a web browser with internet access, along with diagnostics and computer management tools.

- RAM test

  1. [Boot the server](#boot-up) using the Rescue CD.
  1. In the main SystemRescue menu, select **Run Memtest86+ (RAM test)**.
  1. Once the Memtest86+ window opens, wait for the RAM test to complete.

      To cancel the test and reboot the server, press **Esc**.

{% endlist %}

#### See also {#see-also}

* [{#T}](./reset-password.md)
* [{#T}](./add-new-ssh-key.md)
* [{#T}](./restore-grub.md)
* [{#T}](./switch-raid-member.md)
* [{#T}](../image-upload.md)
