---
title: "Creating an {{ alb-full-name }} target group"
description: "To create an {{ alb-full-name }} target group, in the management console, select the folder to create your target group in. In the list of services, select {{ alb-name }}. In the left-hand menu, select **Target groups**. Click **Create target group**. Enter the name of the target group. Select the VMs. Click **Create**."
---

# Creating an {{ alb-name }} target group

Create VMs in the working folder by following the [guide](../../compute/operations/index.md#vm-create).

To create a [target group](../concepts/target-group.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to create your target group in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/target.svg) **{{ ui-key.yacloud.alb.label_target-groups }}**.
   1. Click **{{ ui-key.yacloud.alb.button_target-group-create }}**.
   1. Enter a name and description for the target group.
   1. Under **{{ ui-key.yacloud.alb.label_targets }}**, select a VM from the list or add the target manually:

      1. In the **{{ ui-key.yacloud.alb.column_target }}** field, specify the target's IP and select the [subnet](../../vpc/concepts/network.md#subnet).

      
      1. (Optional) If the target's IP does not belong to {{ vpc-name }}, select **{{ ui-key.yacloud.alb.label_target-private-ip }}**.

         For example, specify a private IPv4 address belonging to your data center connected to {{ yandex-cloud }} through [{{ interconnect-name }}](../../interconnect/index.yaml). The IP address must be within the [RFC 1918 private ranges](https://datatracker.ietf.org/doc/html/rfc1918#section-3). For more information, see [Subnets](../../vpc/concepts/network.md#subnet).


      1. Click **{{ ui-key.yacloud.alb.button_add-target }}**.

   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's create target group command:

      ```bash
      yc alb target-group create --help
      ```

   1. Run the following command, specifying the target group name, [subnet](../../vpc/concepts/network.md#subnet) name, and VM internal IPs as parameters:

      ```bash
      yc alb target-group create \
        --name <target_group_name> \
        --target subnet-name=<subnet_name>,ip-address=<VM_1_internal_IP_address> \
        --target subnet-name=<subnet_name>,ip-address=<VM_2_internal_IP_address> \
        --target subnet-name=<subnet_name>,ip-address=<VM_3_internal_IP_address>
      ```

      Result:

      ```yaml
      id: a5d751meibht4ev26...
      name: <target_group_name>
      folder_id: aoerb349v3h4bupph...
      targets:
      - ip_address: <VM_1_internal_IP_address>
        subnet_id: fo2tgfikh3hergif2...
      - ip_address: <VM_2_internal_IP_address>
        subnet_id: fo2tgfikh3hergif2...
      - ip_address: <VM_3_internal_IP_address>
        subnet_id: fo2tgfikh3hergif2...
      created_at: "2021-02-11T11:16:27.770674538Z
      ```

      You can also create a target group with targets residing outside {{ vpc-name }}, e.g., in your data center connected to {{ yandex-cloud }} through [{{ interconnect-name }}](../../interconnect/index.yaml). The target IP addresses must be within the [RFC 1918 private ranges](https://datatracker.ietf.org/doc/html/rfc1918#section-3). For more information, see [Subnets](../../vpc/concepts/network.md#subnet).

      Run the following command, specifying the target group name and and target private IPv4 addresses as parameters:

      ```bash
      yc alb target-group create \
        --name <target_group_name> \
        --target private-ip-address=true,ip-address=<private_IPv4_address_of_target_1> \
        --target private-ip-address=true,ip-address=<private_IPv4_address_of_target_2> \
        --target private-ip-address=true,ip-address=<private_IPv4_address_of_target_3>
      ```

      Result:

      ```yaml
      id: ds7s2dld2usr59qbu...
      name: <target_group_name>
      folder_id: aoerb349v3h4bupph...
      targets:
        - ip_address: <private_IPv4_address_of_target_1>
          private_ipv4_address: true
        - ip_address: <private_IPv4_address_of_target_2>
          private_ipv4_address: true
        - ip_address: <private_IPv4_address_of_target_3>
          private_ipv4_address: true
      created_at: "2023-07-25T08:55:14.172526884Z"
      ```

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. In the {{ TF }} configuration file, describe the parameters of the resource to create:

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

      Where `yandex_alb_target_group` specifies the target group parameters:
      * `name`: Target group name.
      * `target`: Target parameters:
         * `subnet_id`: ID of the [subnet](../../vpc/concepts/network.md#subnet) hosting the VM. You can get a list of available subnets using the [CLI](../../cli/quickstart.md) command: `yc vpc subnet list`.
         * `ip_address`: VM internal IP. You can get a list of internal IP addresses using the [CLI](../../cli/quickstart.md) command: `yc vpc subnet list-used-addresses --id <subnet_ID>`.

      You can also create a target group with targets residing outside {{ vpc-name }}, e.g., in your data center connected to {{ yandex-cloud }} through [{{ interconnect-name }}](../../interconnect/index.yaml):

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
   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```bash
      yc alb target-group list
      ```

- API

   Use the [create](../api-ref/TargetGroup/create.md) REST API method for the [TargetGroup](../api-ref/TargetGroup/index.md) resource or the [TargetGroupService/Create](../api-ref/grpc/target_group_service.md#Create) gRPC API call.

{% endlist %}
