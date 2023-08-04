# Editing target group

You can add or remove instances from a target group.

## Add a VM to a target group {#add-targets}

To add a VM to a target group:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the target group was created.
   1. Select **{{ alb-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/trgroups.svg) **Target groups**.
   1. Click on the name of the group you need.
   1. Click **Add targets**.
   1. Select a VM from the list or add the target manually:
      1. In the **IP address** field, specify the target's IP and select the [subnet](../../vpc/concepts/network.md#subnet).

      
      1. (Optional) If the target's IP does not belong to {{ vpc-name }}, select **{{ ui-key.yacloud.alb.label_target-private-ip }}**.

         For example, specify the IP belonging to your data center connected to {{ yandex-cloud }} via [{{ interconnect-name }}](../../interconnect/). The IP address must be within the [RFC 1918 private ranges](https://datatracker.ietf.org/doc/html/rfc1918#section-3).


      1. Click **Add target resource**.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for adding resources to target groups:

      ```bash
      yc alb target-group add-targets --help
      ```

   1. Run the command, specifying the target group name, subnet name, and internal IP address of the VM:

      ```bash
      yc alb target-group add-targets \
        --name <target_group_name> \
        --target subnet-name=<subnet_name>,ip-address=<VM_internal_IP_address>
      ```

      Result:

      ```yaml
      done (1s)
      id: a5d751meibht4ev26...
      name: <target_group_name>
      ...
      - ip_address: <VM_internal_IP_address>
        subnet_id: fo2tgfikh3hergif2...
      created_at: "2021-02-11T11:16:27.770674538Z"
      ```

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see our documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Open the {{ TF }} configuration file and add the target section with `target` parameters to the fragment describing the target group:

      ```hcl
      resource "yandex_alb_target_group" "foo" {
        name           = "<target_group_name>"

        target {
          subnet_id    = "<subnet_ID>"
          ip_address   = "<VM_1_internal_IP_address>"
        }

        target {
          subnet_id    = "<subnet_ID>"
          ip_address   = "<VM_2_internal_IP_address>"
        }

        target {
          subnet_id    = "<subnet_ID>"
          ip_address   = "<VM_3_internal_IP_address>"
        }

        target {
          subnet_id    = "<subnet_ID>"
          ip_address   = "<VM_4_internal_IP_address>"
        }
      }
      ```

      Where `yandex_alb_target_group` specifies the target group parameters:
      * `name`: Target group name.
      * `target`: Target parameters:
         * `subnet_id`: ID of the subnet hosting the VM. You can get a list of available subnets using the [CLI](../../cli/quickstart.md) command: `yc vpc subnet list`.
         * `ip_address`: VM's internal IP. You can get a list of internal IP addresses using the [CLI](../../cli/quickstart.md) command: `yc vpc subnet list-used-addresses --id <subnet ID>`.

      For more information about the `yandex_alb_target_group` resource parameters, see the [{{ TF }} provider documentation]({{ tf-provider-alb-targetgroup }}).
   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      You can verify that the target group has been updated in the [management console]({{ link-console-main }}) or using the following [CLI](../../cli/quickstart.md) command:

      ```bash
      yc alb target-group get --name <target_group_name>
      ```

- API

   Use the [addTargets](../api-ref/TargetGroup/addTargets.md) REST API method for the [TargetGroup](../api-ref/TargetGroup/index.md) resource or the [TargetGroupService/AddTargets](../api-ref/grpc/target_group_service.md#AddTargets) gRPC API call.

{% endlist %}

## Remove a VM from a target group {#remove-targets}

To remove a VM from a target group:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the target group was created.
   1. Select **{{ alb-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/trgroups.svg) **Target groups**.
   1. Click on the name of the group you need.
   1. To the right of the VM, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Delete target**.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for removing resources from a target group:

      ```bash
      yc alb target-group remove-targets --help
      ```

   1. Run the following command with the target group name, subnet name, and internal IP address of the VM:

      ```bash
      yc alb target-group remove-targets \
        --name <target_group_name> \
        --target subnet-name=<subnet_name>,ip-address=<VM_internal_IP_address>
      ```

      Result:

      ```yaml
      id: ds7urm6dn6cm48ba7...
      name: <target_group_name>
      folder_id: aoerb349v3h4bupph...
      created_at: "2023-06-10T13:14:55.239094324Z"
      ```

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see our documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Open the {{ TF }} configuration file and delete the `target` section with the IP address of the VM to be removed in the fragment describing the target group:

      Sample target group description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_alb_target_group" "foo" {
        name           = "<target_group_name>"

        target {
          subnet_id    = "<subnet_ID>"
          ip_address   = "<VM_1_internal_IP_address>"
        }

        target {
          subnet_id    = "<subnet_ID>"
          ip_address   = "<VM_2_internal_IP_address>"
        }

        target {
          subnet_id    = "<subnet_ID>"
          ip_address   = "<VM_3_internal_IP_address>"
        }
      }
      ```

      For more information about the `yandex_alb_target_group` resource parameters, see the [{{ TF }} provider documentation]({{ tf-provider-alb-targetgroup }}).
   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      You can verify that the target group has been updated in the [management console]({{ link-console-main }}) or using the following [CLI](../../cli/quickstart.md) command:

      ```bash
      yc alb target-group get --name <target_group_name>
      ```

- API

   Use the [removeTargets](../api-ref/TargetGroup/removeTargets.md) REST API method for the [TargetGroup](../api-ref/TargetGroup/index.md) resource or the [TargetGroup/RemoveTargets](../api-ref/grpc/target_group_service.md#RemoveTargets) gRPC API call.

{% endlist %}