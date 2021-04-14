# Setting up statuses

{% note warning %}

By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

You can choose a set of available statuses for each individual workflow. These statuses can be assigned to issues under your workflow.

## Add a status {#section_dcl_jdv_vbb}

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. On the **Statuses and transitions** panel, click **Add status**.

1. Fill in the fields:

    | Field | Description |
    | ----- | ----- |
    | **Choose new status** | Select one of the available statuses. |
    | **Previous status** | Select a status to transition from. If there are multiple statuses, you can [add them later](workflow-action-edit.md#section_en2_fhb_wbb). |
    | **Button name in English** | The name of the button in the {{ tracker-name }} interface that will switch the issue to this status. The same name is used for the transition in the editor. |
    | **Button name in Russian** | The name of the button in the Russian {{ tracker-name }} interface that will switch the issue to this status. |

   {% if audience == "external" %}

   The most popular statuses are available in {{ tracker-name }} by default. If you don't see the status you need, your company's admin can [create it](create-status.md).

   {% else %}

   If the status you need is missing in {{ tracker-name }}, send a request to create it via the [form](../user/create-param.md#section_bjz_3p4_xgb).

   {% endif %}

1. Click **Save**.

## Change status{#section_q4q_nfv_vbb}

#### Set this status as initial

Initial status is the first status of a newly created issue. To make the status initial:

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. Put the cursor on the desired status.

1. Click ![](../../_assets/tracker/initial-ststus-icon.png).

#### Configure the action when comments are added

You can configure automatically changing the issue status when a comment is added:

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. Select a status on the **Statuses and transitions** panel.

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

1. Select the initial status on the **Statuses and transitions** panel.

1. Go to the **Add transition** tab.

1. Configure a new transition:

    | Field | Description |
    | ---- | -------- |
    | **Transition to status** | Indicate the status to transition to. |
    | **Button name** | The name of the button in the {{ tracker-name }} interface that will switch the issue to this status. The same name is used for the transition in the editor. |
    | **Button name in Russian** | The name of the button in the Russian {{ tracker-name }} interface that will switch the issue to this status. |

1. Click **Save**.

1. [Edit your transition](workflow-action-edit.md) if you want to add conditions or auto-actions.

## Remove a status{#section_mqt_5fv_vbb}

{% note warning %}

You can't delete the initial status or a status that transitions originate from.

{% endnote %}

To remove a status from a workflow:

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. Put the cursor on the desired status.

1. Click ![](../../_assets/tracker/remove-task-type.png).

1. Confirm the deletion.

