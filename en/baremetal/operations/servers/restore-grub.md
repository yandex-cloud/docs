---
title: How to restore the OS bootloader on a {{ baremetal-full-name }} server
description: Follow this guide to restore the Linux bootloader from a Rescue CD boot image on a {{ baremetal-name }} server running in legacy mode.
---

# Restoring the OS bootloader

{% note info %}

This guide applies to Linux servers running in legacy mode. The procedure for restoring GRUB in UEFI mode is different.

{% endnote %}

In the event of {{ baremetal-name }} server issues with the [GRUB](https://en.wikipedia.org/wiki/GNU_GRUB) bootloader for Linux distributions running in legacy mode, you can use a Rescue CD boot image to restore GRUB. Proceed in the [KVM console](./server-kvm.md).

To restore the bootloader:

1. {% include [rescue-chroot-to-server-fs1](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs1.md) %}
1. View information about the server storage devices (disks and partitions created on them):

    {% include [fdisk-l-in-rescue](../../../_includes/baremetal/fdisk-l-in-rescue.md) %}

    In the above example, the `fdisk` utility outputs information about the physical disks (`/dev/sda` and `/dev/sdb`), their partitions, and the RAID created from them containing three partitions (`/dev/md127`, `/dev/md126`, and `/dev/md125`).
    
    The example server is partitioned as follows:
    * `/dev/md126`: `/boot` partition.
    * `/dev/md127`: `SWAP` partition.
    * `/dev/md125`: `/` partition with the root file system.
    
    You need to mount the `/boot` and `/` partitions in SystemRescue.

1. Mount the partitions with the root file system and boot files for the {{ baremetal-name }} server OS in SystemRescue:

    ```bash
    mount /dev/md125 /mnt/
    mount /dev/md126 /mnt/boot
    ```

    {% note info %}

    If there is no RAID in the OS, you need to mount the physical disk partitions (`/dev/sda1`, `/dev/sda2`, etc.).

    If the OS was installed on the disk using [LVM](https://en.wikipedia.org/wiki/Logical_Volume_Manager_(Linux)), you need to mount the `/dev/mapper` partition.

    If using the [UEFI](https://en.wikipedia.org/wiki/UEFI) bootloader, mount the relevant EFI partition as well, e.g., `mount /dev/sda3 /mnt/boot/efi`, where `/dev/sda3` is the EFI partition.

    {% endnote %}

1. Mount the `/sys`, `/proc`, and `/dev` directories:

    ```bash
    mount --bind /sys /mnt/sys
    mount --bind /proc /mnt/proc
    mount --bind /dev /mnt/dev
    ```
1. {% include [rescue-chroot-to-server-fs4](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs4.md) %}
1. If GRUB is not installed on the disks, install it. GRUB must be installed on all the disks you are going to boot the server OS from. If GRUB is already installed, proceed to the next step.

    For the example server, you need to install GRUB on the `/dev/sda` and `/dev/sdb` disks.

    ```bash
    grub-install /dev/sda
    grub-install /dev/sdb
    ```

    Result:

    ```
    Installing for i386-pc platform.
    Installation finished. No error reported.
    ```
1. Generate a GRUB configuration file:

    ```bash
    update-grub
    ```

    Result:

    ```text
    Sourcing file '/etc/default/grub'
    Sourcing file '/etc/default/grub.d/init-select.cfg'
    Generating grub configuration file ...
    Found linux image: /boot/uml inuz-5.15.0-130-generic
    Found initrd image: /boot/initrd.img-5.15.0-130-generic
    Found linux image: /boot/vmlinuz-5.15.0-113-generic
    Found initrd image: /boot/initrd.img-5.15.0-113-generic
    Found linux image: /boot/vmlinuz-5.15.0-25-generic
    Found initrd image: /boot/initrd.img-5.15.0-25-generic
    Warning: os-prober will not be executed to detect other bootable partitions.
    Systems on them will not be added to the GRUB boot configuration.
    Check GRUB_DISABLE_OS_PROBER documentation entry.
    done
    ```
1. Exit the `chroot` environment you created:

    ```bash
    exit
    ```
1. {% include [disconnect-kvm-cd](../../../_includes/baremetal/disconnect-kvm-cd.md) %}
1. {% include [rescue-chroot-to-server-fs7](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs7.md) %}

#### See also {#see-also}

* [{#T}](./rescue-boot.md)
* [{#T}](./reset-password.md)
* [{#T}](./add-new-ssh-key.md)
* [{#T}](./switch-raid-member.md)