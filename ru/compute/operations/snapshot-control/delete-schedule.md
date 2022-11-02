# Удалить расписание, по которому создаются снимки дисков

Чтобы удалить расписание снимков дисков:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится расписание.
  1. Выберите сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/snapshots.svg) **Снимки дисков**.
  1. Перейдите на вкладку **Расписания снимков**.
  1. Напротив расписания, которое нужно удалить, нажмите ![image](../../../_assets/options.svg) и выберите **Удалить**.
  1. Подтвердите удаление расписания.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команд CLI для работы с расписаниями:

      ```bash
      yc compute snapshot-schedule --help
      yc compute snapshot-schedule delete --help
      ```

  1. Получите список расписаний в каталоге по умолчанию:

      ```bash
      yc compute snapshot-schedule list --format yaml
      ```
      Результат:
      ```text
      - id: fc852cvb1ipd55flc7t9
        folder_id: e1ea8s8l71li5n96eakv
        created_at: "2022-09-28T13:25:02Z"
        name: sched-1
        status: ACTIVE
        schedule_policy:
          start_at: "2022-10-01T00:00:00Z"
          expression: 59 14 */1 * *
        snapshot_spec: {}
      - id: fc89n1j15l7frkrne9eo
        folder_id: e1ea8s8l71li5n96eakv
        created_at: "2022-09-27T16:04:13Z"
        name: sched-2
        status: ACTIVE
        schedule_policy:
          start_at: "1970-01-01T00:00:00Z"
          expression: 0 */1 * * *
        retention_period: 3600s
        snapshot_spec: {}
      - id: fc8bplhqmh2bnjni3lm0
        folder_id: b8gauskl78li5n96eabk
        created_at: "2022-10-03T13:28:01Z"
        name: sched-3
        description: Ежедневное
        labels:
          machine: file-server
        status: ACTIVE
        schedule_policy:
          start_at: "2022-12-31T19:04:05Z"
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

- API

  1. Получите список расписаний с помощью метода [SnapshotScheduleService/List](../../api-ref/grpc/snapshot_schedule_service.md#List) gRPC API или метода [list](../../api-ref/SnapshotSchedule/list.md) для ресурса `SnapshotSchedule` REST API.
  1. Удалите расписание снимков с помощью метода [SnapshotScheduleService/Delete](../../api-ref/grpc/snapshot_schedule_service.md#Delete) gRPC API или метода [delete](../../api-ref/SnapshotSchedule/delete.md) для ресурса `SnapshotSchedule` REST API.

{% endlist %}

Все операции по созданию и удалению снимков, начатые до удаления расписания, будут доведены до конца.
