---
title: How to create an ultra high-speed network storage with three replicas (SSD) in {{ compute-full-name }}
description: Follow this guide to create an ultra high-speed network storage with three replicas (SSD).
---

# Creating an ultra high-speed network storage with three replicas (SSD)


You can create an [ultra high-speed network storage](../../concepts/disk.md#nr-disks) with three replicas (SSD), which is a high-performance SSD offering the same speed as a non-replicated SSD, plus redundancy.

The disk size must be a multiple of 93 GB.

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
  1. Select `{{ ui-key.yacloud.compute.value_disk-type-network-ssd-io-m3_pPfnG }}` as the disk type.
  1. Select the required block size.
  1. Specify the required disk size.

  1. {% include [encryption-section](../../../_includes/compute/encryption-section.md) %}
  1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.

- CLI {#cli}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. See the description of the CLI command for creating disks:
  
      ```bash
      yc compute disk create --help
      ```
  
  1. To create a high-performance disk named `ssd-io-disk`, run this command:

      ```bash
      yc compute disk create \
        --name ssd-io-disk \
        --zone {{ region-id }}-a \
        --type network-ssd-io-m3 \
        --size 93G \
        --kms-key-id <key_ID>
      ```

      Where:

      * `--name`: Disk name.
      * `--zone`: Availability zone.
      * `--type`: Disk type.
      * `--size`: Disk size.
      * `--kms-key-id`: ID of the [{{ kms-short-name }} symmetric key](../../../kms/concepts/key.md) to create an encrypted disk. This is an optional parameter.

        {% include [encryption-role](../../../_includes/compute/encryption-role.md) %}
        
        {% include [encryption-disable-warning](../../../_includes/compute/encryption-disable-warning.md) %}

        {% include [encryption-keys-note](../../../_includes/compute/encryption-keys-note.md) %}

      Result:

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

  Use the [create](../../api-ref/Disk/create.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/Create](../../api-ref/grpc/Disk/create.md) gRPC API call.

{% endlist %}