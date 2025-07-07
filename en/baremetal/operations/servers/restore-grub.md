---
title: How to restore the OS bootloader on a {{ baremetal-full-name }} server
description: In this tutorial, you will learn how to restore the Linux bootloader on a {{ baremetal-name }} legacy BIOS server using the Rescue CD.
---

# Restoring the OS bootloader

{% note info %}

This guide only applies to Linux servers configured for legacy BIOS boot. Restoring GRUB on UEFI systems requires a different procedure.

{% endnote %}

If your {{ baremetal-name }} legacy BIOS server experiences [GRUB](https://en.wikipedia.org/wiki/GNU_GRUB) bootloader issues, you can use the Rescue CD to restore it. Proceed with the following steps in the [KVM console](./server-kvm.md).

To restore the bootloader:

1. {% include [rescue-chroot-to-server-fs1](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs1.md) %}
1. List server disks and their partitions:

    {% include [fdisk-l-in-rescue](../../../_includes/baremetal/fdisk-l-in-rescue.md) %}

    In the example above, the `fdisk` utility displayed information about the `/dev/sda` and `/dev/sdb` physical disks, their partitions, and the partitions of the server’s RAID array: `/dev/md127`, `/dev/md126`, and `/dev/md125`.
    
    The reference server uses the following partition scheme:
    * `/dev/md126`: `/boot` partition.
    * `/dev/md127`: `SWAP` partition.
    * `/dev/md125`: `/` root partition.
    
    You need to mount the `/boot` and `/` partitions in SystemRescue.

1. Mount {{ baremetal-name }} server’s root and boot partitions in SystemRescue:

    ```bash
    mount /dev/md125 /mnt/
    mount /dev/md126 /mnt/boot
    ```

    {% note info %}

    If the system has no RAID array, you need to mount physical disk partitions, e.g., `/dev/sda1`, `/dev/sda2`, directly.

    If you installed your OS using [LVM](https://en.wikipedia.org/wiki/Logical_Volume_Manager_(Linux)), you need to mount the `/dev/mapper` partition.

    When using an [UEFI](https://en.wikipedia.org/wiki/UEFI) bootloader, also mount the corresponding EFI system partition, e.g., `mount /dev/sda3 /mnt/boot/efi`, where `/dev/sda3` is the EFI partition.

    {% endnote %}

1. Mount the `/sys`, `/proc`, and `/dev` directories:

    ```bash
    mount --bind /sys /mnt/sys
    mount --bind /proc /mnt/proc
    mount --bind /dev /mnt/dev
    ```
1. {% include [rescue-chroot-to-server-fs4](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs4.md) %}
1. If GRUB is not installed, install it on all disks you are planning to use as OS boot drives. If GRUB is already installed, proceed to the next step.

    In our example, you need to install GRUB on the `/dev/sda` and `/dev/sdb` disks.

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
1. Exit the `chroot` environment:

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