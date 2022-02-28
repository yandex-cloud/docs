# Adding comments to issues

You can use comments to leave notes about progress, ask for additional information, or ask colleagues to join the discussion.

{% note tip %}

If you keep all your discussions about an issue in the comments section, you will always have access to the full history of what was discussed.

{% endnote %}

## Leaving a comment {#leave-comment}

{% list tabs %}

- Web interface

    To comment on an issue, enter your text in the box at the bottom of the page and click **Submit**. You can use [markup](markup.md) in the comments section and attach images and files.

    You can use the comments section to specify a key for a different issue so that {{ tracker-name }} automatically links the issue.



    If you close or refresh the page without sending your comment, it is still stored in drafts. You can restore the comment text by clicking ![](../../_assets/tracker/drafts.png) in the toolbar above the comment box and choosing the draft.

- Mobile app

    To comment on an issue, enter your text in the **Write a comment** box at the bottom of the screen and tap ![](../../_assets/tracker/send.png). You can use [text markup](markup.md) and [attach images and files](#sec_file) in the comment section. To expand the comment box to full screen, tap ![](../../_assets/tracker/open-text.png).

    You can use the comments section to specify a key for a different issue so that {{ tracker-name }} automatically [links](ticket-links.md#add-link) the issue.

{% endlist %}

## Replying to comments {#answer-comment}

{% list tabs %}

- Web interface

    1. Hover over the comment and click **Reply**. The comment you reply to is quoted in the response.

    1. Make your changes and click **Submit**.

- Mobile app

    1. Tap ![](../../_assets/tracker/dots.png) next to the comment and select **Reply**. The comment you reply to is quoted in the response.

    1. Make your changes and tap ![](../../_assets/tracker/send.png).

{% endlist %}

## Editing comments {#edit-comment}

{% list tabs %}

- Web interface

    1. Hover over the comment and click **Edit**.

    1. Make your changes and click **Save**.

    Any changes to comments are saved in the [History](history.md).

- Mobile app

    1. Tap ![](../../_assets/tracker/dots.png) next to the comment and select **Edit**.

    1. Make your changes and tap ![](../../_assets/tracker/send.png).

    Any changes to comments are saved in the [History](history.md).

{% endlist %}

## Inviting to comment {#call-comment}

{% list tabs %}

- Web interface

    To invite other users to discuss an issue:

    1. Above the comment box, click ![](../../_assets/tracker/summon.png).

    1. Enter the login or name of the user you want to invite to the comments. You can invite multiple users at once.

    1. Enter the comment text.

    1. Click **Submit**.

- Mobile app

    To invite other users to discuss an issue:

    1. Select **Write a comment** at the bottom of the screen and tap ![](../../_assets/tracker/at.png).

    1. Enter the username or name of the user you want to invite to the comments and tap **Save**. You can invite multiple users at once.

    1. Enter the comment and tap ![](../../_assets/tracker/send.png).

{% endlist %}

Users invited to comment are notified by email, with their names added to the **Pending reply from** issue field.

{% note info %}

If you add a user in the **Pending reply from** field without inviting them when sending your comment, that user won't receive an email notification.

{% endnote %}

## Attaching a file {#sec_file}

{% list tabs %}

- Web interface

    Drag files to the comment box or click **Choose files**.

    To insert images attached to an issue in the comment text, click ![](../../_assets/tracker/add-image.png).

- Mobile app

    To attach a file to a comment:

    1. Select **Write a comment** at the bottom of the screen and tap ![](../../_assets/tracker/pin.png).

       * To add a photo or video from your phone's camera, tap **Camera**. When everything is ready, tap **OK**. To take a new photo or video, tap **Repeat**.

       * To attach files from your phone, tap **Files** and select them.

       {% note info %}

       If you're attaching files for the first time, allow access to your phone's camera and files.

       {% endnote %}

    1. Enter the comment and tap ![](../../_assets/tracker/send.png).

    The attached files are displayed below the comment.

{% endlist %}

## Sending comments to a user's email address {#send-comment}

{% note alert %}

You can only send comments to **external** users if the [queue settings](../manager/edit-queue-general.md) allow it.

{% endnote %}

You can send emails to in-house and outside users directly from the issue page. The message text is attached to the issue as a comment.

To send an email from the issue page:

1. Click **Email** on the toolbar under the issue title.

1. Choose an address to send your email from:

    {% list tabs %}

    - Queue address

        You can use this option if the queue has a [dedicated email address](../manager/queue-mail.md#section_gwv_hqb_hgb).

        The <q>From</q> field will only display the queue address. Responses to such emails are turned into comments for the corresponding issue.

        You can set up a custom **Sender name** to communicate with external users. Create one or more sender names in the [queue email address](../manager/queue-mail.md#section_ffq_gqb_hgb) settings.

    - Your own address

        The <q>From</q> field will display your name and email address.

    {% endlist %}

1. Specify your recipient and write your message.

1. Click **Submit**.

Responses to such emails are turned into comments for the corresponding issue automatically.

## Sharing a comment {#share-comment}

{% list tabs %}

- Web interface

    To copy a link to a comment, hover over it and click ![](../../_assets/tracker/share-comment.png). You can also click on the date in the upper-right corner of the comment: the link to it appears in the browser address bar.

- Mobile app

    To copy a link to a comment, tap ![](../../_assets/tracker/dots.png) next to it and select **Copy link**.

{% endlist %}

## Deleting a comment {#delete-comment}

{% list tabs %}

- Web interface

    To delete a comment, hover over it and click ![](../../_assets/tracker/delete-comment.png).

- Mobile app

    To delete a comment, tap ![](../../_assets/tracker/dots.png) next to it and select **Delete**.

{% endlist %}



## Using templates {#template-comment}

#### Creating a template {#create-template}

If you frequently leave similar comments, make a template for them. You can create a template on the [relevant page](ticket-template.md) or from the comment text:

1. Enter the comment that you want to make a template.

1. Tap ![](../../_assets/tracker/comment-template.png).

1. Choose **Create template from this comment** from the drop-down list.

1. Enter a name for the template.

1. If you want the template to only be available in this queue, select the **Bind template to queue** option.

1. Click **Create**.

#### Using a template {#use-template}

To create a comment from a template:

1. Make sure that the comments field does not contain any text.

1. Tap ![](../../_assets/tracker/comment-template.png).

1. Select a template from the drop-down list and click **Choose**.

1. If necessary, edit the comment. To publish it, click **Submit**.

## Creating an issue based on a comment {#create-task}

If the discussion of an issue leads to creating a new issue, you can create it directly from the comment:

1. Click the comment that the new issue will be based on.

1. Click **Create issue** and choose the link type.

1. Fill in the fields the same way as when [creating a regular issue](create-ticket.md#create-task).

1. Click **Create**.

## Sorting comments {#order-comments}

Comments are listed chronologically by default. If you want to place the most recent comments at the start of the chain, do the following:

1. {% include [open-personal-settings](../../_includes/tracker/open-personal-settings.md) %}

1. Under **Message order in issues**, select **Newest first**.

1. Click **Save**.

All issue changelogs on the **History** tab will also change their order to newest first.

