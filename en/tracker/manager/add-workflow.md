# Creating a workflow

{% note warning %}

By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

Your workflow sets acceptable issue statuses and their sequence. To add a new workflow to the queue, copy an existing one and edit the [available issue statuses](workflow-status-edit.md) and [status transition rules](workflow-action-edit.md).

## Copy a workflow {#section_osf_wz5_vbb}

1. Open the queue page.

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Configure**.

1. Go to the **Workflow** tab.

1. Click ![](../../_assets/tracker/button-copy.png) to copy the workflow.

1. Enter a name for the new workflow. If you leave this box empty, the new workflow will have the name `Copy of ...`.

1. Click **Copy**.

1. If you need to edit the new workflow, click ![](../../_assets/tracker/button-edit.png).

## Copy a workflow from a different queue {#section_pcf_xz5_vbb}

If you have already set up a suitable workflow in another queue, you can copy it:

1. Open the queue page.

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Configure**.

1. Go to the **Workflow** tab.

1. Click **Copy workflow from another queue**.

1. Select the queue and the workflow you want to copy.

1. Enter a name for the new workflow. If you leave this box empty, the new workflow will have the name `Copy of ...`.

1. Click **Copy**.

1. If you need to edit the new workflow, click ![](../../_assets/tracker/button-edit.png).

## Delete a workflow {#section_s35_xz5_vbb}

{% note warning %}

You can&apos;t delete a workflow that is used by at least one issue in the queue.

{% endnote %}

To delete a workflow that you created:

1. Open the queue page.

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Configure**.

1. Go to the **Workflow** tab.

1. Select the workflow and click ![](../../_assets/tracker/button-delete.png).

1. Confirm the deletion.

