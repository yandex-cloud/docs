---
title: "Как изменить диск в {{ compute-full-name }}"
description: "Следуя данной инструкции, вы сможете изменить диск."
---

# Изменить диск


После создания [диска](../../concepts/disk.md) вы можете:
* [Изменить имя и описание диска](#change-disk-name).
* [Увеличить размер диска](#change-disk-size), в том числе подключенного к [запущенной](../../concepts/vm-statuses.md#list-of-statuses) [виртуальной машине](../../concepts/vm.md).

## Изменить имя и описание диска {#change-disk-name}

Чтобы изменить имя и описание диска:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет изменен диск.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
  1. Нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) напротив нужного диска и выберите **{{ ui-key.yacloud.compute.disks.button_action-edit }}**.
  1. Измените имя и описание диска.
  1. Нажмите **{{ ui-key.yacloud.compute.disks.edit.button_update }}**.

  {{ compute-name }} запустит операцию изменения диска.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../../cli/) для изменения диска:

     ```bash
     {{ yc-compute }} disk update --help
     ```

  1. Запросите список доступных дисков:

     {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного диска, например `first-disk`.
  1. Укажите нужное имя и описание в команде изменения диска:

     ```bash
     {{ yc-compute }} disk update first-disk \
       --new-name updated-disk \
       --description "Updated disk via CLI"
     ```

     {{ compute-name }} запустит операцию изменения диска.

- API {#api}

  Чтобы изменить имя и описание диска, воспользуйтесь методом REST API [update](../../api-ref/Disk/update.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызовом gRPC API [DiskService/Update](../../api-ref/grpc/disk_service.md#Update).

  Список доступных дисков запрашивайте методом REST API [list](../../api-ref/Disk/list.md) или вызовом gRPC API [DiskService/List](../../api-ref/grpc/disk_service.md#List).

{% endlist %}

## Увеличить размер диска {#change-disk-size}

{% note info %}

Изменить размер диска можно только в сторону увеличения, уменьшить размер диска нельзя.

{% endnote %}

Вы можете увеличить размер диска даже на [запущенной](../../concepts/vm-statuses.md#list-of-statuses) ВМ.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится диск.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
  1. Нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) напротив нужного диска и выберите **{{ ui-key.yacloud.compute.disks.button_action-edit }}**.
  1. Увеличьте размер диска.
  1. Нажмите **{{ ui-key.yacloud.compute.disks.edit.button_update }}**.

     {{ compute-name }} запустит операцию изменения размера диска.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения диска:

     ```bash
     {{ yc-compute }} disk update --help
     ```

  1. Запросите список доступных дисков:

     {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного диска, например `first-disk`.
  1. Укажите нужный размер (например, 32 ГБ) в команде изменения диска:

     ```bash
     {{ yc-compute }} disk update first-disk \
       --size 32
     ```

     {{ compute-name }} запустит операцию изменения размера диска.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  {% note warning %}

  Вы можете увеличить размер диска с помощью {{ TF }} без пересоздания ВМ, если диск задан в манифесте как отдельный ресурс `yandex_compute_disk`.

  Если диск задан в блоке `initialize_params` ресурса `yandex_compute_instance`, то при увеличении размера диска с помощью {{ TF }} ВМ будет пересоздана. Чтобы увеличить размер такого диска без пересоздания ВМ, воспользуйтесь [консолью управления](../../../console/), CLI или API.

  {% endnote %}

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые вы хотите создать:

     ```hcl
     # Создание диска.

     resource "yandex_compute_disk" "first-disk" {
       name     = "<имя_диска>"
       type     = "<тип_диска>"
       zone     = "<зона_доступности>"
       size     = "<размер_диска>"
       image_id = "<идентификатор_образа>"
     }

     # Создание ВМ.

     resource "yandex_compute_instance" "vm-lamp" {
       name        = "<имя_ВМ>"
       platform_id = "standard-v3"
       zone        = "<зона_доступности>"

       resources {
         core_fraction = <уровень_производительности_vCPU>
         cores         = <количество_ядер_vCPU>
         memory        = <объем_RAM_ГБ>
       }

       boot_disk {
         disk_id = yandex_compute_disk.first-disk.id
       }

       network_interface {
         subnet_id          = "<идентификатор_подсети>"
         nat                = true
         security_group_ids = [<идентификатор_группы_безопасности>]
       }

       metadata = {
         user-data = "#cloud-config\nusers:\n  - name: <имя_пользователя>\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=        (ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - <содержимое_SSH-ключа>"
       }
     }
     ```

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  1. Чтобы увеличить размер диска, внесите изменение в конфигурационный файл:

     ```hcl
     resource "yandex_compute_disk" "first-disk" {
       ...
       size = "<новый_размер_диска>"
     }
     ```

     Где `size` — новый размер диска.
  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     После этого размер диска будет увеличен. Проверить размер диска и его настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI:

     ```bash
     yc compute disk get <имя_диска>
     ```

- API {#api}

  Увеличить размер диска можно с помощью метода REST API [update](../../api-ref/Disk/update.md) для ресурса [Disk](../../api-ref/Disk/) или вызова gRPC API [DiskService/Update](../../api-ref/grpc/disk_service.md#Update).

  Список доступных дисков запрашивайте методом REST API [list](../../api-ref/Disk/list.md) или вызовом gRPC API [DiskService/List](../../api-ref/grpc/disk_service.md#List).

{% endlist %}

## Увеличить раздел диска Linux {#change-part-size-linux}

После увеличения диска нужно также увеличить его раздел и файловую систему. У загрузочных дисков это происходит автоматически после перезагрузки ВМ.

Если раздел диска не увеличился или вы увеличиваете размер незагрузочного диска, необходимо сделать это вручную. Порядок действий зависит от файловой системы:

{% list tabs %}

- ext4

  1. [Подключитесь](../../operations/vm-connect/ssh.md) к ВМ по [SSH](../../../glossary/ssh-keygen.md):

     ```bash
     ssh <имя_пользователя>@<публичный_IP-адрес_ВМ>
     ```

  1. Посмотрите, какие диски подключены к ВМ:

     ```bash
     lsblk
     ```

     Результат:

     ```text
     NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
     vda    252:0    0  25G  0 disk
     ├─vda1 252:1    0   1M  0 part
     └─vda2 252:2    0  25G  0 part /
     vdb    252:16   0  64G  0 disk
     └─vdb1 252:17   0  32G  0 part /data
     ```

     В графе `NAME` перечислены разделы диска. В графе `MOUNTPOINT` — точки монтирования разделов.
  1. Если в графе `MOUNTPOINT` напротив вашего раздела есть значение, ваш раздел смонтирован. Отмонтируйте его:

     ```bash
     sudo umount /data
     ```

     Где `/data` — точка монтирования раздела.
  1. Выполните проверку и восстановление файловой системы:

     ```bash
     sudo e2fsck -f /dev/vdb1
     ```

     Результат:

     ```text
     e2fsck 1.44.1 (24-Mar-2018)
     Pass 1: Checking inodes, blocks, and sizes
     Pass 2: Checking directory structure
     Pass 3: Checking directory connectivity
     Pass 4: Checking reference counts
     Pass 5: Checking group summary information
     /dev/vdb1: 11/2097152 files (0.0% non-contiguous), 143890/8388352 blocks
     ```

  1. Измените размер раздела:

     ```bash
     sudo growpart /dev/vdb 1
     ```

     Где:
     * `/dev/vdb` — название устройства.
     * `1` — номер раздела, поэтому он указывается через пробел.

     Результат:

     ```text
     CHANGED: partition=1 start=2048 old: size=67106816 end=67108864 new: size=134215647,end=134217695
     ```

  1. Измените размер файловой системы:

     ```bash
     sudo resize2fs /dev/vdb1
     ```

     Где `dev/vdb1` — название раздела.

     Результат:

     ```text
     Resizing the filesystem on /dev/vdb1 to 16776955 (4k) blocks.
     The filesystem on /dev/vdb1 is now 16776955 (4k) blocks long.
     ```

  1. Если перед проверкой вы отмонтировали раздел, то смонтируйте его обратно:

     ```bash
     sudo mount /data
     ```

  1. Убедитесь, что раздел увеличился:

     ```bash
     lsblk
     ```

     Результат:

     ```text
     NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
     vda    252:0    0  25G  0 disk
     ├─vda1 252:1    0   1M  0 part
     └─vda2 252:2    0  25G  0 part /
     vdb    252:16   0  64G  0 disk
     └─vdb1 252:17   0  64G  0 part /data
     ```

- xfs

  1. [Подключитесь](../../operations/vm-connect/ssh.md) к ВМ по [SSH](../../../glossary/ssh-keygen.md):

     ```bash
     ssh <имя_пользователя>@<публичный_IP-адрес_ВМ>
     ```

  1. Посмотрите, какие диски подключены к ВМ:

     ```bash
     lsblk
     ```

     Результат:

     ```text
     NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
     vda    252:0    0  25G  0 disk
     ├─vda1 252:1    0   1M  0 part
     └─vda2 252:2    0  25G  0 part /
     vdb    252:16   0  64G  0 disk
     └─vdb1 252:17   0  32G  0 part /data
     ```

     В графе `NAME` перечислены разделы диска. В графе `MOUNTPOINT` — точки монтирования разделов.
  1. Выполните команду:

     ```bash
     sudo growpart /dev/vdb 1
     ```

     Где:
     * `/dev/vdb` — название устройства.
     * `1` — номер раздела, поэтому он указывается через пробел.

     Результат:

     ```text
     CHANGED: partition=1 start=2048 old: size=67106816 end=67108864 new: size=134215647,end=134217695
     ```

  1. Измените размер файловой системы:

     ```bash
     sudo xfs_growfs /data -d
     ```

     Где:
     * `/data` — точка монтирования раздела, который необходимо расширить.
     * `-d` — параметр для расширения раздела.

     Результат:

     ```text
     meta-data=/dev/vdb1              isize=512    agcount=4, agsize=655360 blks
              =                       sectsz=4096  attr=2, projid32bit=1
              =                       crc=1        finobt=1, sparse=1, rmapbt=0
              =                       reflink=1    bigtime=0 inobtcount=0
     data     =                       bsize=4096   blocks=2621440, imaxpct=25
              =                       sunit=0      swidth=0 blks
     naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
     log      =internal log           bsize=4096   blocks=2560, version=2
              =                       sectsz=4096  sunit=1 blks, lazy-count=1
     realtime =none                   extsz=4096   blocks=0, rtextents=0
     data blocks changed from 2621440 to 11796219
     ```

  1. Убедитесь, что раздел увеличился:

     ```bash
     lsblk /dev/vdb
     ```

     Результат:

     ```text
     NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
     vdb    252:16   0  64G  0 disk
     └─vdb1 252:17   0  64G  0 part /data
     ```

{% endlist %}

