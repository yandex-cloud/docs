---
title: "Как получить информацию о расписании, по которому создаются снимки дисков в {{ compute-full-name }}"
---

# Получить информацию о расписании, по которому создаются снимки дисков

{% list tabs %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [расписание](../../concepts/snapshot-schedule.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.switch_snapshots }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.compute.snapshots-schedules.label_title }}**.
  1. Выберите нужное расписание.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о расписании снимков дисков.

- CLI

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о расписании:

      ```bash
      yc compute snapshot-schedule get --help
      ```

  1. Получите информацию о расписании, указав его имя или идентификатор:

      ```bash
      yc compute snapshot-schedule get <имя_расписания>
      ```

      Результат:

      ```bash
      id: fd8cc5qd25cp********
      folder_id: b1gmit33ngp3********
      created_at: "2023-10-30T14:53:33Z"
      name: schedule-1
      status: ACTIVE
      schedule_policy:
        start_at: "2023-10-30T14:00:51Z"
        expression: 0 10 */1 * *
      snapshot_count: "2"
      snapshot_spec: {}
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы получить информацию о [расписании снимков дисков](../../concepts/snapshot-schedule.md) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

      ```hcl
      data "yandex_compute_snapshot_schedule" "snapshot_schedule" {
        snapshot_schedule_id = "<идентификатор_расписания>"
      }

      output "snapshot_schedule" {
        value = data.yandex_compute_snapshot_schedule.snapshot_schedule.status
      }
      ```

      Где:

      * `data "yandex_compute_snapshot_schedule"` — описание расписания снимков дисков в качестве источника данных:
        * `snapshot_schedule_id` — идентификатор расписания снимков дисков.
      * `output "snapshot_schedule"` — выходная переменная, которая содержит информацию о расписании снимков дисков:
        * `value` — возвращаемое значение.

      Вместо `status` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_compute_snapshot_schedule` см. в [документации провайдера]({{ tf-provider-datasources-link }}/datasource_compute_snapshot_schedule).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```bash
      snapshot_schedule = "inactive"
      ```

- API {#api}

  Чтобы получить подробную информацию о [расписании снимков дисков](../../concepts/snapshot-schedule.md), воспользуйтесь методом REST API [get](../../api-ref/SnapshotSchedule/get.md) для ресурса [SnapshotSchedule](../../api-ref/SnapshotSchedule/index.md), или вызовом gRPC API [SnapshotScheduleService/Get](../../api-ref/grpc/snapshot_schedule_service.md#Get).

{% endlist %}