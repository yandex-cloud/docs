{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where the network load balancer is stored.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
   1. In the left-hand panel, select ![image](../../_assets/trgroups.svg) **{{ ui-key.yacloud.load-balancer.target-group.label_list }}**.
   1. Select the target group you need.
   1. Under **{{ ui-key.yacloud.load-balancer.target-group.label_targets-section-title }}**, remove the old VMs and add new ones.

- CLI {#cli}

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   1. View a description of the CLI command for removing resources from a target group:

      ```bash
      yc load-balancer target-group remove-targets --help
      ```

   1. [Get](../../network-load-balancer/operations/target-group-list.md#list) a list of {{ network-load-balancer-name }} target groups in the default folder.

   1. [Get](../../network-load-balancer/operations/target-group-list.md#get) a list of targets linked to the target group.

   1. Remove the old VMs from the target group:

      ```bash
      yc load-balancer target-group remove-targets <target_group_ID> \
        --target subnet-id=<subnet_ID_of_VM_1>,address=<internal_IP_address_of_VM_1> \
        --target subnet-id=<subnet_ID_of_VM_2>,address=<internal_IP_address_of_VM_2>
        ...
        --target subnet-id=<subnet_ID_of_VM_N>,address=<internal_IP_address_of_VM_N>
      ```

      Where:
      * `<target_group_ID>`: ID of the target group to remove targets from.
      * `--target`: Resource parameters in the target group:
         * `subnet-id`: ID of the subnet of the target to be removed.
         * `address`: Internal IP address of the target to be removed.

      Result:

      ```yaml
      done (4s)
      id: enplckhtn77s********
      folder_id: b1gt6g8ht345********
      created_at: "2023-10-16T10:42:18Z"
      name: sample-tg
      region_id: {{ region-id }}
      targets:
      ```

   1. View a description of the CLI command for adding targets to a target group:

      ```bash
      yc load-balancer target-group add-targets --help
      ```

   1. Get a list of subnets in the default folder:

      ```bash
      yc vpc subnet list
      ```

      Result:

      ```
      +----------------------+------------+----------------------+----------------+---------------+------------------+
      |          ID          |    NAME    |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |      RANGE       |
      +----------------------+------------+----------------------+----------------+---------------+------------------+
      | b0cnd1srghnm******** | rucentralc | enpv51f8lple******** |                | {{ region-id }}-c | [192.168.3.0/24] |
      | e2li9tcgi7ii******** | rucentralb | enpv51f8lple******** |                | {{ region-id }}-b | [192.168.0.0/24] |
      | e9b4a9ksc88k******** | rucentrala | enpv51f8lple******** |                | {{ region-id }}-a | [192.168.1.0/24] |
      +----------------------+------------+----------------------+----------------+---------------+------------------+
      ```

   1. Get a list of VMs in the default folder:

      ```bash
      yc compute instance list
      ```

      Result:

      ```
      +----------------------+------------+---------------+---------+-----------------+--------------+
      |          ID          |    NAME    |    ZONE ID    | STATUS  |   EXTERNAL IP   | INTERNAL IP  |
      +----------------------+------------+---------------+---------+-----------------+--------------+
      | fhmkchjddi40******** | sample-vm1 | {{ region-id }}-a | RUNNING | 130.193.**.***  | 192.168.1.9  |
      | fhm13ts43oml******** | sample-vm2 | {{ region-id }}-a | RUNNING | 158.160.***.*** | 192.168.1.32 |
      | epdsj30mndgj******** | sample-vm3 | {{ region-id }}-b | RUNNING | 51.250.***.***  | 192.168.0.7  |
      +----------------------+------------+---------------+---------+-----------------+--------------+
      ```

   1. Add targets to your target group:

      ```bash
      yc load-balancer target-group add-targets <target_group_ID> \
        --target subnet-id=<subnet_ID_of_VM_1>,address=<internal_IP_address_of_VM_1> \
        --target subnet-id=<subnet_ID_of_VM_2>,address=<internal_IP_address_of_VM_2>
        ...
        --target subnet-id=<subnet_ID_of_VM_N>,address=<internal_IP_address_of_VM_N>
      ```

      Where:
      * `<target_group_ID>`: ID of the target group to add targets to.
      * `--target`: Resource parameters in the target group:
         * `subnet-id`: ID of the subnet of the target to be added.
         * `address`: Internal IP address of the target to be added.

      Result:

      ```yaml
      done (4s)
      id: enplckhtn77s********
      folder_id: b1gt6g8ht345********
      created_at: "2023-10-18T08:04:15Z"
      name: sample-tg
      region_id: {{ region-id }}
      targets:
        - subnet_id: e9b4a9ksc88k********
          address: 192.168.1.32
        - subnet_id: e9b4a9ksc88k********
          address: 192.168.1.9
      ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. Open the fragment with the target group description in the {{ TF }} configuration file and edit the `subnet_id` and `address` field values in the `target` section:

      {% cut "Sample target group description" %}

      ```hcl
      resource "yandex_lb_target_group" "foo" {
        name        = "<target_group_name>"
        target {
          subnet_id = "<subnet_ID>"
          address   = "<internal_IP_address_of_target_1>"
        }
        target {
          subnet_id = "<subnet_ID>"
          address   = "<internal_IP_address_of_target_2>"
        }
      }
      ```

      {% endcut %}

   {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

   You can check the update using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

   ```bash
   yc load-balancer target-group get <target_group_name>
   ```

- API {#api}

   1. To remove targets from a target group, use the [removeTargets](../../network-load-balancer/api-ref/TargetGroup/removeTargets.md) REST API method for the [TargetGroup](../../network-load-balancer/api-ref/TargetGroup/index.md) resource or the [TargetGroupService/RemoveTargets](../../network-load-balancer/api-ref/grpc/target_group_service.md#RemoveTargets) gRPC API call.

   1. To add targets to a target group, use the [addTargets](../../network-load-balancer/api-ref/TargetGroup/addTargets.md) REST API method for the [TargetGroup](../../network-load-balancer/api-ref/TargetGroup/index.md) resource or the [TargetGroupService/AddTargets](../../network-load-balancer/api-ref/grpc/target_group_service.md#AddTargets) gRPC API call.

{% endlist %}
