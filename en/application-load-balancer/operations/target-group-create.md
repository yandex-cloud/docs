---
title: Creating a {{ alb-full-name }} target group
description: To create a {{ alb-full-name }} target group, in the management console, select a folder where you want to store it. In the list of services, select {{ alb-name }}. In the left-hand menu, select Target groups. Click **Create target group**. Specify your target group name. Select a VM. Click **Create**.
---

# Creating an {{ alb-name }} target group

Create [VMs](../../compute/concepts/vm.md) in your previously selected [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) by following [this guide](../../compute/operations/index.md#vm-create).

To create a [target group](../concepts/target-group.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create your target group.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/target.svg) **{{ ui-key.yacloud.alb.label_target-groups }}**.
  1. Click **{{ ui-key.yacloud.alb.button_target-group-create }}**.
  1. Specify the target group name and description.
  1. Under **{{ ui-key.yacloud.alb.label_targets }}**, select a VM from the list or add the target manually:
     1. In the **{{ ui-key.yacloud.alb.column_target }}** field, specify the target's IP and select its [subnet](../../vpc/concepts/network.md#subnet).
     1. Optionally, if the target's [IP address](../../vpc/concepts/address.md) does not belong to [{{ vpc-full-name }}](../../vpc/), select **{{ ui-key.yacloud.alb.label_target-private-ip }}**.

        For example, you can specify a private IPv4 address from your data center connected to {{ yandex-cloud }} through [{{ interconnect-full-name }}](../../interconnect/). This IP address must belong to the [RFC 1918 private address range](https://datatracker.ietf.org/doc/html/rfc1918#section-3). For more information, see the [subnets](../../vpc/concepts/network.md#subnet) article.


     1. Click **{{ ui-key.yacloud.alb.button_add-target }}**.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../cli/) command for creating a target group:

     ```bash
     yc alb target-group create --help
     ```

  1. Run this command, with the target group name, [subnet](../../vpc/concepts/network.md#subnet) name, and VM’s [internal IP addresses](../../vpc/concepts/address.md#internal-addresses) specified:

     ```bash
     yc alb target-group create \
       --name <target_group_name> \
       --target subnet-name=<subnet_name>,ip-address=<VM_1_internal_IP_address> \
       --target subnet-name=<subnet_name>,ip-address=<VM_2_internal_IP_address> \
       --target subnet-name=<subnet_name>,ip-address=<VM_3_internal_IP_address>
     ```

     Result:

      ```text
      id: a5d751meibht********
      name: <target_group_name>
      folder_id: aoerb349v3h4********
      targets:
      - ip_address: <VM_1_internal_IP_address>
        subnet_id: fo2tgfikh3he********
      - ip_address: <VM_2_internal_IP_address>
        subnet_id: fo2tgfikh3he********
      - ip_address: <VM_3_internal_IP_address>
        subnet_id: fo2tgfikh3he********
      created_at: "2021-02-11T11:16:27.770674538Z
      ```

      You can also create a target group with resources outside [{{ vpc-full-name }}](../../vpc/), e.g., in your data center connected to {{ yandex-cloud }} via [{{ interconnect-full-name }}](../../interconnect/). Target IP addresses must belong to the [RFC 1918 private address range](https://datatracker.ietf.org/doc/html/rfc1918#section-3). For more information, see the [subnets](../../vpc/concepts/network.md#subnet) article.


      Run this command, with the target group name and resource’s private IPv4 addresses specified:

      ```bash
      yc alb target-group create \
        --name <target_group_name> \
        --target private-ip-address=true,ip-address=<resource_1_IPv4_private_address> \
        --target private-ip-address=true,ip-address=<resource_2_IPv4_private_address> \
        --target private-ip-address=true,ip-address=<resource_3_IPv4_private_address>
      ```

      Result:

      ```text
      id: ds7s2dld2usr********
      name: <target_group_name>
      folder_id: aoerb349v3h4********
      targets:
        - ip_address: <resource_1_IPv4_private_address>
          private_ipv4_address: true
        - ip_address: <resource_2_IPv4_private_address>
          private_ipv4_address: true
        - ip_address: <resource_3_IPv4_private_address>
          private_ipv4_address: true
      created_at: "2023-07-25T08:55:14.172526884Z"
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In the {{ TF }} configuration file, specify your new resource settings:

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

     Where `yandex_alb_target_group` specifies target group settings:
     * `name`: Target group name.
     * `target`: Target resource settings:
       * `subnet_id`: ID of the [subnet](../../vpc/concepts/network.md#subnet) hosting the VM. You can get the list of available subnets using the `yc vpc subnet list` [CLI](../../cli/) command.
       * `ip_address`: VM internal IP address. You can get the list of [internal IP addresses](../../vpc/concepts/address.md#internal-addresses) using the following CLI command: `yc vpc subnet list-used-addresses --id <subnet_ID>`.

     You can also create a target group with resources outside [{{ vpc-full-name }}](../../vpc), e.g., in your data center connected to {{ yandex-cloud }} via [{{ interconnect-full-name }}](../../interconnect/):

     ```hcl
     resource "yandex_alb_target_group" "foo" {
       name                   = "<target_group_name>"

       target {
         private_ipv4_address = true
         ip_address           = "<resource_1_IPv4_private_address>"
       }

       target {
         private_ipv4_address = true
         ip_address           = "<resource_2_IPv4_private_address>"
       }

       target {
         private_ipv4_address = true
         ip_address           = "<resource_3_IPv4_private_address>"
       }
     }
     ```


     Where `yandex_alb_target_group` specifies target group settings:
     * `name`: Target group name.
     * `target`: Target resource settings:
       * `private_ipv4_address`: Setting indicating that the IP address is outside {{ vpc-name }}.
       * `ip_address`: Resource’s private IPv4 address. This IP address must belong to the [RFC 1918 private address range](https://datatracker.ietf.org/doc/html/rfc1918#section-3). For more information, see the [subnets](../../vpc/concepts/network.md#subnet) article.

     For more information about `yandex_alb_target_group` properties, see the relevant [{{ TF }} article]({{ tf-provider-alb-targetgroup }}).
  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources. You can check the new resources in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/) command:

     ```bash
     yc alb target-group list
     ```

- API {#api}

  Use the [create](../api-ref/TargetGroup/create.md) REST API method for the [TargetGroup](../api-ref/TargetGroup/index.md) resource or the [TargetGroupService/Create](../api-ref/grpc/TargetGroup/create.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](../tutorials/application-load-balancer-website/index.md)
* [{#T}](../tutorials/logging.md)
* [{#T}](../tutorials/alb-with-ddos-protection/console.md)
