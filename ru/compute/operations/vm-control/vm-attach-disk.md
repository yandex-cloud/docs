# Подключить диск к виртуальной машине

Подключить диск можно как к работающей, так и к остановленной ВМ.

Чтобы диск был успешно подключен к работающей ВМ, операционная система ВМ должна быть готова принимать команды на подключение диска. Перед подключением диска убедитесь, что ОС загружена, или остановите ВМ — иначе операция подключения диска завершится с ошибкой. При возникновении ошибки остановите ВМ и повторите операцию.

{% include [disk-auto-delete](../../_includes_service/disk-auto-delete.md) %}

## Подключить диск {#attach}

Чтобы подключить диск к ВМ:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. Выберите сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/disks-pic.svg) **Диски**.
  1. Выберите неподключенный диск или [создайте](../disk-create/empty.md) новый.
  1. Напротив нужного диска нажмите ![image](../../../_assets/horizontal-ellipsis.svg) и выберите **Присоединить**.
  1. В открывшемся окне:
     * В поле **ВМ** выберите ВМ, к которой нужно подключить диск.
     * Введите **Название устройства**.
     * Выберите значение параметра **Автоматическое удаление**.
  1. Нажмите кнопку **Подключить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для подключения дисков:

     ```bash
     yc compute instance attach-disk --help
     ```

  1. Получите список ВМ в каталоге по умолчанию:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной ВМ, например `first-instance`.

  1. Получите список дисков в каталоге по умолчанию:

     {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного диска, например `first-disk`. Посмотреть список подключенных к ВМ дисков можно с помощью команды:

     ```bash
     yc compute instance get --full first-instance
     ```

  1. Подключите диск к ВМ:

     ```bash
     yc compute instance attach-disk first-instance \
       --disk-name first-disk \
       --mode rw
     ```

     Чтобы диск был автоматически удален при удалении ВМ, укажите флаг `--auto-delete`.

     {% include [attach_empty_disk](../../_includes_service/attach-empty-disk.md) %}

     Если возникла ошибка, остановите ВМ:

     ```bash
     yc compute instance stop first-instance
     ```

     Затем подключите диск повторно.

  1. Если ВМ была остановлена, запустите ее заново:

     ```bash
     yc compute instance start first-instance
     ```

- API

  Воспользуйтесь методом [attachDisk](../../api-ref/Instance/attachDisk.md) для ресурса [Instance](../../api-ref/Instance/).

{% endlist %}

## Смонтировать диск, созданный из снимка или образа {#mount-disk-and-fix-uuid}

Для использования подключенного диска:

{% list tabs %}

- Linux

  Смонтируйте диск:

  1. Подключитесь к ВМ [по SSH](../vm-connect/ssh.md).
  1. Выполните команду `blkid` и проверьте, что нет разделов с одинаковыми UUID:

     ```bash
     sudo blkid
     /dev/vda2: UUID="0d6dfef0-542d-47ba-b55b-18ab5f5f9210" TYPE="ext4" PARTUUID="752aa845-94ee-4850-9188-71c2f919ee7b"
     /dev/vdb2: UUID="0d6dfef0-542d-47ba-b55b-18ab5f5f9210" TYPE="ext4" PARTUUID="752aa845-94ee-4850-9188-71c2f919ee7b"
     ...
     ```

  1. Если вы обнаружили, что какие-то UUID дублируются, сгенерируйте новый UUID для тех дубликатов, которые идут последними в выводе команды `blkid`. Для примера из предыдущего шага надо сгенерировать UUID для раздела `/dev/vdb2`:

     ```bash
     sudo e2fsck -f /dev/vdb2
     sudo tune2fs -U $(uuidgen) /dev/vdb2
     ```

     Этот способ подойдет для разделов с файловыми системами `ext2`, `ext3` и `ext4`. Последняя используется в образах Linux, предоставляемых {{ yandex-cloud }}. Тип файловой системы возвращается командой `blkid` в параметре `TYPE`.

     Если у вас отличается файловая система, используйте соответствующие команды. Например, для `XFS` выполните:

     ```bash
     sudo xfs_admin -U generate /dev/vdb2
     ```

     Чтобы проверить, что UUID изменился, снова выполните команду `blkid`:

     ```bash
     sudo blkid
     /dev/vda2: UUID="0d6dfef0-542d-47ba-b55b-18ab5f5f9210" TYPE="ext4" PARTUUID="752aa845-94ee-4850-9188-71c2f919ee7b"
     /dev/vdb2: UUID="ea004485-07fb-4128-b20d-e408db1e8ae8" TYPE="ext4" PARTUUID="752aa845-94ee-4850-9188-71c2f919ee7b"
     ```

     {% include [include](../../../_includes/compute/duplicated-uuid-note.md) %}

  1. {% include [include](../../../_includes/compute/mount-disk.md) %}

  1. Выполните команду `df`, чтобы проверить состояние файловой системы.


{% endlist %}

## Разметить и смонтировать пустой диск {#mount}

Чтобы самостоятельно разметить и смонтировать пустой диск:

{% list tabs %}

- Linux

  1. Проверьте, подключен ли диск как устройство и узнайте его путь в системе:

     ```bash
     lsblk
     ```

     Результат:

     ```bash
     NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
     vda    252:0    0  13G  0 disk
     ├─vda1 252:1    0   1M  0 part
     └─vda2 252:2    0  13G  0 part /
     vdb    252:16   0   1G  0 disk
     ```

     Обычно пустой диск имеет метку вида /dev/vdb.

  1. Разметьте диск. Для этого создайте на нем [разделы](https://help.ubuntu.ru/wiki/%D1%80%D0%B0%D0%B7%D0%B4%D0%B5%D0%BB%D1%8B_%D0%B8_%D1%84%D0%B0%D0%B9%D0%BB%D0%BE%D0%B2%D1%8B%D0%B5_%D1%81%D0%B8%D1%81%D1%82%D0%B5%D0%BC%D1%8B_linux) с помощью [утилиты](https://www.opennet.ru/man.shtml?topic=cfdisk&category=8&russian=2) `cfdisk`, [утилиты](https://www.opennet.ru/man.shtml?topic=fdisk&russian=2&category=&submit=%F0%CF%CB%C1%DA%C1%D4%D8+man) `fdisk` или [утилиты](https://www.opennet.ru/man.shtml?topic=parted&russian=2&category=&submit=%F0%CF%CB%C1%DA%C1%D4%D8+man) `parted`.

  1. Для примера создадим разделы с помощью команды `fdisk`. Используйте команду `sudo` или выполняйте команды от имени пользователя `root`: для этого выполните команду `sudo su -`.
     
     ```bash
     sudo fdisk /dev/vdb
     ```

     Вы попадете в меню программы `fdisk`. Чтобы получить список доступных команд нажмите клавишу **M**.

  1. Создайте новый раздел — нажмите **N**. 
  1. Укажите, что раздел будет основным — нажмите **P**. 
  1. Появится предложение выбрать номер раздела. Нажмите **Enter**, чтобы создать первый раздел. 
  1. Номера первого и последнего секторов раздела оставьте по умолчанию — два раза нажмите **Enter**.
  1. Убедитесь, что раздел успешно создан. Для этого нажмите клавишу **P** и выведите список разделов диска. Пример созданного раздела:

     ```bash
     Device     Boot Start      End  Sectors Size Id Type
     /dev/vdb1        2048 41943039 41940992  20G 83 Linux
     ```

  1. Для сохранения внесенных изменений нажмите клавишу **W**.
     
  1. Отформатируйте диск в нужную файловую систему, например, с помощью [утилиты](https://www.opennet.ru/man.shtml?topic=mkfs&category=8&russian=0) `mkfs`. Например, чтобы отформатировать раздел в ext4 введите команду:

     ```bash
     sudo mkfs.ext4 /dev/vdb1
     ```

  1. Смонтируйте разделы диска с помощью [утилиты](https://www.opennet.ru/man.shtml?topic=mount&category=8&russian=0) `mount`. Для того, чтобы монтировать раздел `vdb1` в папку `/mnt/vdb1` выполните:

     ```bash
     sudo mkdir /mnt/vdb1
     sudo mount /dev/vdb1 /mnt/vdb1
     ```
   
  1. Настройте разрешения на чтение и запись на диске с помощью [утилиты](https://www.opennet.ru/man.shtml?topic=chmod&russian=0&category=&submit=%F0%CF%CB%C1%DA%C1%D4%D8+man) `chmod`. Например, для предоставления доступа на запись к диску всем пользователям, выполните команду:

     ```bash
     sudo chmod a+w /mnt/vdb1
     ```   

  1. Получите идентификатор (`UUID`) диска с помощью [утилиты](https://www.opennet.ru/man.shtml?topic=blkid&russian=0&category=&submit=%F0%CF%CB%C1%DA%C1%D4%D8+man) `blkid`:

     ```bash
     sudo blkid /dev/vdb1
     ```     

     Результат:

     ```bash
     /dev/vdb1: UUID="397f9660-e740-40bf-8e59-ecb88958b50e" TYPE="ext4" PARTUUID="e34d0d32-01"
     ```
  
  1. Чтобы настроить автоматическое монтирование раздела после перезапуска ВМ:
      1. Откройте файл `/etc/fstab` с помощью текстового редактора `nano`:

          ```bash
          sudo nano /etc/fstab
          ```       

      1. Допишите в файл следующую строку, указав в параметре `UUID` идентификатор вашего диска, например:

          ```
          UUID=397f9660-e740-40bf-8e59-ecb88958b50e /mnt/vdb1 ext4 defaults 0 2
          ```

      1. Сохраните изменения в файле.
  1. Проверьте состояние файловых систем:

     ```bash
     df
     ```

     Результат:

     ```bash
     Filesystem     1K-blocks    Used Available Use% Mounted on
     udev              989424       0    989424   0% /dev
     tmpfs             203524     816    202708   1% /run
     /dev/vda2       13354932 2754792  10015688  22% /
     tmpfs            1017608       0   1017608   0% /dev/shm
     tmpfs               5120       0      5120   0% /run/lock
     tmpfs            1017608       0   1017608   0% /sys/fs/cgroup
     tmpfs             203520       0    203520   0% /run/user/1000
     /dev/vdb1         523260    3080    520180   1% /mnt/vdb1
     ```


{% endlist %}