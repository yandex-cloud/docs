# Deleting a placement group

Delete the [placement group](../../concepts/placement-groups.md).

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

   1. Delete the instances in the group:

      ```bash
      yc compute instance delete --name instance-in-group-1
      yc compute instance delete --name instance-in-group-2
      ```

   1. Delete the placement group:

      ```bash
      yc compute placement-group delete --name my-group
      ```

   1. Check that the placement group was deleted:

      ```bash
      yc compute placement-group list
      ```

      Result:

      ```bash
      +----+------+----------+
      | ID | NAME | STRATEGY |
      +----+------+----------+
      +----+------+----------+
      ```

- API

   Use the [delete](../../api-ref/PlacementGroup/delete.md) REST API method for the [PlacementGroup](../../api-ref/PlacementGroup/index.md) resource or the [PlacementGroupService/Delete](../../api-ref/grpc/placement_group_service.md#Delete) gRPC API call.

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   For more information about the {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete a placement group created with {{ TF }}:

   1. Open the {{ TF }} configuration file and delete the fragment with the placement group description.

      Example placement group description in a {{ TF }} configuration:

      ```hcl
      ...
      resource "yandex_compute_placement_group" "group1" {
        name        = "test-pg"
        folder_id   = "abc*********123"
        description = "my description"
      }
      ...
      ```

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

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the changes using the [management console]({{ link-console-main }}) or the [CLI](../../../cli/quickstart.md) command below:

      ```bash
      yc compute placement-group list
      ```

{% endlist %}
