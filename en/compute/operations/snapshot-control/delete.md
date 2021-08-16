# Deleting a disk snapshot

{% note warning %}

Deleting a snapshot is an operation that cannot be canceled or reversed. You cannot restore a deleted snapshot.

{% endnote %}

To delete a snapshot:

{% list tabs %}

- Management console
  
  1. In the management console, select the folder the snapshot belongs to.
  1. Select **{{ compute-name }}**.
  1. On the **Virtual machines** page, go to the **Disk snapshots** tab.
  1. In the line with the appropriate snapshot, click ![image](../../../_assets/dots.svg) and select the **Delete** command.
  1. Confirm deletion.
  
- CLI
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. View a description of the CLI's delete snapshot commands:
  
      ```
      $ yc compute snapshot delete --help
      ```
  
  1. Get a list of snapshots in the default folder:
  
      {% include [compute-snapshot-list](../../_includes_service/compute-snapshot-list.md) %}
  
  1. Select the `ID` or `NAME` of the snapshot.
  
  1. Delete the snapshot:
  
      ```
      $ yc compute snapshot delete \
          --name first-snapshot
      ```
  
{% endlist %}

