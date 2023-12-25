# Creating an issue

You can create issues in any of the available [queues](../queue-intro.md). Select the queue so that its subject corresponds to the issue's subject. If you do not know which queue to create your issue in, check with the project manager or your company's admin.

## Create an issue {#create-task}

To create an issue:

1. In the top-right corner, click ![](../../_assets/tracker/add-task-mobile.png).

1. Select the queue to create your issue in.

   
   {% note info %}

   The default queue selected for new issues is the one that is created automatically when you register your company in {{ tracker-name }}. To see a list of all available queues, delete the queue name in the issue creation window.

   {% endnote %}


1. Enter a name for the issue and tap **Create issue**.

1. A window with the new issue will open. The **Type**, **Priority**, **Status**, and **{{ ui-key.startrek-backend.fields.issue.author-key-value }}** fields are filled in automatically. Each queue can have its own [set of types and statuses](../manager/add-ticket-type.md).

1. [Edit](edit-ticket.md) the issue details:

   * Go to the **{{ ui-key.startrek.ui_components_IssueTabs.description-tab }}** tab and specify general parameters: add a description, select the issue type and priority, specify the assignee, and set the deadline. Use [YFM markup](../user/markup.md) to format text.

   * In the **{{ ui-key.startrek.ui_components_IssueTabs.fields-tab }}** tab, specify [additional parameters](../user/create-param.md#default-fields) for the issue.

   * If your issue is related to other issues, go to the **{{ ui-key.startrek.ui_components_IssueTabs.links-tab }}** tab and [create sub-issues](#subtask). To change the issue [link type](../user/links.md), tap ![](../../_assets/tracker/dots.png) next to the sub-issue name and choose a new type.

1. To [attach files or images to the issue](attach-file.md), open the screen for editing the issue description ![](../../_assets/tracker/icon-edit.png
   ). Then click ![](../../_assets/tracker/pin.png) and select the apps.

## Issue key {#key}

Each new issue is automatically assigned a key: this is the unique code that enables you to easily identify the issue. The issue key consists of the [queue key](../manager/create-queue.md#key) and the issue number (for example, `TEST-1234`). On the issue page, the key is shown under the issue's title.

You can use the issue key in order to:

* Create [links with other issues](ticket-links.md).
* Refer to the issue from other issues: for this, paste the issue key in the comment text or issue description. The key will be converted to a link.
* Directly access issues at: `({{ link-tracker-example-1 }})`.

## Creating a sub-issue {#subtask}

You can break down your complex issues into simpler sub-issues and track their resolution separately. After creating a sub-issue, you can change the [link type](../user/links.md).

To create a sub-issue:

1. Open the issue to create a sub-issue for.

1. In the top-right corner, click ![](../../_assets/tracker/dots.png) and select **{{ ui-key.startrek.ui_components_IssueActionsButton.menu-item-create-subticket }}**.

1. Fill in the fields the same way as when [creating a new issue](#create-task).

1. Click **{{ ui-key.startrek.ui_components_IssueActionsButton.menu-item-create-subticket }}**.




