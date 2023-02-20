# Настроить создание снимков диска по расписаниям

Вы можете настроить для диска [расписания](../../concepts/snapshot-schedule.md), по которым будут создаваться [снимки](../../concepts/snapshot.md):

* [{#T}](#add-schedule).
* [{#T}](#remove-schedule).

## Добавить расписание к диску {#add-schedule}

{% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится диск.
  1. Выберите сервис **{{ compute-name }}**.
  1. Откройте вкладку ![image](../../../_assets/compute/disks-pic.svg) **Диски** и выберите диск.
  1. В разделе **Расписания снимков** нажмите ![image](../../../_assets/plus.svg) **Добавить расписание**.
  1. Выберите расписание или создайте новое. Подробнее о настройках расписания см. в [инструкции](../snapshot-control/create-schedule.md).
  1. Нажмите **Сохранить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

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
      Подробнее о команде `yc compute disk list` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/compute/disk/list.md).

      Чтобы получить список дисков, привязанных к отдельному расписанию, можно также воспользоваться командой:

      ```bash
      yc compute snapshot-schedule list-disks <имя_или_идентификатор_расписания>
      ```
      См. [подробнее](../../../cli/cli-ref/managed-services/compute/snapshot-schedule/list-disks.md).

  1. Получите имя и идентификатор расписания:

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

      Если у вас еще нет расписаний, [создайте](../snapshot-control/create-schedule.md) новое.

  1. Добавьте один или несколько дисков в расписание:

      ```bash
      yc compute snapshot-schedule add-disks <имя_или_идентификатор_расписания> \
        --disk-id <идентификатор_диска_1>,<идентификатор_диска_2>
      ```
      Результат:
      ```text
      done (3s)
      id: fc8e52mvchb2dbp0pou2
      folder_id: e1iaui8l7klihn96gabc
      created_at: "2022-09-28T09:15:28Z"
      name: sched-1
      status: ACTIVE
      ```

{% endlist %}

## Отвязать расписание от диска {#remove-schedule}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится диск.
  1. Выберите сервис **{{ compute-name }}**.
  1. Откройте вкладку ![image](../../../_assets/compute/disks-pic.svg) **Диски** и выберите диск.
  1. В разделе **Расписания снимков** в строке с расписанием нажмите кнопку ![image](../../../_assets/horizontal-ellipsis.svg) и выберите **Отвязать от диска**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

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
        folder_id: e1ea8s8l71li5n96eakv
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
          - epdothb6lppn5kn8mtom
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
          - fhm1c7u23aiq8scvnbag
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
      id: fc8e52mvchb2dbp0pou2
      folder_id: e1ea8s8l71li5n96eakv
      created_at: "2022-09-28T09:15:28Z"
      name: sched-1
      status: ACTIVE
      ```


{% endlist %}


#### См. также {#see-also}

* [{#T}](../snapshot-control/create-schedule.md)
* [Изменить список дисков в расписании снимков](../snapshot-control/update-schedule.md#update-disk-list)
* [Создать снимок диска вручную](../disk-control/create-snapshot.md)
