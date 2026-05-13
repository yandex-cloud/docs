# Остановить и запустить расписание, по которому создаются снимки дисков

## Остановить расписание {#stop-schedule}

Чтобы остановить автоматическое создание [снимков дисков](../../concepts/snapshot.md) по [расписанию](../../concepts/snapshot-schedule.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится расписание.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/picture.svg) **Снимки дисков**.
  1. Перейдите на вкладку **Расписания снимков**.
  1. Напротив расписания, которое нужно остановить, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Остановить**.
  1. Подтвердите остановку расписания.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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
      ```text
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
      ```text
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

  1. Получите список расписаний с помощью метода REST API [list](../../api-ref/SnapshotSchedule/list.md) для ресурса [SnapshotSchedule](../../api-ref/SnapshotSchedule/index.md) или вызова gRPC API [SnapshotScheduleService/List](../../api-ref/grpc/SnapshotSchedule/list.md).
  1. Остановите расписание снимков с помощью метода REST API [disable](../../api-ref/SnapshotSchedule/disable.md) для ресурса `SnapshotSchedule` или вызова gRPC API [SnapshotScheduleService/Disable](../../api-ref/grpc/SnapshotSchedule/disable.md).

{% endlist %}

Расписание перейдет в [статус](../../concepts/snapshot-schedule.md#statuses) `INACTIVE` — снимки дисков не создаются и не удаляются. 

Все операции по созданию и удалению снимков, начатые до остановки расписания, будут доведены до конца.

## Запустить расписание {#start-schedule}

Чтобы запустить автоматическое создание снимков дисков по расписанию:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится расписание.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/picture.svg) **Снимки дисков**.
  1. Перейдите на вкладку **Расписания снимков**.
  1. Напротив расписания, которое нужно запустить, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Запустить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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
      ```text
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
      ```text
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

  1. Получите список расписаний с помощью метода REST API [list](../../api-ref/SnapshotSchedule/list.md) для ресурса [SnapshotSchedule](../../api-ref/SnapshotSchedule/index.md) или вызова gRPC API [SnapshotScheduleService/List](../../api-ref/grpc/SnapshotSchedule/list.md).
  1. Запустите расписание снимков с помощью метода REST API [enable](../../api-ref/SnapshotSchedule/enable.md) для ресурса `SnapshotSchedule` или вызова gRPC API [SnapshotScheduleService/Enable](../../api-ref/grpc/SnapshotSchedule/enable.md).

{% endlist %}

Расписание перейдет в статус `ACTIVE` — создаются новые снимки дисков и удаляются старые (если выбрана соответствующая опция в настройках [хранения снимков](../../concepts/snapshot-schedule.md#retention)). 

#### Что дальше {#what-is-next}

* [Изменить расписание, по которому создаются снимки дисков](update-schedule.md)
* [Удалить расписание, по которому создаются снимки дисков](delete-schedule.md)