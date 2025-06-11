# Adding a VM to a placement group

Add an existing [VM](../../concepts/vm.md) to a [placement group](../../concepts/placement-groups.md).

{% include [placement-groups-info.md](../../../_includes/compute/placement-groups-info.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the placement group belongs to.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/compute/group-placement-pic.svg) **{{ ui-key.yacloud.compute.placement-groups_3CwzD }}**.
  1. Go to the **{{ ui-key.yacloud.compute.placement-groups.label_tab-instances }}** tab.
  1. Select the placement group to add a VM to.
  1. Go to the **{{ ui-key.yacloud.compute.placement-group.switch_instances }}** panel.
  1. In the top-right corner, click ![image](../../../_assets/plus-sign.svg) **{{ ui-key.yacloud.compute.placement-group.instances.button_add-instance }}**.
  1. In the window that opens, select the VM and click **{{ ui-key.yacloud.compute.placement-group.instances.popup-add_button_add }}**.

  {% note info %}

  You can only add a [VM with the `stopped` status](../../concepts/vm-statuses.md) to a placement group.

  {% endnote %}

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Create a VM:

     ```bash
     yc compute instance create \
       --zone {{ region-id }}-a \
       --name instance-in-group-2
     ```

     Where:
     * `--zone`: [Availability zone](../../../overview/concepts/geo-scope.md) for the VM.
     * `--name`: VM name.

     Result:

     ```text
     id: epdlv1pp5401********
     ...
     ```

  1. View a list of VMs in the placement group:

     ```bash
     yc compute placement-group list-instances \
       --name my-group
     ```

     Where `--name` is the placement group name.

     Result:

     ```text
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     |          ID          |        NAME         |      ZONE ID      | STATUS  | EXTERNAL IP | INTERNAL IP |
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     | epdep2kq6dt5******** | instance-in-group-1 |   {{ region-id }}-a   | RUNNING |             | 10.129.0.5  |
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     ```

  1. Stop the VM by specifying its name in the command below:

     ```bash
     yc compute instance stop instance-in-group-2
     ```

     Result:

     ```text
     id: epdlv1pp5401********
     ...
     status: STOPPED
     ```

  1. Add the VM to the placement group:

     ```bash
     yc compute instance update \
       --name instance-in-group-2 \
       --placement-group-name my-group \
       --placement-group-partition <partition_number>
     ```

     Where:
     * `--name`: VM name.
     * `--placement-group-name`: Placement group name.
     * `--placement-group-partition`: Partition number in the placement group with the [partition placement](../../concepts/placement-groups.md#partition) strategy.

       {% note info %}

       If you do not specify the partition number when adding a VM to a partition placement group, the VM will be added to a random partition.

       {% endnote %}

     Result:

     ```text
     id: epdlv1pp5401********
     ...
     placement_policy:
       placement_group_id: fd83bv4rnsna********
     ```

  1. Check that the VM is now in the placement group:

     ```bash
     yc compute placement-group list-instances \
       --name my-group
     ```

     Where `--name` is the placement group name.

     Result:

     ```text
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     |          ID          |        NAME         |      ZONE ID      | STATUS  | EXTERNAL IP | INTERNAL IP |
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     | epdep2kq6dt5******** | instance-in-group-1 |   {{ region-id }}-a   | RUNNING |             | 10.129.0.5  |
     | epdlv1pp5401******** | instance-in-group-2 |   {{ region-id }}-a   | STOPPED |             | 10.129.0.30 |
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     ```

  1. Start the VM by specifying its name in the command below:

     ```bash
     yc compute instance start instance-in-group-2
     ```

     Result:

     ```text
     id: epdlv1pp5401********
     ...
     status: RUNNING
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To add an existing VM to a placement group:
  1. To the configuration file of the existing VM, add the `placement_group_id` field indicating the `yandex_compute_placement_group` placement group resource.

     Here is an example of the configuration file structure:

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

     Where `placement_group_id` is the placement group ID.

     {% note info %}

     If you do not specify the partition number when adding a VM to a [partition placement](../../concepts/placement-groups.md#partition) group, the VM will be added to a random partition.

     {% endnote %}

     For more information about the resources you can create with {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/compute_instance).
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

     All the resources you need will then be created in the specified folder. You can check that the VM has been added to the placement group using the [management console]({{ link-console-main }}).

- API {#api}

  Use the [update](../../api-ref/Instance/update.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/Update](../../api-ref/grpc/Instance/update.md) gRPC API call.

{% endlist %}

## See also {#see-also}

* [How to create a VM in a placement group](create-vm-in-pg.md)