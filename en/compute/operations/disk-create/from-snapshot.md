---
title: How to recover a disk from a snapshot in {{ compute-full-name }}
description: Follow this guide to recover a disk from a snapshot.
---

# Recovering a disk from a snapshot

{% note info %}

{% include [boot-disk-recover](../../../_includes/compute/boot-disk-recover.md) %}

{% endnote %}

To create a disk from a [snapshot](../../concepts/snapshot.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a disk.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks_ddfdb }}**.
  1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.
  1. Enter a name for the disk. The naming requirements are as follows:

      {% include [name-format](../../../_includes/name-format.md) %}

  1. Provide a description for the disk, if required.
  1. Select the [availability zone](../../../overview/concepts/geo-scope.md) the disk will reside in.
  1. In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}` and select your snapshot from the list that opens. Optionally, use the filter.
  1. Set the disk parameters: [disk type](../../concepts/disk.md#disks_types), [disk size](../../concepts/disk.md#maximum-disk-size), and [block size](../../concepts/disk.md#maximum-disk-size).
  1. {% include [encryption-section](../../../_includes/compute/encryption-section.md) %}
  1. Optionally, select or create a [schedule](../../concepts/snapshot-schedule.md) for automatic disk snapshots. For more information about setting up schedules, see [this guide](../snapshot-control/create-schedule.md).

      {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

      When creating a disk, you can only select a single snapshot schedule. After the disk is created, you can add a few more schedules by following [this guide](../disk-control/configure-schedule.md#add-schedule).
  1. Optionally, expand the **{{ ui-key.yacloud.compute.section_additional_7yvYG }}** section and, in the **{{ ui-key.yacloud.compute.hardware-generation_1iEpT }}** field, select the virtualized hardware [generation](../../concepts/hardware-generations.md#configurations) you want to assign to the new disk:

      {% include [generation-types-console](../../../_includes/compute/generation-types-console.md) %}

      If you make no assignment, by default the disk will get the same generation assigned as the source snapshot.

  1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.

- CLI {#cli}

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to create a disk:

      ```bash
      yc compute disk create --help
      ```

  1. Get a list of snapshots in the default folder:

      ```bash
      yc compute snapshot list
      ```

      Result:

      ```text
      +----------------------+----------------------+----------------------+----------+
      |          ID          |         NAME         |     PRODUCT IDS      |  STATUS  |
      +----------------------+----------------------+----------------------+----------+
      | fd84hanhvjql******** | disk-1-1668075122980 | f2ef3frbftr2******** | READY    |
      | fd85mc22cosp******** | disk-2-1669114692462 | f2ef3frbftr2******** | READY    |
      +----------------------+----------------------+----------------------+----------+
      ```

  1. Select `ID` or `NAME` of the snapshot you need.
  1. Create a disk from the selected snapshot:

      ```bash
      yc compute disk create \
        --name <disk_name> \
        --source-snapshot-name <source_snapshot_name> \
        --zone <availability_zone> \
        --description <text_description_of_disk> \
        --hardware-generation-id <hardware_generation> \
        --hardware-features pci_topology=<PCI_topology>
      ```

      Where:
      * `--name`: Disk name. The naming requirements are as follows:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `--source-snapshot-name`: Source snapshot name. Instead of a name, you can provide the source snapshot ID in the `--source-snapshot-id` parameter.
      * `--zone`: [Availability zone](../../../overview/concepts/geo-scope.md) you are creating the disk in.
      * `--description`: Text description of the new disk. This is an optional setting.
      * `--hardware-generation-id`: Hardware [generation](../../concepts/hardware-generations.md#configurations) assigned to the disk. This is an optional setting. The possible values are:

          {% include [generation-types-cli](../../../_includes/compute/generation-types-cli.md) %}

          If not specified, the disk will get the same hardware generation assigned as the source snapshot.
      * `--hardware-features`: Additional settings for `Gen 1`. This is an optional setting. The possible values are:

          * `pci_topology=v1`: `PCI_TOPOLOGY_V1` topology.
          * `pci_topology=v2`: `PCI_TOPOLOGY_V2` topology.


          If the source snapshot has `Gen 1` assigned, by default the new disk will get the same `--hardware-features` value as the source snapshot.

      Result:

      ```text
      done (44s)
      id: epdbnjirsai9********
      folder_id: b1gt6g8ht345********
      created_at: "2025-06-23T14:46:22Z"
      name: second-disk
      description: my second disk via yc
      type_id: network-hdd
      zone_id: {{ region-id }}-a
      size: "21474836480"
      block_size: "4096"
      product_ids:
        - f2evcrm9ti79********
      status: READY
      source_snapshot_id: fd81qi89ldop********
      disk_placement_policy: {}
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V2
      ```

      For more information about the `yc compute disk create` command, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/disk/create.md).

  1. Get a list of disks in the default folder:

      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

      Get the same list with more details in YAML format:

      ```bash
      yc compute disk list --format yaml
      ```

      Result:

      ```text
      - id: epd73ra2mrd4********
        folder_id: b1gt6g8ht345********
        created_at: "2025-06-23T16:57:01Z"
        name: first-disk
        description: my first disk
        type_id: network-hdd
        zone_id: {{ region-id }}-a
        size: "21474836480"
        block_size: "4096"
        product_ids:
          - f2evcrm9ti79********
        status: READY
        source_snapshot_id: fd81qi89ldop********
        disk_placement_policy: {}
        hardware_generation:
          legacy_features:
            pci_topology: PCI_TOPOLOGY_V1
      - id: epd8lmcncidv********
        folder_id: b1gt6g8ht345********
        created_at: "2025-06-23T06:32:26Z"
        name: second-disk
        type_id: network-ssd
        zone_id: {{ region-id }}-a
        size: "21474836480"
        block_size: "4096"
        product_ids:
          - f2evcrm9ti79********
        status: READY
        source_image_id: fd80j21lmqar********
        instance_ids:
          - epdm2ene322e********
        disk_placement_policy: {}
        hardware_generation:
          legacy_features:
            pci_topology: PCI_TOPOLOGY_V1
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Define the parameters of the `yandex_compute_disk` resource in the configuration file.

      Here is an example of the configuration file structure:
     
      ```hcl
      resource "yandex_compute_disk" "my-disk" {
        name           = "<disk_name>"
        zone           = "<availability_zone>"
        snapshot_id    = "<snapshot_ID>"
        hardware_generation {
          legacy_features {
            pci_topology = "<PCI_topology>"
          }
        }
      }
      ```

      Where:
      * `name`: Disk name. The naming requirements are as follows:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `zone`: [Availability zone](../../../overview/concepts/geo-scope.md) you are creating the disk in.
      * `snapshot_id`: ID of the snapshot you are creating the disk based on.
      * `hardware_generation`: Block of settings describing the virtualized hardware [generation](../../concepts/hardware-generations.md#configurations) assigned to the disk. This is an optional setting. It includes the following blocks of settings:

          {% include [generation-types-tf](../../../_includes/compute/generation-types-tf.md) %}

          {% note info %}

          If the `hardware_generation` settings are not specified, the disk will get the same hardware generation assigned as the source snapshot.

          {% endnote %}

      For more information about the `yandex_compute_disk` resource, see the [relevant provider documentation]({{ tf-provider-resources-link }}/compute_disk).

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

     1. Confirm creating the resources.

     This will create all the resources you need in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}).

- API {#api}

  1. Get a list of snapshots using the [list](../../api-ref/Snapshot/list.md) REST API method for the [Snapshot](../../api-ref/Snapshot/index.md) resource or the [SnapshotService/List](../../api-ref/grpc/Snapshot/list.md) gRPC API call.
  1. Create a disk using the [create](../../api-ref/Disk/create.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/Create](../../api-ref/grpc/Disk/create.md) gRPC API call. In your request, specify the source snapshot ID, and optionally the required hardware [generation](../../concepts/hardware-generations.md#configurations) in the [`hardwareGeneration` object](../../api-ref/Disk/create.md#yandex.cloud.compute.v1.HardwareGeneration) ([`hardware_generation`](../../api-ref/grpc/Disk/create.md#yandex.cloud.compute.v1.HardwareGeneration) if using the gRPC API).

{% endlist %}

Once created, the disk will get the `CREATING` status. Wait until the disk status changes to `READY` before using it.


#### See also {#see-also}

* [Creating a VM with disks from snapshots](../vm-create/create-from-snapshots.md)
* [Attaching a disk to a VM and mounting partitions](../vm-control/vm-attach-disk.md)
* [Creating a snapshot schedule](../snapshot-control/create-schedule.md)
* [Encryption in {{ compute-name }}](../../concepts/encryption.md)
* [{#T}](../../../backup/concepts/index.md)
