---
title: Как создать сверхбыстрое сетевое хранилище с тремя репликами (SSD) в {{ compute-full-name }}
description: Следуя данной инструкции, вы сможете создать сверхбыстрое сетевое хранилище с тремя репликами (SSD).
---

# Создать сверхбыстрое сетевое хранилище с тремя репликами (SSD)


Вы можете создать отдельное [сверхбыстрое сетевое хранилище](../../concepts/disk.md#nr-disks) с тремя репликами (SSD) — высокопроизводительный SSD-диск, который обладает теми же скоростными характеристиками, что и нереплицируемый SSD-диск, но одновременно обеспечивает избыточность.

Размер диска должен быть кратен 93 ГБ.

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать диск.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.disks.button_create }}**.
  1. Введите имя диска. Требования к имени:
  
      {% include [name-format](../../../_includes/name-format.md) %}
  
  1. Если требуется, добавьте произвольное описание диска.
  1. Выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться диск.
  1. Укажите тип диска `{{ ui-key.yacloud.compute.value_disk-type-network-ssd-io-m3 }}`.
  1. Выберите нужный размер блока.
  1. Задайте нужный размер диска.

  1. {% include [encryption-section](../../../_includes/compute/encryption-section.md) %}
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.disks.button_create }}**.

- CLI {#cli}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для создания дисков:
  
      ```bash
      yc compute disk create --help
      ```
  
  1. Чтобы создать высокопроизводительный диск с именем `ssd-io-disk`, выполните команду:

      ```bash
      yc compute disk create \
        --name ssd-io-disk \
        --zone {{ region-id }}-a \
        --type network-ssd-io-m3 \
        --size 93G \
        --kms-key-id <идентификатор_ключа>
      ```

      Где:

      * `--name` — имя диска.
      * `--zone` — зона доступности.
      * `--type` — тип диска.
      * `--size` — размер диска.
      * `--kms-key-id` — идентификатор [симметричного ключа {{ kms-short-name }}](../../../kms/concepts/key.md) для создания зашифрованного диска. Необязательный параметр.

        {% include [encryption-role](../../../_includes/compute/encryption-role.md) %}
        
        {% include [encryption-disable-warning](../../../_includes/compute/encryption-disable-warning.md) %}

        {% include [encryption-keys-note](../../../_includes/compute/encryption-keys-note.md) %}

      Результат:

      ```text
      id: a7li08c1fd8l********
      folder_id: aoerb349fdhb********
      created_at: "2024-11-25T21:22:20Z"
      name: ssd-io-disk
      type_id: network-ssd-io-m3
      zone_id: {{ region-id }}-a
      size: "99857989632"
      block_size: "4096"
      status: READY
      disk_placement_policy: {}
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V1
      kms_key:
        key_id: abjbaqdga6hs********
        version_id: abj295dgqnlp********
      ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Disk/create.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызовом gRPC API [DiskService/Create](../../api-ref/grpc/Disk/create.md).

{% endlist %}