{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), open the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [instance group](../../compute/concepts/instance-groups/index.md) you need.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
   1. Select the instance group to update.
   1. In the top-right corner, click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
   1. Under **{{ ui-key.yacloud.compute.groups.create.section_allocation }}**, add the [availability zone](../../overview/concepts/geo-scope.md) where you want to move the instance group.
   1. If your instance group is [manually scaled](../../compute/concepts/instance-groups/scale.md#fixed-scale), under **{{ ui-key.yacloud.compute.groups.create.section_scale }}**, specify a group size that will be sufficient for placing instances in all the selected availability zones.

      You will be able to reset the number of instances back to the initial one after all the instances in the group are moved to the new availability zone and deleted from the old one.
   1. If your instance group is [autoscaling](../../compute/concepts/instance-groups/scale.md#auto-scale) and has the `OPPORTUNISTIC` [shutdown strategy](../../compute/concepts/instance-groups/policies/deploy-policy.md#strategy), change the strategy to `PROACTIVE` in the **{{ ui-key.yacloud.compute.groups.create.field_deploy-strategy }}** field.

      You will be able to reset the shutdown strategy back to OPPORTUNISTIC after all the instances in the group are moved to the new availability zone and deleted from the old one.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install.md](../cli-install.md) %}

   {% include [default-catalogue.md](../default-catalogue.md) %}

   1. Open the [instance group](../../compute/concepts/instance-groups/index.md) [specification](../../compute/concepts/instance-groups/specification.md) file and edit the [VM template](../../compute/concepts/instance-groups/instance-template.md):
      * Under `allocation_policy`, add a new [availability zone](../../overview/concepts/geo-scope.md).
      * Add the ID of the previously created [subnet](../../vpc/concepts/network.md#subnet) in the `network_interface_specs` section.
      * If your instance group is [manually scaled](../../compute/concepts/instance-groups/scale.md#fixed-scale), under `scale_policy`, specify a group size that will be sufficient for placing instances in all the selected availability zones.

         You will be able to reset the number of instances back to the initial one after all the instances in the group are moved to the new availability zone and deleted from the old one.
      * If your instance group is [autoscaling](../../compute/concepts/instance-groups/scale.md#auto-scale) and has the `OPPORTUNISTIC` [shutdown strategy](../../compute/concepts/instance-groups/policies/deploy-policy.md#strategy), change the strategy to `PROACTIVE` in the `deploy_policy` section.

         You will be able to reset the shutdown strategy back to OPPORTUNISTIC after all the instances in the group are moved to the new availability zone and deleted from the old one.
   1. View a description of the CLI command to update an instance group:

      ```bash
      yc compute instance-group update --help
      ```

   1. Get a list of all instance groups in the default [folder](../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc compute instance-group list
      ```

      Result:

      ```text
      +----------------------+---------------------------------+--------+--------+
      |          ID          |              NAME               | STATUS |  SIZE  |
      +----------------------+---------------------------------+--------+--------+
      | cl15sjqilrei******** | first-fixed-group-with-balancer | ACTIVE |      3 |
      | cl19s7dmihgm******** | test-group                      | ACTIVE |      2 |
      +----------------------+---------------------------------+--------+--------+
      ```

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
      - zone_id: <old_availability_zone>
      - zone_id: <new_availability_zone>
      ...
      ```

- {{ TF }} {#tf}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Open the {{ TF }} configuration file for the [instance group](../../compute/concepts/instance-groups/index.md). Under `allocation_policy`, specify the new [availability zone](../../overview/concepts/geo-scope.md); in the `network_interface` section, specify the ID of the previously created [subnet](../../vpc/concepts/network.md#subnet).

      ```hcl
      ...
      network_interface {
        subnet_ids = [
          "<subnet_ID_in_the_old_availability_zone>",
          "<subnet_ID_in_the_new_availability_zone>"
        ]
      }
      ...
      allocation_policy {
        zones = [
          "<old_availability_zone>",
          "<new_availability_zone>"
        ]
      }
      ...
      ```

      Where:
      * `zones`: Availability zones to place the instance group in (the new and old ones).
      * `subnet_ids`: IDs of subnets in the availability zones to place the instance group in.

      If your instance group is [manually scaled](../../compute/concepts/instance-groups/scale.md#fixed-scale), under `scale_policy`, specify a group size that will be sufficient for placing instances in all the selected availability zones.

      ```hcl
      ...
      scale_policy {
        fixed_scale {
          size = <number_of_instances_per_group>
        }
      }
      ...
      ```

      You will be able to reset the number of instances back to the initial one after all the instances in the group are moved to the new availability zone and deleted from the old one.

      If your instance group is [autoscaling](../../compute/concepts/instance-groups/scale.md#auto-scale) and has the `OPPORTUNISTIC` [shutdown strategy](../../compute/concepts/instance-groups/policies/deploy-policy.md#strategy), change the strategy to `PROACTIVE`:

      ```hcl
      ...
      deploy_policy {
        strategy = "proactive"
      }
      ...
      ```

      You will be able to reset the shutdown strategy back to OPPORTUNISTIC after all the instances in the group are moved to the new availability zone and deleted from the old one.

      For more information about resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/compute_instance_group).
   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      This will add a new availability zone for an instance group. You can check the update using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```bash
      yc compute instance-group get <instance_group_name>
      ```

- API {#api}

   Use the [update](../../compute/instancegroup/api-ref/InstanceGroup/update.md) REST API method for the [InstanceGroup](../../compute/instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Update](../../compute/instancegroup/api-ref/grpc/InstanceGroup/update.md) gRPC API call.

   If your instance group is [manually scaled](../../compute/concepts/instance-groups/scale.md#fixed-scale), specify a group size that will be sufficient for placing instances in all the selected availability zones. You will be able to reset the number of instances back to the initial one after all the instances in the group are moved to the new availability zone and deleted from the old one.

   If your instance group is [autoscaling](../../compute/concepts/instance-groups/scale.md#auto-scale) and has the `OPPORTUNISTIC` [shutdown strategy](../../compute/concepts/instance-groups/policies/deploy-policy.md#strategy), change the strategy to `PROACTIVE`. You will be able to reset the shutdown strategy back to OPPORTUNISTIC after all the instances in the group are moved to the new availability zone and deleted from the old one.

{% endlist %}

Wait until the instances appear in the new availability zone and switch to the `Running Actual` status.