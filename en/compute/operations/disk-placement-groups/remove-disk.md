# Removing a disk from a placement group

Remove a non-replicated disk from a [placement group](../../concepts/disk-placement-group.md). You can then [permanently delete the disk](../disk-control/delete.md) or add it back to the placement group.

{% list tabs %}

- Management console
  1. In the [management console]({{ link-console-main }}), select the folder where you want to create your disk placement group.
  1. Select **{{ compute-name }}**.
  1. Go to the **Placement groups** tab.
  1. Go to the **Non-replicated disk placement groups** tab.
  1. Select the placement group to remove a disk from.
  1. Go to the **List of disks** panel.
  1. To the right of the name of the disk to remove, click ![horizontal-ellipsis](../../../_assets/horizontal-ellipsis.svg) and select **Delete from group**.
  1. In the window that opens, click **Delete from group**.

{% endlist %}

