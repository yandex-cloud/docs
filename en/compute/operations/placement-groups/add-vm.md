# Adding a VM to a placement group

Add an existing instance to a [placement group](../../concepts/placement-groups.md).

{% include [placement-groups-info.md](../../../_includes/compute/placement-groups-info.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the placement group belongs to.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/compute/group-placement-pic.svg) **{{ ui-key.yacloud.compute.switch_placement-groups }}**.
   1. Go to the **{{ ui-key.yacloud.compute.placement-groups.label_tab-instances }}** tab.
   1. Select a placement group to add your VM to.
   1. Go to the **{{ ui-key.yacloud.compute.placement-group.switch_instances }}** panel.
   1. In the top-right corner, click ![image](../../../_assets/plus-sign.svg) **{{ ui-key.yacloud.compute.placement-group.instances.button_add-instance }}**.
   1. In the window that opens, select the appropriate VM and click **{{ ui-key.yacloud.compute.placement-group.instances.popup-add_button_add }}**.

   {% note info %}

   Please note that only a `stopped` VM can be added to a placement group.

   {% endnote %}

- CLI

   {% include [cli-install.md](../../../_includes/cli-install.md) %}

   {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

   1. Create a virtual machine:

      ```bash
      yc compute instance create --zone {{ region-id }}-a --name instance-in-group-2
      ```

      Result:

      ```bash
      id: epdlv1pp5401********
      ...
      ```

      This command creates a VM instance with the following characteristics:

      - Named `instance-in-group-2`.
      - In the `{{ region-id }}-a` availability zone.

   1. View a list of VM instances in the placement group:

      ```bash
      yc compute placement-group list-instances --name my-group
      ```

      Result:

      ```bash
      +----------------------+---------------------+---------------+---------+-------------+-------------+
      |          ID          |        NAME         |    ZONE ID    | STATUS  | EXTERNAL IP | INTERNAL IP |
      +----------------------+---------------------+---------------+---------+-------------+-------------+
      | epdep2kq6dt5******** | instance-in-group-1 | {{ region-id }}-a | RUNNING |             | 10.129.0.5  |
      +----------------------+---------------------+---------------+---------+-------------+-------------+
      ```

   1. Stop the VM:

      ```bash
      yc compute instance stop instance-in-group-2
      ```

      Result:

      ```bash
      id: epdlv1pp5401********
      ...
      status: STOPPED
      ```

   1. Add a VM instance to the placement group:

      ```bash
      yc compute instance update --name instance-in-group-2 --placement-group-name my-group
      ```

      Result:

      ```bash
      id: epdlv1pp5401********
      ...
      placement_policy:
        placement_group_id: fd83bv4rnsna********
      ```

      This command adds the `instance-in-group-2` instance to the `my-group` placement group.

      {% note info %}

      If you omit the partition number when adding a VM to a group with the [partition placement](../../concepts/placement-groups.md#partition) strategy, the VM will be added to a random partition.

      {% endnote %}

   1. Check that the instance was added to the placement group:

      ```bash
      yc compute placement-group list-instances --name my-group
      ```

      Result:

      ```bash
      +----------------------+---------------------+---------------+---------+-------------+-------------+
      |          ID          |        NAME         |    ZONE ID    | STATUS  | EXTERNAL IP | INTERNAL IP |
      +----------------------+---------------------+---------------+---------+-------------+-------------+
      | epdep2kq6dt5******** | instance-in-group-1 | {{ region-id }}-b | RUNNING |             | 10.129.0.5  |
      | epdlv1pp5401******** | instance-in-group-2 | {{ region-id }}-b | STOPPED |             | 10.129.0.30 |
      +----------------------+---------------------+---------------+---------+-------------+-------------+
      ```

   1. Start the VM:

      ```bash
      yc compute instance start instance-in-group-2
      ```

      Result:

      ```bash
      id: epdlv1pp5401********
      ...
      status: RUNNING
      ```

- API

   Use the [update](../../api-ref/Instance/update.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/Update](../../api-ref/grpc/instance_service.md#Update) gRPC API call.

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   Adding an existing instance to a placement group:

   1. To the configuration file of an existing [virtual machine](../../operations/vm-create/create-linux-vm.md), add a field named `placement_group_id` pointing to the `yandex_compute_placement_group` placement group resource.

      Example of the configuration file structure:

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

      Where `placement_group_id` is the ID of a placement group.

      {% note info %}

      If you omit the partition number when adding a VM to a group with the [partition placement](../../concepts/placement-groups.md#partition) strategy, the VM will be added to a random partition.

      {% endnote %}

      For more information about the resources that you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/compute_instance).

   1. In the command line, go to the directory with the {{ TF }} configuration file.

   1. Check the configuration using this command:

      ```
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      All the resources you need will then be created in the specified folder. You can verify that the virtual machine has been added to the placement group from the [management console]({{ link-console-main }}).

{% endlist %}

## See also {#see-also}

* [How to create a VM in a placement group](create-vm-in-pg.md)
