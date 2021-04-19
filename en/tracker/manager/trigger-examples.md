# Examples

Let's look at some examples of how triggers work in {{ tracker-name }}:

- How to [automatically pick assignees](#assign_ticket) based on status or component.

- How to [automatically invite assignees](#summon_ticket) based on the status or field value.


- How to [set up notifications in messengers](#section_vsn_mb2_d3b) via HTTP requests.

## Pick assignees automatically {#assign_ticket}

Different stages of a project are often handled by different employees. When an employee does their part, they transfer the issue to another assignee. In {{ tracker-name }}, each issue stage has its own status. When an issue receives a status update, a new employee can be automatically assigned to work on the issue with a trigger.

However, sometimes employees only handle issues related to their field of expertise and don't collaborate on a single issue. For example, each support team member only processes requests related to the product they were assigned to. To manage this kind of workflow, you can [configure components](components.md) so that they correspond to specific products. When a specific component is added to the issue, the employee responsible for the corresponding product is automatically assigned to work on it via a trigger.

Let's set up a trigger that automatically picks an assignee for our issue:


1. Make sure every employee you might want to assign [has full access to {{ tracker-name }}](../enable-tracker.md).

1. Go to queue settings, open the **Triggers** section, and click [**Create trigger**](../user/create-trigger.md).

1. Set the trigger to react when the issue's <q>Status</q> or <q>Components</q> change:

    1. Choose **Conditions to be met** → **All**.

    1. Add the condition **Event type** → **Issue changed**.

    1. If you want a new assignee to be picked after a status update, add the following condition: **System** → **Status** → **Field value became equal to** and specify the status.

        ![](../../_assets/tracker/trigger-example-status.png)

        If you want a new assignee to be picked after a component changes, add the following condition: **System** → **Components** → **Field value became equal to** and specify the components.

        ![](../../_assets/tracker/trigger-example-components.png)

        {% note info %}

        This trigger only works if only one component is specified in the issue.

        {% endnote %}

1. Set a trigger action:

    1. Add the action **Change field values**.

    1. Choose **System** → **Assignee** → **Set value** and specify who should be picked as the assignee after the trigger is executed.

        ![](../../_assets/tracker/trigger-example-assignee.png)

1. Save your trigger.
To see if you trigger works, pick any issue from the queue with the added trigger and change the issue's status or components.

## Invite assignees automatically {#summon_ticket}

After completing an issue, the assignee may forget to specify some important information, such as time spent. In this case, you can configure a trigger that will automatically invite the assignee if the issue is closed and the time spent is not specified:

1. Go to queue settings, open the **Triggers** section, and click [**Create trigger**](../user/create-trigger.md).

1. Set the trigger to react when the issue is closed with the <q>Time spent</q> field being empty:

    1. Choose **Conditions to be met** → **All**.

    1. Add the condition **Status** → **Field value became equal to** → **Closed**.

    1. Add the condition **Time spent** → **Field value empty**.

1. Set trigger actions:

    1. Add the **Add comment** action.

    1. Click ![](../../_assets/tracker/summon.png), find the line **Invite users from a field**, and enter <q>Assignee</q>.

    1. Enter the comment to be displayed to the assignee and choose **Send as robot**.

1. Click **Create** to save the trigger.

    ![](../../_assets/tracker/trigger-example-summon.png)

When closing any issue that does not specify the time spent, the robot will create a comment and invite the assignee.


## Send notifications to instant messengers {#section_vsn_mb2_d3b}

Messengers are a great way to quickly notify employees about important events. If a messenger has an API, you can use {{ tracker-name }} to set up a trigger that sends HTTP requests to the messenger's API when certain events occur. For instance, a request can be triggered once an error with the critical priority status is added to the queue.

To view examples for setting up triggers that send notifications to Slack and Telegram, see [{#T}](../messenger.md).

