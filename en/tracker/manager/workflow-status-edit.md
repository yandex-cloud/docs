# Setting up statuses

{% note warning %}

By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

You can configure a set of available statuses for each workflow. You can assign such statuses to the issues that your workflow is applied to.

{% if audience == "external" %}

## Creating a status {#create-status}

{% note warning %}

Only an [administrator](../role-model.md) can create new issue statuses. Once you have created a status, you can't delete or edit it.

{% endnote %}

A status is an issue attribute that reflects the current state of the issue completion process. For example: <q>Open</q>, <q>In progress</q>, <q>Testing</q>, and <q>Closed</q>.

The most popular issue statuses are available in {{ tracker-name }} by default. If there is no matching status among them, create a new status.

1. Make sure you are authorized in {{ tracker-full-name }} as an [administrator](../role-model.md).

1. On the right-hand panel, select ![](../../_assets/tracker/svg/admin.svg) **Administration** → **{{ tracker-name }} setting** .

1. Go to the **Issue statuses** tab.

1. Click **Create status**.

1. Fill in the fields and click **Create**.

{% endif %}

## Adding a status to the workflow {#section_dcl_jdv_vbb}

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. On the **Statuses and transitions** panel, click **Add status**.

1. Complete the fields below:

   | Field | Description |
   ----- | -----
   | **Choose a new status** | Choose one of the available statuses. |
   | **Previous status** | Select the original status of the transition. If there are multiple statuses, you can [add them later](workflow-action-edit.md#section_en2_fhb_wbb). |
   | **Transition button name** | The name of the button in the {{ tracker-name }} interface that will switch the issue to this status. The transition also has this name in the editor. |
   | **Transition button name in Russian** | The name of the button in the English {{ tracker-name }} interface that will switch the issue to this status. |

   {% if audience == "external" %}

   The most popular statuses are available in {{ tracker-name }} by default. If you don't see the status you need, admin can [create one](#create-status).

   {% else %}

   If the desired status isn't available in {{ tracker-name }}, send a request for creating it via the [form](https://forms.yandex-team.ru/surveys/66769/).

   {% endif %}

1. Click **Save**.

## Changing the status in the workflow {#section_q4q_nfv_vbb}

#### Making a status the initial status

The initial status is the first status of a newly created issue. To make the status initial:

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. Put the cursor over the desired status.

1. Click the ![](../../_assets/tracker/initial-ststus-icon.png).

#### Setting up an action on commenting

You can set issues to automatically change their status on commenting:

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. Select a status in the **Statuses and transitions** panel.

1. Go to the **Actions on comment** tab.

1. In **Choose an action**, select one of the options:

   - <q>Do nothing</q>: New comments won't change the issue status.

   - <q>Return to previous status</q>: The issue will be reverted to its previous status.

   - <q>Make transition</q>: When a comment is added, the issue will be switched to the selected status.

1. If necessary, enable the options **Set assignee from previous status** and **Only if comment was left by assignee**.

1. Click **Save**.

#### Adding a transition

You can add a transition between the statuses set for your workflow:

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. Select the initial status in the **Statuses and transitions** panel.

1. Go to the **Add transition** tab.

1. Set up a new transition:

   | Field | Description |
   ---- | --------
   | **Transition to status** | Specify the target status of the transition. |
   | **Button name** | The name of the button in the {{ tracker-name }} interface that will switch the issue to this status. The transition also has this name in the editor. |
   | **Button name in English** | The name of the button in the English {{ tracker-name }} interface that will switch the issue to this status. |

1. Click **Save**.

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