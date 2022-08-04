# Setting up statuses

{% note warning %}

By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

You can choose a set of available statuses for each individual workflow. These statuses can be assigned to issues under your workflow.



## Creating a status {#create-status}

{% note warning %}

Only the [administrator](../role-model.md) can create new issue statuses. The created status can't be deleted or edited.

{% endnote %}

A status is an issue attribute that reflects the current state of the issue completion process. For example: <q>Open</q>, <q>In progress</q>, <q>Testing</q>, and <q>Closed</q>.

The most popular issue statuses are available in {{ tracker-name }} by default. If you need something different, create a new one:

1. Make sure you are logged in to {{ tracker-full-name }} as an [administrator](../role-model.md).

1. On the {{ tracker-name }} top panel, select ![](../../_assets/tracker/icon-settings.png) → **Configure {{ tracker-name }}**.

1. Go to the **Issue statuses** tab.

1. Click **Create status**.

1. Fill in the fields and click **Create**.


## Adding statuses to workflows {#section_dcl_jdv_vbb}

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. On the **Statuses and transitions** panel, click **Add status**.

1. Fill in the fields:

    | Field | Description |
    | ----- | ----- |
    | **Name** | Select one of the available statuses. |
    | **Previous status** | Select a status to transition from. If there are multiple statuses, you can [add them later](workflow-action-edit.md#section_en2_fhb_wbb). |
    | **Transition button name** | The name of the button in the {{ tracker-name }} interface that will switch the issue to this status. The same name is used for the transition in the editor. |
    | **Transition button name in Russian** | The name of the button in the English {{ tracker-name }} interface that will switch the issue to this status. |

   

   The most popular statuses are available in {{ tracker-name }} by default. If you don't see the status you need, your admin can [create one](#create-status).


1. Click **Save**.

## Changing statuses in workflows {#section_q4q_nfv_vbb}

#### Making a status the initial status

The initial status is the first status of a newly created issue. To make the status initial:

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. Put the cursor over the desired status.

1. Click the ![](../../_assets/tracker/initial-ststus-icon.png) icon that appears.

#### Configure the action when comments are added

You can configure automatically changing the issue status when a comment is added:

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. Select a status in the **Statuses and transitions** panel.

1. Go to the **Actions on comment** tab.

1. In **Choose an action**, select one of the options:

    - <q>Do nothing</q>: New comments won't change the issue status.

    - <q>Return to previous status</q>: The issue will be reverted to its previous status.

    - <q>Make transition</q>: When a comment is added, the issue will be switched to the selected status.

1. If necessary, enable the options **Set assignee from previous status** and **Only if comment was left by assignee**.

1. Click **Save**.

#### Add transition

You can add transitions between statuses available in your workflow:

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. Select the initial status in the **Statuses and transitions** panel.

1. Go to the **Add transition** tab.

1. Configure a new transition:

    | Field | Description |
    | ---- | -------- |
    | **Transition to status** | Indicate the status to transition to. |
    | **Button name** | The name of the button in the {{ tracker-name }} interface that will switch the issue to this status. The same name is used for the transition in the editor. |
    | **Button name in English** | The name of the button in the English {{ tracker-name }} interface that will switch the issue to this status. |

1. Click **Save**.

1. [Edit your transition](workflow-action-edit.md) if you want to add conditions or auto actions.

## Removing statuses from workflows {#section_mqt_5fv_vbb}

{% note warning %}

You can't delete the initial status or a status that transitions originate from.

{% endnote %}

To remove a status from a workflow:

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. Put the cursor over the desired status.

1. Click the ![](../../_assets/tracker/remove-task-type.png) icon that appears.

1. Confirm the deletion.

