[Документация Yandex Cloud](../../../index.md) > [Yandex Compute Cloud](../../index.md) > [Пошаговые инструкции](../index.md) > Управление диском > Настроить создание снимков диска по расписаниям

# Настроить создание снимков диска по расписаниям


Вы можете настроить для диска [расписания](../../concepts/snapshot-schedule.md), по которым будут создаваться [снимки](../../concepts/snapshot.md):

* [Добавить расписание к диску](#add-schedule).
* [Отвязать расписание от диска](#remove-schedule).

## Добавить расписание к диску {#add-schedule}

Создавать можно снимки сетевых [дисков](../../concepts/disk.md#disks_types) HDD, SSD и нереплицируемых SSD, а также сверхбыстрых сетевых хранилищ с тремя репликами (SSD).

Для нереплицируемых SSD и сверхбыстрых сетевых хранилищ с тремя репликами (SSD) момент времени, когда фиксируется содержимое диска, не детерминирован.

Для снимков с локальных дисков на [выделенных хостах](../../concepts/dedicated-host.md) используйте сервис [Yandex Cloud Backup](../../../backup/index.md) (поддерживает ОС Ubuntu, CentOS, CentOS Stream и Windows Server).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится диск.
  1. Перейдите в сервис **Compute Cloud**.
  1. Откройте вкладку ![image](../../../_assets/console-icons/hard-drive.svg) **Диски** и выберите диск.
  1. В блоке **Расписания снимков** нажмите ![image](../../../_assets/console-icons/plus.svg) **Настроить расписания снимков**.
  1. Выберите расписание или создайте новое. Подробнее о настройках расписания читайте в [инструкции](../snapshot-control/create-schedule.md).
  1. Нажмите **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команд CLI для работы с дисками и расписаниями:

      ```bash
      yc compute disk --help
      yc compute snapshot-schedule --help
      ```

  1. Получите идентификаторы дисков в каталоге по умолчанию:

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
        zone_id: ru-central1-a
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
        zone_id: ru-central1-a
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
      Подробнее о команде `yc compute disk list` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/disk/list.md).

      Чтобы получить список дисков, привязанных к отдельному расписанию, можно также воспользоваться командой:

      ```bash
      yc compute snapshot-schedule list-disks <имя_или_идентификатор_расписания>
      ```
      [Подробнее](../../../cli/cli-ref/compute/cli-ref/snapshot-schedule/list-disks.md).

  1. Получите имя и идентификатор расписания:

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

      Если у вас еще нет расписаний, [создайте](../snapshot-control/create-schedule.md) новое.

  1. Добавьте один или несколько дисков в расписание:

      ```bash
      yc compute snapshot-schedule add-disks <имя_или_идентификатор_расписания> \
        --disk-id <идентификатор_диска_1>,<идентификатор_диска_2>
      ```
      Результат:
      ```text
      done (3s)
      id: fc8e52mvchb2********
      folder_id: e1iaui8l7kli********
      created_at: "2022-09-28T09:15:28Z"
      name: sched-1
      status: ACTIVE
      ```

{% endlist %}

## Отвязать расписание от диска {#remove-schedule}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится диск.
  1. Перейдите в сервис **Compute Cloud**.
  1. Откройте вкладку ![image](../../../_assets/console-icons/hard-drive.svg) **Диски** и выберите диск.
  1. В блоке **Расписания снимков** в строке с расписанием нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Отвязать от диска**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команд CLI для работы с дисками и расписаниями:

      ```bash
      yc compute disk --help
      yc compute snapshot-schedule --help
      ```

  1. Получите имя и идентификатор расписания:

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
        folder_id: e1ea8s8l71li********
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
        name: disk-2
        type_id: network-hdd
        zone_id: ru-central1-a
        size: "21474836480"
        block_size: "4096"
        product_ids:
          - f2euv1kekdgv********
        status: READY
        source_image_id: fd88d14a6790********
        instance_ids:
          - epdothb6lppn********
        disk_placement_policy: {}
      - id: fhm7mip40dqh********
        folder_id: e1ea8s8l71li********
        created_at: "2022-10-10T05:00:04Z"
        name: disk-1
        type_id: network-hdd
        zone_id: ru-central1-a
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

  1. Удалите один или несколько дисков из расписания:

      ```bash
      yc compute snapshot-schedule remove-disks <имя_или_идентификатор_расписания> \
        --disk-id <идентификатор_диска_1>,<идентификатор_диска_2>
      ```
      Результат:
      ```text
      done (3s)
      id: fc8e52mvchb2********
      folder_id: e1ea8s8l71li********
      created_at: "2022-09-28T09:15:28Z"
      name: sched-1
      status: ACTIVE
      ```


{% endlist %}


#### Полезные ссылки {#see-also}

* [Создать расписание, по которому будут создаваться снимки дисков](../snapshot-control/create-schedule.md)
* [Изменить список дисков в расписании снимков](../snapshot-control/update-schedule.md#update-disk-list)
* [Создать снимок диска вручную](create-snapshot.md)