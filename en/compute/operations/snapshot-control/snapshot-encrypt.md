---
title: Encrypting a snapshot
description: Follow this guide to encrypt a snapshot.
---

# Encrypting an image

{% include [encryption-keys-note](../../../_includes/compute/encryption-keys-note.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. {% include [encryption-preparations](../../../_includes/compute/encryption-preparations.md) %}
  1. Create an encrypted disk from the snapshot you want to encrypt:

      1. In the [management console]({{ link-console-main }}), select the folder where you want to create an encrypted disk.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. In the left-hand panel, select ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks.label_title }}**.
      1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.
      1. Enter a name for the disk.

          {% include [name-format](../../../_includes/name-format.md) %}

      1. Select the same [availability zone](../../../overview/concepts/geo-scope.md) that contained the source disk.
      1. Set the disk parameters, such as [disk type](../../../compute/concepts/disk.md#disks_types), [block size](../../../compute/concepts/disk.md#maximum-disk-size), and [disk size](../../../compute/concepts/disk.md#maximum-disk-size).
      1. In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}` and then select the snapshot you created earlier from the list below. Use the filter to find the snapshot.
      1. Under **{{ ui-key.yacloud.compute.disk-form.section_encryption }}**, enable **{{ ui-key.yacloud.compute.disk-form.label_disk-encryption }}** and select the [key](../../../kms/concepts/key.md) you created earlier in the **{{ ui-key.yacloud.compute.disk-form.label_disk-kms-key }}** field.

      1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.

      {% include [disk-ready](../../../_includes/compute/disk-ready.md) %}

  1. [Create](../disk-control/create-snapshot.md) a snapshot from the encrypted disk created earlier.
  1. [Delete](../disk-control/delete.md) the encrypted disk.
  1. [Delete](delete.md) the source snapshot.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Create a {{ kms-full-name }} encryption key:

      ```bash
      yc kms symmetric-key create \
        --name <key_name> \
        --default-algorithm aes-256 \
        --rotation-period 24h \
        --deletion-protection
      ```

      Where:
      * `--name`: Name of the new {{ kms-name }} key.

      Result:

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

  1. Get a list of all snapshots in the default folder:

      ```bash
      yc compute snapshot list
      ```

      Result:
      ```text
      +----------------------+-----------------------+----------------------+----------+
      |          ID          |         NAME          |     PRODUCT IDS      |  STATUS  |
      +----------------------+-----------------------+----------------------+----------+
      | fd823vsvcmop******** | snap-ubuntu-24-04-lts | f2etq3erab3o******** | READY    |
      | fd8p8l3asgud******** | snap-debian-2025      | f2etq3erab3o******** | READY    |
      +----------------------+-----------------------+----------------------+----------+
      ```

  1. Create an encrypted disk from the snapshot you want to encrypt:

      ```bash
      yc compute disk create <encrypted_disk_name> \
        --source-snapshot-name <snapshot_name> \
        --kms-key-name <key_name>
      ```

      Where:
      * `--source-snapshot-name`: Name of the snapshot used to create the encrypted disk.
      * `--kms-key-name`: Encryption key name.

      Result:

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

  1. Get a list of all disks in the default folder:

      ```bash
      yc compute disk list
      ```

      Result:
      ```text
      +----------------------+--------------+-------------+---------------+--------+----------------------+-------------------------+
      |          ID          |     NAME     |    SIZE     |     ZONE      | STATUS |     INSTANCE IDS     |       DESCRIPTION       |
      +----------------------+--------------+-------------+---------------+--------+----------------------+-------------------------+
      | a7lqgbt0bb9s******** | first-disk   | 20401094656 | ru-central1-a | READY  | a7lcvu28njbh******** |                         |
      | a7lv5j5hm1p1******** | second-disk  | 21474836480 | ru-central1-a | READY  |                      |                         |
      +----------------------+--------------+-------------+---------------+--------+----------------------+-------------------------+
      ```

  1. Create a snapshot from the encrypted disk you created earlier:
  
      ```bash
      yc compute snapshot create \
        --name <name_of_new_snapshot> \
        --disk-name <encrypted_disk_name>
      ```

      Result:

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

  1. Delete the encrypted disk:
      ```bash
      yc compute disk delete <encrypted_disk_name>
      ```

      Result:

      ```text
      done (5s)
      ```

  1. Delete the source snapshot:
      ```bash
      yc compute snapshot delete <unencrypted_snapshot_name>
      ```

      Result:

      ```text
      done (7s)
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To encrypt a disk using {{ TF }}:
  1. In the {{ TF }} configuration file, describe the resources you want to create:

      ```hcl
      # Creating a {{ kms-full-name }} key

      resource "yandex_kms_symmetric_key" "my-key" {
        name                = "Encrypt key"
        default_algorithm   = "AES_256"
        rotation_period     = "8760h"
        deletion_protection = true
        lifecycle {
          prevent_destroy = true
        }
      }

      # Creating an encrypted disk

      resource "yandex_compute_disk" "encrypted-disk" {
        name        = "new-encrypted-disk"
        type        = "network-hdd"
        zone        = "ru-central1-a"
        size        = 20
        block_size  = 4096
        snapshot_id = "<unencrypted_snapshot_ID>"
        kms_key_id  = yandex_kms_symmetric_key.my-key.id
      }

      # Creating an encrypted snapshot

      resource "yandex_compute_snapshot" "encrypted-snapshot" {
        name           = "<encrypted_snapshot_name>"
        source_disk_id = yandex_compute_disk.encrypted-disk.id
        depends_on     = [yandex_compute_disk.encrypted-disk]
      }
      ```

      Where:
      * `source_snapshot`: Unencrypted snapshot ID.
      * `name`: Name of the encrypted snapshot you are creating.

      For more information about `yandex_compute_snapshot` properties, see the [relevant provider documentation]({{ tf-provider-resources-link }}/compute_snapshot).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {% include [disk-ready](../../../_includes/compute/disk-ready.md) %}

  1. [Delete](../disk-control/delete.md) the encrypted disk.
  1. [Delete](../disk-control/delete.md) the source snapshot.


- API {#api}

  1. Create a {{ kms-full-name }} encryption key using the [create](../../../kms/api-ref/SymmetricKey/create.md) REST API method for the [SymmetricKey](../../../kms/api-ref/SymmetricKey/index.md) resource or the [SymmetricKeyService/Create](../../../kms/api-ref/grpc/SymmetricKey/create.md) gRPC API call.

  1. Create an encrypted disk from a snapshot using the [create](../../api-ref/Disk/create.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/Create](../../api-ref/grpc/Disk/create.md) gRPC API call.

      To request a list of available snapshots, use the [list](../../api-ref/Snapshot/list.md) REST API method or the [SnapshotService/List](../../api-ref/grpc/Snapshot/list.md) gRPC API call.

      {% include [disk-ready](../../../_includes/compute/disk-ready.md) %}

  1. Create a snapshot for or the encrypted disk using the [create](../../api-ref/Snapshot/create.md) REST API method for the [Snapshot](../../api-ref/Snapshot/index.md) resource or the [SnapshotService/Create](../../api-ref/grpc/Snapshot/create.md) gRPC API call.

  1. Delete the encrypted disk using the [delete](../../api-ref/Disk/delete.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/Delete](../../api-ref/grpc/Disk/delete.md) gRPC API call.

  1. Delete the source snapshot using the [delete](../../api-ref/Snapshot/delete.md) REST API method for the [Snapshot](../../api-ref/Snapshot/index.md) resource or the [SnapshotService/Delete](../../api-ref/grpc/Snapshot/delete.md) gRPC API call.

{% endlist %}


#### See also {#see-also}

* [{#T}](../../concepts/encryption.md)
* [{#T}](../disk-control/disk-encrypt.md)
