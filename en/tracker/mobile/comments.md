# Adding comments to issues

You can use comments to leave notes about the work progress, ask questions about the issue description, and invite your teammates to discuss the issue.

{% note tip %}

If you only discuss an issue in the comments, you will always have access to a full history of its discussion.

{% endnote %}

## Leaving a comment {#leave-comment}

To comment on an issue, enter your text in the **{{ ui-key.startrek.ui_components_CommentEditor.write-comment }}** box at the bottom of the screen and tap ![](../../_assets/tracker/send.png). In the comments section, you can use [text markup](../user/markup.md) and [attach images and files](#sec_file). To expand the comment box to full screen, tap ![](../../_assets/tracker/open-text.png).

You can use the comments section to specify a key for a different issue so that {{ tracker-name }} automatically [links](ticket-links.md#add-link) the issue.

## Replying to comments {#answer-comment}

1. Tap ![](../../_assets/horizontal-ellipsis.svg) next to the comment and select **Respond**. The comment you are replying to will be quoted in the response.

1. Make your changes and tap ![](../../_assets/tracker/send.png).

## Editing comments {#edit-comment}

1. Tap ![](../../_assets/horizontal-ellipsis.svg) next to the comment and select **Edit**.

1. Make your changes and tap ![](../../_assets/tracker/send.png).

Any changes to comments are saved in the [History](../user/history.md).

## Inviting to comment {#call-comment}

To invite other users to discuss an issue:

1. Select **{{ ui-key.startrek.ui_components_CommentEditor.write-comment }}** at the bottom of the screen and tap ![](../../_assets/tracker/at.png).

1. Enter the username or name of the user you want to invite to the comments and tap **{{ ui-key.startrek.ui_components_ModalTextEditor.save }}**. You can invite multiple users at once.

1. Enter the comment and tap ![](../../_assets/tracker/send.png).

Users invited to comment will be notified by email, with their names added to the **{{ ui-key.startrek-backend.fields.issue.pendingReplyFrom }}** issue field.

{% note info %}

If you add a user in the **{{ ui-key.startrek-backend.fields.issue.pendingReplyFrom }}** field without inviting them when commenting on an issue, the user will not receive an email notification.

{% endnote %}

## Attaching a file {#sec_file}

To attach a file to a comment:

1. Select **{{ ui-key.startrek.ui_components_CommentEditor.write-comment }}** at the bottom of the screen and tap ![](../../_assets/tracker/pin.png).

   * To add a photo or video from your phone's camera, tap **Camera**. When everything is ready, tap **OK**. To take a new photo or video, tap **Repeat**.

   * To attach files from your phone, tap **{{ ui-key.startrek.ui_components_AttachmentsManager.attachments-section-title }}** and select them.

   {% note info %}

   If you're attaching files for the first time, allow access to your phone's camera and files.

   {% endnote %}

1. Enter the comment and tap ![](../../_assets/tracker/send.png).

The attached files are displayed below the comment.

## Sharing a comment {#share-comment}

To copy a link to a comment, tap ![](../../_assets/horizontal-ellipsis.svg) and select **Copy link**.

## Deleting a comment {#delete-comment}

To delete a comment, tap ![](../../_assets/horizontal-ellipsis.svg) next to the comment and select **Remove**.


## Creating an issue based on a comment {#create-task}

If, while having a discussion with your teammates, you decided to create a new issue, you can do so directly from the comment:

1. Click the comment the new issue will be based on.

1. Click **Create issue from comment** and choose the link type.

1. Fill in the fields the same way as when [creating a regular issue](create-ticket.md#create-task).

1. Click **Create**.
