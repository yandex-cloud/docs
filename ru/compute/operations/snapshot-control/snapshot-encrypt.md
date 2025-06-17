---
title: Зашифровать снимок
description: Следуя данной инструкции, вы сможете зашифровать снимок.
---

# Зашифровать снимок

{% include [encryption-keys-note](../../../_includes/compute/encryption-keys-note.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. {% include [encryption-preparations](../../../_includes/compute/encryption-preparations.md) %}
  1. Создайте зашифрованный диск из снимка, который вы хотите зашифровать:

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать зашифрованный диск.
      1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. На панели слева выберите ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks.label_title }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.compute.disks.button_create }}**.
      1. Введите имя диска.

          {% include [name-format](../../../_includes/name-format.md) %}

      1. Выберите ту же [зону доступности](../../../overview/concepts/geo-scope.md), в которой находился исходный диск.
      1. Задайте параметры диска: [тип диска](../../../compute/concepts/disk.md#disks_types), а также [размер блока](../../../compute/concepts/disk.md#maximum-disk-size) и [размер диска](../../../compute/concepts/disk.md#maximum-disk-size).
      1. В поле **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** выберите `{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}` и в списке ниже отметьте снимок, который создали ранее. Для поиска снимка воспользуйтесь фильтром.
      1. В блоке **{{ ui-key.yacloud.compute.disk-form.section_encryption }}** включите опцию **{{ ui-key.yacloud.compute.disk-form.label_disk-encryption }}** и в поле **{{ ui-key.yacloud.compute.disk-form.label_disk-kms-key }}** выберите [ключ](../../../kms/concepts/key.md), созданный ранее.

      1. Нажмите кнопку **{{ ui-key.yacloud.compute.disks.button_create }}**.

      {% include [disk-ready](../../../_includes/compute/disk-ready.md) %}

  1. [Создайте](../disk-control/create-snapshot.md) снимок из зашифрованного диска, созданного ранее.
  1. [Удалите](../disk-control/delete.md) зашифрованный диск.
  1. [Удалите](delete.md) исходный снимок.

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

      Где:
      * `--name` — имя создаваемого ключа {{ kms-name }}.

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

  1. Получите список всех снимков в каталоге по умолчанию:

      ```bash
      yc compute snapshot list
      ```

      Результат:
      ```text
      +----------------------+-----------------------+----------------------+----------+
      |          ID          |         NAME          |     PRODUCT IDS      |  STATUS  |
      +----------------------+-----------------------+----------------------+----------+
      | fd823vsvcmop******** | snap-ubuntu-24-04-lts | f2etq3erab3o******** | READY    |
      | fd8p8l3asgud******** | snap-debian-2025      | f2etq3erab3o******** | READY    |
      +----------------------+-----------------------+----------------------+----------+
      ```

  1. Создайте зашифрованный диск из снимка, который вы хотите зашифровать:

      ```bash
      yc compute disk create <имя_зашифрованного_диска> \
        --source-snapshot-name <имя_снимка> \
        --kms-key-name <имя_ключа>
      ```

      Где:
      * `--source-snapshot-name` — имя снимка для создания зашифрованного диска.
      * `--kms-key-name` — имя ключа шифрования.

      Результат:

      ```text
      done (53s)
      id: fhmihpagi991amj4m7h3
      folder_id: b1geoelk7fld********
      created_at: "2025-05-20T17:39:01Z"
      name: fromcliencrypte
      type_id: network-hdd
      zone_id: ru-central1-a
      size: "21474836480"
      block_size: "4096"
      status: READY
      source_snapshot_id: fd8lb5jnr2m2********
      disk_placement_policy: {}
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V1
      kms_key:
        key_id: abj73fd9mekk********
        version_id: abjdno4pqi67********
      ```

      {% include [disk-ready](../../../_includes/compute/disk-ready.md) %}

  1. Получите список всех дисков в каталоге по умолчанию:

      ```bash
      yc compute disk list
      ```

      Результат:
      ```text
      +----------------------+--------------+-------------+---------------+--------+----------------------+-------------------------+
      |          ID          |     NAME     |    SIZE     |     ZONE      | STATUS |     INSTANCE IDS     |       DESCRIPTION       |
      +----------------------+--------------+-------------+---------------+--------+----------------------+-------------------------+
      | a7lqgbt0bb9s******** | first-disk   | 20401094656 | ru-central1-a | READY  | a7lcvu28njbh******** |                         |
      | a7lv5j5hm1p1******** | second-disk  | 21474836480 | ru-central1-a | READY  |                      |                         |
      +----------------------+--------------+-------------+---------------+--------+----------------------+-------------------------+
      ```

  1. Создайте снимок из зашифрованного диска, созданного ранее:
  
      ```bash
      yc compute snapshot create \
        --name <имя_создаваемого_снимка> \
        --disk-name <имя_зашифрованного_диска>
      ```

      Результат:

      ```text
      id: fhmu3pfcpicd********
      description: Create snapshot
      created_at: "2025-06-02T16:14:07.523160478Z"
      created_by: ajevfb0tjfts********
      modified_at: "2025-06-02T16:14:07.523160478Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.compute.v1.CreateSnapshotMetadata
        snapshot_id: fd8pb5en4j9m********
        disk_id: fhmqgef7vh76********
      ```

  1. Удалите зашифрованный диск:
      ```bash
      yc compute disk delete <имя_зашифрованного_диска>
      ```

      Результат:

      ```text
      done (5s)
      ```

  1. Удалите исходный снимок:
      ```bash
      yc compute snapshot delete <имя_незашифрованного_снимка>
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

      # Создание зашифрованного диска

      resource "yandex_compute_disk" "encrypted-disk" {
        name        = "new-encrypted-disk"
        type        = "network-hdd"
        zone        = "ru-central1-a"
        size        = 20
        block_size  = 4096
        snapshot_id = "<идентификатор_незашифрованного_снимка"
        kms_key_id  = yandex_kms_symmetric_key.my-key.id
      }

      # Создание зашифрованного снимка

      resource "yandex_compute_snapshot" "encrypted-snapshot" {
        name           = "<имя_зашифрованного_снимка>"
        source_disk_id = yandex_compute_disk.encrypted-disk.id
        depends_on     = [yandex_compute_disk.encrypted-disk]
      }
      ```

      Где:
      * `source_snapshot` — идентификатор незашифрованного снимка.
      * `name` — имя создаваемого зашифрованного снимка.

      Более подробную информацию о параметрах ресурса `yandex_compute_snapshot` см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_snapshot).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {% include [disk-ready](../../../_includes/compute/disk-ready.md) %}

  1. [Удалите](../disk-control/delete.md) зашифрованный диск.
  1. [Удалите](../disk-control/delete.md) исходный снимок.


- API {#api}

  1. Создайте ключ шифрования {{ kms-full-name }} с помощью метода REST API [create](../../../kms/api-ref/SymmetricKey/create.md) для ресурса [SymmetricKey](../../../kms/api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/Create](../../../kms/api-ref/grpc/SymmetricKey/create.md).

  1. Создайте зашифрованный диск из снимка, используя метод REST API [create](../../api-ref/Disk/create.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызов gRPC API [DiskService/Create](../../api-ref/grpc/Disk/create.md).

      Список доступных снимков запрашивайте методом REST API [list](../../api-ref/Snapshot/list.md) или вызовом gRPC API [SnapshotService/List](../../api-ref/grpc/Snapshot/list.md).

      {% include [disk-ready](../../../_includes/compute/disk-ready.md) %}

  1. Для зашифрованного диска создайте снимок с помощью метода REST API [create](../../api-ref/Snapshot/create.md) для ресурса [Snapshot](../../api-ref/Snapshot/index.md) или вызовом gRPC API [SnapshotService/Create](../../api-ref/grpc/Snapshot/create.md).

  1. Удалите зашифрованный диск, используя метод REST API [delete](../../api-ref/Disk/delete.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызов gRPC API [DiskService/Delete](../../api-ref/grpc/Disk/delete.md).

  1. Удалите исходный снимок, используя метод REST API [delete](../../api-ref/Snapshot/delete.md) для ресурса [Snapshot](../../api-ref/Snapshot/index.md) или вызов gRPC API [SnapshotService/Delete](../../api-ref/grpc/Snapshot/delete.md).

{% endlist %}


#### См. также {#see-also}

* [{#T}](../../concepts/encryption.md)
* [{#T}](../disk-control/disk-encrypt.md)
