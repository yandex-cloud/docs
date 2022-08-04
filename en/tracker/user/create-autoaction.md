# Automatic issue updates

You can use {{ tracker-name }} to automatically update issues that match a certain filter. For example, you can use an auto action to automatically check all issues containing a desired component every hour and set an assignee if one isn't set. You can also invite users responsible for the issue to the comments if you need a progress update.

{% note warning %}

When an auto action is triggered, only the first 100 issues that meet the specified criteria are processed.

{% endnote %}

## Configuring automatic issue updates {#section_eh1_zlr_kgb}

1. Open the [queue page](../user/queue.md).

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Configure**.

1. Select **Automation** → **Auto actions** in the left-hand panel and click **Create auto action**.

1. Select **Update issues**.

1. Enter a name for your auto action.

1. Set the update frequency in hours or days.

1. To pick issues to include in your auto action, set up a filter using one of the following methods:
    - Click **Add condition**, choose your issue's field, and specify its value.
You can add multiple conditions if you want. The auto action will only work if all the conditions are met simultaneously.
    - Click **Query** and set the required condition using the [query language](query-filter.md).

1. Set one or more issue actions:

    - **Change issue status**

         Set a new issue status. The available statuses depend on the [workflow](../manager/workflow-status-edit.md) settings.

         {% note warning %}

         Auto actions are performed by a service robot named `yndx-tracker-cnt-robot@`. To enable the robot to update issue statuses:

         - If certain [conditions are set up](../manager/workflow-action-edit.md#section_jrk_hmb_wbb) for status transitions and they restrict user permissions to change a status, add the `yndx-tracker-cnt-robot@` robot to the list of users.

         - If you [set up a transition screen](../manager/workflow-action-edit.md#section_uf2_sks_gcb) for the status change, make sure it doesn't have required fields.

         {% endnote %}

    - **Changing a field value**

        To change values in one or more fields, select the fields and [set their new values](set-action.md#section_mod_fields).

    - **Add comment**

        Enter the comment you wish to add to the issue.

        You can also enter [issue field values in your comments](vars.md). To do this, click **Add variable**.

    - **Calculating a value**

        You can [set up a special field](set-action.md#section_calc_field) whose values are calculated automatically based on values entered in other fields.

    - **HTTP request**

        You can [send HTTP requests](set-action.md#create-http) each time an auto action is triggered.

1. To save an auto action, click **Create**.

## Auto update example {#autoaction_example}

If you want an issue to be completed by a particular date, you can specify it in the **Deadline** field. If you want to make sure assignees finish their issues on time, you can use auto updates to send them reminders a few days before the deadline.

Let's set up a daily auto update that invites the assignee to the comments and only triggers if there are 3 days left before the deadline or less:

1. Select the queue you want to create an automatic reminder for and open its settings.

1. Go to **Auto actions** and click [**Create auto action**](create-autoaction.md#section_eh1_zlr_kgb).

1. Select **Update issues** and name the auto action.

1. Set the update frequency to once a day.

1. Set a condition that triggers an auto action if unsolved issues are detected with 3 days left before their deadline or less. To do this, go to **Filter settings**, select **Query**, and set a condition using the [query language](query-filter.md):

    ```
    Resolution: empty() AND Deadline: <= today() + 3d
    ```

    ![](../../_assets/tracker/autoaction-example-condition.png)

1. Set an auto action that invites the assignee to the comments:

    1. Click **Add new action** and select **Send comment**.

    1. In the field saying **Invite users from field**, click ![](../../_assets/tracker/summon.png) and enter **Assignee**.

    1. Write the text of your comment. You can add issue fields to the comment by clicking **Add variable**.

   ![](../../_assets/tracker/autoaction-example-action.png)

1. Save the auto action.

The created auto action then checks issues in the queue once a day. If the issue remains unsolved when there are less than 3 days until the deadline, the assignee is automatically invited to the comments.

