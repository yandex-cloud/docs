---
title: How to encrypt a disk in {{ compute-full-name }}
description: Follow this guide to encrypt a disk.
---

# Encrypting a disk

{% include [encryption-role](../../../_includes/compute/encryption-role.md) %}

{% include [encryption-keys-note](../../../_includes/compute/encryption-keys-note.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. {% include [encryption-preparations](../../../_includes/compute/encryption-preparations.md) %}
  1. [Create](../image-create/create-from-disk.md) an image of the disk you want to encrypt.
  1. Create an encrypted disk from the image:

      1. In the [management console]({{ link-console-main }}), select the folder where you want to create an encrypted disk.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. In the left-hand panel, select ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks.label_title  }}**.
      1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.
      1. Enter a name for the disk.

          {% include [name-format](../../../_includes/name-format.md) %}

      1. Select the same [availability zone](../../../overview/concepts/geo-scope.md) that contained the source disk.
      1. Set the disk parameters, such as [disk type](../../concepts/disk.md#disks_types), [block size](../../concepts/disk.md#maximum-disk-size), and [disk size](../../concepts/disk.md#maximum-disk-size).
      1. In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` and then select the image you created earlier from the list below. Use the filter to find the image.
      1. Under **{{ ui-key.yacloud.compute.disk-form.section_encryption }}**:

          * Select **{{ ui-key.yacloud.compute.disk-form.label_disk-encryption }}**.
          * In the **{{ ui-key.yacloud.compute.disk-form.label_disk-kms-key }}** field, select the [key](../../../kms/concepts/key.md) you created earlier. To [create](../../../kms/operations/key.md#create) a new key, click **{{ ui-key.yacloud.component.symmetric-key-select.button_create-key-new }}**.

      1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.

      {% include [disk-ready](../../../_includes/compute/disk-ready.md) %}

  1. [Delete](../image-control/delete.md) the image.
  1. [Delete](../disk-control/delete.md) the unencrypted disk.

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

  1. Create an image of the disk you want to encrypt.

      ```bash
      yc compute image create \
        --name <image_name> \
        --source-disk-name <unencrypted_disk_name>
      ```

      Where:
      * `--name`: Name of the image you are creating.
      * `--source-disk-name`: Name of the unencrypted disk you are creating the image for.

      Result:

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

  1. Create an encrypted disk from the image:

      ```bash
      yc compute disk create <encrypted_disk_name> \
        --source-image-name <image_name> \
        --kms-key-name <key_name>
      ```

      Where:
      * `--source-image-name`: Image name to create an encrypted disk.
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

  1. Delete the image:

      ```bash
      yc compute image delete <image_name>
      ```

      Result:

      ```text
      done (15s)
      ```

  1. Delete the unencrypted disk:

      ```bash
      yc compute disk delete <unencrypted_disk_name>
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

      # Creating an image

      resource "yandex_compute_image" "image-1" {
        name        = "disk-image"
        source_disk = "<unencrypted_disk_ID>"
      }

      # Creating an encrypted disk

      resource "yandex_compute_disk" "empty-disk" {
        name       = "<encrypted_disk_name>"
        type       = "network-hdd"
        zone       = "{{ region-id}}-a"
        size       = 20
        block_size = 4096
        image_id   = yandex_compute_image.image-1.id
        kms_key_id = yandex_kms_symmetric_key.my-key.id
        depends_on = [yandex_compute_image.image-1]
      }
      ```

      Where:
      * `source_disk`: Unencrypted disk ID.
      * `name`: Name of the encrypted disk you are creating.

     For more information about `yandex_compute_disk` properties, see [this Terraform article]({{ tf-provider-resources-link }}/yandex_compute_disk).
  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {% include [disk-ready](../../../_includes/compute/disk-ready.md) %}

  1. [Delete](../image-control/delete.md) the image.
  1. [Delete](../disk-control/delete.md) the unencrypted disk.


- API {#api}

  1. Create a {{ kms-full-name }} encryption key using the [create](../../../kms/api-ref/SymmetricKey/create.md) REST API method for the [SymmetricKey](../../../kms/api-ref/SymmetricKey/index.md) resource or the [SymmetricKeyService/Create](../../../kms/api-ref/grpc/SymmetricKey/create.md) gRPC API call.

  1. Create an image using the [create](../../api-ref/Image/create.md) REST API method for the [Image](../../api-ref/Image/index.md) resource or the [ImageService/Create](../../api-ref/grpc/Image/create.md) gRPC API call. Specify the disk ID in your request.

      To request a list of available disks, use the [list](../../api-ref/Disk/list.md) REST API method or the [DiskService/List](../../api-ref/grpc/Disk/list.md) gRPC API call.

  1. Create an encrypted disk from an image using the [create](../../api-ref/Disk/create.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/Create](../../api-ref/grpc/Disk/create.md) gRPC API call.

      {% include [disk-ready](../../../_includes/compute/disk-ready.md) %}

  1. Delete an image using the [delete](../../api-ref/Image/delete.md) REST API method for the [Image](../../api-ref/Image/index.md) resource or the [ImageService/Delete](../../api-ref/grpc/Image/delete.md) gRPC API call.

  1. Delete an unencrypted disk using the [delete](../../api-ref/Disk/delete.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/Delete](../../api-ref/grpc/Disk/delete.md) gRPC API call.

{% endlist %}


### See also {#see-also}

* [{#T}](../../concepts/encryption.md)
* [{#T}](../snapshot-control/snapshot-encrypt.md)
