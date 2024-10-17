---
title: Как изменить расписание, по которому создаются снимки дисков {{ compute-full-name }}
description: Из статьи вы узнаете, как изменить расписание, по которому создаются снимки дисков {{ compute-name }}.
---

# Изменить расписание, по которому создаются снимки дисков


## Изменить основные параметры {#update-basic-parameters}

Чтобы изменить основные параметры [расписания](../../concepts/snapshot-schedule.md) [снимков дисков](../../concepts/snapshot.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится расписание.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.switch_snapshots }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.compute.snapshots-schedules.label_title }}**.
  1. Напротив расписания, которое нужно изменить, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Измените параметры расписания снимков [диска](../../concepts/disk.md):
     * **{{ ui-key.yacloud.common.name }}**. Требования к имени:

       {% include [name-format](../../../_includes/name-format.md) %}

     * **{{ ui-key.yacloud.common.description }}**.
     * В поле **{{ ui-key.yacloud.compute.snapshots-schedules.label_schedule-policy }}** выберите периодичность создания снимков диска: `{{ ui-key.yacloud.compute.snapshots-schedules.label_hourly }}`, `{{ ui-key.yacloud.compute.snapshots-schedules.label_daily }}`, `{{ ui-key.yacloud.compute.snapshots-schedules.label_weekly }}` [или `{{ ui-key.yacloud.compute.snapshots-schedules.label_custom }}`](../../concepts/snapshot-schedule.md#cron). Время создания снимка диска указывается в часовом поясе [UTC±00:00](https://{{ lang }}.wikipedia.org/wiki/UTC±00:00).
     * В поле **{{ ui-key.yacloud.compute.snapshots-schedules.label_start-at }}** укажите дату, начиная с которой будет работать расписание.
     * Выберите политику хранения снимков диска:
       * **{{ ui-key.yacloud.compute.snapshots-schedules.label_empty-retention-policy }}** — будут храниться все снимки диска, созданные по этому расписанию. 
       * **{{ ui-key.yacloud.compute.snapshots-schedules.message_store-last-begin_many }}** — укажите количество последних снимков диска, которые нужно хранить, или количество дней, снимки за которые нужно хранить. Остальные снимки диска, созданные по этому расписанию, будут удаляться автоматически.

       {% note info %}

       На количество и суммарный объем снимков диска в облаке действуют [квоты](../../concepts/limits.md#compute-quotas).

       {% endnote %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команд [CLI](../../../cli/) для работы с расписаниями:

     ```bash
     yc compute snapshot-schedule --help
     yc compute snapshot-schedule update --help
     ```

  1. Получите список расписаний в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     ```bash
     yc compute snapshot-schedule list --format yaml
     ```

     Результат:

     ```text
     - id: fc852cvb1ipd5********
       folder_id: e1ea8s8l71li********
       created_at: "2022-09-28T13:25:02Z"
     ...
         expression: 10 19 ? * *
       snapshot_count: "7"
       snapshot_spec: {}
     ```

  1. Измените параметры выбранного расписания:

     ```bash
     yc compute snapshot-schedule update <имя_или_идентификатор_расписания> \
       --new-name <новое_имя_расписания> \
       --description <описание> \
       --expression <cron-выражение> \
       --retention-period <срок_хранения_снимков_диска> \
       --snapshot-count <количество_снимков_диска> \
       --start-at <дата_и_время_начала> \
       --labels <метки>
      ```

     Где:
     * `--new-name` — новое имя расписания.
     * `--description` — описание.
     * `--expression` — [cron-выражение](../../concepts/snapshot-schedule.md#cron).
     * `--retention-period` — длительность хранения снимков [диска](../../concepts/disk.md), указанная в секундах (`s`), минутах (`m`) или часах (`h`).
     * `--snapshot-count` — количество хранимых снимков диска. Используйте либо параметр `--snapshot-count`, либо `--retention-period`. См. подробнее о политике [хранения снимков диска](../../concepts/snapshot-schedule.md#retention).
     * `--start-at` — дата и время начала. Также можно указать промежуток времени относительно текущего момента. Например: `"2022-12-31T16:39:00+05:00"`, `"2h"`.
     * `--labels` — метки, указанные в формате `ключ=значение`.

     Подробнее о команде `yc compute snapshot-schedule update` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/compute/snapshot-schedule/update.md).

     Результат:

     ```text
     done (3s)
     id: fc8e52mvchb2********
     folder_id: e1ea8s8l71li********
     ...
       expression: 36 14 */1 * *
     snapshot_count: "3"
     snapshot_spec: {}
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и измените фрагмент с описанием расписания:

     {% cut "Пример описания расписания в конфигурации {{ TF }}" %}

     ```hcl
     resource "yandex_compute_snapshot_schedule" "default" {
       name = "my-name"

       schedule_policy {
         expression = "0 0 * * *"
       }

       snapshot_count = 1

       snapshot_spec {
         description = "snapshot-description"
         labels = {
           snapshot-label = "my-snapshot-label-value"
         }
       }

       disk_ids = ["test_disk_id", "another_test_disk_id"]
     }
     ```

     {% endcut %}

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить изменение расписания и его настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

  ```bash
  yc compute snapshot-schedule get <имя_расписания>
  ```

- API {#api}

  1. Получите список расписаний с помощью метода REST API [list](../../api-ref/SnapshotSchedule/list.md) для ресурса [SnapshotSchedule](../../api-ref/SnapshotSchedule/index.md) или вызова gRPC API [SnapshotScheduleService/List](../../api-ref/grpc/SnapshotSchedule/list.md).

     {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

  1. Измените расписание снимков [диска](../../concepts/disk.md) с помощью метода REST API [update](../../api-ref/SnapshotSchedule/update.md) для ресурса `SnapshotSchedule` или вызова gRPC API [SnapshotScheduleService/Update](../../api-ref/grpc/SnapshotSchedule/update.md).

{% endlist %}

## Изменить список дисков {#update-disk-list}

Чтобы изменить список дисков, снимки диска которых создаются по расписанию:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится расписание.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.switch_snapshots }}**.
  1. На вкладке **{{ ui-key.yacloud.compute.snapshots-schedules.label_title }}** выберите расписание, в котором нужно изменить список дисков.
  1. Измените список дисков:
     * Чтобы добавить новый диск, в блоке **{{ ui-key.yacloud.compute.snapshots-schedules.title_snapshot-schedule-disks }}** нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.compute.snapshots-schedules.action_attach-disk }}**. В открывшемся окне выберите диск, который нужно добавить к расписанию, и нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

       {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

     * Чтобы удалить диск, в блоке **{{ ui-key.yacloud.compute.snapshots-schedules.title_snapshot-schedule-disks }}** напротив диска, который нужно удалить из расписания, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.snapshots-schedules.action_detach-disk }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Добавьте или [удалите](#remove) диски с помощью команд `add-disks` и `remove-disks`.

  Чтобы добавить диски:
  1. Посмотрите описание команд CLI для работы с расписаниями:

     ```bash
     yc compute snapshot-schedule --help
     yc compute snapshot-schedule add-disks --help
     ```

  1. Получите список расписаний в каталоге по умолчанию:

     ```bash
     yc compute snapshot-schedule list --format yaml
     ```

     Результат:

     ```text
     - id: fc852cvb1ipd5********
       folder_id: e1ea8s8l71li********
       created_at: "2022-09-28T13:25:02Z"
     ...
         expression: 10 19 ? * *
       snapshot_count: "7"
       snapshot_spec: {}
     ```

  1. Получите идентификаторы дисков, чтобы добавить их в расписание:

     ```bash
     yc compute disk list --format yaml
     ```

     Результат:

     ```text
     - id: epdcq9g3co9s********
       folder_id: e1ea8s8l71li********
       created_at: "2022-10-13T14:37:44Z"
     ...
       instance_ids:
         - fhm1c7u23aiq********
       disk_placement_policy: {}
     ```

  1. Добавьте диски в расписание:

     ```bash
     yc compute snapshot-schedule add-disks <имя_или_идентификатор_расписания> \
       --disk-id <идентификатор_диска_1>,<идентификатор_диска_2>
     ```

     Результат:

     ```text
     done (3s)
     id: fc8e52mvchb2********
     folder_id: e1ea8s8l71li********
     ...
       expression: 36 14 */1 * *
     snapshot_count: "3"
     snapshot_spec: {}
     ```

  Чтобы удалить диски: {#remove}
  1. Посмотрите описание команд CLI для работы с расписаниями:

     ```bash
     yc compute snapshot-schedule --help
     yc compute snapshot-schedule remove-disks --help
     ```

  1. Получите список расписаний в каталоге по умолчанию:

     ```bash
     yc compute snapshot-schedule list --format yaml
     ```

     Результат:

     ```text
     - id: fc852cvb1ipd5********
       folder_id: e1ea8s8l71li********
       created_at: "2022-09-28T13:25:02Z"
     ...
         expression: 10 19 ? * *
       snapshot_count: "7"
       snapshot_spec: {}
     ```

  1. Получите список дисков в выбранном расписании:

     ```bash
     yc compute snapshot-schedule list-disks <имя_или_идентификатор_расписания> \
       --format yaml
     ```

     Результат:

     ```text
     - id: epdcq9g3co9s********
       folder_id: e1ea8s8l71li********
       created_at: "2022-10-13T14:37:44Z"
     ...
       instance_ids:
         - fhm1c7u23aiq********
       disk_placement_policy: {}
     ```

  1. Удалите диски из расписания:

     ```bash
     yc compute snapshot-schedule remove-disks <имя_или_идентификатор_расписания> \
       --disk-id <идентификатор_диска_1>,<идентификатор_диска_2>
     ```

     Результат:

     ```text
     done (3s)
     id: fc8e52mvchb2********
     folder_id: e1ea8s8l71li********
     ...
       expression: 36 14 */1 * *
     snapshot_count: "3"
     snapshot_spec: {}
     ```

- API {#api}

  1. Получите список расписаний с помощью метода REST API [list](../../api-ref/SnapshotSchedule/list.md) для ресурса [SnapshotSchedule](../../api-ref/SnapshotSchedule/index.md) или вызова gRPC API [SnapshotScheduleService/List](../../api-ref/grpc/SnapshotSchedule/list.md).
  1. Получите список дисков с помощью метода REST API [list](../../api-ref/Disk/list.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызова gRPC API [DiskService/List](../../api-ref/grpc/Disk/list.md).
  1. Измените список дисков в расписании с помощью метода REST API [updateDisks](../../api-ref/SnapshotSchedule/updateDisks.md) для ресурса `SnapshotSchedule` или вызова gRPC API [SnapshotScheduleService/UpdateDisks](../../api-ref/grpc/SnapshotSchedule/update.mdDisks).

{% endlist %}

## Примеры {#examples}

### Изменить имя расписания {#change-name}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Получите список расписаний в каталоге по умолчанию:

     ```bash
     yc compute snapshot-schedule list --format yaml
     ```

     Результат:

     ```text
     - id: fc852cvb1ipd5********
       folder_id: e1ea8s8l71li********
       created_at: "2022-09-28T13:25:02Z"
     ...
         expression: 10 19 ? * *
       snapshot_count: "7"
       snapshot_spec: {}
     ```

  1. Измените имя выбранного расписания:

     ```bash
     yc compute snapshot-schedule update sched-1 \
       --new-name "my-schedule"
     ```

     Результат:

     ```text
     done (3s)
     id: fc8e52mvchb2********
     folder_id: e1ea8s8l71li********
     ...
       expression: 36 14 */1 * *
     snapshot_count: "3"
     snapshot_spec: {}
     ```

{% endlist %}

#### Что дальше {#what-is-next}

* [{#T}](stop-and-start-schedule.md).
* [{#T}](delete-schedule.md).