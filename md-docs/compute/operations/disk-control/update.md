# Изменить диск


После создания [диска](../../concepts/disk.md) вы можете:
* [Изменить имя и описание диска](#change-disk-name).
* [Увеличить размер диска](#change-disk-size), в том числе подключенного к [запущенной](../../concepts/vm-statuses.md#list-of-statuses) [виртуальной машине](../../concepts/vm.md).

## Изменить имя и описание диска {#change-disk-name}

Чтобы изменить имя и описание диска:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет изменен диск.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/hard-drive.svg) **Диски**.
  1. Нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) напротив нужного диска и выберите **Редактировать**.
  1. Измените имя и описание диска.
  1. Нажмите **Сохранить изменения**.

  Compute Cloud запустит операцию изменения диска.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../../cli/index.md) для изменения диска:

     ```bash
     yc compute disk update --help
     ```

  1. Запросите список доступных дисков:

     ```bash
     yc compute disk list
     ```
     
     Результат:
     
     ```text
     +----------------------+--------------+-------------+-------------------+--------+----------------------+-----------------+-------------+
     |          ID          |     NAME     |    SIZE     |       ZONE        | STATUS |     INSTANCE IDS     | PLACEMENT GROUP | DESCRIPTION |
     +----------------------+--------------+-------------+-------------------+--------+----------------------+-----------------+-------------+
     | a7lqgbt0bb9s******** | first-disk   | 20401094656 |   ru-central1-a   | READY  | a7lcvu28njbh******** |                 |             |
     | a7lv5j5hm1p1******** | second-disk  | 21474836480 |   ru-central1-a   | READY  |                      |                 |             |
     +----------------------+--------------+-------------+-------------------+--------+----------------------+-----------------+-------------+
     ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного диска, например `first-disk`.
  1. Укажите нужное имя и описание в команде изменения диска:

     ```bash
     yc compute disk update first-disk \
       --new-name updated-disk \
       --description "Updated disk via CLI"
     ```

     Compute Cloud запустит операцию изменения диска.

- API {#api}

  Чтобы изменить имя и описание диска, воспользуйтесь методом REST API [update](../../api-ref/Disk/update.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызовом gRPC API [DiskService/Update](../../api-ref/grpc/Disk/update.md).

  Список доступных дисков запрашивайте методом REST API [list](../../api-ref/Disk/list.md) или вызовом gRPC API [DiskService/List](../../api-ref/grpc/Disk/list.md).

{% endlist %}

## Увеличить размер диска {#change-disk-size}

{% note info %}

Изменить размер диска можно только в сторону увеличения, уменьшить размер диска нельзя.

{% endnote %}

Вы можете увеличить размер диска даже на [запущенной](../../concepts/vm-statuses.md#list-of-statuses) ВМ.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится диск.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/hard-drive.svg) **Диски**.
  1. Нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) напротив нужного диска и выберите **Редактировать**.
  1. Увеличьте размер диска.
  1. Нажмите **Сохранить изменения**.

     Compute Cloud запустит операцию изменения размера диска.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения диска:

     ```bash
     yc compute disk update --help
     ```

  1. Запросите список доступных дисков:

     ```bash
     yc compute disk list
     ```
     
     Результат:
     
     ```text
     +----------------------+--------------+-------------+-------------------+--------+----------------------+-----------------+-------------+
     |          ID          |     NAME     |    SIZE     |       ZONE        | STATUS |     INSTANCE IDS     | PLACEMENT GROUP | DESCRIPTION |
     +----------------------+--------------+-------------+-------------------+--------+----------------------+-----------------+-------------+
     | a7lqgbt0bb9s******** | first-disk   | 20401094656 |   ru-central1-a   | READY  | a7lcvu28njbh******** |                 |             |
     | a7lv5j5hm1p1******** | second-disk  | 21474836480 |   ru-central1-a   | READY  |                      |                 |             |
     +----------------------+--------------+-------------+-------------------+--------+----------------------+-----------------+-------------+
     ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного диска, например `first-disk`.
  1. Укажите нужный размер (например, 32 ГБ) в команде изменения диска:

     ```bash
     yc compute disk update first-disk \
       --size 32
     ```

     Compute Cloud запустит операцию изменения размера диска.

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  {% note warning %}

  Вы можете увеличить размер диска с помощью Terraform без пересоздания ВМ, если диск задан в манифесте как отдельный ресурс `yandex_compute_disk`.

  Если диск задан в блоке `initialize_params` ресурса `yandex_compute_instance`, то при увеличении размера диска с помощью Terraform ВМ будет пересоздана. Чтобы увеличить размер такого диска без пересоздания ВМ, воспользуйтесь [консолью управления](../../../console/index.md), CLI или API.

  {% endnote %}

  1. Опишите в конфигурационном файле Terraform параметры ресурсов, которые вы хотите создать:

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
         user-data = "#cloud-config\nusers:\n  - name: <имя_пользователя>\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=        (ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - <содержимое_SSH-ключа>"
       }
     }
     ```

  1. Создайте ресурсы:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

  1. Чтобы увеличить размер диска, внесите изменение в конфигурационный файл:

     ```hcl
     resource "yandex_compute_disk" "first-disk" {
       ...
       size = "<новый_размер_диска>"
     }
     ```

     Где `size` — новый размер диска.
  1. Примените изменения:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     После этого размер диска будет увеличен. Проверить размер диска и его настройки можно в [консоли управления](https://console.yandex.cloud) или с помощью команды CLI:

     ```bash
     yc compute disk get <имя_диска>
     ```

- API {#api}

  Увеличить размер диска можно с помощью метода REST API [update](../../api-ref/Disk/update.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызова gRPC API [DiskService/Update](../../api-ref/grpc/Disk/update.md).

  Список доступных дисков запрашивайте методом REST API [list](../../api-ref/Disk/list.md) или вызовом gRPC API [DiskService/List](../../api-ref/grpc/Disk/list.md).

{% endlist %}

Чтобы изменился размер загрузочного диска, [перезапустите](../vm-control/vm-stop-and-start.md#restart) ВМ.

## Увеличить раздел диска Linux {#change-part-size-linux}

После увеличения диска нужно также увеличить размер его разделов и файловые системы. У загрузочных дисков это происходит автоматически после перезагрузки ВМ. 

Вы также можете увеличить размер любого диска ВМ без перезагрузки. Порядок действий зависит от файловой системы нужного раздела диска:

{% list tabs %}

- ext4

  1. [Подключитесь](../vm-connect/ssh.md) к ВМ по [SSH](../../../glossary/ssh-keygen.md):

     ```bash
     ssh <имя_пользователя>@<публичный_IP-адрес_ВМ>
     ```

  1. Убедитесь, что установлен пакет `growpart`:

     ```bash
     # Debian/Ubuntu
     sudo apt-get install -y cloud-utils

     # RHEL/CentOS/AlmaLinux
     sudo yum install -y cloud-utils-growpart
     ```

  1. Посмотрите, какие диски подключены к ВМ:

     ```bash
     lsblk
     ```

     Результат:

     ```text
     NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
     vda    252:0    0  25G  0 disk
     ├─vda1 252:1    0   1M  0 part
     └─vda2 252:2    0  25G  0 part /
     vdb    252:16   0  64G  0 disk
     └─vdb1 252:17   0  32G  0 part /data
     ```

     В графе `NAME` перечислены разделы диска. Если в графе `MOUNTPOINTS` нужного раздела есть значение, значит ваш раздел смонтирован.

  1. (Опционально) Выполните проверку и восстановление файловой системы.

     {% note info %}

     Пропустите этот шаг, если вы хотите увеличить корневой раздел. Корневой раздел (`/`) нельзя размонтировать на работающей ВМ, поэтому `e2fsck` для него недоступен. Используйте `growpart` и `resize2fs` напрямую без предварительной проверки.

     {% endnote %}

     1. Отмонтируйте диск:

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

  1. Если вы выполняли проверку файловой системы и отмонтировали раздел, то вновь смонтируйте его:

     ```bash
     sudo mount /dev/vdb1 /data
     ```

  1. Убедитесь, что раздел увеличился:

     ```bash
     lsblk
     ```

     Результат:

     ```text
     NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
     vda    252:0    0  25G  0 disk
     ├─vda1 252:1    0   1M  0 part
     └─vda2 252:2    0  25G  0 part /
     vdb    252:16   0  64G  0 disk
     └─vdb1 252:17   0  64G  0 part /data
     ```

- xfs

  1. [Подключитесь](../vm-connect/ssh.md) к ВМ по [SSH](../../../glossary/ssh-keygen.md):

     ```bash
     ssh <имя_пользователя>@<публичный_IP-адрес_ВМ>
     ```

  1. Убедитесь, что установлен пакет `growpart`:

     ```bash
     # Debian/Ubuntu
     sudo apt-get install -y cloud-utils

     # RHEL/CentOS/AlmaLinux
     sudo yum install -y cloud-utils-growpart
     ```

  1. Посмотрите, какие диски подключены к ВМ:

     ```bash
     lsblk
     ```

     Результат:

     ```text
     NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
     vda    252:0    0  25G  0 disk
     ├─vda1 252:1    0   1M  0 part
     └─vda2 252:2    0  25G  0 part /
     vdb    252:16   0  64G  0 disk
     └─vdb1 252:17   0  32G  0 part /data
     ```

     В графе `NAME` перечислены разделы диска. В графе `MOUNTPOINTS` — точки монтирования разделов.

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
     NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
     vdb    252:16   0  64G  0 disk
     └─vdb1 252:17   0  64G  0 part /data
     ```

- LVM

  Если диск использует LVM, расширьте физический том, логический том и файловую систему.

  1. [Подключитесь](../vm-connect/ssh.md) к ВМ по [SSH](../../../glossary/ssh-keygen.md):

     ```bash
     ssh <имя_пользователя>@<публичный_IP-адрес_ВМ>
     ```

  1. Посмотрите текущую конфигурацию LVM:

     ```bash
     sudo pvs && sudo vgs && sudo lvs
     ```

  1. Расширьте физический том до нового размера диска:

     ```bash
     sudo pvresize /dev/vdb
     ```

  1. Расширьте логический том на все доступное пространство:

     ```bash
     sudo lvextend -l +100%FREE /dev/<имя_группы>/<имя_тома>
     ```

  1. Расширьте файловую систему на логическом томе. Команда зависит от типа файловой системы:

     * Для ext4:

       ```bash
       sudo resize2fs /dev/<имя_группы>/<имя_тома>
       ```

     * Для xfs:

       ```bash
       sudo xfs_growfs /dev/<имя_группы>/<имя_тома>
       ```

  1. Убедитесь, что логический том и файловая система увеличились:

     ```bash
     sudo lvs
     df -h
     ```

{% endlist %}