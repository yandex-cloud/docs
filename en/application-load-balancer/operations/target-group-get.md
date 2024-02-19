---
title: "How to get information about a target group in {{ alb-full-name }}"
---

# Getting information about a target group

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the directory where the [target group](../concepts/target-group.md) is located.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/target.svg) **{{ ui-key.yacloud.alb.label_target-groups }}**.
   1. Select the target group.
   1. The **{{ ui-key.yacloud.common.overview }}** page will display detailed information about the group.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View the description of the CLI command to get information about a [target group](../concepts/target-group.md):

      ```bash
      yc alb target-group get --help
      ```

   1. Get information about the target group by specifying its ID or name:

      ```bash
      yc alb target-group get <target_group_name>
      ```

      Result:

      ```bash
      id: ds7cjrs15ero********
      name: alb-tg
      folder_id: b1geoelk7fld********
      targets:
        - ip_address: 192.168.3.34
          subnet_id: b0cqh32phmc1********
        - ip_address: 192.168.2.4
          subnet_id: e2ltekraekpc********
        - ip_address: 192.168.1.10
          subnet_id: e9bns2fv233c********
      created_at: "2023-10-24T12:21:09.159841076Z"
      ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To get information about a [target group](../concepts/target-group.md) using {{ TF }}:

   1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_alb_target_group" "my_tg" {
        target_group_id = "<target_group_ID>"
      }

      output "target_group" {
        value = data.yandex_alb_target_group.my_tg.target
      }
      ```

      Where:

      * `data "yandex_alb_target_group"`: Description of the target group as a data source:
         * `target_group_id`: Target group ID.
      * `output "target_group"`: Output variable that contains information about the connected resources of the target group:
         * `value`: Returned value.

      You can replace `target` with any other parameter to get the information you need. For more information about the `yandex_alb_target_group` data source parameters, see the [provider documentation]({{ tf-provider-datasources-link }}/datasource_alb_target_group).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display the output variable values in the terminal. To check the results, run:

      ```bash
      terraform output
      ```

      Result:

      ```text
      target_group = tolist([
        {
          "ip_address" = "10.129.0.29"
          "private_ipv4_address" = false
          "subnet_id" = "e2lfebujacgf********"
        },
      ])
      ```

- API {#api}

   For detailed information about a [target group](../concepts/target-group.md), use the [get](../api-ref/TargetGroup/get.md) REST API method for the [TargetGroup](../api-ref/TargetGroup/index.md) resource or the [TargetGroupService/Get](../api-ref/grpc/target_group_service.md#Get) gRPC API call.

{% endlist %}
