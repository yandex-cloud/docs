---
title: "Восстановить диск с помощью снимка"
description: "Следуя данной инструкции, вы сможете восстановить диск с помощью снимка."
---

# Восстановить диск с помощью снимка

{% note info %}

{% include [boot-disk-recover](../../../_includes/compute/boot-disk-recover.md) %}

{% endnote %}

Чтобы создать диск из [снимка](../../concepts/snapshot.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать диск.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/disks-pic.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.disks.button_create }}**.
  1. Введите имя диска. Требования к имени:

      {% include [name-format](../../../_includes/name-format.md) %}

  1. Если требуется, укажите произвольное текстовое описание диска.
  1. Выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться диск.
  1. Задайте параметры диска: [тип диска](../../concepts/disk.md#disks_types), а также [размер блока](../../concepts/disk.md#maximum-disk-size) и [размер диска](../../concepts/disk.md#maximum-disk-size).
  1. В поле **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** выберите `{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}` и в списке ниже отметьте нужный снимок. Для поиска снимка воспользуйтесь фильтром.
  1. Если требуется, выберите [расписание](../../concepts/snapshot-schedule.md), по которому для диска будут автоматически создаваться снимки, или создайте его. Подробнее о настройках расписания см. в [инструкции](../snapshot-control/create-schedule.md).

     {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

     При создании диска для него можно выбрать только одно расписание снимков. После создания диска вы сможете добавить к нему еще несколько расписаний по [инструкции](../disk-control/configure-schedule.md#add-schedule).

  1. Нажмите кнопку **{{ ui-key.yacloud.compute.disks.button_create }}**.

- CLI {#cli}

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команд CLI для работы с дисками и снимками дисков:

      ```bash
      yc compute disk create --help
      yc compute snapshot --help
      ```

  1. Получите список снимков в каталоге по умолчанию:

      ```bash
      yc compute snapshot list
      ```
      Результат:
      ```text
      +----------------------+----------------------+----------------------+----------+
      |          ID          |         NAME         |     PRODUCT IDS      |  STATUS  |
      +----------------------+----------------------+----------------------+----------+
      | fd84hanhvjqljepbgqr4 | disk-1-1668075122980 | f2ef3frbftr2f3hq3uji | READY    |
      | fd85mc22cospn62qq5dg | disk-2-1669114692462 | f2ef3frbftr2f3hq3uji | READY    |
      +----------------------+----------------------+----------------------+----------+
      ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного снимка.

  1. Создайте диск из выбранного снимка:

      ```bash
      yc compute disk create <имя_диска> \
        --source-snapshot-name <имя_снимка> \
        --description <текстовое_описание_диска>
      ```
      Указать снимок можно с помощью параметра `--source-snapshot-name` или `--source-snapshot-id`.

      Подробнее о команде `yc compute disk create` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/compute/disk/create.md).

  1. Получите список дисков в каталоге по умолчанию:

      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

      Получите тот же список с большим количеством деталей в формате YAML:

      ```bash
      yc compute disk list --format yaml
      ```

      Результат:
      ```yaml
      - id: fhm4aq4hvq5g3nepvt9b
          folder_id: b1gm3og7ei7aegv8i73m
          created_at: "2018-10-29T07:43:06Z"
          name: first-disk
          description: my first disk via yc
          type_id: network-hdd
          zone_id: {{ region-id }}-a
          size: "10737418240"
          status: READY
      - id: fhmo6rdqg5folrc3lsaf
          folder_id: b1gm3og7ei7aegv8i73m
          created_at: "2018-10-29T07:33:04Z"
          name: second-disk
          description: my second disk via yc
          type_id: network-hdd
          zone_id: {{ region-id }}-a
          size: "8589934592"
          product_ids:
          - f2en2dtd08b5la74mlde
          status: READY
          source_image_id: fdvk34al8k5nltb58shr
          instance_ids:
          - fhm5b617fjnj44ovhcun
      ```

- API {#api}

  1. Получите список снимков с помощью метода [SnapshotService/List](../../api-ref/grpc/snapshot_service.md#List) gRPC API или метода [list](../../api-ref/Snapshot/list.md) ресурса `Snapshot` REST API.
  1. Создайте диск с помощью метода [DiskService/Create](../../api-ref/grpc/disk_service.md#Create) gRPC API или метода [create](../../api-ref/Disk/create.md) ресурса `Disk` REST API. В запросе укажите идентификатор снимка.

{% endlist %}

После создания диск перейдет в статус `CREATING`. Дождитесь, когда диск перейдет в статус `READY`, прежде чем его использовать.

#### См. также {#see-also}

* [Создать ВМ с дисками из снимков](../vm-create/create-from-snapshots.md)
* [Подключить диск к ВМ и смонтировать разделы](../vm-control/vm-attach-disk.md)
* [Создать расписание снимков](../snapshot-control/create-schedule.md)
* [{#T}](../../../backup/concepts/index.md)
