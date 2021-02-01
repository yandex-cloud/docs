# Изменить диск

После создания диска вы можете:
* [Изменить имя и описание диска](#change-disk-name).
* [Увеличить размер диска](#change-disk-size) (доступно только для остановленной виртуальной машины).

## Изменить имя и описание диска {#change-disk-name}

Чтобы изменить имя и описание диска:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет изменен диск.
  1. В списке сервисов выберите **{{ compute-full-name }}**.
  1. На странице **Виртуальные машины** перейдите на вкладку **Диски**.
  1. Нажмите значок ![image](../../../_assets/dots.svg) напротив нужного диска и выберите **Редактировать**.
  1. Измените имя и описание диска.
  1. Нажмите кнопку **Сохранить изменения**.

  {{ compute-short-name }} запустит операцию изменения диска.

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

     {{ compute-short-name }} запустит операцию изменения диска.

- API

  Изменить имя и описание диска можно с помощью метода API [update](../../api-ref/Disk/update.md) для ресурса [Disk](../../api-ref/Disk/).

  Список доступных дисков запрашивайте методом [list](../../api-ref/Disk/list.md) для ресурса [Disk](../../api-ref/Disk/).

{% endlist %}

## Увеличить размер диска {#change-disk-size}

Размер диска можно увеличить, только если он не подключен к запущенной ВМ. Чтобы увеличить диск у запущенной ВМ, сначала остановите ее.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится диск.
  1. В списке сервисов выберите **{{ compute-full-name }}**.
  1. На странице **Виртуальные машины** остановите виртуальную машину (см. раздел [{#T}](../vm-control/vm-stop-and-start.md#stop)).
  1. Дождитесь, когда статус машины изменится на `STOPPED`.
  1. Перейдите на вкладку **Диски**.
  1. Нажмите значок ![image](../../../_assets/dots.svg) напротив нужного диска и выберите **Редактировать**.
  1. Увеличьте размер диска.
  1. Нажмите кнопку **Сохранить изменения**.
     {{ compute-short-name }} запустит операцию изменения размера диска.
  1. Когда операция завершится, вернитесь на страницу **Виртуальные машины** и запустите остановленную ВМ.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения диска:

     ```bash
     {{ yc-compute }} disk update --help
     ```

  1. Запросите список доступных дисков:

     {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

  1. Остановите ВМ, диск которой нужно обновить. Для этого выберите `ID` нужной машины:

     ```bash
     {{ yc-compute }} instance stop --id a7lcvu28njbhnkcteb5n
     ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного диска, например `first-disk`.
  1. Укажите нужный размер (например, 32 ГБ) в команде изменения диска:

     ```bash
     {{ yc-compute }} disk update first-disk \
       --size 32
     ```

     {{ compute-short-name }} запустит операцию изменения размера диска.

  1. Запустите ВМ:

     ```bash
     {{ yc-compute }} instance start --id a7lcvu28njbhnkcteb5n
     ```

- API

  Увеличить размер диска можно с помощью метода API [update](../../api-ref/Disk/update.md) для ресурса [Disk](../../api-ref/Disk/).

  Список доступных дисков запрашивайте методом [list](../../api-ref/Disk/list.md) для ресурса [Disk](../../api-ref/Disk/).

  Чтобы остановить или запустить ВМ, воспользуйтесь методами [stop](../../api-ref/Instance/stop.md) и [start](../../api-ref/Instance/start.md) для ресурса [Instance](../../api-ref/Instance/).

{% endlist %}

## Увеличить раздел {#change-part-size}

После увеличения диска нужно также увеличить его раздел и файловую систему. У загрузочных дисков это должно происходить автоматически. 

Если раздел диска не увеличился или вы увеличиваете размер незагрузочного диска, необходимо сделать это вручную:

{% list tabs %}

- Linux

  1. Подключитесь к ВМ [по SSH](../../operations/vm-connect/ssh.md):

     ```bash
     ssh <имя пользователя>@<публичный IP-адрес ВМ>
     ```

  1. Посмотрите, какие диски подключены к ВМ:

     ```bash
     lsblk
     ```

     Результат выполнения команды:

     ```bash
     NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
     vda    252:0    0  25G  0 disk
     ├─vda1 252:1    0   1M  0 part
     └─vda2 252:2    0  25G  0 part /
     vdb    252:16   0  64G  0 disk
     └─vdb1 252:17   0  32G  0 part
     ```

     В графе `NAME` перечислены разделы диска.

  1. Выполните проверку и восстановление файловой системы:

     ```bash
     sudo e2fsck -f /dev/vdb1
     ```

     Результат выполнения команды:

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

     Результат выполнения команды:

     ```bash
     CHANGED: partition=1 start=2048 old: size=67106816 end=67108864 new: size=134215647,end=134217695
     ```

  1. Измените размер файловой системы:

     ```bash
     sudo resize2fs /dev/vdb1
     ```

     Где:
     * `dev/vdb1` — название раздела.

     Результат выполнения команды:

     ```bash
     Resizing the filesystem on /dev/vdb1 to 16776955 (4k) blocks.
     The filesystem on /dev/vdb1 is now 16776955 (4k) blocks long.
     ```

  1. Убедитесь, что раздел увеличился:

     ```bash
     lsblk
     ```

     Результат выполнения команды:

     ```bash
     NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
     vda    252:0    0  25G  0 disk
     ├─vda1 252:1    0   1M  0 part
     └─vda2 252:2    0  25G  0 part /
     vdb    252:16   0  64G  0 disk
     └─vdb1 252:17   0  64G  0 part
     ```

- Windows

  1. Подключитесь к ВМ Windows [с помощью RDP](../../quickstart/quick-create-windows.md#connect-rdp).

  1. В строке поиска по системе напишите `diskmgmt.msc` и запустите найденную оснастку.

  1. В открывшемся окне **Управление дисками** выберите нужный диск. Откройте контекстное меню и выберите пункт **Расширить том..**.

  1. Введите новый объем раздела и подтвердите действие.

  1. Убедитесь, что раздел увеличился.

{% endlist %}