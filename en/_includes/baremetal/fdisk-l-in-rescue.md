```bash
fdisk -l
```

Result:

```text
Disk /dev/sda: 838.36 GiB, 900185481216 bytes, 1758174768 sectors
Disk model: SAMSUNG MZ7GE900
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/0 size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: D79F5407-DEEC-4A1D-983F-3AC5********

Device      Start      End         Sectors      Size  Type
/dev/sda1   2048       614399      612352       299M  BIOS boot
/dev/sda2   614400     21585919    20971520     10G   Linux filesystem
/dev/sda3   21585920   34168831    12582912     6G    Linux filesystem
/dev/sda4   34168832   1732861951  1698693120   810G  Linux filesystem


Disk /dev/sdb: 838.36 GiB, 900185481216 bytes, 1758174768 sectors
Disk model: SAMSUNG MZ7GE900
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/0 size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: CDZACB4C-1618-4BAF-A6BB-D2B9********

Device      Start      End         Sectors      Size  Type
/dev/sdb1   2048       614399      612352       299M  BIOS boot
/dev/sdb2   614400     21585919    20971520     10G   Linux filesystem
/dev/sdb3   21585920   34168831    12582912     6G    Linux filesystem
/dev/sdb4   34168832   1732861951  1698693120   810G  Linux filesystem

Disk /dev/md127: 6 GiB, 6438256640 bytes, 12574720 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/0 size (minimum/optimal): 512 bytes / 512 bytes

Disk /dev/md126: 9.99 GiB, 10729029632 bytes, 20955136 sectors = 512 bytes
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/0 size (minimum/optimal): 512 bytes / 512 bytes

Disk /dev/md125: 809.88 GiB, 869596659712 bytes, 1698430976 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/0 size (minimum/optimal): 512 bytes / 512 bytes

Disk /dev/loop: 824.97 MiB, 865046528 bytes, 1689544 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
```