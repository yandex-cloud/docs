---
title: "Create an {{ alb-full-name }} target group"
description: "To create an {{ alb-full-name }} target group, in the management console, select the folder to create your target group in. In the list of services, select {{ alb-name }}. In the left-hand menu, select Target groups. Click Create target group. Enter the name of the target group. Select the VMs. Click Create."
---

# Create a target group {{ alb-name }}

Create VMs in the working folder by following the [instructions](../../compute/operations/index.md#vm-create).

To create a target group:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to create your target group in.
   1. In the list of services, select **{{ alb-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/trgroups.svg) **Target groups**.
   1. Click **Create target group**.
   1. Enter a name and description for the target group.
   1. Under **Targets**, select a VM from the list or add the target manually:

      1. In the **IP address** field, specify the target's IP and select the [subnet](../../vpc/concepts/network.md#subnet).

      
      1. (Optional) If the target's IP does not belong to {{ vpc-name }}, select **{{ ui-key.yacloud.alb.label_target-private-ip }}**.

         For example, specify the IP belonging to your data center connected to {{ yandex-cloud }} via [{{ interconnect-name }}](../../interconnect/). The IP address must be within the [RFC 1918 private ranges](https://datatracker.ietf.org/doc/html/rfc1918#section-3).


      1. Click **Add target resource**.

   1. Click **Create**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's create target group command:

      ```bash
      yc alb target-group create --help
      ```

   1. Run the command, specifying the [subnet](../../vpc/concepts/network.md#subnet) name and the internal IP addresses of the VMs in the parameters:

      ```bash
      yc alb target-group create <target_group_name> \
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
      ```

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see our documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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

      Where:

      * `yandex_alb_target_group` specifies the target group parameters:
         * `name`: Target group name.
         * `target`: Target parameters:
            * `subnet_id`: ID of the [subnet](../../vpc/concepts/network.md#subnet) hosting the VM. You can get a list of available subnets using the [CLI](../../cli/quickstart.md) command: `yc vpc subnet list`.
            * `ip_address`: VM's internal IP. You can get a list of internal IP addresses using the [CLI](../../cli/quickstart.md) command: `yc vpc subnet list-used-addresses --id <subnet_ID>`.

      For more information about the `yandex_alb_target_group` resource parameters, see the [{{ TF }} provider documentation]({{ tf-provider-alb-targetgroup }}).
   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all required resources. You can check that the resources are there using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```bash
      yc alb target-group list
      ```

- API

   Use the [create](../api-ref/TargetGroup/create.md) REST API method for the [TargetGroup](../api-ref/TargetGroup/index.md) resource or the [TargetGroupService/Create](../api-ref/grpc/target_group_service.md#Create) gRPC API call.

{% endlist %}
