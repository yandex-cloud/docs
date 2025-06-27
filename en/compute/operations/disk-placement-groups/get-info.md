---
title: How to get information about a disk placement group in {{ compute-full-name }}
description: Follow this guide to get information about a disk placement group.
---

# Getting information about a disk placement group


{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your [disk placement group](../../concepts/disk-placement-group.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.compute.placement-groups_3CwzD }}**.
  1. Navigate to the **{{ ui-key.yacloud.compute.placement-groups.label_tab-disks }}** tab.
  1. Select the disk placement group.
  1. The **{{ ui-key.yacloud.compute.placement-group.overview.label_title }}** page will show the disk placement group details.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for getting information about a [disk placement group](../../concepts/disk-placement-group.md):

      ```bash
      yc compute disk-placement-group get --help
      ```

  1. Get information about a disk placement group by specifying its ID or name:

      ```bash
      yc compute disk-placement-group get <disk_placement_group_ID>
      ```

      Result:

      ```text
      id: d9h3qkknmtsl********
      folder_id: aoe3hggkil3t********
      created_at: "2023-10-27T13:01:20Z"
      name: test-placement-group
      zone_id: {{ region-id }}-d
      status: READY
      spread_placement_strategy: {}
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To get information about a [disk placement group](../../concepts/disk-placement-group.md) using {{ TF }}:

  1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_compute_disk_placement_group" "my_group" {
        group_id = "<group_ID>"
      }

      output "placement_group" {
        value = data.yandex_compute_disk_placement_group.my_group.name
      }
      ```

      Where:

      * `data "yandex_compute_disk_placement_group"`: Description of the disk placement group as a data source:
        * `group_id`: Disk placement group ID.
      * `output "placement_group"`: Output variable that contains information about the disk placement group:
        * `value`: Return value.

      You can replace `name` with any other parameter to get the information you need. For more information about the `yandex_compute_disk_placement_group` data source variables, see the [relevant provider documentation]({{ tf-provider-datasources-link }}/compute_disk_placement_group).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display their output variables. To check the results, run this command:

      ```bash
      terraform output
      ```

      Result:

      ```text
      placement_group = "test-placement-group"
      ```

- API {#api}

  To get detailed information about a [disk placement group](../../concepts/disk-placement-group.md), use the [get](../../api-ref/DiskPlacementGroup/get.md) REST API method for the [DiskPlacementGroup](../../api-ref/DiskPlacementGroup/index.md) resource or the [DiskPlacementGroupService/Get](../../api-ref/grpc/DiskPlacementGroup/get.md) gRPC API call.

{% endlist %}