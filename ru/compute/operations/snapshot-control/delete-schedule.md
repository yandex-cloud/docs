---
title: "Как удалить расписание, по которому создаются снимки дисков в {{ compute-full-name }}"
description: "Следуя данной инструкции, вы сможете удалить расписание, по которому создаются снимки дисков."
---

# Удалить расписание, по которому создаются снимки дисков

Чтобы удалить [расписание](../../concepts/snapshot-schedule.md) [снимков дисков](../../concepts/snapshot.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится расписание.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.switch_snapshots }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.compute.snapshots-schedules.label_title }}**.
  1. Напротив расписания, которое нужно удалить, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление расписания.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команд [CLI](../../../cli/) для работы с расписаниями:

     ```bash
     yc compute snapshot-schedule --help
     yc compute snapshot-schedule delete --help
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

  1. Удалите выбранное расписание:

     ```bash
     yc compute snapshot-schedule delete <имя_или_идентификатор_расписания>
     ```

     Результат:

     ```text
     done (5s)
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием расписания:

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

  Проверить удаление расписания можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

  ```bash
  yc compute snapshot-schedule list
  ```

- API {#api}

  1. Получите список расписаний с помощью метода REST API [list](../../api-ref/SnapshotSchedule/list.md) для ресурса [SnapshotSchedule](../../api-ref/SnapshotSchedule/index.md) или вызова gRPC API [SnapshotScheduleService/List](../../api-ref/grpc/snapshot_schedule_service.md#List).
  1. Удалите расписание снимков с помощью метода REST API [delete](../../api-ref/SnapshotSchedule/delete.md) для ресурса `SnapshotSchedule` или вызова gRPC API [SnapshotScheduleService/Delete](../../api-ref/grpc/snapshot_schedule_service.md#Delete).

{% endlist %}

Все операции по созданию и удалению снимков, начатые до удаления расписания, будут доведены до конца.