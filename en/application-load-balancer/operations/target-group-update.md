# Editing a target group

You can add or remove [VMs](../../compute/concepts/vm.md) from a [target group](../concepts/target-group.md).

## Add a VM to a target group {#add-targets}

To add a VM to a target group:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select your target group [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/target.svg) **{{ ui-key.yacloud.alb.label_target-groups }}**.
  1. Click your target group name.
  1. Click **{{ ui-key.yacloud.alb.button_add-targets }}**.
  1. Select a VM from the list or add the target manually:
     1. In the **{{ ui-key.yacloud.alb.column_target }}** field, specify the target's [IP address](../../vpc/concepts/address.md) and select its [subnet](../../vpc/concepts/network.md#subnet).
     1. Optionally, if the target's IP address does not belong to [{{ vpc-full-name }}](../../vpc/), select **{{ ui-key.yacloud.alb.label_target-private-ip }}**.

        For example, you can specify a private IPv4 address from your data center connected to {{ yandex-cloud }} through [{{ interconnect-full-name }}](../../interconnect/). This IP address must belong to the [RFC 1918 private address range](https://datatracker.ietf.org/doc/html/rfc1918#section-3). For more information, see the [subnets](../../vpc/concepts/network.md#subnet) article.


     1. Click **{{ ui-key.yacloud.alb.button_add-target }}**.
  1. Click **{{ ui-key.yacloud.common.add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../cli/) command for adding resources to target groups:

     ```bash
     yc alb target-group add-targets --help
     ```

  1. Run this command, with your target group name, the [subnet](../../vpc/concepts/network.md#subnet) name, and the VM’s [internal IP address](../../vpc/concepts/address.md#internal-addresses) specified:

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

     When editing a target group, you can add targets outside the [{{ vpc-full-name }}](../../vpc/), e.g., residing in your data center connected to {{ yandex-cloud }} via [{{ interconnect-full-name }}](../../interconnect/). Target IP addresses must belong to the [RFC 1918 private address range](https://datatracker.ietf.org/doc/html/rfc1918#section-3). For more information, see the [subnets](../../vpc/concepts/network.md#subnet) article.


     Run this command, with your target group name and the target’s private IPv4 address specified:

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

  1. Open the {{ TF }} configuration file and add the `target` section to your target group description:

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

     Where `yandex_alb_target_group` specifies target group settings:
     * `name`: Target group name.
     * `target`: Target settings:
       * `subnet_id`: ID of the [subnet](../../vpc/concepts/network.md#subnet) hosting the VM. You can get the list of available subnets using the `yc vpc subnet list` [CLI](../../cli/) command.
       * `ip_address`: VM [internal IP address](../../vpc/concepts/address.md#internal-addresses). You can get the list of internal IP addresses using the following CLI command: `yc vpc subnet list-used-addresses --id <subnet_ID>`.

     When editing a target group, you can add targets outside the [{{ vpc-full-name }}](../../vpc/), e.g., residing in your data center connected to {{ yandex-cloud }} via [{{ interconnect-full-name }}](../../interconnect/):

     ```hcl
     resource "yandex_alb_target_group" "foo" {
       name                   = "<target_group_name>"

       target {
         private_ipv4_address = true
         ip_address           = "<private_IPv4_address_of_target_1>"
       }

       target {
         private_ipv4_address = true
         ip_address           = "<private_IPv4_address_of_target_2s>"
       }

       target {
         private_ipv4_address = true
         ip_address           = "<private_IPv4_address_of_target_3>"
       }
     }
     ```


     Where `yandex_alb_target_group` specifies target group settings:
     * `name`: Target group name.
     * `target`: Target settings:
       * `private_ipv4_address`: Setting indicating that the IP address is outside {{ vpc-name }}.
       * `ip_address`: Resource’s private IPv4 address. This IP address must belong to the [RFC 1918 private address range](https://datatracker.ietf.org/doc/html/rfc1918#section-3). For more information, see the [subnets](../../vpc/concepts/network.md#subnet) article.

     For more information about `yandex_alb_target_group` properties, see the relevant [{{ TF }} article]({{ tf-provider-alb-targetgroup }}).
  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     You can check target group updates in the [management console]({{ link-console-main }}) or using this CLI command:

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

  1. In the [management console]({{ link-console-main }}), select the folder with your target group.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/target.svg) **{{ ui-key.yacloud.alb.label_target-groups }}**.
  1. Click your target group name.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the VM you need, then select **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for removing targets from a target group:

     ```bash
     yc alb target-group remove-targets --help
     ```

  1. Run this command with your target group name, the subnet name, and the VM’s internal IP address specified:

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

     To remove a target group resource residing outside {{ vpc-name }}, e.g., in your data center connected to {{ yandex-cloud }} via {{ interconnect-name }}, run this command, with the target group name and the resource’s private IPv4 address specified:

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

  1. Open the {{ TF }} configuration file and delete the `target` section with your VM’s IP address from the target group description:

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

     For more information about `yandex_alb_target_group` properties, see the relevant [{{ TF }} article]({{ tf-provider-alb-targetgroup }}).
  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     You can check target group updates in the [management console]({{ link-console-main }}) or using this CLI command:

     ```bash
     yc alb target-group get --name <target_group_name>
     ```

- API {#api}

  Use the [removeTargets](../api-ref/TargetGroup/removeTargets.md) REST API method for the [TargetGroup](../api-ref/TargetGroup/index.md) resource or the [TargetGroup/RemoveTargets](../api-ref/grpc/TargetGroup/removeTargets.md) gRPC API call.

{% endlist %}