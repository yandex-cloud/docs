# Deleting a disk snapshot

{% note warning %}

Deleting a snapshot is an operation that cannot be canceled or reversed. You cannot restore a deleted snapshot.

{% endnote %}

To delete a snapshot:

{% list tabs %}

- Management console

   1. In the management console, select the folder the snapshot belongs to.
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/snapshots.svg) **Disk snapshots**.
   1. In the row with the desired snapshot, click ![image](../../../_assets/dots.svg) and select the **Delete** command from the menu.
   1. Confirm the deletion.

- CLI

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's delete snapshot commands:

      ```
      yc compute snapshot delete --help
      ```

   1. Get a list of snapshots in the default folder:

      {% include [compute-snapshot-list](../../_includes_service/compute-snapshot-list.md) %}

   1. Select the ID (`ID`) or the name (`NAME`) of the desired snapshot.
   1. Delete the snapshot:

      ```
      yc compute snapshot delete \
          --name first-snapshot
      ```

- {{ TF }}

   For more information about {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   If you created a snapshot with {{ TF }}, you can delete it:

   1. In the command line, go to the directory with the {{ TF }} configuration file.
   2. Delete resources using the command:

      ```
      terraform destroy
      ```

      {% note alert %}

      {{ TF }} deletes all the resources that you created in the current configuration, such as clusters, networks, subnets, and VMs.

      {% endnote %}

   3. Confirm the deletion of resources.

{% endlist %}
