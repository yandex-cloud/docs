# Information about current target groups

You can request detailed information about each target group you created.

## Getting a list of target groups in a folder {#list}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
    1. In the left-hand panel, select ![trgroups.svg](../../_assets/console-icons/target.svg) **{{ ui-key.yacloud.load-balancer.target-group.label_list }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of target groups in the default folder, run this command:

    ```bash
    yc load-balancer target-group list
    ```

    Result:

    ```text
    +----------------------+-------------+---------------------+-------------+--------------+
    |          ID          |    NAME     |       CREATED       |  REGION ID  | TARGET COUNT |
    +----------------------+-------------+---------------------+-------------+--------------+
    | enp1d7t5pdea******** | test-group1 | 2023-02-03 07:17:56 | {{ region-id }} |            1 |
    | ...                  |             |                     |             |              |
    +----------------------+-------------+---------------------+-------------+--------------+
    ```

- API {#api}

    Use the [list](../api-ref/TargetGroup/list.md) API method, providing the folder ID in the `folderId` parameter of your request.

{% endlist %}

## Getting detailed information about a target group {#get}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing your [target group](../concepts/target-resources.md).
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
    1. In the left-hand panel, select ![trgroups.svg](../../_assets/console-icons/target.svg) **{{ ui-key.yacloud.load-balancer.target-group.label_list }}**.
    1. Click your group name.
    1. The **Overview** page will show the target group details.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To find out the [target group](../concepts/target-resources.md) name or unique ID, [get the list](#list) of target groups in the folder.

    1. See the description of the CLI command for getting information about a target group:
  
        ```bash
        yc load-balancer target-group --help
        ```

    1. Get information about a target group by specifying its name or ID:

        ```bash
        yc load-balancer target-group get <target_group_name_or_ID>
        ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To get information about a [target group](../concepts/target-resources.md) using {{ TF }}:

  1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_lb_target_group" "my_target_group" {
        target_group_id = "<target_group_ID>"
      }

      output "target_group" {
        value = data.yandex_lb_target_group.my_target_group.created_at
      }
      ```

      Where:

      * `data "yandex_lb_target_group"`: Description of the target group as a data source:
         * `target_group_id`: Target group ID.
      * `output "target_group"`: Output variable with target group creation date information:
         * `value`: Return value.

      You can replace `created_at` with any other parameter to get the information you need. For more information about the `yandex_lb_target_group` data source properties, see [this {{ TF }} provider article]({{ tf-provider-datasources-link }}/datasource_lb_target_group).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display their output variables. To check the results, run this command:

      ```bash
      terraform output
      ```

      Result:

      ```bash
      target_group = "2024-03-20T23:43:56Z"
      ```

- API {#api}

    Use the [get](../api-ref/TargetGroup/get.md) API method, providing the target group ID in the `targetGroupId` parameter of your request.

    You can get the target group ID with the [list of target groups in the folder](#list).

{% endlist %}
