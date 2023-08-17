# Изменить диск

После создания [диска](../../concepts/disk.md) вы можете:
* [Изменить имя и описание диска](#change-disk-name).
* [Увеличить размер диска](#change-disk-size) (доступно только для [остановленной](../../concepts/vm-statuses.md#list-of-statuses) [виртуальной машины](../../concepts/vm.md)).

## Изменить имя и описание диска {#change-disk-name}

Чтобы изменить имя и описание диска:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет изменен диск.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/disks-pic.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
  1. Нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) напротив нужного диска и выберите **{{ ui-key.yacloud.compute.disks.button_action-edit }}**.
  1. Измените имя и описание диска.
  1. Нажмите **{{ ui-key.yacloud.compute.disks.edit.button_update }}**.

  {{ compute-name }} запустит операцию изменения диска.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения диска:

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

- API

  Чтобы изменить имя и описание диска, воспользуйтесь методом REST API [update](../../api-ref/Disk/update.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызовом gRPC API [DiskService/Update](../../api-ref/grpc/disk_service.md#Update).

  Список доступных дисков запрашивайте методом REST API [list](../../api-ref/Disk/list.md) или вызовом gRPC API [DiskService/List](../../api-ref/grpc/disk_service.md#List).

{% endlist %}

## Увеличить размер диска {#change-disk-size}

{% note info %}

Изменить размер диска можно только в сторону увеличения, уменьшить размер диска нельзя.

{% endnote %}

Размер диска можно увеличить, только если он не подключен к запущенной ВМ. Чтобы увеличить диск у запущенной ВМ, сначала остановите ее.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится диск.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На странице **{{ ui-key.yacloud.compute.switch_instances }}** остановите ВМ (см. раздел [{#T}](../vm-control/vm-stop-and-start.md#stop)).
  1. Дождитесь, когда статус ВМ изменится на `STOPPED`.
  1. На панели слева выберите ![image](../../../_assets/compute/disks-pic.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
  1. Нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) напротив нужного диска и выберите **{{ ui-key.yacloud.compute.disks.button_action-edit }}**.
  1. Увеличьте размер диска.
  1. Нажмите **{{ ui-key.yacloud.compute.disks.edit.button_update }}**.

     {{ compute-name }} запустит операцию изменения размера диска.
  1. Когда операция завершится, вернитесь на страницу **{{ ui-key.yacloud.compute.switch_instances }}** и запустите остановленную ВМ.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения диска:

     ```bash
     {{ yc-compute }} disk update --help
     ```

  1. Запросите список доступных дисков:

     {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

  1. Остановите ВМ, диск которой нужно обновить. Для этого выберите `ID` нужной ВМ:

     ```bash
     {{ yc-compute }} instance stop --id a7lcvu28njbhnkcteb5n
     ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного диска, например `first-disk`.
  1. Укажите нужный размер (например, 32 ГБ) в команде изменения диска:

     ```bash
     {{ yc-compute }} disk update first-disk \
       --size 32
     ```

     {{ compute-name }} запустит операцию изменения размера диска.
  1. Запустите ВМ:

     ```bash
     {{ yc-compute }} instance start --id a7lcvu28njbhnkcteb5n
     ```

- API

  Увеличить размер диска можно с помощью метода REST API [update](../../api-ref/Disk/update.md) для ресурса [Disk](../../api-ref/Disk/) или вызова gRPC API [DiskService/Update](../../api-ref/grpc/disk_service.md#Update).

  Список доступных дисков запрашивайте методом REST API [list](../../api-ref/Disk/list.md) или вызовом gRPC API [DiskService/List](../../api-ref/grpc/disk_service.md#List).

  Чтобы остановить или запустить ВМ, воспользуйтесь методами REST API [stop](../../api-ref/Instance/stop.md) и [start](../../api-ref/Instance/start.md) для ресурса [Instance](../../api-ref/Instance/) или вызовами gRPC API [InstanceService/Stop](../../api-ref/grpc/instance_service.md#Stop) и [InstanceService/Start](../../api-ref/grpc/instance_service.md#Start).

{% endlist %}

## Увеличить раздел {#change-part-size}

После увеличения диска нужно также увеличить его раздел и файловую систему. У загрузочных дисков это должно происходить автоматически.

Если раздел диска не увеличился или вы увеличиваете размер незагрузочного диска, необходимо сделать это вручную:

{% list tabs %}

- Linux

  1. [Подключитесь](../../operations/vm-connect/ssh.md) к ВМ по [SSH](../../../glossary/ssh-keygen.md):

     ```bash
     ssh <имя пользователя>@<публичный IP-адрес ВМ>
     ```

  1. Посмотрите, какие диски подключены к ВМ:

     ```bash
     lsblk
     ```

     Результат:

     ```bash
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

     ```bash
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

     ```bash
     CHANGED: partition=1 start=2048 old: size=67106816 end=67108864 new: size=134215647,end=134217695
     ```

  1. Измените размер файловой системы:

     ```bash
     sudo resize2fs /dev/vdb1
     ```

     Где `dev/vdb1` — название раздела.

     Результат:

     ```bash
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

     ```bash
     NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
     vda    252:0    0  25G  0 disk
     ├─vda1 252:1    0   1M  0 part
     └─vda2 252:2    0  25G  0 part /
     vdb    252:16   0  64G  0 disk
     └─vdb1 252:17   0  64G  0 part /data
     ```


{% endlist %}