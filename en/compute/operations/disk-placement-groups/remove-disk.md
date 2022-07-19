# Removing a disk from a placement group

Remove a non-replicated disk from a [placement group](../../concepts/disk-placement-group.md). You can then [permanently delete](../disk-control/delete.md) the disk or add it back to the placement group.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create a disk placement group.
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/group-placement-pic.svg) **Placement groups**.
   1. Open the **Non-replicated disk placement groups** tab.
   1. Select the placement group to remove a disk from.
   1. Go to the **List of disks** panel.
   1. To the right of the name of the disk to be deleted, click ![horizontal-ellipsis](../../../_assets/horizontal-ellipsis.svg) and select **Remove from group**.
   1. In the resulting window, click **Delete from group**.

{% endlist %}
