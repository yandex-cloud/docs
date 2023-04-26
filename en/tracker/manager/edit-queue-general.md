# Changing basic queue settings

{% note warning %}

By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

To set up the basic parameters of the queue:

1. Open the [queue page](../user/queue.md).

1. In the top-right corner of the page, click ![](../../_assets/tracker/svg/settings-old.svg) **Queue settings**.

1. Go to the **Basic settings** tab.

1. Configure the queue's settings.
    * Basic parameters
        * **Queue name**.
        * **Queue description**. The description is displayed on the **Description** tab on the queue page.
        * **Default priority**.
        * **Issue voting**: Allows or prohibits users from [voting for issues](../user/votes.md) in the queue.

    * Under **Advanced settings**:
        * **Required fields for the queue**: Issue fields that are always displayed on the issue page, regardless of [user settings](../user/edit-ticket.md#edit-fields).
        * **Fields in notifications**: Issue fields that are displayed in all notifications about queue issues.


        * **Send emails**: Allows users to [send emails](../user/comments.md#send-comment) to any address directly from the issue page. The email text is added to the issue as a comment.
        * **Add issue IDs to the email subject field**: Indicates issue keys in the subject field for [emails sent from the issue page](../user/comments.md#send-comment).

        * **Do not link issues from other queues automatically**: Issue linking is not triggered when an issue key from another queue is embedded in a comment or issue description.
    * Under **Integration settings**: {#integration}
      * **Show "Commits" tab**: Show or hide the **Commits** tab on the queue and issue pages. The tab shows all [commits that are linked to issues](../user/ticket-links.md#section_commit).


        * **Show "Projects" tab**: Show or hide the [Projects](project-new.md) tab on the queue page.


1. Click **Save**.
