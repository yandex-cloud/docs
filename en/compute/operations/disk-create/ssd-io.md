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
  1. Enter a name for the disk. The naming requirements are as follows:
  
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

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To create a high-performance disk, do the following:
  1. In the {{ TF }} configuration file, describe the resources you want to create:

     ```hcl
     resource "yandex_compute_disk" "empty-fast-disk" {
       name       = "<disk_name>"
       type       = "network-ssd-io-m3"
       zone       = "<availability_zone>"
       size       = 93
       block_size = 4096
       kms_key_id = <key_ID>
     }
     ```

     Where:
     * `name`: Disk name. Use the following name format:

         {% include [name-format](../../../_includes/name-format.md) %}

     * `type`: Disk type, `ssd-io-m3`.
     * `zone`: [Availability zone](../../../overview/concepts/geo-scope.md). The availability zone for your disk must match the zone of the placement group where you want to create it. We recommend creating disks in the `{{ region-id }}-a` or `{{ region-id }}-b` availability zone.
     * `size`: Disk size in GB. This must be a multiple of 93 GB. The maximum disk size depends on the specified block size.
     * `block_size`: Block size in bytes (minimum storage unit on the disk). By default, the block size is 4 KB for all new disks; however, this is insufficient for disks larger than 8 TB. For more information, see [{#T}](empty-disk-blocksize.md).
     * `kms_key_id`: ID of the [{{ kms-short-name }} symmetric key](../../../kms/concepts/key.md) to create an [encrypted](../../concepts/encryption.md) disk. This is an optional parameter.

         {% include [encryption-role](../../../_includes/compute/encryption-role.md) %}

         {% include [encryption-disable-warning](../../../_includes/compute/encryption-disable-warning.md) %}

         {% include [encryption-keys-note](../../../_includes/compute/encryption-keys-note.md) %}

     For more information about the `yandex_compute_disk` resource, see the [relevant provider documentation]({{ tf-provider-resources-link }}/compute_disk).

  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

     ```bash
     yc compute disk list
     ```

- API {#api}

  Use the [create](../../api-ref/Disk/create.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/Create](../../api-ref/grpc/Disk/create.md) gRPC API call.

{% endlist %}


#### See also {#see-also}

* [{#T}](../snapshot-control/create-schedule.md)