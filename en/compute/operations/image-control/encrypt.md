---
title: Encrypting an image in {{ compute-full-name }}
description: Follow this guide to encrypt a disk image in {{ compute-short-name }}.
---

# Encrypting an image

{% include [encryption-keys-note](../../../_includes/compute/encryption-keys-note.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. {% include [encryption-preparations](../../../_includes/compute/encryption-preparations.md) %}
  1. Create an encrypted disk from the image you want to encrypt:

      1. In the [management console]({{ link-console-main }}), select the folder containing the source image.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. In the left-hand panel, select ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks.label_title }}**.
      1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.
      1. Enter a name for the disk.

          {% include [name-format](../../../_includes/name-format.md) %}

      1. Set the disk parameters, such as [disk type](../../../compute/concepts/disk.md#disks_types), [block size](../../../compute/concepts/disk.md#maximum-disk-size), and [disk size](../../../compute/concepts/disk.md#maximum-disk-size).
      1. In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` and then select the image you need from the list below. Use the filter to find the image.
      1. Under **{{ ui-key.yacloud.compute.disk-form.section_encryption }}**, enable **{{ ui-key.yacloud.compute.disk-form.label_disk-encryption }}** and select the [key](../../../kms/concepts/key.md) you created earlier in the **{{ ui-key.yacloud.compute.disk-form.label_disk-kms-key }}** field.

      1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.

      {% include [disk-ready](../../../_includes/compute/disk-ready.md) %}

  1. [Create](../image-create/create-from-disk.md) an image from the encrypted disk you created earlier.
  1. [Delete](../disk-control/delete.md) the encrypted disk.
  1. [Delete](delete.md) the source image.

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

      Where `--name` is the name of the new {{ kms-name }} key.

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

  1. Get a list of all images in the default folder:

      ```bash
      yc compute image list
      ```

      Result:

      ```text
      +----------------------+--------------------+------------------------+----------+
      |          ID          |        NAME        |       PRODUCT IDS      |  STATUS  |
      +----------------------+--------------------+------------------------+----------+
      | fd823vsvcmop******** | image-ubuntu-24-04 | igf2etq3erab3o******** | READY    |
      | fd8p8l3asgud******** | image-debian-2025  | goa2etq3erab3o******** | READY    |
      +----------------------+--------------------+------------------------+----------+
      ```

  1. Create an encrypted disk from the image you want to encrypt:

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
      id: fhmihpagi991********
      folder_id: b1geoelk7fld********
      created_at: "2025-05-20T17:39:01Z"
      name: fromcliencrypted
      type_id: network-hdd
      zone_id: {{ region-id }}-a
      size: "21474836480"
      block_size: "4096"
      status: READY
      source_image_id: sd1lb3jnrcs2********
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
      | a7lqgbt0bb9s******** | first-disk   | 20401094656 | {{ region-id }}-a | READY  | a7lcvu28njbh******** |                         |
      | a7lv5j5hm1p1******** | second-disk  | 21474836480 | {{ region-id }}-a | READY  |                      |                         |
      +----------------------+--------------+-------------+---------------+--------+----------------------+-------------------------+
      ```

  1. Create an image from the encrypted disk you created earlier:
  
      ```bash
      yc compute image create \
        --name <name_of_new_image> \
        --source-disk-name <encrypted_disk_name>
      ```

      Result:

      ```text
      done (8s)
      id: fd87fubin9ql********
      folder_id: b1geoelk7fld********
      created_at: "2025-06-25T10:52:31Z"
      name: encrypted-image
      min_disk_size: "5368709120"
      status: READY
      os:
        type: LINUX
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V1
      kms_key:
        key_id: abjgkrgibtmo********
        version_id: abjvf41ltfi8********
      ```

  1. Delete the encrypted disk:

      ```bash
      yc compute disk delete <encrypted_disk_name>
      ```

      Result:

      ```text
      done (4s)
      ```

  1. Delete the source image:

      ```bash
      yc compute image delete <unencrypted_image_name>
      ```

      Result:

      ```text
      done (2s)
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To encrypt an image using {{ TF }}:

  1. In the {{ TF }} configuration file, describe the resources you want to create:

      ```hcl
      # Creating a {{ kms-full-name }} key

      resource "yandex_kms_symmetric_key" "my-key" {
        name                = "encrypt-key"
        default_algorithm   = "AES_256"
        rotation_period     = "8760h"
        deletion_protection = true
        lifecycle {
          prevent_destroy = true
        }
      }

      # Creating an encrypted disk

      resource "yandex_compute_disk" "encrypted-disk" {
        name       = "new-encrypted-disk"
        type       = "network-hdd"
        zone       = "{{ region-id }}-a"
        size       = 20
        block_size = 4096
        image_id   = "<unencrypted_image_ID>"
        kms_key_id = yandex_kms_symmetric_key.my-key.id
      }

      # Creating an encrypted image

      resource "yandex_compute_image" "encrypted-image" {
        name           = "<encrypted_image_name>"
        source_disk_id = yandex_compute_disk.encrypted-disk.id
        depends_on     = [yandex_compute_disk.encrypted-disk]
      }
      ```

      Where:
      * `image_id`: Unencrypted image ID.
      * `name`: Name of the new encrypted image.

      For more information about `yandex_compute_snapshot` properties, see the [relevant provider documentation]({{ tf-provider-resources-link }}/compute_image).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {% include [disk-ready](../../../_includes/compute/disk-ready.md) %}

  1. [Delete](../disk-control/delete.md) the encrypted disk.
  1. [Delete](../image-control/delete.md) the source image.

- API {#api}

  1. Create a {{ kms-full-name }} encryption key using the [create](../../../kms/api-ref/SymmetricKey/create.md) REST API method for the [SymmetricKey](../../../kms/api-ref/SymmetricKey/index.md) resource or the [SymmetricKeyService/Create](../../../kms/api-ref/grpc/SymmetricKey/create.md) gRPC API call.

  1. Create an encrypted disk from an image using the [create](../../api-ref/Disk/create.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/Create](../../api-ref/grpc/Disk/create.md) gRPC API call.

      To request a list of available images, use the [list](../../api-ref/Image/list.md) REST API method or the [ImageService/List](../../api-ref/grpc/Image/list.md) gRPC API call.

      {% include [disk-ready](../../../_includes/compute/disk-ready.md) %}

  1. For the encrypted disk, create an image using the [create](../../api-ref/Image/create.md) REST API method for the [Image](../../api-ref/Image/index.md) resource or the [ImageService/Create](../../api-ref/grpc/Image/create.md) gRPC API call.

  1. Delete the encrypted disk using the [delete](../../api-ref/Disk/delete.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/Delete](../../api-ref/grpc/Disk/delete.md) gRPC API call.

  1. Delete the source image using the [delete](../../api-ref/Image/delete.md) REST API method for the [Image](../../api-ref/Image/index.md) resource or the [ImageService/Delete](../../api-ref/grpc/Image/delete.md) gRPC API call.

{% endlist %}


#### See also {#see-also}

* [{#T}](../../concepts/encryption.md)
* [{#T}](../disk-control/disk-encrypt.md)
* [{#T}](../snapshot-control/snapshot-encrypt.md)
