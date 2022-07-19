# Adding a VM to a placement group

Add an existing instance to a [placement group](../../concepts/placement-groups.md).

{% list tabs %}

- CLI

   {% include [cli-install.md](../../../_includes/cli-install.md) %}

   {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

   1. Create a virtual machine:

      ```
      yc compute instance create --zone {{ region-id }}-b --name instance-in-group-2
      id: epdlv1pp54019j09fhue
      ...
      ```

      This command creates a VM instance with the following characteristics:

      - Named `instance-in-group-2`.
      - In the `{{ region-id }}-b` availability zone.

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
      +----------------------+---------------------+---------------+---------+-------------+-------------+
      ```

   1. Stop the VM:

      ```
      yc compute instance stop instance-in-group-2
      id: epdlv1pp54019j09fhue
      ...
      status: STOPPED
      ```

   1. Add a VM instance to the placement group:

      ```
      yc compute instance update --name instance-in-group-2 --placement-group-name my-group
      id: epdlv1pp54019j09fhue
      ...
      placement_policy:
        placement_group_id: fd83bv4rnsna2sjkiq4s
      ```

      This command adds the `instance-in-group-2` instance to the `my-group` placement group.

   1. Check that the instance was added to the placement group:

      ```
      yc compute placement-group list-instances --name my-group
      ```

      Result:

      ```
      +----------------------+---------------------+---------------+---------+-------------+-------------+
      |          ID          |        NAME         |    ZONE ID    | STATUS  | EXTERNAL IP | INTERNAL IP |
      +----------------------+---------------------+---------------+---------+-------------+-------------+
      | epdep2kq6dt5uekuhcrd | instance-in-group-1 | {{ region-id }}-b | RUNNING |             | 10.129.0.5  |
      | epdlv1pp54019j09fhue | instance-in-group-2 | {{ region-id }}-b | STOPPED |             | 10.129.0.30 |
      +----------------------+---------------------+---------------+---------+-------------+-------------+
      ```

   1. Start the VM:

      ```
      yc compute instance start instance-in-group-2
      id: epdlv1pp54019j09fhue
      ...
      status: RUNNING
      ```

- API

   Use the [update](../../api-ref/Instance/update.md).

{% endlist %}

## See also {#see-also}

* [How to create a VM instance in a placement group](create-vm-in-pg.md).
