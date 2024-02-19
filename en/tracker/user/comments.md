# Adding comments to issues

You can use comments to leave notes about the work progress, ask questions about the issue description, and invite your teammates to discuss the issue.

{% note tip %}

If you only discuss an issue in the comments, you will always have access to a full history of its discussion.

{% endnote %}

## Leaving a comment {#leave-comment}

To comment on an issue, enter your text in the box at the bottom of the page and click **Submit**. In the comments section, you can use [text markup](markup.md) and attach images and files.

You can use the comments section to specify a key for a different issue so that {{ tracker-name }} automatically links the issue. When entering the issue key, use ALL CAPS.


If you close or refresh the page without sending your comment, it will still be stored in the relevant text box. You can continue entering the comment or delete the text.

## Replying to comments {#answer-comment}

1. Hover over the comment and click ![](../../_assets/tracker/svg/icon-reply.svg) **Reply**. The comment you are replying to will be quoted in the response.

1. Make your changes and click **Submit**.

## Editing comments {#edit-comment}

1. Hover over the comment and click ![](../../_assets/tracker/svg/icon-edit.svg) **Edit comment**.

1. Make your changes and click **Save**.

Any changes to comments are saved in the [History](history.md).

## Inviting to comment {#call-comment}

To invite other users to discuss an issue:

1. In the bottom part of the comment entry field, click ![](../../_assets/tracker/svg/icon-call.svg) **Invite**.

1. Enter the login or name of the user you want to invite to the comments. To add another user, click ![](../../_assets/tracker/svg/icon-call.svg) **Invite** again.

1. Enter the text of your comment.

1. Click **Send**.

Users invited to a discussion will be notified of the invitation:
* By [email](notification-settings.md).
* In {{ tracker-name }} ![](../../_assets/tracker/svg/bell_2.svg) **Notifications** (only if they opened the {{ tracker-name }} interface at least once prior to the invitation).

In addition, the names of these users will be added to the **{{ ui-key.startrek-backend.fields.issue.pendingReplyFrom }}** issue field.

{% note info %}

If you add a user in the **{{ ui-key.startrek-backend.fields.issue.pendingReplyFrom }}** field without inviting them when commenting on an issue, the user will not receive an email notification.

{% endnote %}

## Attaching a file {#sec_file}

Drag files to the comment box or click ![](../../_assets/tracker/svg/icon-file.svg).

To attach an image, click ![](../../_assets/tracker/text-edit/image.svg) in the comment field on the toolbar. Then, add the image URL or upload it from your device.

## Sharing a comment {#share-comment}

To copy a link to a comment, hover over it and click ![](../../_assets/horizontal-ellipsis.svg) → ![](../../_assets/tracker/text-edit/link.svg) **Copy link**. You can also click the date next to the comment author's name: the link will be shown in the browser's address bar.

## Deleting a comment {#delete-comment}

To delete a comment, hover over it and click ![](../../_assets/horizontal-ellipsis.svg) → ![](../../_assets/tracker/svg/icon-remove.svg) **Delete**.



## Sorting comments {#order-comments}

By default, comments are listed chronologically. To display the latest comments at the beginning of the list, on the right-hand side of the **Activity** section, click ![](../../_assets/tracker/svg/new-first.svg) **Newest first**.

The issue's changelog showing up when you click **History** will also change its order to newest first.

## Sending comments to a user's email address {#send-comment}

You can send emails from comments if [email integration](../manager/queue-mail.md) is set up.

{% note alert %}

You can only send comments to **external** users if the [queue settings](../manager/edit-queue-general.md) allow it.

{% endnote %}

You can send emails both to the external and internal users right from the issue page. The email text is added to the issue as a comment.

To send an email from the issue page:

1. Select **Email** above the field for a new comment.

1. Select the email sender address from the list:

   * Queue address

      The **From** field will display the queue address. A response to such a message will become a comment to the issue.

      You can [set up](../manager/queue-mail.md) multiple email addresses for the queue in the organization domain or on any other email server.

   * User's personal email address {{ tracker-name }}

      The **From** field will display your name and personal email address linked to the account in {{ tracker-name }}. Response emails will be sent to your personal email address.

1. You can choose a **Nickname** for the queue address. Nicknames are used when emails need to be sent from the entire organization or service rather than from a single user.

   Create one or more sender names in the queue [email address settings](../manager/queue-mail.md).

1. Specify the recipient and enter the email text

   To send a copy of an email to a different recipient, click ![](../../_assets/tracker/svg/icon-add.svg) **Copy** and select their email address.

1. Click **Send**.

The user's response will automatically be added as an issue comment.
