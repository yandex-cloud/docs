---
title: How to create an empty disk in {{ compute-full-name }}
description: Follow this guide to create an empty disk of the specified size.
---

# Creating an empty disk

You can create an empty disk of the specified size.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a disk.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks_ddfdb }}**.
  1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.
  1. Enter a name for the disk. Follow these naming requirements:

      {% include [name-format](../../../_includes/name-format.md) %}

  1. Add a description for the disk, if required.
  1. Select the [availability zone](../../../overview/concepts/geo-scope.md) the disk will reside in.
  1. Select the required disk type: `{{ ui-key.yacloud.compute.value_disk-type-network-hdd_cw9XD }}`, `{{ ui-key.yacloud.compute.value_disk-type-network-ssd_4Mmub }}`, `{{ ui-key.yacloud.compute.value_disk-type-network-ssd-io-m3_pPfnG }}`, or `{{ ui-key.yacloud.compute.value_disk-type-network-ssd-nonreplicated_d7W56 }}`.


  1. Select the required block size (minimum storage unit on the disk). By default, the block size is 4 KB for all new disks; however, this is insufficient for disks larger than 8 TB.
  1. Specify the required disk size. The maximum disk size depends on the specified block size.
  1. {% include [encryption-section](../../../_includes/compute/encryption-section.md) %}
  1. Select or set up a [schedule](../../concepts/snapshot-schedule.md) for automatically creating disk [snapshots](../../concepts/snapshot.md), if required. For more information about setting up schedules, see [this guide](../snapshot-control/create-schedule.md).

     {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

     When creating a disk, you can only select a single snapshot schedule. After the disk is created, you can add a few more schedules, if required, by following [this guide](../disk-control/configure-schedule.md#add-schedule).

  1. Click **{{ ui-key.yacloud.compute.disks.create.button_create }}**.

- CLI {#cli}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI commands for creating disks:

      ```bash
      yc compute disk create --help
      ```

  1. Create a disk in the default folder:

      ```bash
      yc compute disk create \
        --name first-disk \
        --size 10 \
        --description "my first disk via yc" \
        --kms-key-id <key_ID>
      ```

      Where:

      * `--name`: Disk name. The disk naming requirements are as follows:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `--size`: Disk size.
      * `--description`: Disk description.
      * `--kms-key-id`: ID of the [{{ kms-short-name }} symmetric key](../../../kms/concepts/key.md) to create an encrypted disk. This is an optional parameter.

        {% include [encryption-role](../../../_includes/compute/encryption-role.md) %}
        
        {% include [encryption-disable-warning](../../../_includes/compute/encryption-disable-warning.md) %}

        {% include [encryption-keys-note](../../../_includes/compute/encryption-keys-note.md) %}

      This command will create a 10 GB disk named `first-disk` and described as `my first disk via yc`.

  1. Get a list of disks in the default folder:

      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

      Get the same list with more details in YAML format:

      ```bash
      yc compute disk list --format yaml
      ```

      Result:
      ```text
      - id: fhm4aq4hvq5g********
          folder_id: b1gm3og7ei7a********
          created_at: "2018-10-29T07:43:06Z"
          name: first-disk
          description: my first disk via yc
          type_id: network-hdd
          zone_id: {{ region-id }}-a
          size: "10737418240"
          status: READY
          disk_placement_policy: {}
          hardware_generation:
            legacy_features:
              pci_topology: PCI_TOPOLOGY_V1
          kms_key:
            key_id: abjbaqdga6hs********
            version_id: abj295dgqnlp********
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
          disk_placement_policy: {}
          hardware_generation:
            legacy_features:
              pci_topology: PCI_TOPOLOGY_V1
          kms_key:
            key_id: abjbaqdga6hs********
            version_id: abj295dgqnlp********
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  {% include [terraform-empty-disk-create](../../../_includes/compute/terraform-empty-disk-create.md) %}

- API {#api}

  Use the [create](../../api-ref/Disk/create.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/Create](../../api-ref/grpc/Disk/create.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](../snapshot-control/create-schedule.md)
