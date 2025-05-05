{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [network load balancer](../../network-load-balancer/concepts/index.md).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/target.svg) **{{ ui-key.yacloud.load-balancer.target-group.label_list }}**.
  1. Select the [target group](../../network-load-balancer/concepts/target-resources.md) in question.
  1. Under **{{ ui-key.yacloud.load-balancer.target-group.label_targets-section-title }}**, remove the old [VMs](../../compute/concepts/vm.md) and add new ones.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. See the description of the [CLI](../../cli/) command for removing targets from a [target group](../../network-load-balancer/concepts/target-resources.md):

     ```bash
     yc load-balancer target-group remove-targets --help
     ```

  1. [Get](../../network-load-balancer/operations/target-group-list.md#list) a list of [{{ network-load-balancer-name }}](../../network-load-balancer/) target groups in the default [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Get](../../network-load-balancer/operations/target-group-list.md#get) a list of targets linked to the target group.
  1. Remove old [VMs](../../compute/concepts/vm.md) from the target group:

     ```bash
     yc load-balancer target-group remove-targets <target_group_ID> \
       --target subnet-id=<VM_1_subnet_ID>,address=<VM_1_internal_IP_address> \
       --target subnet-id=<VM_2_subnet_ID>,address=<VM_2_internal_IP_address> \
       ...
       --target subnet-id=<VM_n_subnet_ID>,address=<VM_n_internal_IP_address>
     ```

     Where:
     * `<target_group_ID>`: ID of the target group to remove targets from.
     * `--target`: Settings of the target within the target group:
       * `subnet-id`: [Subnet](../../vpc/concepts/network.md#subnet) ID of the target to remove.
       * `address`: [Internal IP address](../../vpc/concepts/address.md#internal-addresses) of the target to remove.

     Result:

     ```text
     done (4s)
     id: enplckhtn77s********
     folder_id: b1gt6g8ht345********
     created_at: "2023-10-16T10:42:18Z"
     name: sample-tg
     region_id: {{ region-id }}
     targets:
     ```

  1. See the description of the CLI command for adding targets to a target group:

     ```bash
     yc load-balancer target-group add-targets --help
     ```

  1. Get a list of subnets in the default folder:

     ```bash
     yc vpc subnet list
     ```

     Result:

      ```text
      +----------------------+------------+----------------------+----------------+---------------+------------------+
      |          ID          |    NAME    |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |      RANGE       |
      +----------------------+------------+----------------------+----------------+---------------+------------------+
      | b0cnd1srghnm******** | rucentrald | enpv51f8lple******** |                | {{ region-id }}-d | [192.168.3.0/24] |
      | e2li9tcgi7ii******** | rucentralb | enpv51f8lple******** |                | {{ region-id }}-b | [192.168.0.0/24] |
      | e9b4a9ksc88k******** | rucentrala | enpv51f8lple******** |                | {{ region-id }}-a | [192.168.1.0/24] |
      +----------------------+------------+----------------------+----------------+---------------+------------------+
      ```

  1. Get a list of VMs in the default folder:

     ```bash
     yc compute instance list
     ```

     Result:

     ```text
     +----------------------+------------+-------------------+---------+-----------------+--------------+
     |          ID          |    NAME    |      ZONE ID      | STATUS  |   EXTERNAL IP   | INTERNAL IP  |
     +----------------------+------------+-------------------+---------+-----------------+--------------+
     | fhmkchjddi40******** | sample-vm1 | {{ region-id }}-a | RUNNING | 130.193.**.***  | 192.168.1.9  |
     | fhm13ts43oml******** | sample-vm2 | {{ region-id }}-a | RUNNING | 158.160.***.*** | 192.168.1.32 |
     | epdsj30mndgj******** | sample-vm3 | {{ region-id }}-b | RUNNING | 51.250.***.***  | 192.168.0.7  |
     +----------------------+------------+-------------------+---------+-----------------+--------------+
     ```

  1. Add targets to the target group:

     ```bash
     yc load-balancer target-group add-targets <target_group_ID> \
       --target subnet-id=<VM_1_subnet_ID>,address=<VM_1_internal_IP_address> \
       --target subnet-id=<VM_2_subnet_ID>,address=<VM_2_internal_IP_address>
       ...
       --target subnet-id=<VM_n_subnet_ID>,address=<VM_n_internal_IP_address>
     ```

     Where:
     * `<target_group_ID>`: ID of the target group to add targets to.
     * `--target`: Settings of the target within the target group:
       * `subnet-id`: Subnet ID of the target to add.
       * `address`: Internal IP address of the target to add.

     Result:

     ```text
     done (4s)
     id: enplckhtn77s********
     folder_id: b1gt6g8ht345********
     ...
         address: 192.168.1.32
       - subnet_id: e9b4a9ksc88k********
         address: 192.168.1.9
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file, find the section describing the [target group](../../network-load-balancer/concepts/target-resources.md), and edit the `subnet_id` and `address` values under `target`:

     {% cut "Target group description example" %}

     ```hcl
     resource "yandex_lb_target_group" "foo" {
       name        = "<target_group_name>"
       target {
         subnet_id = "<subnet_ID>"
         address   = "<resource_1_internal_IP_address>"
       }
       target {
         subnet_id = "<subnet_ID>"
         address   = "<resource_2_internal_IP_address>"
       }
     }
     ```

     {% endcut %}

  {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check updates in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/) command:

  ```bash
  yc load-balancer target-group get <target_group_name>
  ```

- API {#api}

  1. To remove targets from a [target group](../../network-load-balancer/concepts/target-resources.md), use the [removeTargets](../../network-load-balancer/api-ref/TargetGroup/removeTargets.md) REST API method for the [TargetGroup](../../network-load-balancer/api-ref/TargetGroup/index.md) resource or the [TargetGroupService/RemoveTargets](../../network-load-balancer/api-ref/grpc/TargetGroup/removeTargets.md) gRPC API call.
  1. To add targets to a target group, use the [addTargets](../../network-load-balancer/api-ref/TargetGroup/addTargets.md) REST API method for the [TargetGroup](../../network-load-balancer/api-ref/TargetGroup/index.md) resource or the [TargetGroupService/AddTargets](../../network-load-balancer/api-ref/grpc/TargetGroup/addTargets.md) gRPC API call.

{% endlist %}