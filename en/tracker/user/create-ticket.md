# Creating issues

You can create issues in any of the available [queues](../queue-intro.md). Select the queue that best matches the topic of the issue. If you don't know which queue to create your issue in, check with the project manager or your organization's admin.



## Creating an issue {#create-task}

{% list tabs %}

- Web interface

    To create an issue:

    1. On the top panel in {{ tracker-name }}, click **Create issue**.

    1. Select the **Queue** to create the issue in.

        {% note info %}

        The queue owner can [set up simplified forms](../manager/attach-form.md) for creating issues. If this is the case, select the appropriate form and fill in the fields following the prompts. If you are unsure how you should fill the form out, contact the queue owner.

        If no simplified forms are linked to the queue, the standard issue creation form will open instead.

        {% endnote %}

    1. Select the issue **Type**.
Each queue can have its own [set of issue types](../manager/add-ticket-type.md). If you don&apos;t see an appropriate type in the list, contact the queue owner.

    1. Enter a title in the **Summary** field.

    1. Fill in the **Description** field. Use [YFM markup](markup.md) to format text.

    1. Click **Choose files** to attach files or images to the issue.
To insert images into the text, click ![](../../_assets/tracker/add-image.png).

    1. Enter the login or name of the assignee or click **Me** to assign the issue to yourself.
You can also leave this field empty to assign someone later.

    1. Select the issue **Priority**.

    1. If your issue is related to other issues, create links between them. To do this, click **Add link** and specify the related issues.

    1. You can specify [additional settings](create-param.md#section_ymd_ycj_1gb) if necessary. To do this, add fields by clicking ![](../../_assets/tracker/task-params-btn.png) **Select fields** and fill them in.

    1. Click **Create** at the bottom of the page.

        {% note tip %}

        If you need to create a lot of similar issues, make a [template](ticket-template.md) for them.

        {% endnote %}

- Mobile app

    To create an issue:

    1. In the upper-right corner, tap ![](../../_assets/tracker/add-task-mobile.png).

    1. Select the queue to create your issue in.



        {% note info %}

        The default queue selected for new issues is the one that is created automatically when you register your company in {{ tracker-name }}. To see a list of all available queues, delete the queue name in the issue creation window.

        {% endnote %}


    1. Name the issue and tap **Create issue**.

    1. A window with the new issue opens. The **Type**, **Priority**, **Status**, and **Author** fields are filled in automatically. Each queue can have its own [set of types and statuses](../manager/add-ticket-type.md).

    1. [Edit](edit-ticket.md) the issue details:

        - Go to the **Description** tab and specify general parameters: add a description, select the issue type and priority, specify the assignee, and set the deadline. Use [YFM markup](markup.md) to format text.

        - On the **Parameters** tab, specify [additional settings](create-param.md#section_ymd_ycj_1gb) for the issue.

        - If your issue is related to other issues, go to the **Related** tab and [create sub-issues](#subtask). To change the issue [link type](links.md), tap ![](../../_assets/tracker/dots.png) next to the sub-issue name and choose a new type.

    1. To [attach files or images to the issue](attach-file.md), open the screen for editing the issue description ![](../../_assets/tracker/icon-edit.png). Then tap ![](../../_assets/tracker/pin.png) and choose what you want to attach.

{% endlist %}

## Issue key {#key}

Each new issue is automatically assigned a unique key that identifies it. The issue key consists of the [queue key](../manager/create-queue.md#key) and the issue number (for example, `TEST-1234`). The key is displayed under the issue's title on the issue page.

Here is what you can do with issue keys:

- [Create links with other issues](ticket-links.md).
- Paste the queue key into an issue's description or comment body to put a link to another issue there. It will be converted into a clickable link.
- Directly access issues at: `({{ link-tracker-example-1 }})`.

## Creating a sub-issue {#subtask}

Complex tasks can be divided into simpler sub-issues and tracked separately. After creating a sub-issue, you can change the [link type](links.md).

{% list tabs %}

- Web interface

    To create a sub-issue:

    1. Open the issue page to create a sub-issue for.

    1. Select **Actions** → **Create sub-issue**.

    1. Fill in the fields the same way as when [creating a new issue](#create-task).

    1. Click **Create**.

- Mobile app

    To create a sub-issue:

    1. Open the issue to create a sub-issue for.

    1. In the upper-right corner, tap ![](../../_assets/tracker/dots.png) and select **Create sub-issue**.

    1. Fill in the fields the same way as when [creating a new issue](#create-task).

    1. Tap **Create issue**.

{% endlist %}

## Sharing issue templates {#share}

You can share an issue template with a coworker before finalizing it. This could come in handy in some situations (e.g. quickly creating a batch of similar issues).

Follow these steps to share an issue template:

1. Specify the issue settings as described in [{#T}](#create-task).

1. Click ![](../../_assets/tracker/copy-ticket.png) **Copy link to form template** at the bottom of the issue creation page.

1. Copy the link and send it to your coworker however you find convenient.

Clicking this link sends you to an issue creation window with its fields filled out. You can save the link and use it as a template for quick issue creation.

#### Next step

[Viewing my issues](my-tickets.md)

