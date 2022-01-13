# Changing basic queue settings

{% note warning %}

By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

To configure the main queue settings:

1. Open the [queue page](../user/queue.md).

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Administration**.

1. Go to the **Basic settings** tab.

1. Configure queue settings.

    - General settings:
        - **Queue name**.
        - **Queue description**. The description is displayed on the queue page on the **Description** tab.
        - **Default priority**.
        - **Issue voting**: Allows or prohibits users from [voting for issues](../user/votes.md) in the queue.

    - Under **Advanced settings**:
        - **Required fields for the queue**: Issue fields that are always displayed on the issue page, regardless of [user settings](../user/edit-ticket.md#section_jqw_ppn_jz).
        - **Fields in notifications**: Issue fields that are displayed in all notifications about queue issues.

        {% if audience == "internal" %}
        - **Status after adding external link**: Status that queue issues are automatically switched to when creating links to commits or pull requests on Crusible, Review Board, Stash, or Git Hub. The list of possible issue statuses depends on your [workflow](workflow.md) settings.

        {% endif %}

        - **Send emails**: Allows users to [send emails](../user/comments.md#send-comment) to any address directly from the issue page. The message text is attached to the issue as a comment.

        - **Add issue IDs to the email subject field**: Indicates issue keys in the subject field for [emails sent from the issue page](../user/comments.md#send-comment).

        - **Don't link issues from other queues automatically**: Issue linking doesn't trigger when an issue key from another queue is embedded in a comment or issue description.

    - Under **Integration settings**: {#integration}
        - **Show "Commits" tab**: Show or hide the **Commits** tab on the queue and issue pages. The tab displays all [commits linked to your issues](../user/ticket-links.md#section_commit).

        {% if audience == "internal" %}
        - **Show "Goals" tab**: Show or hide the [Goals](goals.md) tab on the queue page. The tab shows a list of goals linked to issues in the queue.

        {% endif %}
        - **Show "Projects" tab**: Show or hide the [Projects](projects.md) tab on the queue page.

        {% if audience == "internal" %}
        - **Show "OEBS Transactions" tab**: Show or hide the **OEBS transactions** tab on the queue page. The tab shows a list of transactions linked to issues in the queue.
        - **Display links to services**: If enabled, the issue page will contain sections with issue links to external services.
        - **Disable autolinking with Conductor**: By default, {{ tracker-name }} automatically links an issue to a ticket in Conductor if ticket comments specify the issue key.

        {% endif %}

1. Click **Save**.
