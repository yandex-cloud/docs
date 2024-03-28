# Подключить диск к виртуальной машине

Подключить [диск](../../concepts/disk.md) можно к [работающей и остановленной](../../concepts/vm-statuses.md) [ВМ](../../concepts/vm.md).

Чтобы диск был успешно подключен к работающей ВМ, операционная система ВМ должна быть готова принимать команды на подключение диска. Перед подключением диска убедитесь, что ОС загружена, или остановите ВМ — иначе операция подключения диска завершится с ошибкой. При возникновении ошибки остановите ВМ и повторите операцию.

{% include [disk-auto-delete](../../_includes_service/disk-auto-delete.md) %}

## Подключить диск {#attach}


{% note info %}

Подключить локальный диск к ВМ на [выделенном хосте](../../concepts/dedicated-host.md) можно только при ее создании. Подробнее см. в [инструкциях](../index.md#dedicated-host).

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), которому принадлежит ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
  1. Выберите неподключенный диск или [создайте](../disk-create/empty.md) новый.
  1. Напротив диска, который вы хотите подключить, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.disks.button_action-attach }}**.
  1. В открывшемся окне:
     * В поле **{{ ui-key.yacloud.compute.attach-disk.field_instance }}** выберите виртуальную машину, к которой нужно подключить диск.

     
     * Если в хотите подключить [зашифрованный](../../concepts/encryption.md) диск, выберите [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) c [ролью](../../../kms/security/index.md#kms-keys-encrypterDecrypter) `kms.keys.encrypterDecrypter` на [ключ {{ kms-short-name }}](../../../kms/concepts/key.md), которым зашифрован диск.


     * Укажите название устройства.
     * При необходимости включите опцию **{{ ui-key.yacloud.compute.attach-disk.field_auto-delete }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.attach-disk.button_attach }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для подключения дисков:

     ```bash
     yc compute instance attach-disk --help
     ```

  1. Получите список ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

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

- API {#api}

  Воспользуйтесь методом REST API [attachDisk](../../api-ref/Instance/attachDisk.md) для ресурса [Instance](../../api-ref/Instance/) или вызовом gRPC API [InstanceService/AttachDisk](../../api-ref/grpc/instance_service.md#AttachDisk).

{% endlist %}

## Смонтировать диск, созданный из снимка или образа {#mount-disk-and-fix-uuid}

{% list tabs group=operating_system %}

- Linux {#linux}

  1. [Подключите](#attach) диск к ВМ.
  1. [Подключитесь](../vm-connect/ssh.md) к ВМ по [SSH](../../../glossary/ssh-keygen.md).
  1. Выполните команду `blkid` и проверьте, что нет разделов с одинаковыми UUID:

     ```bash
     sudo blkid
     ```

     Результат:

     ```text
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
     ```

     Результат:

     ```text
     /dev/vda2: UUID="0d6dfef0-542d-47ba-b55b-18ab5f5f9210" TYPE="ext4" PARTUUID="752aa845-94ee-4850-9188-71c2f919ee7b"
     /dev/vdb2: UUID="ea004485-07fb-4128-b20d-e408db1e8ae8" TYPE="ext4" PARTUUID="752aa845-94ee-4850-9188-71c2f919ee7b"
     ...
     ```

     {% include [include](../../../_includes/compute/duplicated-uuid-note.md) %}

  1. {% include [include](../../../_includes/compute/mount-disk.md) %}

  1. Выполните команду `df`, чтобы проверить состояние файловой системы.

- Windows {#windows}

  1. Подключитесь к ВМ [по RDP](../vm-connect/rdp.md).
  1. Запустите приложение **Управление компьютером** (оснастка `compmgmt.msc`) с правами администратора.
  1. В меню **Запоминающие устройства** выберите **Управление дисками**.

     {% note info %}

     При подключении диска к работающей ВМ он может не отобразиться в списке. В этом случае перезагрузите ОС и повторите шаги этой инструкции.

     {% endnote %}

  1. Если подключенный диск **Не в сети**, нажмите на него правой кнопкой мыши и выберите пункт **В сети**.
  1. При необходимости назначьте букву подключенному диску. Как это сделать читайте в [документации Microsoft]({{ ms.docs }}/windows-server/storage/disk-management/change-a-drive-letter).
  1. Откройте **Проводник**, чтобы убедиться, что подключенный диск смонтирован и доступен.

{% endlist %}

## Разметить и смонтировать пустой диск {#mount}

{% list tabs group=operating_system %}

- Linux {#linux}

  1. [Подключите](#attach) пустой диск к ВМ.
  1. [Подключитесь к ВМ по SSH](../vm-connect/ssh.md).
  1. Проверьте, подключен ли диск как устройство, и узнайте его путь в системе:

     ```bash
     ls -la /dev/disk/by-id
     ```

     Результат:

     ```text
     total 0
     drwxr-xr-x 2 root root 140 Jan 16 12:09 .
     drwxr-xr-x 6 root root 120 Jan 13 13:51 ..
     lrwxrwxrwx 1 root root   9 Jan 16 12:09 virtio-fhm1dn62tm5d******** -> ../../vdc
     lrwxrwxrwx 1 root root   9 Jan 13 13:51 virtio-fhm4ev6dodt9******** -> ../../vdb
     lrwxrwxrwx 1 root root  10 Jan 13 13:51 virtio-fhm4ev6dodt9********-part1 -> ../../vdb1
     lrwxrwxrwx 1 root root  10 Jan 13 13:51 virtio-fhm4ev6dodt9********-part2 -> ../../vdb2
     lrwxrwxrwx 1 root root   9 Jan 13 13:51 virtio-nvme-disk-0 -> ../../vda
     ```

     Где:
     * Сетевым дискам соответствуют ссылки вида `virtio-<идентификатор_диска>`. Например, запись `virtio-fhm1dn62tm5d******** -> ../../vdc` означает, что неразмеченный диск с ID `fhm1dn62tm5d********` имеет метку `vdc`.
     * Локальным дискам на [выделенных хостах](../../concepts/dedicated-host.md) соответствуют ссылки вида `virtio-nvme-disk-<номер_диска>` (если вы подключали диски к ВМ при ее создании). Диски нумеруются с нуля. Например, запись `virtio-nvme-disk-0 -> ../../vda` означает, что первый (нулевой) локальный диск имеет метку `vda`.

  1. Разметьте диск. Для этого создайте на нем [разделы](https://help.ubuntu.ru/wiki/%D1%80%D0%B0%D0%B7%D0%B4%D0%B5%D0%BB%D1%8B_%D0%B8_%D1%84%D0%B0%D0%B9%D0%BB%D0%BE%D0%B2%D1%8B%D0%B5_%D1%81%D0%B8%D1%81%D1%82%D0%B5%D0%BC%D1%8B_linux) с помощью [утилиты](https://www.opennet.ru/man.shtml?topic=cfdisk&category=8&russian=2) `cfdisk`, [утилиты](https://www.opennet.ru/man.shtml?topic=fdisk&russian=2&category=&submit=%F0%CF%CB%C1%DA%C1%D4%D8+man) `fdisk` или [утилиты](https://www.opennet.ru/man.shtml?topic=parted&russian=2&category=&submit=%F0%CF%CB%C1%DA%C1%D4%D8+man) `parted`.

     Выполняйте команды с правами суперпользователя. Для этого в каждой команде используйте `sudo` или перед началом работы выполните команду `sudo su -`, чтобы перевести терминал в режим суперпользователя. Для примера создадим разделы с помощью `fdisk`:

     1. Запустите утилиту:

         ```bash
         sudo fdisk /dev/<метка_диска>
         ```

        Где `<метка_диска>` — метка диска, который нужно разметить, например `vdb` или `vdc`.

        Вы попадете в меню программы `fdisk`. Чтобы получить список доступных команд, введите `m` и нажмите **Enter**.
     1. Создайте новый раздел — введите `n` и нажмите **Enter**.
     1. Укажите, что раздел будет основным — введите `p` и нажмите **Enter**.
     1. Появится предложение выбрать номер раздела. Нажмите **Enter**, чтобы создать раздел `1`.
     1. Номера первого и последнего секторов раздела оставьте по умолчанию — нажмите **Enter** дважды.
     1. Убедитесь, что раздел успешно создан. Для этого запросите список разделов диска: введите `p` и нажмите **Enter**.

         Результат:

         ```text
         Device     Boot Start      End  Sectors Size Id Type
         /dev/vdc1        2048 41943039 41940992  20G 83 Linux
         ```

         Где `vdc1` — _метка раздела_, состоящая из метки диска и номера раздела. Метка раздела понадобится при выполнении дальнейших действий с разделом.

     1. Чтобы сохранить внесенные изменения, введите `w` и нажмите **Enter**.

  1. Отформатируйте раздел в нужную файловую систему. Для этого можно воспользоваться [утилитой](https://www.opennet.ru/man.shtml?topic=mkfs&category=8&russian=0) `mkfs`. Например, чтобы отформатировать раздел в `ext4`, выполните команду, указав метку созданного ранее раздела:

     ```bash
     sudo mkfs.ext4 /dev/<метка_раздела>
     ```

     Результат:

     ```text
     Creating filesystem with 261888 4k blocks and 65536 inodes
     Filesystem UUID: 584a800c-e1fc-4f66-9228-a444f2d7440d
     Superblock backups stored on blocks:
             32768, 98304, 163840, 229376
     
     Allocating group tables: done
     Writing inode tables: done
     Creating journal (4096 blocks): done
     Writing superblocks and filesystem accounting information: done
     ```

     Где `Filesystem UUID` — уникальный _идентификатор раздела_. Идентификатор раздела понадобится при настройке автоматического монтирования этого раздела к системе. Получить идентификатор раздела также можно с помощью команды `sudo blkid /dev/<метка_раздела>`.

  1. Смонтируйте раздел диска с помощью [утилиты](https://www.opennet.ru/man.shtml?topic=mount&category=8&russian=0) `mount`. Чтобы смонтировать раздел `/dev/<метка_раздела>` в директорию `/mnt/new_disk`, выполните следующую команду:

     ```bash
     sudo mkdir /mnt/new_disk && sudo mount /dev/<метка_раздела> /mnt/new_disk
     ```

  1. Настройте разрешения на чтение и запись в разделе с помощью [утилиты](https://www.opennet.ru/man.shtml?topic=chmod&russian=0&category=&submit=%F0%CF%CB%C1%DA%C1%D4%D8+man) `chmod`. Например, чтобы разрешить всем пользователям  запись в раздел, выполните следующую команду:

     ```bash
     sudo chmod a+w /mnt/new_disk
     ```

  1. Настройте автоматическое монтирование раздела в директорию `mnt/new_disk` при запуске ВМ:

     1. Откройте файл `/etc/fstab` с помощью текстового редактора `nano`:

        ```bash
        sudo nano /etc/fstab
        ```

     1. Допишите в конец файла следующую строку, указав в параметре `UUID` идентификатор вашего раздела:

        ```text
        UUID=<идентификатор_раздела> /mnt/new_disk ext4 defaults 0 2
        ```

        Где `UUID` — уникальный идентификатор раздела, полученный ранее при форматировании. Например `584a800c-e1fc-4f66-9228-a444f2d7440d`.

     1. Сохраните изменения и закройте файл.

  1. Проверьте состояние файловых систем:

     ```bash
     df
     ```

     Результат:

     ```text
     Filesystem     1K-blocks    Used Available Use% Mounted on
     udev              989424       0    989424   0% /dev
     tmpfs             203524     816    202708   1% /run
     /dev/vdb2       13354932 2754792  10015688  22% /
     tmpfs            1017608       0   1017608   0% /dev/shm
     tmpfs               5120       0      5120   0% /run/lock
     tmpfs            1017608       0   1017608   0% /sys/fs/cgroup
     tmpfs             203520       0    203520   0% /run/user/1000
     /dev/vdc1         523260    3080    520180   1% /mnt/vdc1
     ```

- Windows {#windows}

  1. Подключитесь к ВМ [по RDP](../vm-connect/rdp.md).
  1. Запустите приложение **Управление компьютером** (оснастка `compmgmt.msc`) с правами администратора.
  1. В меню **Запоминающие устройства** выберите **Управление дисками**.

     {% note info %}

     При подключении диска к работающей ВМ он может не отобразиться в списке. В этом случае перезагрузите ОС и повторите шаги этой инструкции.

     {% endnote %}

  1. Если подключенный диск **Не в сети**, нажмите на него правой кнопкой мыши и выберите пункт **В сети**.
  1. Инициализируйте диск. Для этого нажмите на него правой кнопкой мыши и выберите пункт **Инициализировать диск**. Откроется окно **Инициализация диска**.
  1. Выберите [стиль разделов]({{ ms.docs }}/windows-server/storage/disk-management/initialize-new-disks#about-partition-styles---gpt-and-mbr) и нажмите **ОК**.
  1. Создайте разделы на диске. Для этого нажмите правой кнопкой мыши на пустой диск и выберите пункт **Создать простой том**.
  1. С помощью **Мастера создания простых томов** задайте размер раздела, [назначьте букву]({{ ms.docs }}/windows-server/storage/disk-management/change-a-drive-letter) диска и укажите файловую систему.
  1. Откройте **Проводник**, чтобы убедиться, что подключенный диск смонтирован и доступен.

{% endlist %}