# Create an instance in a placement group

Create an instance in a [placement group](../../concepts/placement-groups.md).

{% list tabs %}

- CLI

   {% include [cli-install.md](../../../_includes/cli-install.md) %}

   {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to create a placement group:

      ```
      yc compute placement-group create --help
      ```

   1. Create a placement group:

      ```
      yc compute placement-group create --spread-strategy --name my-group
      id: fdvte50kv3nclagfknoc
      folder_id: aoeieef3k7ppari05ajo
      created_at: "2019-12-20T08:59:44Z"
      name: my-group
      spread_placement_strategy: {}
      ```

      This command creates a placement group with the following characteristics:

      - Named `my-group`.
      - Placement strategy `spread`.

   1. View the description of the CLI command for creating a VM:

      ```
      yc compute instance create --help
      ```

   1. Create a virtual machine:

      ```
      yc compute instance create --zone {{ region-id }}-a --name instance-in-group-1 --placement-group-name my-group
      id: epdep2kq6dt5uekuhcrd
      ...
      placement_policy:
        placement_group_id: fd83bv4rnsna2sjkiq4s
      ```

      This command creates a VM instance with the following characteristics:

      - Named `instance-in-group-1`.
      - In the `{{ region-id }}-a` availability zone.
      - In the `my-group` placement group.

   1. Check that the instance was created and added to the placement group:

      ```
      yc compute placement-group list-instances --name my-group
      ```

      Result:

      ```
      +----------------------+---------------------+---------------+---------+-------------+-------------+
      |          ID          |        NAME         |    ZONE ID    | STATUS  | EXTERNAL IP | INTERNAL IP |
      +----------------------+---------------------+---------------+---------+-------------+-------------+
      | epdep2kq6dt5uekuhcrd | instance-in-group-1 | {{ region-id }}-a | RUNNING |             | 10.129.0.5  |
      +----------------------+---------------------+---------------+---------+-------------+-------------+
      ```

- API

   Use the API [Create](../../api-ref/Instance/create.md) method.

{% endlist %}

## See also {see-also}

* [How to add a VM instance to a placement group](add-vm.md).