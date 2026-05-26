---
title: Как создать расписание, по которому будут создаваться снимки дисков {{ compute-full-name }}
description: Из статьи вы узнаете, как создать расписание, по которому будут создаваться снимки дисков {{ compute-name }}.
---

# Создать расписание, по которому будут создаваться снимки дисков


## Настроить автоматическое создание снимков дисков по расписанию {#set-schedule}

Чтобы настроить автоматическое создание [снимков дисков](../../concepts/snapshot.md) по [расписанию](../../concepts/snapshot-schedule.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [диск](../../concepts/disk.md).
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.snapshots_81jHX }}**.
  1. На вкладке **{{ ui-key.yacloud.compute.snapshots-schedules.label_title }}** нажмите **{{ ui-key.yacloud.compute.snapshots-schedules.button_create-snapshot-schedule }}**.
  1. {% include [section-schedule](../../_includes_service/schedule/section-schedule.md) %}
  1. {% include [section-storage](../../_includes_service/schedule/section-storage.md) %}
  1. {% include [section-general](../../_includes_service/schedule/section-general.md) %}
  1. {% include [section-snapshot](../../_includes_service/schedule/section-snapshot.md) %}
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.
      Дождитесь создания расписания.

  1. На открывшейся странице в блоке **{{ ui-key.yacloud.compute.snapshots-schedules.title_snapshot-schedule-disks }}** нажмите **{{ ui-key.yacloud.compute.snapshots-schedules.action_attach-disk }}**. В открывшемся окне выберите диск, который нужно добавить к расписанию, и нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команд [CLI](../../../cli/) для работы с расписаниями:

     ```bash
     yc compute snapshot-schedule --help
     yc compute snapshot-schedule create --help
     ```

  1. Создайте расписание:

     ```bash
     yc compute snapshot-schedule create <имя_расписания> \
       --expression "<cron-выражение>" \
       --start-at "<дата_и_время_начала>" \
       --retention-period "<срок_хранения_снимков>" \
       --description "<описание_расписания>" \
       --labels "<метки_расписания>" \
       --snapshot-description "<описание_снимка>" \
       --snapshot-labels "<метки_снимка>"
     ```

     Где:
     * `--expression` — [cron-выражение](../../concepts/snapshot-schedule.md#cron). Обязательный параметр.
     * `--start-at` — дата и время начала расписания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
     * `--retention-period` — срок хранения снимков. Указывается в формате длительности, например: `300ms`, `1.5h` или `2h45m`. Используйте либо `--retention-period`, либо `--snapshot-count`.
     * `--snapshot-count` — максимальное количество снимков для каждого [диска](../../concepts/disk.md). Используйте либо `--snapshot-count`, либо `--retention-period`.
     * `--description` — описание расписания.
     * `--labels` — [метки](../../../overview/concepts/services.md#labels) расписания в формате `ключ=значение`.
     * `--snapshot-description` — описание снимка.
     * `--snapshot-labels` — метки снимка в формате `ключ=значение`.

     Результат:

     ```text
     id: fd8uhc5qcinv********
     folder_id: b1g681qpemb4********
     created_at: "2026-05-25T21:03:22Z"
     name: my-schedule
     description: for my disks
     status: ACTIVE
     schedule_policy:
       start_at: "2027-01-02T15:04:05Z"
       expression: 30 0 * * *
     retention_period: 3600s
     snapshot_spec:
       description: my snapshot
     ```

     {% note info %}

     Время создания снимка указывается в часовом поясе [UTC±00:00](https://{{ lang }}.wikipedia.org/wiki/UTC±00:00).

     {% endnote %}

     Подробнее о команде `yc compute snapshot-schedule create` в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/snapshot-schedule/create.md).
  1. Получите идентификаторы [дисков](../../concepts/disk.md), чтобы добавить их в расписание:

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

     {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

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

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурса, который необходимо создать:

     ```hcl
     resource "yandex_compute_snapshot_schedule" "default" {
       schedule_policy {
         expression = "<cron-выражение>"
         start_at   = "<дата_и_время_начала>"
       }

       retention_period = "<срок_хранения_снимков>"
       name             = "<название_расписания>"
       description      = "<описание_расписания>"
       labels           = {
         <ключ_метки_расписания> = "<значение_метки_расписания>"
       }

       snapshot_spec {
         description = "<описание_снимка>"
         labels      = {
           <ключ_метки_снимка> = "<значение_метки_снимка>"
         }
       }

       disk_ids = ["<идентификатор_диска_1>", "<идентификатор_диска_2>"]
     }
     ```

     Где:
     * `schedule_policy` — параметры расписания:
       * `expression` — [cron-выражение](../../concepts/snapshot-schedule.md#cron). Обязательный параметр.
       * `start_at` — дата и время в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt), с которого будет работать расписание.
     * `retention_period` — срок хранения снимков. Указывается в формате длительности, например: `"300ms"`, `"1.5h"` или `"2h45m"`. Остальные снимки, созданные по этому расписанию, будут удаляться автоматически. Используйте либо `retention_period`, либо `snapshot_count`.
     * `snapshot_count` — максимальное количество снимков для каждого [диска](../../concepts/disk.md). Используйте либо `snapshot_count`, либо `retention_period`.

        {% note info %}

        На количество и суммарный объем снимков в облаке действуют [квоты](../../concepts/limits.md#compute-quotas).

        {% endnote %}

     * `name` — имя расписания в формате:

        {% include [name-format](../../../_includes/name-format.md) %}

     * `description` — описание расписания.
     * `labels` — [метки](../../../overview/concepts/services.md#labels) расписания в формате `<ключ> = "<значение>"`.
     * `snapshot_spec` — параметры снимков, которые будут созданы по этому расписанию:
        * `description` — описание снимка.
        * `labels` — метки снимка в формате `<ключ> = "<значение>"`.

     * `disk_ids` — идентификаторы дисков, для которых будут создаваться снимки.

     {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

     Подробнее о параметрах ресурса `yandex_compute_snapshot_schedule` в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/compute_snapshot_schedule).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  После этого в указанном каталоге будет создано расписание. Проверить появление расписания и его настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

  ```bash
  yc compute snapshot-schedule get <имя_расписания>
  ```

- API {#api}

  1. Получите список дисков с помощью метода REST API [list](../../api-ref/Disk/list.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызова gRPC API [DiskService/List](../../api-ref/grpc/Disk/list.md).

     {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

  1. Создайте расписание снимков с помощью метода REST API [create](../../api-ref/SnapshotSchedule/create.md) для ресурса [SnapshotSchedule](../../api-ref/SnapshotSchedule/index.md) или вызова gRPC API [SnapshotScheduleService/Create](../../api-ref/grpc/SnapshotSchedule/create.md).

{% endlist %}

Снимки будут автоматически создаваться и удаляться, только пока расписание работает ([статус](../../concepts/snapshot-schedule.md#statuses) `ACTIVE`).

## Примеры {#examples}

### Снимки создаются каждый день {#daily}

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы настроить ежедневное создание снимков:
  1. Создайте расписание с помощью [cron-выражения](../../concepts/snapshot-schedule.md#cron):

     ```bash
     yc compute snapshot-schedule create sched-1 \
       --description "Ежедневное" \
       --expression "10 16 ? * *" \
       --start-at "2022-12-31T19:04:05+03:00" \
       --snapshot-count 7 \
       --labels "machine=file-server"
     ```

     В результате будет создано расписание:
     * С именем `sched-1` и описанием `Ежедневное`.
     * С созданием снимков каждый день в 19:10 по МСК.
     * С датой начала 31 декабря 2022 г. 19:04 по МСК.
     * С сохранением последних семи снимков.
     * С меткой `machine` и значением метки `file-server`.
  1. Получите идентификаторы дисков, чтобы добавить их в расписание:

     ```bash
     yc compute disk list --format yaml
     ```

     Результат:

     ```text
     - id: epdcq9g3co9s********
       folder_id: e1ea8s8l71li********
       created_at: "2022-10-13T14:37:44Z"
       name: disk-2
       type_id: network-hdd
       zone_id: {{ region-id }}-a
       size: "21474836480"
       block_size: "4096"
       product_ids:
         - f2euv1kekdgv********
       status: READY
       source_image_id: fd88d14a6790********
       instance_ids:
         - ephothb6lppn********
       disk_placement_policy: {}
     - id: fhm7mip40dqh********
       folder_id: e1ea8s8l71li********
       created_at: "2022-10-10T05:00:04Z"
       name: disk-1
       type_id: network-hdd
       zone_id: {{ region-id }}-a
       size: "21474836480"
       block_size: "4096"
       product_ids:
         - f2euv1kekdgv********
       status: READY
       source_image_id: fd88d14a6790********
       instance_ids:
         - fhm1c7u23aiq********
       disk_placement_policy: {}
      ```

  1. Добавьте диски в расписание:

     ```bash
     yc compute snapshot-schedule add-disks sched-1 \
       --disk-id epdcq9g3co9s********,fhm7mip40dqh********
     ```

     Результат:

     ```text
     done (3s)
     id: fc8bplhqmh2b********
     folder_id: e1ea8s8l71li********
     created_at: "2022-10-03T13:28:01Z"
     name: sched-1
     description: Ежедневное
     labels:
       machine: file-server
     status: ACTIVE
     schedule_policy:
       start_at: "2022-12-31T16:04:05Z"
       expression: 10 16 ? * *
     snapshot_count: "7"
     snapshot_spec: {}
     ```

{% endlist %}

#### Смотрите также {#see-also}

* [{#T}](stop-and-start-schedule.md).
* [{#T}](update-schedule.md).
* [{#T}](delete-schedule.md).
* [Создать снимок диска вручную](../disk-control/create-snapshot.md).
