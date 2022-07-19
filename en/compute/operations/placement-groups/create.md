# Creating a placement group

Create a [placement group](../../concepts/placement-groups.md).

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
      id: fd83bv4rnsna2sjkiq4s
      folder_id: b1g5kkhshgs9s0l4609d
      created_at: "2019-12-30T10:07:34Z"
      name: my-group
      spread_placement_strategy: {}
      ```

      This command creates a placement group with the following characteristics:

      - Named `my-group`.
      - Distributed placement strategy (`spread`).

   1. Check that the placement group was added:

      ```
      yc compute placement-group list
      ```

      Result:

      ```
      +----------------------+----------+----------+
      |          ID          |   NAME   | STRATEGY |
      +----------------------+----------+----------+
      | fd83bv4rnsna2sjkiq4s | my-group | SPREAD   |
      +----------------------+----------+----------+
      ```

- API

   Use the API [Create](../../api-ref/PlacementGroup/create.md) method.

{% endlist %}

## See also {see-also}

* [How to add a VM instance to a placement group](add-vm.md).
* [How to create a VM instance in a placement group](create-vm-in-pg.md).