# Issue statuses

A status is an issue attribute that reflects the current state of the issue completion process, e.g., **{{ ui-key.startrek-backend.applinks.samsara.status.open }}**, **{{ ui-key.startrek-backend.applinks.samsara.status.in.progress }}**, **{{ ui-key.startrek-backend.presets.developmentPreset.board.column.testing }}**, or **{{ ui-key.startrek-backend.applinks.samsara.status.closed }}**.

For each [issue type](./add-workflow.md) in a queue [workflow](./add-ticket-type.md), you can define their own set of statuses and [transitions](./workflow-action-edit.md) between them. The queue owner and users granted [permission to access the queue settings](queue-access.md) can edit statuses in queue workflows.

In {{ tracker-name }}, there are system statuses that are listed in the [{{ tracker-name }} settings]({{ link-tracker-statuses }}). You can use these statuses in any workflows. If you do not find suitable statuses among the system ones, a {{ tracker-name }} [administrator](../role-model.md) can create new statuses. They will appear in the common status list and users will be able to use them in their workflows.

## Setting up statuses in the workflow editor {#status-settings}

You can set up statuses within a workflow using the workflow visual editor. To open the workflow editor:

1. Go to the queue page.

1. In the top-right corner, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_Queues_pages_PageQueue_header.settings }}**.

1. Go to the **{{ ui-key.startrek.ui_Queues_pages_page-queue-admin_QueueAdminPageContent.menu-item-workflows }}** tab and click the name of the workflow you want to edit statuses in.

The workflow visual editor will open. You can use it to edit existing statuses. To do this, just click the appropriate status in the diagram to open its settings page. You can also [add new statuses](#add-status) to the diagram.

### Workflow start {#initial-status}

Workflow start is the initial status of a newly created issue. In the workflow visual editor, the status being the workflow start is indicated with a flag indicator.

To make a status the starting point of a workflow, click this status in the diagram. This will open the status settings window. In the top-right corner of the setup window, click ![](../../_assets/tracker/initial-ststus-icon.png).

{% note warning %}

A workflow must have a status that starts the workflow. Statuses of any type can act as the workflow start.

{% endnote %}

### Status types {#status-types}

You can define a status type within a workflow. All statuses of the same type are highlighted in a certain color:
* ![](../../_assets/tracker/svg/initial.svg): Issue has been created but is not in progress yet.
* ![](../../_assets/tracker/svg/progress.svg): Issue is in progress.
* ![](../../_assets/tracker/svg/pause.svg): Work on the issue is suspended.
* ![](../../_assets/tracker/svg/end.svg): Issue has been completed and closed.
* ![](../../_assets/tracker/svg/cancel.svg): Issue has not been not completed and is closed.

Issues with the **Completed** and **Canceled** status are considered closed: they appear with a crossed out key in the queue.

### Status update after adding a comment {#change-with-comment}

The **Changing the status when commenting** setting allows updating the status after a comment is added to an issue. It is useful in linear processes, e.g., for the support team.

1. Open the settings of the status to make a transition from when a comment is added to the issue and click **Changing the status when commenting**.

1. Select the target status from the list that the issue should change to after adding a comment. The list contains transitions for the status you are setting up, which have been added to the workflow diagram. Sample transitions in the list include:
   * To the previous status: Issue will switch back to its previous status.
   * **Close** transition: Issue will switch to the **Completed** status.
   * **Need info** transition: Issue will switch to the **Paused** status.
   * **Reopen** transition: Issue will switch to the **Initial** status.

1. If necessary, enable the options **Set assignee from previous status** and **Only if comment was left by assignee**.

1. Click **Save**.

### Transitions between statuses {#add-action}

For a workflow to run properly, make sure to set up [transitions](./workflow-action-edit.md) between statuses.

To set up a status transition:

1. Go to **Transitions** in the status settings and click **Add**.
   The **Source status** field will show the source status. Fill in the **New status** field with the target status that you can choose from the list. The list contains statuses which have been added to the workflow diagram.

1. **Name**: This field is for the name of the button in the {{ tracker-name }} interface that will switch the issue to this status. The same name will be used for the transition in the editor. By default, the name matches the new status in the transition; however, you can edit it. The **Name in English** is filled in automatically.

1. Select the appropriate workflow and click ![](../../_assets/tracker/button-edit.png).

1. Select the initial status in the **Statuses and transitions** panel.

1. Go to the **Add transition** tab.

1. You can configure the following for transitions:
   * [Automation](./workflow-action-edit.md#automatization): Auto actions to be performed during a transition.
   * [Transition conditions](./workflow-action-edit.md#conditions): Conditions under which a transition will be available.
   * [Transition screen](./workflow-action-edit.md#screen): Pop-up window where the user must fill in the respective fields to update the issue parameters.

For convenience, there is a special transition type named **Allow transitions from any status**. For example, if you need to add a status to a workflow, which is achievable from any other status, you will not need to manually set up these transitions for each status in the diagram. Just enable **Allow transitions from any status** and the diagram will show a meta transition for this status.

### Copying transitions {#copy-transitions}

You can apply transitions of one status to other statuses. To do this:

1. In the status settings, click ![](../../_assets/tracker/svg/actions.svg).
1. Click ![](../../_assets/tracker/svg/copy-transition.svg) **Copy transitions from this status to another** or ![](../../_assets/tracker/svg/paste-transition.svg) **Paste transitions from another status**.
1. In the list, select a status to insert or copy the transitions to.

## Creating a status {#create-status}

{% note warning %}

Only an [administrator](../role-model.md) can create new issue statuses. Once you have created a status, you cannot delete or edit it.

{% endnote %}

To create a new status:

1. Make sure you are authorized in {{ tracker-full-name }} as an [administrator](../role-model.md).

1. In the left-hand panel, select ![](../../_assets/tracker/svg/admin.svg) **Administration** → **Issue statuses**.

1. Click **Create status**.

1. Fill out the fields below:
   * **Name**: Enter a status name in Russian.
   * **Name in English**: It will be generated automatically based on the Russian name.
   * **Key**: It will be generated automatically based on the Russian name.

1. Click **Create**.

You can also create a status on the workflows page. The created status will be immediately added to the current queue's workflow. However, you can also use it in other queues.

1. Go to the queue page.

1. In the top-right corner, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_Queues_pages_PageQueue_header.settings }}**.

1. Go to the **{{ ui-key.startrek.ui_Queues_pages_page-queue-admin_QueueAdminPageContent.menu-item-workflows }}** tab. It shows the list of workflows in the queue. Select the workflow to add the new status to and click its name. The workflow visual editor will open.

1. In the top panel of the workflow visual editor, click **Add status**. Start typing the name of the new status and click the **Create** button.

1. Fill out the fields below:
   * **Name**: Enter a status name in Russian.
   * **Name in English**: It will be generated automatically based on the Russian name.
   * **Key**: It will be generated automatically based on the Russian name.

1. Select the appropriate status type from the list.

1. Click **Create**.

## Adding a status to a workflow {#add-status}

To add a status to a workflow:

1. Go to the queue page.

1. In the top-right corner, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_Queues_pages_PageQueue_header.settings }}**.

1. Go to the **{{ ui-key.startrek.ui_Queues_pages_page-queue-admin_QueueAdminPageContent.menu-item-workflows }}** tab and click the name of the workflow you need. The workflow visual editor will open.

1. In the top panel of the workflow visual editor, click **Add status**. Start typing the name of the new status and click the **Create** button.

1. In the suggested list of statuses, select the one to add to the workflow.

   
   The most popular statuses are available in {{ tracker-name }} by default. If you do not see the status you need, the admin can [create one](#create-status).


1. Set up the status. You can:
   * Make it the [workflow start](#initial-status).
   * Select the [status type](#status-types).
   * Set up a [status update after adding a comment](#change-with-comment).
   * Configure [transitions](#add-action).

## Deleting a status from a workflow {#remove-status}

When a status is deleted, all the related status transitions are deleted, too. If you try to delete the status being the workflow start, an error occurs in the diagram, as the workflow may not exist without a starting point.

To delete a status from a workflow:

1. In the top-right corner of the queue page, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_Queues_pages_PageQueue_header.settings }}**.

1. Go to the **{{ ui-key.startrek.ui_Queues_pages_page-queue-admin_QueueAdminPageContent.menu-item-workflows }}** tab. In the editor, open the workflow to delete the status from.

1. Click the status to be deleted and then press **Delete** on the keyboard or go to the status settings and click ![](../../_assets/tracker/svg/actions.svg) → **Remove from workflow**.
