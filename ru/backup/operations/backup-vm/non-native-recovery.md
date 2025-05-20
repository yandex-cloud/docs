---
title: Как восстановить ВМ или сервер {{ baremetal-name }} из резервной копии другой ВМ или сервера {{ baremetal-name }}
description: Следуя данной инструкции, вы сможете восстановить виртуальную машину или сервер {{ baremetal-full-name }} из резервной копии другой виртуальной машины или сервера {{ baremetal-name }}.
---

# Восстановить виртуальную машину или сервер {{ baremetal-name }} из резервной копии другой виртуальной машины или сервера {{ baremetal-name }}

{% include [vm-and-bms-backup-incompatibility](../../../_includes/backup/vm-and-bms-backup-incompatibility.md) %}

{% include [baremetal-note](../../../_includes/backup/baremetal-note.md) %}

Если в каталоге есть несколько виртуальных машин или серверов {{ baremetal-name }}, подключенных к {{ backup-name }}, можно восстановить ВМ или сервер {{ baremetal-name }} из резервной копии другой ВМ или сервера {{ baremetal-name }} соответственно. Это нужно, например, если исходные ВМ или сервер {{ baremetal-name }} неисправны.

{% include [avoid-errors-when-restoring-from-backup.md](../../../_includes/backup/avoid-errors-when-restoring-from-backup.md) %}

{% note info %}

Операционная система целевых ВМ или сервера {{ baremetal-name }} должна совпадать с операционной системой исходных ВМ или сервера {{ baremetal-name }}, из которых создана резервная копия. Размер загрузочного диска целевой ВМ или сервера {{ baremetal-name }} должен быть не меньше размера загрузочного диска исходной ВМ или сервера {{ baremetal-name }}. Целевая ВМ или сервер {{ baremetal-name }} должны находиться в [статусе](../../../compute/concepts/vm-statuses.md#list-of-statuses) `Running`.

{% endnote %}

Чтобы восстановить ВМ или сервер {{ baremetal-name }} из копии другой ВМ или сервера {{ baremetal-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится резервная копия.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. На панели слева выберите ![backups](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.backup.label_backups }}**.
  1. В зависимости от того, какой ресурс вы хотите восстановить из резервной копии, выберите вкладку **{{ ui-key.yacloud.backup.value_vm-recourses }}** или **{{ ui-key.yacloud.backup.value_bms-recourses }}**.
  1. В строке с резервной копией, из которой нужно восстановить ВМ или сервер {{ baremetal-name }}, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите соответственно **{{ ui-key.yacloud.backup.action_recovery }}** или **{{ ui-key.yacloud.backup.action_bms-recovery }}**. В открывшемся окне:
  
      1. Выберите виртуальную машину или сервер {{ baremetal-name }}, в которые нужно восстановить резервную копию. При необходимости нажмите кнопку **{{ ui-key.yacloud.common.create }}**, чтобы [создать](../index.md#connect-vm) новую ВМ или [арендовать](../../../baremetal/operations/servers/server-lease.md) новый сервер {{ baremetal-name }} для восстановления из резервной копии.

          Если вы создаете новую ВМ, дождитесь [подключения](../../concepts/vm-connection.md) этой ВМ к {{ backup-name }}. Если вы арендуете новый сервер {{ baremetal-name }}, [подключите](../backup-baremetal/backup-baremetal.md) его к {{ backup-name }}. После этого в окне восстановления из резервной копии нажмите значок ![refresh](../../../_assets/console-icons/arrow-rotate-right.svg), чтобы новая ВМ или сервер {{ baremetal-name }} появились в списке.
  
      1. (Только для ВМ) Чтобы исключить конфликт между восстановленной и исходной ВМ, включите опцию **{{ ui-key.yacloud.backup.field_delete-old-vm }}**.

          Если не включить эту опцию, то после восстановления исходная ВМ, из которой была создана копия, станет неактуальной. Чтобы продолжить создавать резервные копии этой ВМ, [обновите](../refresh-connection.md) ее подключение к {{ backup-name }}.
      1. Нажмите кнопку **{{ ui-key.yacloud.backup.action_recovery-start }}**.

- CLI {#cli}

  1. {% include [cli-install](../../../_includes/cli-install.md) %}

  1. {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для восстановления ВМ или сервера {{ baremetal-name }} из резервной копии:

     ```bash
     yc backup backups recover --help
     ```

  1. Узнайте идентификаторы целевой ВМ, в которую вы хотите восстановить резервную копию, и исходной ВМ, чью резервную копию вы хотите использовать:

      {% include [get-vm-id](../../../_includes/backup/operations/get-vm-id.md) %}

      {% include [get-bms-ids](../../../_includes/backup/operations/get-bms-ids.md) %}

  1. Узнайте идентификатор резервной копии исходной ВМ или сервера {{ baremetal-name }}:

     ```bash
     yc backup backups list \
       --instance-id <идентификатор_исходной_ВМ_или_сервера_{{ baremetal-name }}>
     ```

     Где `--instance-id` — идентификатор исходной ВМ или сервера {{ baremetal-name }}, резервную копию которых вы хотите использовать.

     Результат:

     ```text
     +--------------------------------------+--------------------------------------+----------------------+--------------------------------------+----------------------+------+------------------+--------+---------------------+
     |                  ID                  |              ARCHIVE ID              | COMPUTE INSTANCE ID  |             RESOURCE ID              |      POLICY ID       | TYPE |      DISKS       |  SIZE  |     CREATED AT      |
     +--------------------------------------+--------------------------------------+----------------------+--------------------------------------+----------------------+------+------------------+--------+---------------------+
     | 9cba836d-869c-41d2-8f25-0dac******** | 8a5b6d59-f7ce-0cb9-6cbf-151c******** | epdhmn8mdqmt******** | 7AF6A532-D1DC-4945-9D0C-E101******** | cdgiqu6ouch3******** | FULL | Disk 1 (13.0 GB) | 1.4 GB | 2023-07-11 05:10:09 |
     | 05e964ca-6a8f-481a-b83e-44c5******** | 8a5b6d59-f7ce-0cb9-6cbf-151c******** | epdhmn8mdqmt******** | 7AF6A532-D1DC-4945-9D0C-E101******** | cdgiqu6ouch3******** | FULL | Disk 1 (15.0 GB) | 1.4 GB | 2023-07-11 05:00:07 |
     +--------------------------------------+--------------------------------------+----------------------+--------------------------------------+----------------------+------+------------------+--------+---------------------+
     ```

  1. Восстановите ВМ или сервер {{ baremetal-name }} из резервной копии:

     ```bash
     yc backup backups recover \
       --source-backup-id <идентификатор_резервной_копии> \
       --destination-instance-id <идентификатор_целевой_ВМ_или_сервера_{{ baremetal-name }}>
     ```

     Где:

     * `--source-backup-id` — идентификатор резервной копии.
     * `--destination-instance-id` — идентификатор целевой ВМ или сервера {{ baremetal-name }}, в которые вы хотите восстановить резервную копию.

     Результат:

     ```text
     ...1s...6s...11s ... 9m4s...9m9s...done (9m9s)
     ```

     Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/backup/cli-ref/backup/recover.md).

- API {#api}

  Воспользуйтесь методом REST API [startRecovery](../../backup/api-ref/Backup/startRecovery.md) для ресурса [Backup](../../backup/api-ref/Backup/index.md) или вызовом gRPC API [BackupService/StartRecovery](../../backup/api-ref/grpc/Backup/startRecovery.md).

{% endlist %}

{% note info %}

{% include [lvm-restoration-notice](../../../_includes/backup/lvm-restoration-notice.md) %}

{% endnote %}

После восстановления из резервной копии исходная ВМ (если при восстановлении в консоли управления не была включена опция **{{ ui-key.yacloud.backup.field_delete-old-vm }}**) или исходный сервер {{ baremetal-name }}, из которых была создана копия, станут неактуальными. Чтобы получить возможность вновь создавать резервные копии исходных ВМ или сервера {{ baremetal-name }}, обновите их подключение к {{ backup-name }}. Подробнее см. в инструкциях [{#T}](../refresh-connection.md) и [{#T}](../backup-baremetal/refresh-connection.md).

{% include [non-native-bms-restore-connectivity-loss](../../../_includes/backup/operations/non-native-bms-restore-connectivity-loss.md) %}

#### См. также {#see-also}

* [{#T}](delete.md)
