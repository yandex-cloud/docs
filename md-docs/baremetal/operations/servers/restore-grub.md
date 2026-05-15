# Восстановить загрузчик ОС

{% note info %}

Данная инструкция применима к серверам с операционными системами Linux, работающими в Legacy-режиме. Порядок действий для восстановления GRUB в UEFI-режиме отличается.

{% endnote %}

При возникновении на сервере BareMetal проблем с загрузчиком [GRUB](https://ru.wikipedia.org/wiki/GNU_GRUB) операционных систем Linux, работающих в Legacy-режиме, вы можете восстановить GRUB с помощью загрузочного CD-образа Rescue-CD. Дальнейшие действия необходимо выполнять в [KVM-консоли](server-kvm.md).

Чтобы восстановить загрузчик:

1. [Запустите](rescue-boot.md#boot-up) сервер с CD-образа Rescue-CD.
   
   В основном меню SystemRescue выберите опцию **Boot SystemRescue using default options**, нажмите **ENTER** и дождитесь загрузки операционной системы SystemRescue.
1. Посмотрите информацию об устройствах хранения ([дисках](../../concepts/disks/disk-types.md) и созданных на них разделах) сервера:

    ```bash
    fdisk -l
    ```
    
    Результат:
    
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

    В примере выше утилита `fdisk` вывела информацию о физических дисках (`/dev/sda` и `/dev/sdb`) и их разделах, а также о созданном из них [RAID](../../concepts/disks/raid.md)-массиве, содержащем три раздела: `/dev/md127`, `/dev/md126` и `/dev/md125`.
    
    На сервере, который используется в качестве примера:
    * `/dev/md126` — раздел `/boot`;
    * `/dev/md127` — раздел `SWAP`;
    * `/dev/md125` — раздел `/` с корневой файловой системой.
    
    Разделы `/boot` и `/` необходимо смонтировать в операционную систему SystemRescue.

1. Смонтируйте разделы с корневой файловой системой и загрузочными файлами операционной системы сервера BareMetal в ОС SystemRescue:

    ```bash
    mount /dev/md125 /mnt/
    mount /dev/md126 /mnt/boot
    ```

    {% note info %}

    Если в системе нет RAID-массива, монтировать нужно непосредственно разделы физического диска (`/dev/sda1`, `/dev/sda2` и т.д.).

    Если операционная система установлена на диск с использованием [LVM](https://ru.wikipedia.org/wiki/LVM), монтировать нужно раздел `/dev/mapper`.

    Если используется [UEFI](https://ru.wikipedia.org/wiki/Extensible_Firmware_Interface)-загрузчик, то смонтируйте также соответствующий раздел с EFI, например: `mount /dev/sda3 /mnt/boot/efi`, где `/dev/sda3` — раздел c EFI.

    {% endnote %}

1. Примонтируйте директории `/sys`, `/proc` и `/dev`:

    ```bash
    mount --bind /sys /mnt/sys
    mount --bind /proc /mnt/proc
    mount --bind /dev /mnt/dev
    ```
1. Создайте новую среду оболочки ОС SystemRescue с окружением в смонтированной ранее файловой системе ОС сервера BareMetal:
   
   ```bash
   chroot /mnt /bin/bash
   ```
1. Если на дисках не установлен GRUB, установите его. GRUB должен быть установлен на все диски, с которых вы планируете загружать ОС сервера. Если GRUB уже установлен, переходите к следующему шагу.

    Для сервера, используемого в качестве примера, GRUB необходимо установить на диски `/dev/sda` и `/dev/sdb`:

    ```bash
    grub-install /dev/sda
    grub-install /dev/sdb
    ```

    Результат:

    ```
    Installing for i386-pc platform.
    Installation finished. No error reported.
    ```
1. Сгенерируйте файл конфигурации GRUB:

    ```bash
    update-grub
    ```

    Результат:

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
1. Выйдите из созданного окружения `chroot`:

    ```bash
    exit
    ```
1. Отключите виртуальный CD-дисковод в KVM-консоли:
   
   1. В окне KVM-консоли в верхнем меню выберите **Media** → **Virtual Media Wizard...** или нажмите на значок с изображением CD-диска.
   1. В открывшемся окне в секции **CD/DVD Media1** нажмите кнопку **Disconnect**.
   1. Нажмите **Close**.
1. Перезапустите сервер:
   
   ```bash
   reboot
   ```

#### См. также {#see-also}

* [Воспользоваться диском восстановления и диагностики Rescue-CD](rescue-boot.md)
* [Сбросить пароль root-пользователя на сервере](reset-password.md)
* [Добавить новый SSH-ключ пользователя](add-new-ssh-key.md)
* [Заменить диск в RAID-массиве](switch-raid-member.md)