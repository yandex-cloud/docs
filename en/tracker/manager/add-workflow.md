# Creating a workflow

{% note warning %}

By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

The workflow defines acceptable issue statuses and their sequence.

{{ tracker-name }} provides a number of standard workflows that can't be deleted or edited. If standard workflows aren't enough to track your team's issues, create a new workflow based on a standard one. For this, copy the existing workflow and edit the [acceptable issue statuses](workflow-status-edit.md) and [rules of status change](workflow-action-edit.md).

## Copying a workflow {#section_osf_wz5_vbb}

1. Open the queue page.

1. In the top-right corner, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Click the **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--workflows }}** tab.

1. Click ![](../../_assets/tracker/button-copy.png)to copy the workflow.

1. Enter a name for the new workflow. If you leave this box empty, the new workflow will have a name like `Copy of ...`.

1. Click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_workflows.actions--copy }}**.

1. If you need to edit the new workflow, click ![](../../_assets/tracker/button-edit.png).

## Copying a workflow from a different queue {#section_pcf_xz5_vbb}

If you already set up a similar workflow for a different queue, you can copy it instead:

1. Open the queue page.

1. In the top-right corner, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Click the **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--workflows }}** tab.

1. Click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_workflows.copy-queue-workflow }}**.

1. Select the key and workflow that you want to copy.

1. Enter a name for the new workflow. If you leave this box empty, the new workflow will have a name like `Copy of ...`.

1. Click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_workflows.actions--copy }}**.

1. If you need to edit the new workflow, click ![](../../_assets/tracker/button-edit.png).

## Deleting a workflow {#section_s35_xz5_vbb}

{% note warning %}

You can't delete a workflow if it's followed by at least one issue in the queue.

{% endnote %}

To delete the workflow that you created:

1. Open the queue page.

1. In the top-right corner, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Click the **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--workflows }}** tab.

1. Select the workflow and click ![](../../_assets/tracker/button-delete.png).

1. Confirm the deletion.

