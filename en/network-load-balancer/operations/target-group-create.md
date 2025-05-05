---
title: Creating a {{ network-load-balancer-name }} target group
description: Follow this guide to create a {{ network-load-balancer-name }} target group.
---

# Creating a {{ network-load-balancer-name }} target group

{% list tabs group=instructions %}

- Management console {#console}
  
  To create a new [target group](../concepts/target-resources.md):
  
  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a target group.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/target.svg) **{{ ui-key.yacloud.load-balancer.target-group.label_list }}**.
  1. Click **{{ ui-key.yacloud.load-balancer.target-group.button_create }}**.
  1. Enter a name for the target group. Follow these naming requirements:
  
      {% include [name-format](../../_includes/name-format.md) %}
  
  1. Select the VMs to add to the target group.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for creating a target group:
  
     ```bash
     yc load-balancer target-group create --help
     ```

  1. Create a target group and add the appropriate VMs as targets by specifying their settings in one or more `--target` parameters:

     ```bash
     yc load-balancer target-group create <target_group_name> \
        --target subnet-id=<subnet_ID>,`
                `address=<VM_internal_IP_address>
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In the configuration file, describe the settings for the target in the target group.

     Here is an example of the configuration file structure:

     ```hcl
     resource "yandex_lb_target_group" "foo" {
       name      = "<target_group_name>"
       target {
         subnet_id = "<subnet_ID>"
         address   = "<target_internal_IP_address>"
       }
       target {
         subnet_id = "<subnet_ID>"
         address   = "<resource_2_internal_IP_address>"
       }
     }
     ```

     * `name`: Target group name.
     * `target`: Target description:
        * `subnet_id`: ID of the subnet hosting the targets. All targets in the target group must reside within the same [availability zone](../../overview/concepts/geo-scope.md).
        * `address`: Target internal IP address.

     For more information about `yandex_lb_target_group` settings, see [this {{ TF }} article]({{ tf-provider-resources-link }}/lb_target_group).

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Create a target group.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

  To create a new target group, use the [create](../api-ref/TargetGroup/create.md) REST API method for the [TargetGroup](../api-ref/TargetGroup/index.md) resource or the [TargetGroupService/Create](../api-ref/grpc/TargetGroup/create.md) gRPC API call.
  
  After you create a target group, add targets for load distribution. To do this, use the [addTargets](../api-ref/TargetGroup/addTargets) REST API method for the [TargetGroup](../api-ref/TargetGroup/index.md) resource or the [TargetGroupService/AddTargets](../api-ref/grpc/TargetGroup/addTargets.md) gRPC API call.

{% endlist %}
