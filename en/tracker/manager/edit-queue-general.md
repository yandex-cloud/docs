# Changing basic queue settings

{% note warning %}

By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

To configure the main queue settings:

1. Open the [queue page](../user/queue.md).

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Configure**.

1. Go to the **Basic settings** tab.

1. Configure queue settings.

    * Basic settings:

        * **Queue name**.

        * **Queue description**. The description is displayed on the queue page on the **Description** tab.

        * **Default priority**.

        * **Issue voting**: To allow or prohibit users from [voting for issues](../user/votes.md) in the queue.


    * Under **Advanced settings**:
        * **Required fields for the queue**: Issue fields that are always displayed on the issue page, regardless of [user settings](../user/edit-ticket.md#section_jqw_ppn_jz).
        * **Fields in notifications**: Issue fields that are displayed in all notifications relating to queue issues.



        * **Send emails**: Allows users to [send emails](../user/comments.md#send-comment) to any address directly from the issue page. The message text is attached to the issue as a comment.

        * **Add issue IDs to the email subject field**: Indicates issue keys in the subject field for [emails sent from the issue page](../user/comments.md#send-comment).

        * **Don't link issues from other queues automatically**: Issue linking doesn't trigger when an issue key from another queue is embedded in a comment or issue description.

    * Under **Integration settings**: {#integration}
        * **Show "Commits" tab**: Show or hide the **Commits** tab on the queue and issue pages. The tab displays all [commits linked to your issues](../user/ticket-links.md#section_commit).


        * **Show "Projects" tab**: Show or hide the [Projects](projects.md) tab on the queue page.



1. Click **Save**.

