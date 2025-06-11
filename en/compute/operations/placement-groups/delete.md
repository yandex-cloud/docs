# Deleting a placement group

Delete a [placement group](../../concepts/placement-groups.md).

{% include [placement-groups-info.md](../../../_includes/compute/placement-groups-info.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the placement group belongs to.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/compute/group-placement-pic.svg) **{{ ui-key.yacloud.compute.placement-groups_3CwzD }}**.
  1. Go to the **{{ ui-key.yacloud.compute.placement-groups.label_tab-instances }}** tab.
  1. In the line with the placement group, click ![image](../../../_assets/options.svg) and select **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. View a list of [VMs](../../concepts/vm.md) in the placement group:

     ```bash
     yc compute placement-group list-instances --name my-group
     ```

     Result:

     ```text
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     |          ID          |        NAME         |      ZONE ID      | STATUS  | EXTERNAL IP | INTERNAL IP |
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     | epdep2kq6dt5******** | instance-in-group-1 |   {{ region-id }}-a   | RUNNING |             | 10.129.0.5  |
     | epdlv1pp5401******** | instance-in-group-2 |   {{ region-id }}-a   | RUNNING |             | 10.129.0.30 |
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     ```

  1. Delete the VMs from the placement group:

     ```bash
     yc compute instance delete --name instance-in-group-1
     yc compute instance delete --name instance-in-group-2
     ```

  1. Delete the placement group:

     ```bash
     yc compute placement-group delete --name my-group
     ```

  1. Check that the placement group has been deleted:

     ```bash
     yc compute placement-group list
     ```

     Result:

     ```text
     +----+------+----------+
     | ID | NAME | STRATEGY |
     +----+------+----------+
     +----+------+----------+
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To delete a placement group created with {{ TF }}:
  1. Open the {{ TF }} configuration file and delete the segment specifying with the placement group.

     Here is an example of specifying a placement group in {{ TF }} configuration:

     ```hcl
     ...
     resource "yandex_compute_placement_group" "group1" {
       name        = "test-pg"
       folder_id   = "b1gia87mbaom********"
       description = "my description"
     }
     ...
     ```

  1. In the command line, go to the directory with the {{ TF }} configuration file.
  1. Check the configuration using this command:

     ```bash
     terraform validate
     ```

     If the configuration is correct, you will get this message:

     ```text
     Success! The configuration is valid.
     ```

  1. Run this command:

     ```bash
     terraform plan
     ```

     The terminal will display a list of resources with their parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.
  1. Apply the configuration changes:

     ```bash
     terraform apply
     ```

  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

     You can check the updates using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

     ```bash
     yc compute placement-group list
     ```

- API {#api}

  Use the [delete](../../api-ref/PlacementGroup/delete.md) REST API method for the [PlacementGroup](../../api-ref/PlacementGroup/index.md) resource or the [PlacementGroupService/Delete](../../api-ref/grpc/PlacementGroup/delete.md) gRPC API call.

{% endlist %}