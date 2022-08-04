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
{% if audience == "internal" %}

        * **Department**: A branch or department that the issue belongs to.

        * **ABC Service**: A service that the issue belongs to.

         {% endif %}

    * Under **Advanced settings**:
        * **Required fields for the queue**: Issue fields that are always displayed on the issue page, regardless of [user settings](../user/edit-ticket.md#section_jqw_ppn_jz).
        * **Fields in notifications**: Issue fields that are displayed in all notifications relating to queue issues.

        {% if audience == "internal" %}
        * **Status after adding external link**: Status to which queue issues are automatically switched when creating a link to commits or pull requests on Crucible, Review Board, Stash, or GitHub. The list of possible issue statuses depends on your [workflow](workflow.md) settings.

        {% endif %}

        * **Send emails**: Allows users to [send emails](../user/comments.md#send-comment) to any address directly from the issue page. The message text is attached to the issue as a comment.

        * **Add issue IDs to the email subject field**: Indicates issue keys in the subject field for [emails sent from the issue page](../user/comments.md#send-comment).

        * **Don't link issues from other queues automatically**: Issue linking doesn't trigger when an issue key from another queue is embedded in a comment or issue description.

    * Under **Integration settings**: {#integration}
        * **Show "Commits" tab**: Show or hide the **Commits** tab on the queue and issue pages. The tab displays all [commits linked to your issues](../user/ticket-links.md#section_commit).

        {% if audience == "internal" %}
        * **Show "Goals" tab**: Show or hide the [Goals](goals.md) tab on the queue page. The tab shows a list of goals linked to issues in the queue.

        {% endif %}
        * **Show "Projects" tab**: Show or hide the [Projects](projects.md) tab on the queue page.

        {% if audience == "internal" %}
        * **Show "OEBS Transactions" tab**: Show or hide the **OEBS Transactions** tab on the queue page. The tab shows a list of transactions linked to issues in the queue.
        * **Display link to service**: select one or more services. If the options are enabled, the issue page will display sections with issue links to external services.
        * **Disable autolinking with Conductor**: By default, {{ tracker-name }} automatically links issues to a ticket in Conductor if ticket comments specify the issue key.
        * **Show the standard issue creation form**: Select whether you want the standard form displayed on the issue creation page, if you have already [enabled your custom form](attach-form.md) from {{ forms-full-name }}.
        * Setting up Samsara integration.
            * **Create comment**: If this option is enabled, notifications are sent to Samsara when comments are added to the issue.
            * **Status update**: If this option is enabled, notifications are sent to Samsara when the issue status is updated.
            * **Assignee update**: If the option is enabled, notifications are sent to Samsara when the issue assignee is changed.

        {% endif %}

1. Click **Save**.

