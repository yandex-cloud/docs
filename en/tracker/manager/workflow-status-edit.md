# Setting up statuses

{% note warning %}

By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

You can configure a set of available statuses for each workflow. You can assign such statuses to the issues that your workflow is applied to.


## Creating a status {#create-status}

{% note warning %}

Only an [administrator](../role-model.md) can create new issue statuses. Once you have created a status, you can't delete or edit it.

{% endnote %}

A status is an issue attribute that reflects the current state of the issue completion process. For example: <q>{{ ui-key.startrek-backend.applinks.samsara.status.open }}</q>, <q>{{ ui-key.startrek-backend.applinks.samsara.status.in.progress }}</q>, <q>{{ ui-key.startrek-backend.presets.developmentPreset.board.column.testing }}</q>, or <q>{{ ui-key.startrek-backend.applinks.samsara.status.closed }}</q>.

The most popular issue statuses are available in {{ tracker-name }} by default. If there is no matching status among them, create a new status.

1. Make sure you are authorized in {{ tracker-full-name }} as an [administrator](../role-model.md).

1. In the right-hand panel, select ![](../../_assets/tracker/svg/admin.svg) **{{ ui-key.startrek.blocks-desktop_b-page-queue.cp }}** → **{{ ui-key.startrek.ui_components_page-admin_PageAdmin.tracker-settings }}**.

1. Click the **{{ ui-key.startrek.ui_components_page-admin_PageAdmin.menu-item-issue-statuses }}** tab.

1. Click **{{ ui-key.startrek.blocks-desktop_page-admin-tab.create--statuses }}**.

1. Fill in the fields and click **{{ ui-key.startrek.blocks-desktop_b-form-new-component.button-create }}**.


## Adding a status to the workflow {#section_dcl_jdv_vbb}

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. In the **{{ ui-key.startrek.blocks-desktop_workflow-editor.sidebar-title }}** panel, click **{{ ui-key.startrek.blocks-desktop_workflow-editor.sidebar-add-status }}**.

1. Fill out the fields below:

   | Field | Description |
   ----- | -----
   | **Choose a new status** | Choose one of the available statuses. |
   | **Previous status** | Select the original status of the transition. If there are multiple statuses, you can [add them later](workflow-action-edit.md#section_en2_fhb_wbb). |
   | **{{ ui-key.startrek.blocks-desktop_workflow-editor.add-status-popup--name }}** | The name of the button in the {{ tracker-name }} interface that will switch the issue to this status. The transition also has this name in the editor. |
   | **{{ ui-key.startrek.blocks-desktop_workflow-editor.add-status-popup--name-en }}** | The name of the button in the English {{ tracker-name }} interface that will switch the issue to this status. |

   
   The most popular statuses are available in {{ tracker-name }} by default. If you don't see the status you need, admin can [create one](#create-status).


1. Click **{{ ui-key.startrek.blocks-desktop_workflow-editor--step.button--submit }}**.

## Changing the status in the workflow {#section_q4q_nfv_vbb}

#### Making a status the initial status

The initial status is the first status of a newly created issue. To make the status initial:

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. Put the cursor over the desired status.

1. Click the ![](../../_assets/tracker/initial-ststus-icon.png).

#### Setting up an action on commenting

You can set issues to automatically change their status on commenting:

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. Select a status in the **{{ ui-key.startrek.blocks-desktop_workflow-editor.sidebar-title }}** panel.

1. Click the **{{ ui-key.startrek.blocks-desktop_workflow-editor--step.tab-title--actions-on-comment }}** tab.

1. In **{{ ui-key.startrek.blocks-desktop_workflow-editor--step_tab_actions-on-comment.select-action }}**, select one of the options:

   - <q>{{ ui-key.startrek.blocks-desktop_workflow-editor--step_tab_actions-on-comment.make-no-transition }}</q>: New comments will not change the issue status.

   - <q>{{ ui-key.startrek.blocks-desktop_workflow-editor--step_tab_actions-on-comment.prev-status }}</q>: The issue will be reverted to its previous status.

   - <q>{{ ui-key.startrek.blocks-desktop_workflow-editor--step_tab_actions-on-comment.make-transition }}</q>: When a comment is added, the issue will be switched to the selected status.

1. If necessary, enable the options **{{ ui-key.startrek.blocks-desktop_workflow-editor--step_tab_actions-on-comment.revert-assignee }}** and **{{ ui-key.startrek.blocks-desktop_workflow-editor--step_tab_actions-on-comment.on-assignee-comment-only }}**.

1. Click **{{ ui-key.startrek.blocks-desktop_workflow-editor--step.button--submit }}**.

#### Adding a transition

You can add a transition between the statuses set for your workflow:

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. Select the initial status in the **{{ ui-key.startrek.blocks-desktop_workflow-editor.sidebar-title }}** panel.

1. Click the **{{ ui-key.startrek.blocks-desktop_workflow-editor--step.tab-title--create-action }}** tab.

1. Set up a new transition:

   | Field | Description |
   ---- | --------
   | **{{ ui-key.startrek.blocks-desktop_workflow-editor--action_tab_general.target-status--label }}** | Specify the target status of the transition. |
   | **{{ ui-key.startrek.blocks-desktop_workflow-editor--action_tab_general.name-ru--label }}** | The name of the button in the {{ tracker-name }} interface that will switch the issue to this status. The transition also has this name in the editor. |
   | **{{ ui-key.startrek.blocks-desktop_workflow-editor--action_tab_general.name-en--label }}** | The name of the button in the English {{ tracker-name }} interface that will switch the issue to this status. |

1. Click **{{ ui-key.startrek.blocks-desktop_workflow-editor--step.button--submit }}**.

1. [Edit your transition](workflow-action-edit.md) if you want to add conditions or auto actions.

## Deleting a status from the workflow {#section_mqt_5fv_vbb}

{% note warning %}

You can't delete the initial status or a status that transitions originate from.

{% endnote %}

To delete a status from the workflow:

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. Put the cursor over the desired status.

1. Click the ![](../../_assets/tracker/remove-task-type.png).

1. Confirm the deletion.