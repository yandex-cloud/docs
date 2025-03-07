---
title: Как заменить неисправный диск в RAID-массиве на сервере {{ baremetal-full-name }}
description: Следуя данной инструкции, вы сможете заменить неисправный диск в RAID-массиве на сервере {{ baremetal-name }}.
---

# Заменить диск в RAID-массиве

При выходе из строя диска, входящего в RAID-массив на сервере {{ baremetal-name }}, необходимо остановить использование диска, [удалить](#remove-from-raid) неисправный диск из массива, [запросить](#request-swap) в технической поддержке замену физического накопителя на сервере, после чего [добавить](#add-to-raid) новый диск в RAID-массив.

{% note info %}

Данная инструкция неприменима к случаям выхода из строя дисков в массивах уровня `RAID 0`. Такие массивы не обладают отказоустойчивостью, поэтому при отказе одного из дисков все хранящиеся в таком массиве данные будут утеряны, а массив придется полностью пересоздавать.

Инструкция сделана на примере стандартной разметки RAID10 на 4xHDD для Ubuntu 24.04. Если ваша конфигурация отличается или в разметку внесены изменения — вносите изменения в шаги в соответствии с вашей конфигурацией.

{% endnote %}

## Удалите из RAID-массива неисправный диск {#remove-from-raid}

1. Подключитесь к серверу по SSH:

    ```bash
    ssh root@<публичный_IP-адрес_сервера>
    ```

    Вы также можете подключиться к серверу через [KVM-консоль](./server-kvm.md) с помощью логина и пароля.
1. Получите информацию о текущей разметке дисков и разделов в RAID-массиве:

    ```bash
    cat /proc/mdstat
    ```

    Результат:

    ```text
    Personalities : [raid10] [raid0] [raid1] [raid6] [raid5] [raid4]
    md3 : active raid10 sdb4[1] sdc4[2] sdd4[3] sda4[0]
          3893569536 blocks super 1.2 256K chunks 2 near-copies [4/4] [UUUU]
          bitmap: 0/30 pages [0KB], 65536KB chunk

    md2 : active raid10 sdc3[2] sdb3[1] sdd3[3] sda3[0]
          2095104 blocks super 1.2 256K chunks 2 near-copies [4/4] [UUUU]

    md1 : active raid10 sdc2[2] sdb2[1](F) sda2[0] sdd2[3]
          8380416 blocks super 1.2 256K chunks 2 near-copies [4/3] [U_UU]
    ```

    В приведенном примере RAID-массив состоит из трех разделов: `md1` (разделы дисков `sdb2` и `sda2`), `md2` (разделы дисков `sdb3` и `sda3`) и `md3` (разделы дисков `sdb4` и `sda4`). В выводе команды есть диск `sdb`, который отмечен как сбойный — рядом с его именем указано `(F)`.

    Дополнительно вы можете получить информацию о ролях разделов RAID-массива:

    ```bash
    lsblk
    ```

    Результат:

    ```text
    NAME    MAJ:MIN RM  SIZE RO TYPE   MOUNTPOINTS
    sda       8:0    0  1.8T  0 disk
    ├─sda1    8:1    0  299M  0 part
    ├─sda2    8:2    0    4G  0 part
    │ └─md1   9:1    0    8G  0 raid10 /boot
    ├─sda3    8:3    0    1G  0 part
    │ └─md2   9:2    0    2G  0 raid10 [SWAP]
    └─sda4    8:4    0  1.8T  0 part
      └─md3   9:3    0  3.6T  0 raid10 /
    sdb       8:16   0  1.8T  0 disk
    ├─sdb1    8:17   0  299M  0 part
    ├─sdb2    8:18   0    4G  0 part
    │ └─md1   9:1    0    8G  0 raid10 /boot
    ├─sdb3    8:19   0    1G  0 part
    │ └─md2   9:2    0    2G  0 raid10 [SWAP]`
    └─sdb4    8:20   0  1.8T  0 part
      └─md3   9:3    0  3.6T  0 raid10 /
    sdc       8:32   0  1.8T  0 disk
    ├─sdc1    8:33   0  299M  0 part
    ├─sdc2    8:34   0    4G  0 part
    │ └─md1   9:1    0    8G  0 raid10 /boot
    ├─sdc3    8:35   0    1G  0 part
    │ └─md2   9:2    0    2G  0 raid10 [SWAP]
    └─sdc4    8:36   0  1.8T  0 part
      └─md3   9:3    0  3.6T  0 raid10 /
    sdd       8:48   0  1.8T  0 disk
    ├─sdd1    8:49   0  299M  0 part
    ├─sdd2    8:50   0    4G  0 part
    │ └─md1   9:1    0    8G  0 raid10 /boot
    ├─sdd3    8:51   0    1G  0 part
    │ └─md2   9:2    0    2G  0 raid10 [SWAP]
    └─sdd4    8:52   0  1.8T  0 part
      └─md3   9:3    0  3.6T  0 raid10 /
    ```

    В приведенном примере:
    * `md1` — раздел `/boot`;
    * `md2` — раздел `SWAP`;
    * `md3` — раздел `/` с корневой файловой системой.
    
1. Предположим, что из строя вышел диск `/dev/sdb`. Удалите разделы диска `/dev/sdb` из разделов RAID-массива:

    ```bash
    mdadm /dev/md1 --remove /dev/sdb2
    mdadm /dev/md2 --remove /dev/sdb3
    mdadm /dev/md3 --remove /dev/sdb4
    ```

    Утилита `mdadm` не позволит удалить диск из RAID-массива, если считает диск исправным или если это действие приведет к отказу массива. В этом случае вы получите сообщение о том, что устройство используется:

    ```text
    mdadm: hot remove failed for /dev/sdb2: Device or resource busy
    ```

    В этом случае предварительно пометьте диск как неисправный и повторите попытку удаления:

    ```bash
    mdadm /dev/md1 --fail /dev/sdb2
    mdadm /dev/md1 --remove /dev/sdb2
    mdadm /dev/md2 --fail /dev/sdb3
    mdadm /dev/md2 --remove /dev/sdb3
    mdadm /dev/md3 --fail /dev/sdb4
    mdadm /dev/md3 --remove /dev/sdb4
    ```

1. Получите идентификатор неисправного диска:

    ```bash
    fdisk -l
    ```

    Результат:

    ```text
    ...
    Disk /dev/sdb: 838.36 GiB, 900185481216 bytes, 1758174768 sectors
    Disk model: SAMSUNG MZ7GE900
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: gpt
    Disk identifier: CD2ACB4C-1618-4BAF-A6BB-D2B9********
    ...
    ```

    Сохраните идентификатор (`Disk identifier`) неисправного диска — он потребуется при обращении в службу технической поддержки.

## Запросите физическую замену диска {#request-swap}

[Создайте](../../../support/overview.md#response-time) запрос на замену носителя в службу технической поддержки, указав идентификаторы сервера {{ baremetal-name }} и неисправного диска.

Дождитесь, когда инженеры дата-центра заменят неисправный диск.

## Добавьте новый диск в RAID-массив {#add-to-raid}

После того как на сервере будет заменен физический накопитель, необходимо разметить его и добавить в существующий RAID-массив.

1. Воспользуйтесь утилитой `gdisk`, чтобы определить используемый тип таблицы разделов: `GPT` или `MBR`. При необходимости установите `gdisk` для операционной системы вашего сервера.

    Выполните команду, указав идентификатор исправного диска, оставшегося в RAID-массиве:

    ```bash
    gdisk -l /dev/sda
    ```

    Результат, в зависимости от используемого типа таблицы разделов:

    {% list tabs group=partition_table_type %}

    - GPT {#gpt}

      ```text
      Partition table scan:
        MBR: protective
        BSD: not present
        APM: not present
        GPT: present
      ...
      ```

    - MBR {#mbr}

      ```text
      Partition table scan:
        MBR: MBR only
        BSD: not present
        APM: not present
        GPT: not present
      ...
      ```

    {% endlist %}

1. Скопируйте на новый диск разметку таблицы разделов с исправного диска, оставшегося в RAID-массиве:

    {% list tabs group=partition_table_type %}

    - GPT {#gpt}

      Если на исходном диске используется таблица разделов GPT:

      1. Создайте копию таблицы разделов исходного диска:

          ```bash
          sgdisk --backup=table /dev/sda
          ```

          Результат:

          ```text
          The operation has completed successfully.
          ```
      1. Восстановите таблицу разделов из созданной копии на новый диск:

          ```bash
          sgdisk --load-backup=table /dev/sdb
          ```

          Результат:

          ```text
          The operation has completed successfully.
          ```
      1. Присвойте новому диску новый случайный UUID:

          ```bash
          sgdisk -G /dev/sdb
          ```

          Результат:

          ```text
          The operation has completed successfully.
          ```          

    - MBR {#mbr}

      Если на исходном диске используется таблица разделов MBR:

      1. Скопируйте таблицу разделов:

          ```bash
          sfdisk -d /dev/sda | sfdisk /dev/sdb
          ```

          Где:
          * `/dev/sda` — исходный диск, оставшийся в RAID-массиве, с которого копируется таблица разделов.
          * `/dev/sdb` — целевой (новый) диск, на который копируется таблица разделов с исходного диска.
      1. Если после копирования разделы не отображаются, повторно прочитайте таблицу разделов:

          ```bash
          sfdisk -R /dev/sdb
          ```

    {% endlist %}

1. Добавьте диск в RAID-массив, по очереди добавив в разделы RAID-массива соответствующие разделы диска. Соответствие этих разделов было определено ранее в секции [{#T}](#remove-from-raid).

    Выполните команды:

    ```bash
    mdadm /dev/md1 --add /dev/sdb2
    mdadm /dev/md2 --add /dev/sdb3
    mdadm /dev/md3 --add /dev/sdb4
    ```

    После добавления диска в массив начинается синхронизация, скорость которой зависит от размера и типа дисков (`ssd`/`hdd`).

    Результат:

    ```text
    mdadm: added /dev/sdb2
    mdadm: added /dev/sdb3
    mdadm: added /dev/sdb4
    ```

1. Убедитесь, что новый диск добавлен в RAID-массив:

    ```bash
    cat /proc/mdstat
    ```

    Результат:

    ```text
    Personalities : [raid1] [linear] [multipath] [raid0] [raid6] [raid5] [raid4] [raid10]
    md2 : active raid1 sdb3[2] sda3[0]
          6287360 blocks super 1.2 [2/2] [UU]

    md3 : active raid1 sdb4[2] sda4[0]
          849215488 blocks super 1.2 [2/2] [UU]
          bitmap: 4/7 pages [16KB], 65536KB chunk

    md1 : active raid1 sdb2[2] sda2[0]
          10477568 blocks super 1.2 [2/2] [UU]

    unused devices: <none>
    ```
1. Установите на новый диск загрузчик операционной системы Linux:

    ```bash
    grub-install /dev/sdb
    ```

    Результат:

    ```text
    Installing for i386-pc platform.
    Installation finished. No error reported.
    ```

#### См. также {#see-also}

* [{#T}](./rescue-boot.md)
* [{#T}](./reset-password.md)
* [{#T}](./restore-grub.md)