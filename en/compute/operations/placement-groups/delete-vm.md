# Remove an instance from a placement group

Remove an instance from a [placement group](../../concepts/placement-groups.md).

If you remove a VM instance, you can [delete it forever](../vm-control/vm-delete.md) or [add it back](add-vm.md) to the placement group.

{% list tabs %}

- CLI

   {% include [cli-install.md](../../../_includes/cli-install.md) %}

   {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

   1. View a list of VM instances in the placement group:

      ```bash
      yc compute placement-group list-instances --name my-group
      ```

      Result:

      ```bash
      +----------------------+---------------------+---------------+---------+-------------+-------------+
      |          ID          |        NAME         |    ZONE ID    | STATUS  | EXTERNAL IP | INTERNAL IP |
      +----------------------+---------------------+---------------+---------+-------------+-------------+
      | epdep2kq6dt5uekuhcrd | instance-in-group-1 | {{ region-id }}-b | RUNNING |             | 10.129.0.5  |
      | epdlv1pp54019j09fhue | instance-in-group-2 | {{ region-id }}-b | RUNNING |             | 10.129.0.30 |
      +----------------------+---------------------+---------------+---------+-------------+-------------+
      ```

   1. Stop the VM instance that you want to remove:

      ```bash
      yc compute instance stop instance-in-group-2
      ```

      Result:

      ```bash
      id: epdlv1pp54019j09fhue
      ...
      status: STOPPED
      ```

   1. Remove the VM instance from the placement group. To do this, update the VM instance, leaving the placement group name (`placement-group-name`) blank:

      ```bash
      yc compute instance update --name instance-in-group-2 --placement-group-name=""
      ```

   1. Check that the VM instance was removed from the group:

      ```bash
      yc compute placement-group list-instances --name my-group
      ```

      Result:

      ```bash
      +----------------------+---------------------+---------------+---------+-------------+-------------+
      |          ID          |        NAME         |    ZONE ID    | STATUS  | EXTERNAL IP | INTERNAL IP |
      +----------------------+---------------------+---------------+---------+-------------+-------------+
      | epdep2kq6dt5uekuhcrd | instance-in-group-1 | {{ region-id }}-b | RUNNING |             | 10.129.0.5  |
      +----------------------+---------------------+---------------+---------+-------------+-------------+
      ```

- API

   Use the [update](../../api-ref/Instance/update.md).

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   For more information about the {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To remove a virtual machine created with {{ TF }} from a placement group:

   1. Open the virtual machine's configuration file and delete the `placement_group_id` parameter.

      Example configuration VM file structure:

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

   1. Check the configuration using the command:

      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the changes in the [management console]({{ link-console-main }}).

{% endlist %}
