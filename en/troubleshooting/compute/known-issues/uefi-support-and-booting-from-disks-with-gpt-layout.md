# UEFI support and data import from GPT-formatted disks

## Issue description {#issue-description}

* You couldn't start an instance whose OS loader uses UEFI.
* You couldn't start an instance whose boot disk uses the GUID Partition Table.

## Solution

The VM image using a UEFI bootloader won't work in Yandex Cloud.
To boot from GPT-formatted disks of more than 2 TB, you can use the [GRUB 2](https://www.gnu.org/software/grub/manual/grub/html_node/BIOS-installation.html) bootloader. 

You can vote for UEFI support on the Yandex Cloud [community portal](https://cloud.yandex.ru/features).

We review all the community suggestions regularly, adding them to our roadmap. As soon as we implement the idea you upvoted, we will email you.
