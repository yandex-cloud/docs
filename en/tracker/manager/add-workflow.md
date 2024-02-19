# Managing workflows

A workflow defines acceptable issue statuses and their sequence. Queue workflow management is available to the queue owner and users granted [permission to access the queue settings](queue-access.md).

How to manage workflows:

* Add [issue types](./add-ticket-type.md) to existing workflows or create new issue types.
* [Set up resolutions](./create-resolution.md) for different issue types.
* Edit and remove workflows, bearing in mind [compatibility](./backward-compatibility.md) with existing queue issues.
* Copy workflows.
* Open the workflow editor where you can [create a workflow](#create-workflow), add [statuses](./workflow-status-edit.md) to it, and [set up transitions](./workflow-action-edit.md) between workflows.

## Rules for new workflows {#rules}

1. A workflow should contain at least two statuses and a transition between them.

1. A workflow may not have statuses without any transitions.

1. One of the statuses should be the [workflow start](./workflow-status-edit.md#initial-status).  Statuses of any type can act as the workflow start.

1. At least one status must be of the **Completed** or **Canceled** [type](./workflow-status-edit.md#status-types): you will not be able to close issues in your queue without it.

## Creating a workflow {#create}

To create a workflow:

1. Go to the queue page.

1. In the top-right corner, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Go to the **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-workflows }}** tab and click **{{ ui-key.startrek.ui_components_queue-admin-tab-workflows_WorkflowsStateList.action-new-process }}**. The workflow visual editor will open.

1. [Add statuses to the diagram](./workflow-status-edit.md#add-status) and [set up transitions](./workflow-action-edit.md#add-action) between them. Stick to the [rules](#rules).

## Copying a workflow from a different queue {#copy}

To copy a workflow from a different queue:

1. Go to the page of the queue to copy the workflow to.
1. In the top-right corner, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.
1. In the **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-workflows }}** tab, click ![](../../_assets/tracker/svg/copy-process.svg).
1. In the window that opens, fill in the fields:
   * **{{ ui-key.startrek.ui_components_queue-admin-tab-workflows_CopyWorkflowDialog.label-queue }}**.
   * **{{ ui-key.startrek.ui_components_queue-admin-tab-workflows_CopyWorkflowDialog.label-workflow }}**.
   * **{{ ui-key.startrek.ui_components_queue-admin-tab-workflows_CopyWorkflowDialog.label-name }}**.
1. Click **{{ ui-key.startrek.ui_components_queue-admin-tab-workflows_CopyWorkflowDialog.action-copy }}**.

## Deleting a workflow {#section_s35_xz5_vbb}

{% note warning %}

You cannot delete a workflow that is currently active for at least one issue in the queue. Before deleting a workflow, we recommend that you move its [issue types to a different workflow](backward-compatibility.md).

{% endnote %}

To delete a workflow:

1. Open the queue page.

1. In the top-right corner, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Go to the **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-workflows }}** tab.

1. Select the appropriate workflow and click ![](../../_assets/tracker/button-delete.png).
