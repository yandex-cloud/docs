{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), open the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [instance group](../../compute/concepts/instance-groups/index.md) you need.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
   1. Select the instance group to update.
   1. In the top-right corner, click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
   1. Under **{{ ui-key.yacloud.compute.groups.create.section_allocation }}**, disable the old [availability zone](../../overview/concepts/geo-scope.md).
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   1. Open the [instance group](../../compute/concepts/instance-groups/index.md) [specification](../../compute/concepts/instance-groups/specification.md) file and edit the [VM template](../../compute/concepts/instance-groups/instance-template.md):
      * Delete the old availability zone in the `allocation_policy` section.
      * Remove the [subnet](../../vpc/concepts/network.md#subnet) ID in the old availability zone from the `network_interface_specs` section.
   1. Update the instance group:

      ```bash
      yc compute instance-group update \
        --id <instance_group_ID> \
        --file <instance_group_specification_file>
      ```

      Where:
      * `--id`: Instance group ID.
      * `--file`: Path to the instance group specification file.

      Result:

      ```text
      id: cl15sjqilrei********
      ...
      allocation_policy:
      zones:
      - zone_id: <new_availability_zone>
      ...
      ```

- {{ TF }} {#tf}

   1. Open the {{ TF }} configuration file for the [instance group](../../compute/concepts/instance-groups/index.md). Under `allocation_policy`, remove the old [availability zone](../../overview/concepts/geo-scope.md); also remove the ID of the [subnet](../../vpc/concepts/network.md#subnet) in the old availability zone from the `network_interface` section.

      ```hcl
      ...
      network_interface {
        subnet_ids = ["<subnet_ID_in_the_new_availability_zone>"]
      }
      ...
      allocation_policy {
        zones = ["<new_availability_zone>"]
      }
      ...
      ```

      Where:
      * `zones`: Availability zone to move the instance group to. You can specify multiple availability zones.
      * `subnet_ids`: ID of the subnet in the availability zone where you want to move your instance group.

      For more information about resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/compute_instance_group).
   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      The group instances will be deleted from the old availability zone. You can check the update using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```bash
      yc compute instance-group get <instance_group_name>
      ```

- API {#api}

   Use the [update](../../compute/api-ref/InstanceGroup/update.md) REST API method for the [InstanceGroup](../../compute/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Update](../../compute/api-ref/grpc/instance_group_service.md#Update) gRPC API call.

{% endlist %}