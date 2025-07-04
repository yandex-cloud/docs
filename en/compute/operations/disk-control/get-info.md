---
title: How to get information about a disk in {{ compute-full-name }}
description: Follow this guide to get information about a disk.
---

# Getting information about a disk

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your [disk](../../concepts/disk.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks_ddfdb }}**.
  1. Select the disk from the list.
  1. The **{{ ui-key.yacloud.common.overview }}** page will show the disk details.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for getting information about a [disk](../../concepts/disk.md):

      ```bash
      yc compute disk get --help
      ```

  1. Get information about a disk by specifying its ID or name:

      ```bash
      yc compute disk get <disk_ID>
      ```

      Result:

      ```text
      id: epdi2r341gcq********
      folder_id: b1go3el0d8fs********
      created_at: "2023-10-27T12:14:30Z"
      name: test-disk
      type_id: network-hdd
      zone_id: {{ region-id }}-a
      size: "21474836480"
      block_size: "4096"
      status: READY
      disk_placement_policy: {}
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To get information about a [disk](../../concepts/disk.md) using {{ TF }}:

  1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_compute_disk" "my_disk" {
        disk_id = "epdi2r341gcq********"
      }

      output "my_disk_size" {
        value = data.yandex_compute_disk.my_disk.size
      }
      ```

      Where:

      * `data "yandex_compute_disk"`: Description of the [disk](../../concepts/disk.md) as a data source:
         * `disk_id`: Disk ID.
      * `output "my_disk_size"`: Output variable that contains information about the disk size:
         * `value`: Return value.

     You can replace `size` with any other parameter to get the information you need. For more information about the `yandex_compute_disk` data source parameters, see the [relevant provider documentation]({{ tf-provider-datasources-link }}/compute_disk).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display their output variables. To check the results, run this command:

      ```bash
      terraform output
      ```

      Result:

      ```text
      my_disk_size = 20
      ```

- API {#api}

  To get information about a [disk](../../concepts/disk.md), use the [get](../../api-ref/Disk/get.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/Get](../../api-ref/grpc/Disk/get.md) gRPC API call.

{% endlist %}