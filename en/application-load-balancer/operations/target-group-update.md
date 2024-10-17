# Editing a target group

You can add or remove [VMs](../../compute/concepts/vm.md) from a [target group](../concepts/target-group.md).

## Add a VM to a target group {#add-targets}

To add a VM to a target group:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where the target group was created.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/target.svg) **{{ ui-key.yacloud.alb.label_target-groups }}**.
   1. Click the name of the target group you need.
   1. Click **{{ ui-key.yacloud.alb.button_add-targets }}**.
   1. Select a VM from the list or add the target manually:
      1. In the **{{ ui-key.yacloud.alb.column_target }}** field, specify the target's [IP address](../../vpc/concepts/address.md) and select the [subnet](../../vpc/concepts/network.md#subnet).
      1. (Optional) If the target's IP address does not belong to [{{ vpc-full-name }}](../../vpc/), select **{{ ui-key.yacloud.alb.label_target-private-ip }}**.

         For example, specify a private IPv4 address belonging to your data center connected to {{ yandex-cloud }} through [{{ interconnect-full-name }}](../../interconnect/). The IP address must be within the [RFC 1918 private ranges](https://datatracker.ietf.org/doc/html/rfc1918#section-3). For more information, see [Subnets](../../vpc/concepts/network.md#subnet).


      1. Click **{{ ui-key.yacloud.alb.button_add-target }}**.
   1. Click **{{ ui-key.yacloud.common.add }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the [CLI](../../cli/) command to add resources to target groups:

      ```bash
      yc alb target-group add-targets --help
      ```

   1. Run the command, specifying the target group name, [subnet](../../vpc/concepts/network.md#subnet) name, and the [internal IP address](../../vpc/concepts/address.md#internal-addresses) of the VM:

      ```bash
      yc alb target-group add-targets \
        --name <target_group_name> \
        --target subnet-name=<subnet_name>,ip-address=<VM_internal_IP_address>
      ```

      Result:

      ```text
      done (1s)
      id: a5d751meibht********
      name: <target_group_name>
      targets:
      ...
        - ip_address: <VM_internal_IP_address>
          subnet_id: fo2tgfikh3he********
      created_at: "2021-02-11T11:16:27.770674538Z"
      ```

      You can also add targets to a target group that reside outside [{{ vpc-full-name }}](../../vpc/), e.g., in your data center connected to {{ yandex-cloud }} via [{{ interconnect-full-name }}](../../interconnect/). The IP addresses of targets must be within the [RFC 1918 private ranges](https://datatracker.ietf.org/doc/html/rfc1918#section-3). For more information, see [Subnets](../../vpc/concepts/network.md#subnet).


      Run the following command, specifying the target group name and private IPv4 address of the target as parameters:

      ```bash
      yc alb target-group add-targets \
        --name <target_group_name> \
        --target private-ip-address=true,ip-address=<target_private_IPv4_address>
      ```

      Result:

      ```text
      done (1s)
      id: a5d751meibht4ev26...
      name: <target_group_name>
      targets:
      ...
        - ip_address: <target_private_IPv4_address>
          private_ipv4_address: true
      created_at: "2023-07-25T08:55:14.172526884Z"
      ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

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
         * `subnet_id`: ID of the [subnet](../../vpc/concepts/network.md#subnet) hosting the VM. You can get a list of available subnets using the [CLI](../../cli/) command: `yc vpc subnet list`.
         * `ip_address`: VM [internal IP address](../../vpc/concepts/address.md#internal-addresses). You can get a list of internal IP addresses using the following CLI command: `yc vpc subnet list-used-addresses --id <subnet_ID>`.

      You can also add targets to a target group that reside outside [{{ vpc-full-name }}](../../vpc/), e.g., in your data center connected to {{ yandex-cloud }} via [{{ interconnect-full-name }}](../../interconnect/):

      ```hcl
      resource "yandex_alb_target_group" "foo" {
        name                   = "<target_group_name>"

        target {
          private_ipv4_address = true
          ip_address           = "<private_IPv4_address_of_target_1>"
        }

        target {
          private_ipv4_address = true
          ip_address           = "<private_IPv4_address_of_target_2>"
        }

        target {
          private_ipv4_address = true
          ip_address           = "<private_IPv4_address_of_target_3>"
        }
      }
      ```


      Where `yandex_alb_target_group` specifies the target group parameters:
      * `name`: Target group name.
      * `target`: Target parameters:
         * `private_ipv4_address`: Parameter indicating that the IP is outside {{ vpc-name }}.
         * `ip_address`: Private IPv4 address of the target. The IP addresses must be within the [RFC 1918 private ranges](https://datatracker.ietf.org/doc/html/rfc1918#section-3). For more information, see [Subnets](../../vpc/concepts/network.md#subnet).

      For more information about the `yandex_alb_target_group` resource parameters, see the [{{ TF }} provider documentation]({{ tf-provider-alb-targetgroup }}).
   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      You can check the target group update using the [management console]({{ link-console-main }}) or this CLI command:

      ```bash
      yc alb target-group get --name <target_group_name>
      ```

- API {#api}

   Use the [addTargets](../api-ref/TargetGroup/addTargets.md) REST API method for the [TargetGroup](../api-ref/TargetGroup/index.md) resource or the [TargetGroupService/AddTargets](../api-ref/grpc/TargetGroup/addTargets.md) gRPC API call.

{% endlist %}

## Remove a VM from a target group {#remove-targets}

To remove a VM from a target group:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where the target group was created.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/target.svg) **{{ ui-key.yacloud.alb.label_target-groups }}**.
   1. Click the name of the target group you need.
   1. To the right of the VM, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

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

      ```text
      id: ds7urm6dn6cm********
      name: <target_group_name>
      folder_id: aoerb349v3h4********
      created_at: "2023-06-10T13:14:55.239094324Z"
      ```

      To remove a target residing outside {{ vpc-name }}, e.g., in your data center connected to {{ yandex-cloud }} via {{ interconnect-name }}, from your target group, run the following command, specifying the target group name and the private IPv4 address of the target:

      ```bash
      yc alb target-group remove-targets \
        --name <target_group_name> \
        --target private-ip-address=true,ip-address=<target_private_IPv4_address>
      ```

      Result:

      ```text
      id: ds7urm6dn6cm********
      name: <target_group_name>
      folder_id: aoerb349v3h4********
      created_at: "2023-06-10T13:14:55.239094324Z"
      ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

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

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      You can check the target group update using the [management console]({{ link-console-main }}) or this CLI command:

      ```bash
      yc alb target-group get --name <target_group_name>
      ```

- API {#api}

   Use the [removeTargets](../api-ref/TargetGroup/removeTargets.md) REST API method for the [TargetGroup](../api-ref/TargetGroup/index.md) resource or the [TargetGroup/RemoveTargets](../api-ref/grpc/TargetGroup/removeTargets.md) gRPC API call.

{% endlist %}