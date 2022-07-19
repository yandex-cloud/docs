# Remove an instance from a placement group

Remove an instance from a [placement group](../../concepts/placement-groups.md).

If you remove a VM instance, you can [delete it forever](../vm-control/vm-delete.md) or [add it back](add-vm.md) to the placement group.

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

   1. Stop the VM instance that you want to remove:

      ```
      yc compute instance stop instance-in-group-2
      id: epdlv1pp54019j09fhue
      ...
      status: STOPPED
      ```

   1. Remove the VM instance from the placement group. To do this, update the VM instance, leaving the placement group name (`placement-group-name`) blank:

      ```
      yc compute instance update --name instance-in-group-2 --placement-group-name=""
      ```

   1. Check that the VM instance was removed from the group:

      ```
      yc compute placement-group list-instances --name my-group
      ```

      Result:

      ```
      +----------------------+---------------------+---------------+---------+-------------+-------------+
      |          ID          |        NAME         |    ZONE ID    | STATUS  | EXTERNAL IP | INTERNAL IP |
      +----------------------+---------------------+---------------+---------+-------------+-------------+
      | epdep2kq6dt5uekuhcrd | instance-in-group-1 | {{ region-id }}-b | RUNNING |             | 10.129.0.5  |
      +----------------------+---------------------+---------------+---------+-------------+-------------+
      ```

- API

   Use the [update](../../api-ref/Instance/update.md).

{% endlist %}
