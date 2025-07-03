---
title: How to create a non-replicated disk in {{ compute-full-name }}
description: Follow this guide to create a non-replicated disk.
---

# Creating a non-replicated disk


You can create a stand-alone [non-replicated](../../concepts/disk.md#nr-disks) disk or add such a disk to a [disk placement group](../../concepts/disk-placement-group.md).

The [disk](../../concepts/disk.md) size must be a multiple of 93 GB.

## Creating a stand-alone non-replicated disk {#nr-disk}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a disk.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks_ddfdb }}**.
  1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.
  1. Enter a name for the disk. The naming requirements are as follows:

     {% include [name-format](../../../_includes/name-format.md) %}

  1. Add a description for the disk, if required.
  1. Select the [availability zone](../../../overview/concepts/geo-scope.md) the disk will reside in.
  1. Select `{{ ui-key.yacloud.compute.value_disk-type-network-ssd-nonreplicated_d7W56 }}` as the disk type.
  1. Select the required block size.
  1. Specify the required disk size.
  1. {% include [encryption-section](../../../_includes/compute/encryption-section.md) %}
  1. Select or set up a [schedule](../../concepts/snapshot-schedule.md) for automatically creating disk [snapshots](../../concepts/snapshot.md), if required. For more information about setting up schedules, see [this guide](../snapshot-control/create-schedule.md).

     When creating a disk, you can only select a single snapshot schedule. After the disk is created, you can add a few more schedules, if required, by following [this guide](../disk-control/configure-schedule.md#add-schedule).
  1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.

- CLI {#cli}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../../cli/) command for creating disks:

     ```bash
     yc compute disk create --help
     ```

  1. To create a non-replicated disk named `nr-disk`, run this command:

     ```bash
     yc compute disk create \
       --name nr-disk \
       --type network-ssd-nonreplicated \
       --size 93 \
       --kms-key-id <key_ID>
     ```

       Where:
       * `--name`: Disk name.
       * `--type`: Disk type.
       * `--size`: Disk size.
       * `--kms-key-id`: ID of the [{{ kms-short-name }} symmetric key](../../../kms/concepts/key.md) to create an encrypted disk. This is an optional parameter.

         {% include [encryption-role](../../../_includes/compute/encryption-role.md) %}
         
         {% include [encryption-disable-warning](../../../_includes/compute/encryption-disable-warning.md) %}

         {% include [encryption-keys-note](../../../_includes/compute/encryption-keys-note.md) %}

     Result:

     ```text
     done (1s)
     id: epdb2517b970********
     folder_id: b1g7gvsi89m3********
     ...
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

  1. In the configuration file, define the non-replicated disk parameters:

     ```hcl
     resource "yandex_compute_disk" "nr" {
       name       = "<non-replicated_disk_name>"
       size       = <non-replicated_disk_size>
       block_size = <block_size>
       type       = "network-ssd-nonreplicated"
       zone       = "<availability_zone>"
       kms_key_id = "<KMS_key_ID>"
     }
     ```

     Where:
     * `name`: Non-replicated disk name. Follow these naming requirements:

       {% include [name-format](../../../_includes/name-format.md) %}

     * `size`: Non-replicated disk size, which must be a multiple of 93 GB.
     * `block_size`: Block size in bytes (minimum storage unit on the disk). The maximum disk size depends on the specified block size. By default, the block size is 4 KB for all new disks; however, this is insufficient for disks larger than 8 TB. For more information, see [{#T}](../../../compute/operations/disk-create/empty-disk-blocksize.md).
     * `type`: Disk type. Specify `network-ssd-nonreplicated` to create a non-replicated disk.
     * `zone`: [Availability zone](../../../overview/concepts/geo-scope.md)
     * `kms_key_id`: ID of the [{{ kms-short-name }} symmetric key](../../../kms/concepts/key.md) to create an [encrypted](../../concepts/encryption.md) disk. This is an optional parameter.

        {% include [encryption-role](../../../_includes/compute/encryption-role.md) %}

        {% include [encryption-disable-warning](../../../_includes/compute/encryption-disable-warning.md) %}

        {% include [encryption-keys-note](../../../_includes/compute/encryption-keys-note.md) %}

     For more information about `yandex_compute_disk` properties, see [this {{ TF }} article]({{ tf-provider-resources-link }}/compute_disk#example-usage---non-replicated-disk).
  1. Make sure the configuration files are correct.
     1. In the command line, navigate to the directory where you created the configuration file.
     1. Run a check using this command:

        ```bash
        terraform plan
        ```

     If the configuration description is correct, the terminal will display a list of the resources being created and their settings. If the configuration contains any errors, {{ TF }} will point them out.
  1. Deploy the cloud resources.
     1. If the configuration does not contain any errors, run this command:

        ```bash
        terraform apply
        ```

     1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

        This will create all the resources you need in the specified [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder). You can check the new resources and their settings using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

        ```bash
        yc compute disk list
        ```

- API {#api}

  Use the [create](../../api-ref/Disk/create.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/Create](../../api-ref/grpc/Disk/create.md) gRPC API call.

{% endlist %}

## Creating a non-replicated disk in a placement group {#nr-disk-in-group}

You can only create a disk in an existing disk placement group.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a disk.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks_ddfdb }}**.
  1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.
  1. Enter a name for the disk. The naming requirements are as follows:

     {% include [name-format](../../../_includes/name-format.md) %}

  1. Add a description for the disk, if required.
  1. Select the availability zone the disk will reside in.

     The availability zone for your disk must match the zone of the placement group where you want to create it.
  1. Select `{{ ui-key.yacloud.compute.value_disk-type-network-ssd-nonreplicated_d7W56 }}` as the disk type.
  1. Select a disk placement group.

      If you select a [partition placement](../../concepts/disk-placement-group.md#partition) group, specify the number of the partition you want to add the disk to.
  1. Specify the required disk size.
  1. Select or set up a [schedule](../../concepts/snapshot-schedule.md) for automatically creating disk snapshots, if required. For more information about setting up schedules, see [this guide](../snapshot-control/create-schedule.md).

     If you want to set another schedule, you can [add](../disk-control/configure-schedule.md#add-schedule) it after the disk is created.
  1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for creating disks:

     ```bash
     yc compute disk create --help
     ```

  1. In a placement group, create a non-replicated disk in the default folder using one of these strategies:
     * [Spread placement](../../concepts/disk-placement-group.md#spread):

       ```bash
       yc compute disk create \
         --name <disk_name> \
         --type network-ssd-nonreplicated \
         --size <disk_size> \
         --disk-placement-group-name <placement_group_name> \
         --kms-key-id <key_ID>
       ```

       Where:
       * `--name`: Disk name.
       * `--type`: Disk type.
       * `--size`: Disk size.
       * `--disk-placement-group-name`: Placement group name.
       * `--kms-key-id`: ID of the [{{ kms-short-name }} symmetric key](../../../kms/concepts/key.md) to create an encrypted disk. This is an optional parameter.

         {% include [encryption-role](../../../_includes/compute/encryption-role.md) %}
         
         {% include [encryption-disable-warning](../../../_includes/compute/encryption-disable-warning.md) %}

         {% include [encryption-keys-note](../../../_includes/compute/encryption-keys-note.md) %}

       Result:

       ```text
       done (1s)
       id: epdtncic35ru********
       folder_id: b1g7gvsi89m3********
       ...
       status: READY
       disk_placement_policy:
         placement_group_id: epdn946ilslh********
       hardware_generation:
         legacy_features:
           pci_topology: PCI_TOPOLOGY_V1
       kms_key:
         key_id: abjbaqdga6hs********
         version_id: abj295dgqnlp********
       ```

     * [Partition placement](../../concepts/disk-placement-group.md#partition):

       ```bash
       yc compute disk create \
         --name <disk_name> \
         --type network-ssd-nonreplicated \
         --size <disk_size> \
         --disk-placement-group-name <placement_group_name> \
         --disk-placement-group-partition <partition_number>
       ```

       Where:
       * `--name`: Disk name.
       * `--type`: Disk type.
       * `--size`: Disk size.
       * `--disk-placement-group-name`: Placement group name.
       * `--disk-placement-group-partition`: Partition number in the placement group.
       * `--kms-key-id`: ID of the [{{ kms-short-name }} symmetric key](../../../kms/concepts/key.md) to create an encrypted disk. This is an optional parameter.

         {% include [encryption-role](../../../_includes/compute/encryption-role.md) %}
         
         {% include [encryption-disable-warning](../../../_includes/compute/encryption-disable-warning.md) %}

         {% include [encryption-keys-note](../../../_includes/compute/encryption-keys-note.md) %}

       Result:

       ```text
       done (1s)
       id: epdtncic35ru********
       folder_id: b1g7gvsi89m3********
       ...
       disk_placement_policy:
         placement_group_id: epdn946ilslh********
         placement_group_partition: 2
       kms_key:
         key_id: abjbaqdga6hs********
         version_id: abj295dgqnlp********
       ```


- API {#api}

  Use the [create](../../api-ref/Disk/create.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/Create](../../api-ref/grpc/Disk/create.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](../snapshot-control/create-schedule.md)
