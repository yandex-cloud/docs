# Create a {{ network-load-balancer-name }} target group

{% list tabs %}

- Management console

   To create a new [target group](../concepts/target-resources.md):

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create a target group.
   1. In the list of services, select **{{ network-load-balancer-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/trgroups.svg) **Target groups**.
   1. Click **Create target group**.
   1. Enter the name of the target group.

      {% include [name-format](../../_includes/name-format.md) %}

   1. Select the VMs to add to the target group.
   1. Click **Create**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's create target group command:

      ```bash
      yc load-balancer target-group create --help
      ```

   1. Create a target group and add the appropriate VMs to it as targets by specifying the VM parameters in one or more `--target` parameters:

      ```bash
      yc load-balancer target-group create <target group name> \
         --target subnet-id=<subnet ID>,`
                 `address=<VM internal IP>
      ```

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Describe the parameters of the target group resource in a configuration file:

      Example of the configuration file structure:

      ```hcl
      resource "yandex_lb_target_group" "foo" {
        name      = "<target group name>"
        target {
          subnet_id = "<subnet ID>"
          address   = "<internal IP address of resource>"
        }
        target {
          subnet_id = "<subnet ID>"
          address   = "<internal IP address of resource 2>"
        }
      }
      ```

      * `name`: Target group name.
      * `target`: Target resource description:
         * `subnet_id`: ID of the subnet to which target objects are connected. All targets in the target group must reside in the same availability zone.
         * `address`: Resource internal IP address.

      For more information about the `yandex_lb_target_group` parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/lb_target_group).

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Create a target group.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

   Use the [create](../api-ref/TargetGroup/create.md) API method and include the following information in the request:

   * ID of the folder where the target group should be placed, in the `folderId` parameter.
   * Target group name in the `name` parameter.
   * Subnet ID and target internal IP in the `targets` parameter.

   You can add targets after creating the target group. To do this, use the [addTargets](../api-ref/TargetGroup/addTargets) API method.

- API

   To create a new target group, use the [create](../api-ref/TargetGroup/create.md) REST API method for the [TargetGroup](../api-ref/TargetGroup/index.md) resource or the [TargetGroupService/Create](../api-ref/grpc/target_group_service.md#Create) gRPC API call.

   Once the target group has been created, add targets that the load will be distributed across. To do this, use the [addTargets](../api-ref/TargetGroup/addTargets) REST API method for the [TargetGroup](../api-ref/TargetGroup/index.md) resource or the [TargetGroupService/AddTargets](../api-ref/grpc/target_group_service.md#AddTargets) gRPC API call.

{% endlist %}
