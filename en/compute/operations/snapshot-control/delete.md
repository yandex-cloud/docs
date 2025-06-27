---
title: How to delete a disk snapshot
description: Follow this guide to delete a disk snapshot.
---

# Deleting a disk snapshot

{% note warning %}

Deleting a [snapshot](../../concepts/snapshot.md) is permanent and cannot be undone, so you cannot recover a deleted snapshot. When you delete a snapshot, all the information it stores is erased. The data on the primary disk will remain unchanged.

{% endnote %}

To delete a snapshot:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the management console, select the folder containing your snapshot.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.snapshots_81jHX }}**.
  1. In the line with the snapshot, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI commands for deleting snapshots:

     ```bash
     yc compute snapshot delete --help
     ```

  1. Get a list of snapshots in the default folder:

     {% include [compute-snapshot-list](../../_includes_service/compute-snapshot-list.md) %}

  1. Select `ID` or `NAME` of the snapshot in question.
  1. Delete the snapshot:

     ```bash
     yc compute snapshot delete \
       --name first-snapshot
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To delete a snapshot created with {{ TF }}, follow these steps:
  1. In the command line, go to the folder with the {{ TF }} configuration file.
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