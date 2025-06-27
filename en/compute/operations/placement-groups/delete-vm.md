# Removing a VM from a placement group

Remove the [VM](../../concepts/vm.md) from the [placement group](../../concepts/placement-groups.md).

You can [permanently delete](../vm-control/vm-delete.md) the removed VM or [add it back](add-vm.md) to the placement group.

{% include [placement-groups-info.md](../../../_includes/compute/placement-groups-info.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the placement group belongs to.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/compute/group-placement-pic.svg) **{{ ui-key.yacloud.compute.placement-groups_3CwzD }}**.
  1. Navigate to the **{{ ui-key.yacloud.compute.placement-groups.label_tab-instances }}** tab.
  1. Select the placement group you want to remove the VM from.
  1. Go to the **{{ ui-key.yacloud.compute.placement-group.switch_instances }}** panel.
  1. In the line with the VM, click ![image](../../../_assets/options.svg) and select **{{ ui-key.yacloud.compute.placement-group.instances.button_action-delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.compute.placement-group.instances.popup-confirm_button_delete }}**.

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. View a list of VMs in the placement group:

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

  1. Stop the VM you want to remove:

     ```bash
     yc compute instance stop instance-in-group-2
     ```

     Result:

     ```text
     id: epdlv1pp5401********
     ...
     status: STOPPED
     ```

  1. Remove the VM from the placement group. To do this, update the VM leaving `placement-group-name` blank:

     ```bash
     yc compute instance update --name instance-in-group-2 --placement-group-name=""
     ```

  1. Check that the VM has been removed from the placement group:

     ```bash
     yc compute placement-group list-instances --name my-group
     ```

     Result:

     ```text
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     |          ID          |        NAME         |      ZONE ID      | STATUS  | EXTERNAL IP | INTERNAL IP |
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     | epdep2kq6dt5******** | instance-in-group-1 |   {{ region-id }}-a   | RUNNING |             | 10.129.0.5  |
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To remove a VM created with {{ TF }} from a placement group:
  1. Open the VM configuration file and delete the `placement_group_id` parameter.

     Here is an example of the VM configuration file structure:

     ```hcl
     ...
     resource "yandex_compute_instance" "vm-1" {
       name        = "my-vm"
       platform_id = "standard-v3"
       placement_policy {
         placement_group_id = "${yandex_compute_placement_group.group1.id}"
       }
     }

     resource "yandex_compute_placement_group" "group1" {
       name = "test-pg"
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

     You will see a detailed list of resources. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will show them.
  1. Apply the changes:

     ```bash
     terraform apply
     ```

  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

     You can check the update using the [management console]({{ link-console-main }}).

- API {#api}

  Use the [update](../../api-ref/Instance/update.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/Update](../../api-ref/grpc/Instance/update.md) gRPC API call.

{% endlist %}