# Восстановить диск с помощью образа

{% note info %}

{% include [boot-disk-recover](../../../_includes/compute/boot-disk-recover.md) %}

{% endnote %}

Чтобы создать диск из [образа](../../concepts/image.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать диск.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.disks.button_create }}**.
  1. Введите имя диска.

      {% include [name-format](../../../_includes/name-format.md) %}

  1. Если требуется, укажите произвольное текстовое описание диска.
  1. Выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться диск.
  1. Задайте параметры диска: [тип диска](../../concepts/disk.md#disks_types), а также [размер блока](../../concepts/disk.md#maximum-disk-size) и [размер диска](../../concepts/disk.md#maximum-disk-size).
  1. В поле **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** выберите `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` и в списке ниже отметьте нужный образ. Для поиска образа воспользуйтесь фильтром.

  
  1. {% include [encryption-section-without-sa](../../../_includes/compute/encryption-section-without-sa.md) %}


  1. Если требуется, выберите [расписание](../../concepts/snapshot-schedule.md), по которому для диска будут автоматически создаваться снимки, или создайте его. Подробнее о настройках расписания см. в [инструкции](../snapshot-control/create-schedule.md).

     {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

     При создании диска для него можно выбрать только одно расписание снимков. После создания диска вы сможете добавить к нему еще несколько расписаний по [инструкции](../disk-control/configure-schedule.md#add-schedule).
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.disks.button_create }}**.

- CLI {#cli}

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команд CLI для работы с дисками и образами:

      ```bash
      yc compute disk create --help
      yc compute image --help
      ```

  1. Получите список образов в каталоге по умолчанию:

      ```bash
      yc compute image list
      ```

      Результат:
      ```text
      +----------------------+------------+--------+----------------------+--------+
      |          ID          |    NAME    | FAMILY |     PRODUCT IDS      | STATUS |
      +----------------------+------------+--------+----------------------+--------+
      | fd8ool134m70******** | test-image |        | f2e3eaei7io3******** | READY  |
      | fd8u2d7plgpu******** | image-2    |        |                      | READY  |
      +----------------------+------------+--------+----------------------+--------+
      ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного образа.

  1. Создайте диск из выбранного образа:

      ```bash
      yc compute disk create <имя_диска> \
        --source-image-name <имя_снимка> \
        --description <текстовое_описание_диска>
      ```
      Указать образ можно с помощью параметра `--source-image-name` или `--source-image-id`.

      Подробнее о команде `yc compute disk create` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/compute/disk/create.md).

  1. Получите список дисков в каталоге по умолчанию:

      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

      Получите тот же список с большим количеством деталей в формате YAML:

      ```bash
      yc compute disk list --format yaml
      ```

      Результат:
      ```yaml
      - id: fhm4aq4hvq5g********
          folder_id: b1gm3og7ei7a********
          created_at: "2018-10-29T07:43:06Z"
          name: first-disk
          description: my first disk via yc
          type_id: network-hdd
          zone_id: {{ region-id }}-a
          size: "10737418240"
          status: READY
      - id: fhmo6rdqg5fo********
          folder_id: b1gm3og7ei7a********
          created_at: "2018-10-29T07:33:04Z"
          name: second-disk
          description: my second disk via yc
          type_id: network-hdd
          zone_id: {{ region-id }}-a
          size: "8589934592"
          product_ids:
          - f2en2dtd08b5********
          status: READY
          source_image_id: fdvk34al8k5n********
          instance_ids:
          - fhm5b617fjnj********
      ```

- API {#api}

  1. Получите список образов с помощью метода [ImageService/List](../../api-ref/grpc/image_service.md#List) gRPC API или метода [list](../../api-ref/Image/list.md) ресурса `Image` REST API.
  1. Создайте диск с помощью метода [DiskService/Create](../../api-ref/grpc/disk_service.md#Create) gRPC API или метода [create](../../api-ref/Disk/create.md) ресурса `Disk` REST API. В запросе укажите идентификатор образа.

{% endlist %}

После создания диск перейдет в статус `CREATING`. Дождитесь, когда диск перейдет в статус `READY`, прежде чем его использовать.

#### См. также {#see-also}

* [Создать ВМ из пользовательского образа](../vm-create/create-from-user-image.md)
* [Подключить диск к ВМ и смонтировать разделы](../vm-control/vm-attach-disk.md)
* [{#T}](../../../backup/concepts/index.md)
