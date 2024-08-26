---
title: "Как остановить и запустить расписание, по которому создаются снимки дисков {{ compute-full-name }}"
description: "Из статьи вы узнаете, как остановить и запустить расписание, по которому создаются снимки дисков {{ compute-name }}."
---

# Остановить и запустить расписание, по которому создаются снимки дисков

## Остановить расписание {#stop-schedule}

Чтобы остановить автоматическое создание [снимков дисков](../../concepts/snapshot.md) по [расписанию](../../concepts/snapshot-schedule.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится расписание.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.switch_snapshots }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.compute.snapshots-schedules.label_title }}**.
  1. Напротив расписания, которое нужно остановить, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.stop }}**.
  1. Подтвердите остановку расписания.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команд CLI для работы с расписаниями:

      ```bash
      yc compute snapshot-schedule --help
      yc compute snapshot-schedule disable --help
      ```

  1. Получите список расписаний в каталоге по умолчанию:

      ```bash
      yc compute snapshot-schedule list --format yaml
      ```
      Результат:
      ```bash
      - id: fc852cvb1ipd5********
        folder_id: e1ea8s8l71li********
        created_at: "2022-09-28T13:25:02Z"
        name: sched-1
        status: ACTIVE
        schedule_policy:
          start_at: "2022-10-01T00:00:00Z"
          expression: 59 14 */1 * *
        snapshot_spec: {}
      - id: fc89n1j15l7f********
        folder_id: e1ea8s8l71li********
        created_at: "2022-09-27T16:04:13Z"
        name: sched-2
        status: ACTIVE
        schedule_policy:
          start_at: "1970-01-01T00:00:00Z"
          expression: 0 */1 * * *
        retention_period: 3600s
        snapshot_spec: {}
      - id: fc8bplhqmh2b********
        folder_id: b8gauskl78li********
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

  1. Остановите выбранное расписание:

      ```bash
      yc compute snapshot-schedule disable <имя_или_идентификатор_расписания>
      ```
      Результат:
      ```bash
      done (3s)
      id: fc8e52mvchb2********
      folder_id: e1ea8s8l71li********
      created_at: "2022-09-28T09:15:28Z"
      name: sched-1
      status: INACTIVE
      schedule_policy:
        start_at: "1970-01-01T00:00:00Z"
        expression: 36 14 */1 * *
      snapshot_count: "3"
      snapshot_spec: {}
      ```

- API {#api}

  1. Получите список расписаний с помощью метода REST API [list](../../api-ref/SnapshotSchedule/list.md) для ресурса [SnapshotSchedule](../../api-ref/SnapshotSchedule/index.md) или вызова gRPC API [SnapshotScheduleService/List](../../api-ref/grpc/snapshot_schedule_service.md#List).
  1. Остановите расписание снимков с помощью метода REST API [disable](../../api-ref/SnapshotSchedule/disable.md) для ресурса `SnapshotSchedule` или вызова gRPC API [SnapshotScheduleService/Disable](../../api-ref/grpc/snapshot_schedule_service.md#Disable).

{% endlist %}

Расписание перейдет в [статус](../../concepts/snapshot-schedule.md#statuses) `INACTIVE` — снимки дисков не создаются и не удаляются. 

Все операции по созданию и удалению снимков, начатые до остановки расписания, будут доведены до конца.

## Запустить расписание {#start-schedule}

Чтобы запустить автоматическое создание снимков дисков по расписанию:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится расписание.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.switch_snapshots }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.compute.snapshots-schedules.label_title }}**.
  1. Напротив расписания, которое нужно запустить, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.start }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команд CLI для работы с расписаниями:

      ```bash
      yc compute snapshot-schedule --help
      yc compute snapshot-schedule enable --help
      ```

  1. Получите список расписаний в каталоге по умолчанию:

      ```bash
      yc compute snapshot-schedule list --format yaml
      ```
      Результат:
      ```bash
      - id: fc852cvb1ipd5********
        folder_id: e1ea8s8l71li********
        created_at: "2022-09-28T13:25:02Z"
        name: sched-1
        status: ACTIVE
        schedule_policy:
          start_at: "2022-10-01T00:00:00Z"
          expression: 59 14 */1 * *
        snapshot_spec: {}
      - id: fc89n1j15l7f********
        folder_id: e1ea8s8l71li********
        created_at: "2022-09-27T16:04:13Z"
        name: sched-2
        status: ACTIVE
        schedule_policy:
          start_at: "1970-01-01T00:00:00Z"
          expression: 0 */1 * * *
        retention_period: 3600s
        snapshot_spec: {}
      - id: fc8bplhqmh2b********
        folder_id: b8gauskl78li********
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

  1. Запустите выбранное расписание:

      ```bash
      yc compute snapshot-schedule enable <имя_или_идентификатор_расписания>
      ```
      Результат:
      ```bash
      done (3s)
      id: fc8e52mvchb2********
      folder_id: e1ea8s8l71li********
      created_at: "2022-09-28T09:15:28Z"
      name: sched-1
      status: ACTIVE
      schedule_policy:
        start_at: "1970-01-01T00:00:00Z"
        expression: 36 14 */1 * *
      snapshot_count: "3"
      snapshot_spec: {}
      ```

- API {#api}

  1. Получите список расписаний с помощью метода REST API [list](../../api-ref/SnapshotSchedule/list.md) для ресурса [SnapshotSchedule](../../api-ref/SnapshotSchedule/index.md) или вызова gRPC API [SnapshotScheduleService/List](../../api-ref/grpc/snapshot_schedule_service.md#List).
  1. Запустите расписание снимков с помощью метода REST API [enable](../../api-ref/SnapshotSchedule/enable.md) для ресурса `SnapshotSchedule` или вызова gRPC API [SnapshotScheduleService/Enable](../../api-ref/grpc/snapshot_schedule_service.md#Enable).

{% endlist %}

Расписание перейдет в статус `ACTIVE` — создаются новые снимки дисков и удаляются старые (если выбрана соответствующая опция в настройках [хранения снимков](../../concepts/snapshot-schedule.md#retention)). 

#### Что дальше {#what-is-next}

* [{#T}](update-schedule.md)
* [{#T}](delete-schedule.md) 
