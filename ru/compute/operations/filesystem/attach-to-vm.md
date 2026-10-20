---
title: Подключить файловое хранилище к виртуальной машине
description: Следуя данной инструкции, вы сможете подключить файловое хранилище к виртуальной машине.
---

# Подключить файловое хранилище к виртуальной машине

{% note warning %}

[Файловое хранилище](../../concepts/filesystem.md) можно привязать только к [ВМ](../../concepts/vm.md) под управлением [операционной системы](../../concepts/filesystem.md#os) Linux с версией ядра 5.4 или выше.

Чтобы проверить версию ядра, выполните команду `sudo uname -r`.

{% endnote %}

Подключение состоит из следующих этапов — привязки хранилища к ВМ в {{ compute-name }} и монтирования устройства в операционной системе ВМ. Для привязки выберите удобный интерфейс, а команды монтирования выполните внутри ВМ.

## Подготовьте ВМ {#prepare-vm}

Если ВМ находится в [статусе](../../concepts/vm-statuses.md) `RUNNING`, [остановите ее](../vm-control/vm-stop-and-start.md#stop). Дождитесь статуса `STOPPED`.

## Привяжите файловое хранилище {#attach-filesystem}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создано файловое хранилище.
  1. [Перейдите]({{ link-console-main }}/link/compute) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.storage_uisyT }}** и перейдите на вкладку **{{ ui-key.yacloud.compute.file-storages_pNPw1 }}**.
  1. В строке файлового хранилища нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите пункт ![image](../../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.compute.nfs.button_attach-instance-to-the-filesystem }}**.
  1. В открывшемся окне:
     1. Выберите ВМ.
     1. Укажите имя устройства, под которым файловое хранилище будет доступно в ВМ. Например, укажите `storagename`. Сохраните это значение: оно понадобится при монтировании хранилища.
     1. Нажмите **{{ ui-key.yacloud.compute.nfs.button_attach-instance-to-the-filesystem }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../../cli/) для привязки файлового хранилища к ВМ:

     ```bash
     yc compute instance attach-filesystem --help
     ```

  1. Получите список файловых хранилищ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     {% include [compute-filesystem-list](../../_includes_service/compute-filesystem-list.md) %}

  1. Получите список виртуальных машин в каталоге по умолчанию:

     ```bash
     yc compute instance list
     ```

     Результат:

     ```text
     +----------------------+-------+---------------+---------+--------------+-------------+
     |          ID          | NAME  |    ZONE ID    | STATUS  |  EXTERNAL IP | INTERNAL IP |
     +----------------------+-------+---------------+---------+--------------+-------------+
     | epdj4upltbiv******** | vm-01 | {{ region-id }}-a | RUNNING | 51.250.**.** | 192.168.*.* |
     | 1pc3088tkv4m******** | vm-02 | {{ region-id }}-a | RUNNING | 84.201.**.** | 192.168.*.* |
     +----------------------+-------+---------------+---------+--------------+-------------+
     ```

  1. Привяжите файловое хранилище к ВМ:

     ```bash
     yc compute instance attach-filesystem \
       --id <идентификатор_ВМ> \
       --filesystem-id <идентификатор_файлового_хранилища> \
       --device-name <имя_устройства>
     ```

     Где:
     * `--id` — идентификатор ВМ.

       Вместо идентификатора вы можете указать имя ВМ в параметре `--name`.

     * `--filesystem-id` — идентификатор файлового хранилища.

       Вместо идентификатора вы можете указать имя файлового хранилища в параметре `--filesystem-name`.

     * `--device-name` — имя устройства, под которым файловое хранилище будет доступно в ВМ, например `storagename`. Необязательный параметр.

       По умолчанию в качестве имени устройства используется идентификатор файлового хранилища. Сохраните имя устройства: оно понадобится при монтировании хранилища.

     Результат:

     ```text
     id: epdj4upltbiv********
     folder_id: b1g681qpemb4********
     created_at: "2024-04-29T15:50:19Z"
     name: vm-01
     ...
     filesystems:
     - mode: READ_WRITE
       device_name: storagename
       filesystem_id: epdtcr9blled********
     ...
     ```

  1. Проверьте привязку хранилища к ВМ:

     ```bash
     yc compute instance get <имя_ВМ>
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Если вы не указали для ВМ параметр `allow_stopping_for_update` в значении `true`, сделайте это.

  Чтобы привязать файловое хранилище к ВМ, добавьте к ее описанию блок `filesystem` с параметром `filesystem_id` (смотрите пример).
  1. Откройте файл конфигурации {{ TF }} и добавьте фрагмент с описанием хранилища к описанию ВМ:

     ```hcl
     ...
     resource "yandex_compute_instance" "vm-1" {
       name        = "vm-01"
       platform_id = "standard-v3"
       zone        = "{{ region-id }}-a"

       filesystem {
         filesystem_id = "epdtcr9blled********"
         device_name   = "storagename"
       }
     }
     ...
     ```

     Сохраните значение `device_name`: оно понадобится при монтировании хранилища.

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

     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Примените изменения конфигурации:

     ```bash
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

  1. Проверьте привязку хранилища к ВМ в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

     ```bash
     yc compute instance get <имя_ВМ>
     ```

- API {#api}

  Чтобы привязать файловое хранилище к ВМ, воспользуйтесь методом REST API [attachFilesystem](../../api-ref/Instance/attachFilesystem.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/AttachFilesystem](../../api-ref/grpc/Instance/attachFilesystem.md).

  Сохраните имя устройства, указанное при привязке: оно понадобится при монтировании хранилища.

{% endlist %}

## Запустите ВМ {#start-vm}

[Запустите ВМ](../vm-control/vm-stop-and-start.md#start), если она остановлена, и дождитесь статуса `RUNNING`.

## Смонтируйте файловое хранилище {#mount-filesystem}

1. [Подключитесь](../vm-connect/ssh.md) к ВМ по [SSH](../../../glossary/ssh-keygen.md).
1. Создайте каталог монтирования, например `/mnt/vfs0`:

   ```bash
   sudo mkdir -p /mnt/vfs0
   ```

1. Смонтируйте файловое хранилище:

   ```bash
   sudo mount -t virtiofs <имя_устройства> <путь_монтирования>
   ```

   Где:
   * `<имя_устройства>` — имя устройства, которое вы указали при привязке хранилища в {{ compute-name }}. Например, `storagename`. Если вы не указали имя, [используйте идентификатор файлового хранилища](get-info.md?tabs=instructions_cli).

     {% cut "Как узнать имя устройства через CLI" %}

     Выполните на компьютере с настроенным YC CLI:

     ```bash
     yc compute instance get <имя_ВМ>
     ```

     Результат:

     ```text
     ...
     filesystems:
       - mode: READ_WRITE
         device_name: storagename
         filesystem_id: epdtcr9blled********
     ...
     ```

     Имя устройства указано в поле `device_name` в блоке `filesystems`.

     {% endcut %}

   * `<путь_монтирования>` — существующий каталог, в который будет смонтировано файловое хранилище. Например, `/mnt/vfs0`.

1. Проверьте, что файловое хранилище смонтировано:

   ```bash
   df -T
   ```

   Результат:

   ```text
   Filesystem        Type         1K-blocks    Used Available Use% Mounted on
   udev              devtmpfs        988600       0    988600   0% /dev
   tmpfs             tmpfs           203524     780    202744   1% /run
   /dev/vda2         ext4          13354932 1909060  10861420  15% /
   tmpfs             tmpfs          1017604       0   1017604   0% /dev/shm
   tmpfs             tmpfs             5120       0      5120   0% /run/lock
   tmpfs             tmpfs          1017604       0   1017604   0% /sys/fs/cgroup
   tmpfs             tmpfs           203520       0    203520   0% /run/user/1000
   storagename       virtiofs      66774660       0  66774660   0% /mnt/vfs0
   ```

1. Чтобы файловое хранилище монтировалось при каждом запуске ВМ, добавьте в файл `/etc/fstab` строку вида:

   ```text
   <имя_устройства> <путь_монтирования> virtiofs    rw    0   0
   ```

## Что дальше {#what-is-next}

* Настройте приложения на ВМ так, чтобы они записывали файлы в смонтированное хранилище.
* Для совместной работы с файлами подключите хранилище к другой ВМ в той же зоне доступности.
* Если места станет недостаточно, [увеличьте размер хранилища](update.md).
