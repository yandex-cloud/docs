# Creating issue

You can create issues in any of the available [queues](../queue-intro.md). Select the queue so that its subject corresponds to the issue's subject. If you don't know which queue to create your issue in, check with the project manager or your company's admin.


## Create an issue {#create-task}

To create a issue:

1. Click ![](../../_assets/tracker/svg/icon-add.svg) **Create issue** in the left panel.

1. In the upper-left corner of the page, choose the queue to create your issue in.

   {% note info %}

   The queue owner can [set up simplified forms](../manager/attach-form.md) for creating issues. In this case, select the proper form and fill out the fields by following the tips. If in doubt how to properly fill out the form, contact the queue owner.

   If no simplified form has been added to the queue, a standard issue creation form with open.

   {% endnote %}

1. Enter a name for the issue.

1. Add an issue description. Use [YFM markup](markup.md) to format text.

1. To add files or images to the issue, click **Attach files**.

1. To add a list of steps for issue resolution, click **Add checklist**.

1. In the right panel, specify:

   * Key issue parameters: <q>Type</q>, <q>Priority</q>, <q>Deadline</q>, <q>Project</q>, and <q>Tags</q>.

   * List of the users related to the issue: enter the name or login in the fields <q>Assignee</q> and <q>Followers</q> or click **Me** to add yourself.

      You can also leave the values at defaults to come back to them later.

1. If necessary, configure [additional parameters](create-param.md#default-fields): For this, add the fields using the button ![](../../_assets/tracker/task-params-btn.png) **Edit parameter list** and fill them out.

1. Click **Create issue**.

   {% note tip %}

   If you need to create a lot of similar issues, make a [template](ticket-template.md) for them.

   {% endnote %}

## Issue key {#key}

Each new issue is automatically assigned a key: this is the unique code that enables you to easily identify the issue. The issue key consists of the [queue key](../manager/create-queue.md#key) and the issue number (for example, `TEST-1234`). On the issue page, the key is shown under the issue's title.

You can use the issue key in order to:

* Create [links with other issues](ticket-links.md).
* Refer to the issue from other issues: for this, paste the issue key in the comment text or issue description. The key will be converted to a link.
* Directly access issues at: `({{ link-tracker-example-1 }})`.

## Creating a sub-issue {#subtask}

You can break down your complex issues into simpler sub-issues and track their resolution separately. After creating a sub-issue, you can change the [link type](links.md).

To create a sub-issue:

1. Open the issue page to create a sub-issue for.

1. In the upper-right corner, select **Actions** → **Add sub-issue**.

1. Fill in the fields the same way as when [creating a new issue](#create-task).

1. Click **Create issue**.


#### The next step

[Viewing my issues](my-tickets.md)



