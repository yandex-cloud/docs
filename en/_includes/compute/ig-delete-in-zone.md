{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), open the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [instance group](../../compute/concepts/instance-groups/index.md) you need.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. Select the instance group to update.
  1. In the top-right corner, click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_allocation }}**, deselect the previous [availability zone](../../overview/concepts/geo-scope.md).
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  1. Open the [instance group](../../compute/concepts/instance-groups/index.md) [specification](../../compute/concepts/instance-groups/specification.md) file and edit the [instance template](../../compute/concepts/instance-groups/instance-template.md):
     * Delete the previous availability zone from the `allocation_policy` section.
     * Delete the ID of the [subnet](../../vpc/concepts/network.md#subnet) in the previous availability zone from the `network_interface_specs` section.
  1. Update the instance group:

     ```bash
     yc compute instance-group update \
       --id <instance_group_ID> \
       --file <instance_specification_file>
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

  1. Open the {{ TF }} configuration file for the [instance group](../../compute/concepts/instance-groups/index.md). Delete the previous [availability zone](../../overview/concepts/geo-scope.md) from the `allocation_policy` section and the ID of the [subnet](../../vpc/concepts/network.md#subnet) in the previous availability zone from the `network_interface` section:

     ```hcl
     ...
     network_interface {
       subnet_ids = ["<ID_of_subnet_in_new_availability_zone>"]
     }
     ...
     allocation_policy {
       zones = ["<new_availability_zone>"]
     }
     ...
     ```

     Where:
     * `zones`: Availability zone to move the instance group to. You can specify multiple availability zones.
     * `subnet_ids`: ID of the subnet in the availability zone you want to move your instance group to.

     For more information about resource parameters in {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/compute_instance_group).
  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     The group instances will be deleted from the previous availability zone. You can check the updates using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc compute instance-group get <instance_group_name>
     ```

- API {#api}

  Use the [update](../../compute/instancegroup/api-ref/InstanceGroup/update.md) REST API method for the [InstanceGroup](../../compute/instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Update](../../compute/instancegroup/api-ref/grpc/InstanceGroup/update.md) gRPC API call.

{% endlist %}