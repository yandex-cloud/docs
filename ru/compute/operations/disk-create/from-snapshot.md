---
title: Как восстановить диск с помощью снимка в {{ compute-full-name }}
description: Следуя данной инструкции, вы сможете восстановить диск с помощью снимка.
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
  1. На панели слева выберите ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks_ddfdb }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.disks.button_create }}**.
  1. Введите имя диска. Требования к имени:

      {% include [name-format](../../../_includes/name-format.md) %}

  1. Если требуется, укажите произвольное текстовое описание диска.
  1. Выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться диск.
  1. В поле **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** выберите `{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}` и в появившемся списке выберите нужный снимок. При необходимости воспользуйтесь фильтром.
  1. Задайте параметры диска: [тип диска](../../concepts/disk.md#disks_types), [размер диска](../../concepts/disk.md#maximum-disk-size), а также [размер блока](../../concepts/disk.md#maximum-disk-size).
  1. {% include [encryption-section](../../../_includes/compute/encryption-section.md) %}
  1. Если требуется, выберите [расписание](../../concepts/snapshot-schedule.md), по которому для диска будут автоматически создаваться снимки, или создайте его. Подробнее о настройках расписания см. в [инструкции](../snapshot-control/create-schedule.md).

      {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

      При создании диска для него можно выбрать только одно расписание снимков. После создания диска вы сможете добавить к нему еще несколько расписаний по [инструкции](../disk-control/configure-schedule.md#add-schedule).
  1. (Опционально) Разверните блок **{{ ui-key.yacloud.compute.section_additional_7yvYG }}** и в поле **{{ ui-key.yacloud.compute.hardware-generation_1iEpT }}** выберите нужное [поколение](../../concepts/hardware-generations.md#configurations) виртуализированного оборудования, которое будет закреплено за создаваемым диском:

      {% include [generation-types-console](../../../_includes/compute/generation-types-console.md) %}

      Если вы не зададите поколение оборудования, по умолчанию за диском будет закреплено то же поколение, что и за исходным снимком.

  1. Нажмите кнопку **{{ ui-key.yacloud.compute.disks.button_create }}**.

- CLI {#cli}

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания диска:

      ```bash
      yc compute disk create --help
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
      | fd84hanhvjql******** | disk-1-1668075122980 | f2ef3frbftr2******** | READY    |
      | fd85mc22cosp******** | disk-2-1669114692462 | f2ef3frbftr2******** | READY    |
      +----------------------+----------------------+----------------------+----------+
      ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного снимка.
  1. Создайте диск из выбранного снимка:

      ```bash
      yc compute disk create \
        --name <имя_диска> \
        --source-snapshot-name <имя_снимка-источника> \
        --zone <зона_доступности> \
        --description <текстовое_описание_диска> \
        --hardware-generation-id <поколение_оборудования> \
        --hardware-features pci_topology=<топология_PCI>
      ```

      Где:
      * `--name` — имя создаваемого диска. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `--source-snapshot-name` — имя снимка-источника. Вместо имени вы можете передать в команду идентификатор снимка-источника в параметре `--source-snapshot-id`.
      * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой создается диск.
      * `--description` — текстовое описание создаваемого диска. Необязательный параметр.
      * `--hardware-generation-id` — [поколение](../../concepts/hardware-generations.md#configurations) оборудования, закрепляемое за диском. Необязательный параметр. Возможные значения:

          {% include [generation-types-cli](../../../_includes/compute/generation-types-cli.md) %}

          Если параметр не задан, за диском будет закреплено то же поколение оборудования, которое закреплено за снимком-источником.
      * `--hardware-features` — дополнительные настройки для поколения `Gen 1`. Необязательный параметр. Возможные значения:

          * `pci_topology=v1` — выбор топологии `PCI_TOPOLOGY_V1`.
          * `pci_topology=v2` — выбор топологии `PCI_TOPOLOGY_V2`.


          Если за снимком-источником закреплено поколение `Gen 1`, по умолчанию у создаваемого диска для параметра `--hardware-features` будет задано то же значение, что и у снимка-источника.

      Результат:

      ```text
      done (44s)
      id: epdbnjirsai9********
      folder_id: b1gt6g8ht345********
      created_at: "2025-06-23T14:46:22Z"
      name: second-disk
      description: my second disk via yc
      type_id: network-hdd
      zone_id: {{ region-id }}-a
      size: "21474836480"
      block_size: "4096"
      product_ids:
        - f2evcrm9ti79********
      status: READY
      source_snapshot_id: fd81qi89ldop********
      disk_placement_policy: {}
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V2
      ```

      Подробнее о команде `yc compute disk create` см. в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/disk/create.md).

  1. Получите список дисков в каталоге по умолчанию:

      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

      Получите тот же список с большим количеством деталей в формате YAML:

      ```bash
      yc compute disk list --format yaml
      ```

      Результат:

      ```text
      - id: epd73ra2mrd4********
        folder_id: b1gt6g8ht345********
        created_at: "2025-06-23T16:57:01Z"
        name: first-disk
        description: my first disk
        type_id: network-hdd
        zone_id: {{ region-id }}-a
        size: "21474836480"
        block_size: "4096"
        product_ids:
          - f2evcrm9ti79********
        status: READY
        source_snapshot_id: fd81qi89ldop********
        disk_placement_policy: {}
        hardware_generation:
          legacy_features:
            pci_topology: PCI_TOPOLOGY_V1
      - id: epd8lmcncidv********
        folder_id: b1gt6g8ht345********
        created_at: "2025-06-23T06:32:26Z"
        name: second-disk
        type_id: network-ssd
        zone_id: {{ region-id }}-a
        size: "21474836480"
        block_size: "4096"
        product_ids:
          - f2evcrm9ti79********
        status: READY
        source_image_id: fd80j21lmqar********
        instance_ids:
          - epdm2ene322e********
        disk_placement_policy: {}
        hardware_generation:
          legacy_features:
            pci_topology: PCI_TOPOLOGY_V1
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурса `yandex_compute_disk`.

      Пример структуры конфигурационного файла:
     
      ```hcl
      resource "yandex_compute_disk" "my-disk" {
        name           = "<имя_диска>"
        zone           = "<зона_доступности>"
        snapshot_id    = "<идентификатор_снимка>"
        hardware_generation {
          legacy_features {
            pci_topology = "<топология_PCI>"
          }
        }
      }
      ```

      Где:
      * `name` — имя создаваемого диска. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой создается диск.
      * `snapshot_id` — идентификатор снимка, на основе которого вы создаете диск.
      * `hardware_generation` — блок настроек с описанием [поколения](../../concepts/hardware-generations.md#configurations) оборудования, закрепляемого за диском. Необязательный параметр. Включает в себя следующие блоки настроек:

          {% include [generation-types-tf](../../../_includes/compute/generation-types-tf.md) %}

          {% note info %}

          Если блок `hardware_generation` не задан, за диском будет закреплено то же поколение оборудования, которое закреплено за снимком-источником.

          {% endnote %}

      Более подробную информацию о ресурсе `yandex_compute_disk` см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_disk).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  1. Получите список снимков с помощью метода REST API [list](../../api-ref/Snapshot/list.md) для ресурса [Snapshot](../../api-ref/Snapshot/index.md) или вызова gRPC API [SnapshotService/List](../../api-ref/grpc/Snapshot/list.md).
  1. Создайте диск с помощью метода REST API [create](../../api-ref/Disk/create.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызова gRPC API [DiskService/Create](../../api-ref/grpc/Disk/create.md). В запросе укажите идентификатор снимка-источника, а также при необходимости задайте нужное [поколение](../../concepts/hardware-generations.md#configurations) оборудования в [объекте `hardwareGeneration`](../../api-ref/Disk/create.md#yandex.cloud.compute.v1.HardwareGeneration) ([`hardware_generation`](../../api-ref/grpc/Disk/create.md#yandex.cloud.compute.v1.HardwareGeneration) при использовании gRPC API).

{% endlist %}

После создания диск перейдет в статус `CREATING`. Дождитесь, когда диск перейдет в статус `READY`, прежде чем его использовать.


#### См. также {#see-also}

* [Создать ВМ с дисками из снимков](../vm-create/create-from-snapshots.md)
* [Подключить диск к ВМ и смонтировать разделы](../vm-control/vm-attach-disk.md)
* [Создать расписание снимков](../snapshot-control/create-schedule.md)
* [Шифрование в {{ compute-name }}](../../concepts/encryption.md)
* [{#T}](../../../backup/concepts/index.md)
