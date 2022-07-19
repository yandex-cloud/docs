# Deleting a placement group

Delete the [placement group](../../concepts/placement-groups.md).

{% list tabs %}

- CLI

   {% include [cli-install.md](../../../_includes/cli-install.md) %}

   {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

   1. View a list of VM instances in the placement group:

      ```
      yc compute placement-group list-instances --name my-group
      ```

      Result:

      ```
      +----------------------+---------------------+---------------+---------+-------------+-------------+
      |          ID          |        NAME         |    ZONE ID    | STATUS  | EXTERNAL IP | INTERNAL IP |
      +----------------------+---------------------+---------------+---------+-------------+-------------+
      | epdep2kq6dt5uekuhcrd | instance-in-group-1 | {{ region-id }}-b | RUNNING |             | 10.129.0.5  |
      | epdlv1pp54019j09fhue | instance-in-group-2 | {{ region-id }}-b | RUNNING |             | 10.129.0.30 |
      +----------------------+---------------------+---------------+---------+-------------+-------------+
      ```

   1. Delete the instances in the group:

      ```
      yc compute instance delete --name instance-in-group-1
      yc compute instance delete --name instance-in-group-2
      ```

   1. Delete the placement group:

      ```
      yc compute placement-group delete --name my-group
      ```

   1. Check that the placement group was deleted:

      ```
      yc compute placement-group list
      ```

      Result:

      ```
      +----+------+----------+
      | ID | NAME | STRATEGY |
      +----+------+----------+
      +----+------+----------+
      ```

- API

   Use the API [delete](../../api-ref/PlacementGroup/delete.md) method.

{% endlist %}