---
title: How to get information about a placement group in {{ compute-full-name }}
---

# Getting information about a placement group

{% list tabs %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder the [placement group](../../concepts/placement-groups.md) is in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.compute.placement-groups_3CwzD }}**.
  1. Select the group.
  1. The **{{ ui-key.yacloud.compute.placement-group.overview.label_title }}** page will show the VM placement group details.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for getting information about a [placement group](../../concepts/placement-groups.md):

      ```bash
      yc compute placement-group get --help
      ```

  1. Get information about a placement group by specifying its name or ID:

      ```bash
      yc compute placement-group get <placement_group_name>
      ```

      Result:

      ```text
      id: fd8j3mm3229m********
      folder_id: b1g86q4m5vej********
      created_at: "2023-10-19T10:36:38Z"
      name: test-group
      spread_placement_strategy: {}
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To get information about a [placement group](../../concepts/placement-groups.md) using {{ TF }}:

  1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_compute_placement_group" "my_group" {
        group_id = "<placement_group_ID>"
      }

      output "placement_group" {
        value = data.yandex_compute_placement_group.my_group.created_at
      }
      ```

      Where:

      * `data "yandex_compute_placement_group"`: Description of the placement group as a data source:
        * `group_id`: Placement group ID.
      * `output "placement_group"`: Output variable that contains information about the placement group creation time:
        * `value`: Return value.

      You can replace `created_at` with any other parameter to get the information you need. For more information about the `yandex_compute_placement_group` data source properties, see [this {{ TF }} provider article]({{ tf-provider-datasources-link }}/compute_placement_group).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display their output variables. To check the results, run this command:

      ```bash
      terraform output
      ```

      Result:

      ```text
      placement_group = "2024-03-18T17:27:14Z"
      ```

- API {#api}

  To get detailed information about a [placement group](../../concepts/placement-groups.md), use the [get](../../api-ref/PlacementGroup/get.md) REST API method for the [PlacementGroup](../../api-ref/PlacementGroup/index.md) resource or the [PlacementGroupService/Get](../../api-ref/grpc/PlacementGroup/get.md) gRPC API call.

{% endlist %}
