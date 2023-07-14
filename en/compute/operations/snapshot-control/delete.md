# Deleting a disk snapshot

{% note warning %}

Deleting a snapshot is an operation that cannot be canceled or reversed. You cannot restore a deleted snapshot.

{% endnote %}

To delete a snapshot:

{% list tabs %}

- Management console

   1. In the management console, select the folder where the snapshot is located.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/compute/snapshots.svg) **{{ ui-key.yacloud.compute.switch_snapshots }}**.
   1. In the line with the appropriate snapshot, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.compute.snapshots.list.button_action-delete }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.compute.snapshots.list.popup-confirm_button_delete }}**.

- CLI

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's delete snapshot commands:

      ```bash
      yc compute snapshot delete --help
      ```

   1. Get a list of snapshots in the default folder:

      {% include [compute-snapshot-list](../../_includes_service/compute-snapshot-list.md) %}

   1. Select the ID (`ID`) or the name (`NAME`) of the desired snapshot.
   1. Delete the snapshot:

      ```bash
      yc compute snapshot delete \
        --name first-snapshot
      ```


- API

   Use the [delete](../../api-ref/Snapshot/delete.md) REST API method for the [Snapshot](../../api-ref/Snapshot/index.md) resource or the [SnapshotService/Delete](../../api-ref/grpc/snapshot_service.md#Delete) gRPC API call.

- {{ TF }}

   For more information about {{ TF }}, [see our documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   If you created a snapshot with {{ TF }}, you can delete it:
   1. In the command line, go to the directory with the {{ TF }} configuration file.
   1. Delete the resources using this command:

      ```bash
      terraform destroy
      ```

      {% note alert %}

      {{ TF }} will delete all the resources you created in the current configuration, such as clusters, networks, subnets, and VMs.

      {% endnote %}

   1. Type `yes` and press **Enter**.

{% endlist %}