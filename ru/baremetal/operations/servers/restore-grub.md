---
title: Как восстановить загрузчик ОС на сервере {{ baremetal-full-name }}
description: Следуя данной инструкции, с помощью загрузочного CD-образа Rescue-CD вы сможете восстановить загрузчик операционной системы Linux на сервере {{ baremetal-name }}, работающем в Legacy-режиме.
---

# Восстановить загрузчик ОС

{% note info %}

Данная инструкция применима к серверам с операционными системами Linux, работающими в Legacy-режиме. Порядок действий для восстановления GRUB в UEFI-режиме отличается.

{% endnote %}

При возникновении на сервере {{ baremetal-name }} проблем с загрузчиком [GRUB](https://ru.wikipedia.org/wiki/GNU_GRUB) операционных систем Linux, работающих в Legacy-режиме, вы можете восстановить GRUB с помощью загрузочного CD-образа Rescue-CD. Дальнейшие действия необходимо выполнять в [KVM-консоли](./server-kvm.md).

Чтобы восстановить загрузчик:

1. {% include [rescue-chroot-to-server-fs1](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs1.md) %}
1. Посмотрите информацию об устройствах хранения (дисках и созданных на них разделах) сервера:

    {% include [fdisk-l-in-rescue](../../../_includes/baremetal/fdisk-l-in-rescue.md) %}

    В примере выше утилита `fdisk` вывела информацию о физических дисках (`/dev/sda` и `/dev/sdb`) и их разделах, а также о созданном из них RAID-массиве, содержащем три раздела: `/dev/md127`, `/dev/md126` и `/dev/md125`.
    
    На сервере, который используется в качестве примера:
    * `/dev/md126` — раздел `/boot`;
    * `/dev/md127` — раздел `SWAP`;
    * `/dev/md125` — раздел `/` с корневой файловой системой.
    
    Разделы `/boot` и `/` необходимо смонтировать в операционную систему SystemRescue.

1. Смонтируйте разделы с корневой файловой системой и загрузочными файлами операционной системы сервера {{ baremetal-name }} в ОС SystemRescue:

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
1. {% include [rescue-chroot-to-server-fs4](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs4.md) %}
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
1. {% include [disconnect-kvm-cd](../../../_includes/baremetal/disconnect-kvm-cd.md) %}
1. {% include [rescue-chroot-to-server-fs7](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs7.md) %}

#### См. также {#see-also}

* [{#T}](./rescue-boot.md)
* [{#T}](./reset-password.md)
* [{#T}](./add-new-ssh-key.md)
* [{#T}](./switch-raid-member.md)