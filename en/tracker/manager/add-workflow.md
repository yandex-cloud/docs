# Creating a workflow

{% note warning %}

By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

Your workflow sets acceptable issue statuses and their sequence.

{{ tracker-name }} includes some preset workflow templates that cannot be edited or removed. If you need more features to track your team's issues, you can create a new workflow based on a template. To do this, copy an existing workflow and edit [available issue statuses](workflow-status-edit.md) and [status transition rules](workflow-action-edit.md).

## Copying a workflow {#section_osf_wz5_vbb}

1. Open the queue page.

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Configure**.

1. Go to the **Workflow** tab.

1. Click ![](../../_assets/tracker/button-copy.png) to copy the workflow.

1. Enter a name for the new workflow. If you leave this box empty, the new workflow will have a name like `Copy of ...`.

1. Click **Copy**.

1. If you need to edit the new workflow, click ![](../../_assets/tracker/button-edit.png).

## Copying a workflow from a different queue {#section_pcf_xz5_vbb}

If you have already set up a suitable workflow in another queue, you can copy it:

1. Open the queue page.

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Configure**.

1. Go to the **Workflow** tab.

1. Click **Copy workflow from another queue**.

1. Select the queue and the workflow you want to copy.

1. Enter a name for the new workflow. If you leave this box empty, the new workflow will have a name like `Copy of ...`.

1. Click **Copy**.

1. If you need to edit the new workflow, click ![](../../_assets/tracker/button-edit.png).

## Deleting a workflow {#section_s35_xz5_vbb}

{% note warning %}

You can&apos;t delete a workflow that is used by at least one issue in the queue.

{% endnote %}

To delete a workflow that you created:

1. Open the queue page.

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Configure**.

1. Go to the **Workflow** tab.

1. Select the workflow and click ![](../../_assets/tracker/button-delete.png).

1. Confirm the deletion.

