# Create an instance in a placement group

Create an instance in a [placement group](../../concepts/placement-groups.md).

{% list tabs %}

- CLI

   {% include [cli-install.md](../../../_includes/cli-install.md) %}

   {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to create a placement group:

      ```bash
      yc compute placement-group create --help
      ```

   1. Create a placement group:

      ```bash
      yc compute placement-group create --spread-strategy --name my-group
      ```

      Result:

      ```bash
      id: fdvte50kv3nclagfknoc
      folder_id: aoeieef3k7ppari05ajo
      created_at: "2019-12-20T08:59:44Z"
      name: my-group
      spread_placement_strategy: {}
      ```

      This command creates a placement group with the following characteristics:

      - Name: `my-group`
      - Placement strategy: `spread`

   1. View the description of the CLI command for creating a VM:

      ```bash
      yc compute instance create --help
      ```

   1. Create a virtual machine:

      ```bash
      yc compute instance create --zone {{ region-id }}-a --name instance-in-group-1 --placement-group-name my-group
      ```

      Result:

      ```bash
      id: epdep2kq6dt5uekuhcrd
      ...
      placement_policy:
        placement_group_id: fd83bv4rnsna2sjkiq4s
      ```

      This command creates a VM instance with the following characteristics:

      - Name: `instance-in-group-1`
      - Availability zone: `{{ region-id }}-a`
      - Placement group: `my-group`

   1. Check that the instance was created and added to the placement group:

      ```bash
      yc compute placement-group list-instances --name my-group
      ```

      Result:

      ```bash
      +----------------------+---------------------+---------------+---------+-------------+-------------+
      |          ID          |        NAME         |    ZONE ID    | STATUS  | EXTERNAL IP | INTERNAL IP |
      +----------------------+---------------------+---------------+---------+-------------+-------------+
      | epdep2kq6dt5uekuhcrd | instance-in-group-1 | {{ region-id }}-a | RUNNING |             | 10.129.0.5  |
      +----------------------+---------------------+---------------+---------+-------------+-------------+
      ```

- API

   Use the [create](../../api-ref/Instance/create.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/Create](../../api-ref/grpc/instance_service.md#Create) gRPC API call.

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   To create a VM instance in a placement group:

   1. In the configuration file, describe the [parameters of the virtual machine](../../operations/vm-create/create-linux-vm.md) pointing to `yandex_compute_placement_group` in the `placement_group_id` field. The `yandex_compute_instance` resource describe the virtual machine parameters.

      Example of the configuration file structure:

      ```hcl
      ...
      resource "yandex_compute_instance" "vm-1" {
        name        = "linux-vm"
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

      Where `placement_group_id`: ID of a placement group.

      For more information about the parameters of the `yandex_compute_instance` and `yandex_compute_placement_group` resources in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/compute_instance).

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

      All the resources you need will then be created in the specified folder. You can check that the virtual machine has been created and added to the placement group using the [management console]({{ link-console-main }}).

{% endlist %}

## See also {see-also}

* [How to add a VM instance to a placement group](add-vm.md)