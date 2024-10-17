---
title: How to delete a disk snapshot
description: Follow this guide to delete a disk snapshot.
---

# Deleting a disk snapshot

{% note warning %}

Deleting a [snapshot](../../concepts/snapshot.md) is an operation that you cannot cancel or reverse. You cannot restore a deleted snapshot. When you delete a snapshot, all the information in it is deleted. The data on the main disk will remain unchanged.

{% endnote %}

To delete a snapshot:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the management console, select the folder where the snapshot is located.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.switch_snapshots }}**.
   1. In the line with the appropriate snapshot, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

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

- {{ TF }} {#tf}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

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

- API {#api}

   Use the [delete](../../api-ref/Snapshot/delete.md) REST API method for the [Snapshot](../../api-ref/Snapshot/index.md) resource or the [SnapshotService/Delete](../../api-ref/grpc/Snapshot/delete.md) gRPC API call.

{% endlist %}