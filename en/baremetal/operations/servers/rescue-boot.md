---
title: How to start a {{ baremetal-full-name }} server with Rescue CD
description: Follow this guide to start using the diagnostics and recovery tools available in the standard bootable {{ baremetal-name }} Rescue CD image.
---

# Using the Rescue CD recovery and diagnostics disk

If you are unable to boot the main server OS, you can start the server from the dedicated Rescue CD by [SystemRescue](https://www.system-rescue.org/), which comes with a set of utilities and is available in the KVM console.

## Start the server with Rescue CD {#boot-up}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the server belongs to.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the row with the server you need, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **KVM console**.
  1. In the KVM console window, in the top menu, select **Media** → **Virtual Media Wizard...** or click the CD icon. In the window that opens:

      1. In the **CD/DVD Media1** section, click **Browse** and select the `systemrescue<...>.iso` image in the `common-iso` directory.
      1. Click **Connect CD/DVD**.
      1. Check the **Status** section for the **Virtual CD 1** device to make sure the **Connected To** field now indicates the path to the CD image you selected and click **Close**.
  1. To start the server from the selected Rescue CD image, click **Reboot to cdrom** in the top-right corner of the KVM console.
  1. Wait for the server to restart and the main SystemRescue menu to load. To select the required menu item, use the **up and down arrow** keys and press **Enter**.

      {% cut "SystemRescue main menu elements" %}

      * **Boot SystemRescue using default options**

          Launches the SystemRescue recovery interface with default settings.
      * **Boot SystemRescue and copy system to RAM (copyram)**

          Launches the SystemRescue recovery interface while copying the utilities and OS system files used by SystemRescue to RAM.
      * **Boot SystemRescue and verify integrity of the medium (checksum)**

          Launches the SystemRescue recovery interface while checking the Rescue CD medium for corruption.
      * **Boot SystemRescue using basic display drivers (nomodeset)**

          Launches the SystemRescue recovery interface using the basic video driver for the GUI.
      * **Boot SystemRescue with serial console (ttyS0,115200n8)**

          Launches the SystemRescue recovery interface using the serial console.
      * **Boot SystemRescue, do not activate md raid or lvm (nomdlvm)**

          Launches the SystemRescue recovery interface without RAID management.
      * **Boot a Linux operating system installed on the disk (findroot)**

          Boots Linux installed on the server's boot disk.
      * **Stop during the boot process before mounting the root filesystem**

          Boots the OS installed on the server's boot disk and stops the boot process before mounting the root file system.
      * **Boot existing OS**

          Boots the OS installed on the server. You can use the **Tab** key to pre-select the disk and partition number the OS is installed in.
      * **Run Memtest86+ (RAM test)**

          Runs the Memtest86+ RAM testing utility.
      * **Reboot**

          Reboots the server.
      * **Power Off**

          Powers off the server.

      {% endcut %}

{% endlist %}

## Use SystemRescue tools {#use-tools}

Use SystemRescue to restore or configure your server:

{% list tabs %}

- SystemRescue documentation

  1. [Start the server](#boot-up) with Rescue CD.
  1. In the main SystemRescue menu, select **Boot SystemRescue using default options**.
  1. After you run SystemRescue, the SystemRescue terminal will be launched in the KVM console. In this terminal, enter `Manual`.

      You will see the ELinks browser where you can learn about the SystemRescue features and explore its documentation.

      To exit ELinks, press **Esc**, use the **up and down arrow** keys to select **Exit** in the menu, and press **Enter**. Confirm the exit.

  The [SystemRescue documentation](https://www.system-rescue.org/) is also available in the GUI.

- Mounting a disk

  1. [Start the server](#boot-up) with Rescue CD.
  1. In the main SystemRescue menu, select **Boot SystemRescue using default options**.

      Running SystemRescue will launch the SystemRescue terminal in the KVM console. Use the terminal to run all the commands below.
  1.  Get the label of the partition to mount connected to the server:

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

      For example, the server OS partition has the `md127` label. Save this value as you will need it when mounting the disk.

  1. Create a local directory to use as the partition mount point:

      ```bash
      mkdir /mnt/serverdisk
      ```

  1. Mount the selected partition by specifying the previously saved label:

      ```bash
      mount /dev/<partition_label> /mnt/serverdisk
      ```

  1. Go to the mounted disk:

      ```bash
      cd /mnt/serverdisk
      ```

      It houses the directory tree of the server OS:

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

  1. [Start the server](#boot-up) with Rescue CD.
  1. In the main SystemRescue menu, select **Boot SystemRescue using default options**.

      Running SystemRescue will launch the SystemRescue terminal in the KVM console.
  1. To launch the SystemRescue GUI, run the `startx` command in the terminal.

      This will open the SystemRescue GUI with a browser, diagnostics and computer management tools, and internet access.

- RAM test

  1. [Start the server](#boot-up) with Rescue CD.
  1. In the SystemRescue main menu, select **Run Memtest86+ (RAM test)**.
  1. In the Memtest86+ utility window that opens, wait until the RAM is tested for errors.

      To cancel the test and reboot the server, press the **Esc** key.

{% endlist %}

#### See also {#see-also}

* [{#T}](./reset-password.md)
* [{#T}](./add-new-ssh-key.md)
* [{#T}](./restore-grub.md)
* [{#T}](./switch-raid-member.md)
* [{#T}](../image-upload.md)
