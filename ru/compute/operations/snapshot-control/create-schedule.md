# Создать расписание, по которому будут создаваться снимки дисков

Чтобы настроить автоматическое создание [снимков дисков](../../concepts/snapshot.md) по [расписанию](../../concepts/snapshot-schedule.md):

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится диск.
  1. Выберите сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/snapshots.svg) **Снимки дисков**.
  1. На вкладке **Расписания снимков** нажмите кнопку **Создать**.
  1. Задайте параметры расписания снимков:
      * Введите имя расписания:

        {% include [name-format](../../../_includes/name-format.md) %}

      * Если требуется, укажите произвольное текстовое описание расписания.
      * Выберите диски, снимки которых нужно создавать по расписанию. В одно расписание можно добавить несколько дисков, а один диск можно добавить в несколько расписаний в пределах [лимитов](../../concepts/limits.md#compute-limits-snapshot-schedule).
      
        {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}
        
      * В поле **Создавать снимки** выберите периодичность создания снимков: **По часам**, **По дням**, **По неделям** или [**По cron-выражению**](../../concepts/snapshot-schedule.md#cron). Время создания снимка указывается в часовом поясе [UTC±00:00](https://{{ lang }}.wikipedia.org/wiki/UTC±00:00).
      * В поле **Начиная с** укажите дату, начиная с которой будет работать расписание.
      * Выберите политику хранения снимков:
        * **Хранить все снимки** — будут храниться все снимки, созданные по этому расписанию. 
        * **Только последние** — укажите количество последних снимков, которые нужно хранить, или количество дней, снимки за которые нужно хранить. Остальные снимки, созданные по этому расписанию, будут удаляться автоматически.

        {% note info %}

        На количество и суммарный объем снимков в облаке действуют [квоты](../../concepts/limits.md#compute-quotas).

        {% endnote %}

  1. Нажмите кнопку **Создать**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команд CLI для работы с расписаниями:

      ```bash
      yc compute snapshot-schedule --help
      yc compute snapshot-schedule create --help
      ```

  1. Создайте расписание с помощью [cron-выражения](../../concepts/snapshot-schedule.md#cron):

      ```bash
      yc compute snapshot-schedule create <имя_расписания> \
        --expression <cron-выражение>
      ```
      {% note info %}

      Время создания снимка указывается в часовом поясе [UTC±00:00](https://{{ lang }}.wikipedia.org/wiki/UTC±00:00).

      {% endnote %}

      Если необходимо задать политику [хранения снимков](../../concepts/snapshot-schedule.md#retention), добавьте параметр `--snapshot-count` или `--retention-period`. Например:
      * `--snapshot-count 5` — хранение последних 5 снимков.
      * `--retention-period 72h` — хранение снимков за последние 3 дня.

      Чтобы установить дату начала для расписания, используйте параметр `--start-at`. Например:
      * `--start-at "2022-12-31T16:39:00+05:00"` — начало 31 декабря 2022 г. в 16:39 UTC+5.
      * `--start-at "2h"` — начало два часа назад от текущего момента.

      Подробнее о команде `yc compute snapshot-schedule create` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/compute/snapshot-schedule/create.md).

  1. Получите идентификаторы дисков, чтобы добавить их в расписание:

      ```bash
      yc compute disk list --format yaml
      ```
      Результат:
      ```text
      - id: epdcq9g3co9se5uhmgg5
        folder_id: e1ea8s8l71li5n96eakv
        created_at: "2022-10-13T14:37:44Z"
        name: disk-2
        type_id: network-hdd
        zone_id: {{ region-id }}-b
        size: "21474836480"
        block_size: "4096"
        product_ids:
          - f2euv1kekdgvc0jrpaet
        status: READY
        source_image_id: fd88d14a6790do254kj7
        instance_ids:
          - ephothb6lppn5kn8mtom
        disk_placement_policy: {}
      - id: fhm7mip40dqh2lt2hhn2
        folder_id: e1ea8s8l71li5n96eakv
        created_at: "2022-10-10T05:00:04Z"
        name: disk-1
        type_id: network-hdd
        zone_id: {{ region-id }}-a
        size: "21474836480"
        block_size: "4096"
        product_ids:
          - f2euv1kekdgvc0jrpaet
        status: READY
        source_image_id: fd88d14a6790do254kj7
        instance_ids:
          - fhm1c7u23aiq8scvnhag
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
      id: fc8e52mvchb2dbp0pou2
      folder_id: e1ea8s8l71li5n96eakv
      created_at: "2022-09-28T09:15:28Z"
      name: sched-1
      status: ACTIVE
      schedule_policy:
        start_at: "2023-01-01T00:00:00Z"
        expression: 36 14 */1 * *
      snapshot_count: "3"
      snapshot_spec: {}
      ```

- API

  1. Получите список дисков с помощью метода [DiskService/List](../../api-ref/grpc/disk_service.md#List) gRPC API или метода [list](../../api-ref/Disk/list.md) для ресурса `Disk` REST API.

      {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

  1. Создайте расписание снимков с помощью метода [SnapshotScheduleService/Create](../../api-ref/grpc/snapshot_schedule_service.md#Create) gRPC API или метода [create](../../api-ref/SnapshotSchedule/create.md) для ресурса `SnapshotSchedule` REST API.

{% endlist %}

Снимки будут автоматически создаваться и удаляться, только пока расписание работает ([статус](../../concepts/snapshot-schedule.md#statuses) `ACTIVE`).

## Примеры {#examples}

### Снимки создаются каждый день {#daily}

{% list tabs %}

- CLI

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
      - id: epdcq9g3co9se5uhmgg5
        folder_id: e1ea8s8l71li5n96eakv
        created_at: "2022-10-13T14:37:44Z"
        name: disk-2
        type_id: network-hdd
        zone_id: {{ region-id }}-b
        size: "21474836480"
        block_size: "4096"
        product_ids:
          - f2euv1kekdgvc0jrpaet
        status: READY
        source_image_id: fd88d14a6790do254kj7
        instance_ids:
          - ephothb6lppn5kn8mtom
        disk_placement_policy: {}
      - id: fhm7mip40dqh2lt2hhn2
        folder_id: e1ea8s8l71li5n96eakv
        created_at: "2022-10-10T05:00:04Z"
        name: disk-1
        type_id: network-hdd
        zone_id: {{ region-id }}-a
        size: "21474836480"
        block_size: "4096"
        product_ids:
          - f2euv1kekdgvc0jrpaet
        status: READY
        source_image_id: fd88d14a6790do254kj7
        instance_ids:
          - fhm1c7u23aiq8scvnhag
        disk_placement_policy: {}
      ```

      ```bash
      yc compute disk list
      ```

  1. Добавьте диски в расписание:

      ```bash
      yc compute snapshot-schedule add-disks sched-1 \
        --disk-id epdcq9g3co9se5uhmgg5,fhm7mip40dqh2lt2hhn2
      ```
      Результат:
      ```text
      done (3s)
      id: fc8bplhqmh2bnjni3lm0
      folder_id: e1ea8s8l71li5n96eakv
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

#### См. также {#see-also}

* [{#T}](stop-and-start-schedule.md)
* [{#T}](update-schedule.md)
* [{#T}](delete-schedule.md) 
* [Создать снимок диска вручную](../disk-control/create-snapshot.md)
