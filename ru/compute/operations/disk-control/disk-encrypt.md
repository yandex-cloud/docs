---
title: Как зашифровать диск в {{ compute-full-name }}
description: Следуя данной инструкции, вы сможете зашифровать диск в {{ compute-short-name }}.
---

# Зашифровать диск

{% include [encryption-role](../../../_includes/compute/encryption-role.md) %}

{% include [encryption-keys-note](../../../_includes/compute/encryption-keys-note.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. {% include [encryption-preparations](../../../_includes/compute/encryption-preparations.md) %}
  1. [Создайте](../image-create/create-from-disk.md) образ из диска, который вы хотите зашифровать.
  1. Создайте зашифрованный диск из образа:

      {% include [encryption-disk-from-image-withoutnotes](../../../_includes/compute/encryption-disk-from-image-withoutnotes.md) %}

      {% include [disk-ready](../../../_includes/compute/disk-ready.md) %}

  1. [Удалите](../image-control/delete.md) образ.
  1. [Удалите](../disk-control/delete.md) незашифрованный диск.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Создайте ключ шифрования {{ kms-full-name }}:

      ```bash
      yc kms symmetric-key create \
        --name <имя_ключа> \
        --default-algorithm aes-256 \
        --rotation-period 24h \
        --deletion-protection
      ```

      Где `--name` — имя создаваемого ключа {{ kms-name }}.

      Результат:

      ```text
      id: abj73fd9mekk********
      folder_id: b1geoelk7fld********
      created_at: "2025-05-20T17:27:35Z"
      name: my-key1
      status: ACTIVE
      primary_version:
        id: abjdno4pqi67********
        key_id: abj73fd9mekk********
        status: ACTIVE
        algorithm: AES_256
        created_at: "2025-05-20T17:27:35Z"
        primary: true
      default_algorithm: AES_256
      rotation_period: 86400s
      deletion_protection: true
      ```

  1. Получите список всех дисков в каталоге по умолчанию:

      ```bash
      yc compute disk list
      ```

      Результат:
      ```text
      +----------------------+--------------+-------------+---------------+--------+----------------------+-------------------------+
      |          ID          |     NAME     |    SIZE     |     ZONE      | STATUS |     INSTANCE IDS     |       DESCRIPTION       |
      +----------------------+--------------+-------------+---------------+--------+----------------------+-------------------------+
      | a7lqgbt0bb9s******** | first-disk   | 20401094656 | {{ region-id }}-a | READY  | a7lcvu28njbh******** |                         |
      | a7lv5j5hm1p1******** | second-disk  | 21474836480 | {{ region-id }}-a | READY  |                      |                         |
      +----------------------+--------------+-------------+---------------+--------+----------------------+-------------------------+
      ```

  1. Создайте образ из диска, который вы хотите зашифровать:

      ```bash
      yc compute image create \
        --name <имя_образа> \
        --source-disk-name <имя_незашифрованного_диска>
      ```

      Где:
      * `--name` — имя создаваемого образа.
      * `--source-disk-name` — имя незашифрованного диска, для которого создается образ.

      Результат:

      ```text
      done (9s)
      id: fd8lb5jnr2m2********
      folder_id: b1geoelk7fld********
      created_at: "2025-05-20T17:30:33Z"
      name: fromcli
      min_disk_size: "21474836480"
      status: READY
      os:
        type: LINUX
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V1
      ```

  1. Создайте зашифрованный диск из образа:

      ```bash
      yc compute disk create <имя_зашифрованного_диска> \
        --source-image-name <имя_образа> \
        --kms-key-name <имя_ключа>
      ```

      Где:
      * `--source-image-name` — имя образа для создания зашифрованного диска.
      * `--kms-key-name` — имя ключа шифрования.

      Результат:

      ```text
      done (53s)
      id: fhmihpagi991********
      folder_id: b1geoelk7fld********
      created_at: "2025-05-20T17:39:01Z"
      name: fromcliencrypted
      type_id: network-hdd
      zone_id: {{ region-id }}-a
      size: "21474836480"
      block_size: "4096"
      status: READY
      source_image_id: fd8lb5jnr2m2********
      disk_placement_policy: {}
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V1
      kms_key:
        key_id: abj73fd9mekk********
        version_id: abjdno4pqi67********
      ```

      {% include [disk-ready](../../../_includes/compute/disk-ready.md) %}

  1. Удалите образ:

      ```bash
      yc compute image delete <имя_образа>
      ```

      Результат:

      ```text
      done (15s)
      ```

  1. Удалите незашифрованный диск:

      ```bash
      yc compute disk delete <имя_незашифрованного_диска>
      ```

      Результат:

      ```text
      done (7s)
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы зашифровать диск с помощью {{ TF }}:
  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

      ```hcl
      # Создание ключа {{ kms-full-name }}

      resource "yandex_kms_symmetric_key" "my-key" {
        name                = "Encrypt key"
        default_algorithm   = "AES_256"
        rotation_period     = "8760h"
        deletion_protection = true
        lifecycle {
          prevent_destroy = true
        }
      }

      # Создание образа

      resource "yandex_compute_image" "image-1" {
        name        = "disk-image"
        source_disk = "<идентификатор_незашифрованного_диска>"
      }

      # Создание зашифрованного диска

      resource "yandex_compute_disk" "empty-disk" {
        name       = "<имя_зашифрованного_диска>"
        type       = "network-hdd"
        zone       = "{{ region-id}}-a"
        size       = 20
        block_size = 4096
        image_id   = yandex_compute_image.image-1.id
        kms_key_id = yandex_kms_symmetric_key.my-key.id
        depends_on = [yandex_compute_image.image-1]
      }
      ```

      Где:
      * `source_disk` — идентификатор незашифрованного диска.
      * `name` — имя создаваемого зашифрованного диска.

     Более подробную информацию о параметрах ресурса `yandex_compute_disk` см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_disk).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {% include [disk-ready](../../../_includes/compute/disk-ready.md) %}

  1. [Удалите](../image-control/delete.md) образ.
  1. [Удалите](../disk-control/delete.md) незашифрованный диск.


- API {#api}

  1. Создайте ключ шифрования {{ kms-full-name }} с помощью метода REST API [create](../../../kms/api-ref/SymmetricKey/create.md) для ресурса [SymmetricKey](../../../kms/api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/Create](../../../kms/api-ref/grpc/SymmetricKey/create.md).

  1. Создайте образ с помощью метода REST API [create](../../api-ref/Image/create.md) для ресурса [Image](../../api-ref/Image/index.md) или вызова gRPC API [ImageService/Create](../../api-ref/grpc/Image/create.md). В запросе укажите идентификатор диска.

      Список доступных дисков запрашивайте методом REST API [list](../../api-ref/Disk/list.md) или вызовом gRPC API [DiskService/List](../../api-ref/grpc/Disk/list.md).

  1. Создайте зашифрованный диск из образа, используя метод REST API [create](../../api-ref/Disk/create.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызов gRPC API [DiskService/Create](../../api-ref/grpc/Disk/create.md).

      {% include [disk-ready](../../../_includes/compute/disk-ready.md) %}

  1. Удалите образ с помощью метода REST API [delete](../../api-ref/Image/delete.md) для ресурса [Image](../../api-ref/Image/index.md) или вызовом gRPC API [ImageService/Delete](../../api-ref/grpc/Image/delete.md).

  1. Удалите незашифрованный диск, используя метод REST API [delete](../../api-ref/Disk/delete.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызовом gRPC API [DiskService/Delete](../../api-ref/grpc/Disk/delete.md).

{% endlist %}


#### См. также {#see-also}

* [{#T}](../../concepts/encryption.md)
* [{#T}](../image-control/encrypt.md)
* [{#T}](../snapshot-control/snapshot-encrypt.md)
