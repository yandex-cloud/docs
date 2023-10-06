# Changing basic queue settings

{% note warning %}

* By default, [only the queue owner](queue-access.md) can configure a queue.
* You cannot change the [queue key](create-queue.md#key).

{% endnote %}

To set up the basic parameters of the queue:

1. Open the [queue page](../user/queue.md).

1. In the top-right corner of the page, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Go to the **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--main }}** tab.

1. Configure the queue's settings.
    * Basic parameters:
        * **Queue name**.
        * **{{ ui-key.startrek.blocks-desktop_b-page-queue-description.description }}**. The description is displayed on the **{{ ui-key.startrek.blocks-desktop_b-page_type_queue.tab_description }}** tab on the queue page.
        * **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_events.field--default-priority }}**.
        * **{{ ui-key.startrek.blocks-desktop_b-queue-form.voting }}**: Allows or prohibits users from [voting for issues](../user/votes.md) in the queue.

    * Under **{{ ui-key.startrek.blocks-desktop_b-queue-form.advanced-settings }}**:
        * **{{ ui-key.startrek.blocks-desktop_b-queue-form.required-fields }}**: Issue fields that are always displayed on the issue page, regardless of [user settings](../user/edit-ticket.md#edit-fields).
        * **{{ ui-key.startrek.blocks-desktop_b-queue-form.notification-fields }}**: Issue fields that are displayed in all notifications about queue issues.


        * **{{ ui-key.startrek.blocks-desktop_b-queue-form.mail }}**: Allows users to [send emails](../user/comments.md#send-comment) to any address directly from the issue page. The email text is added to the issue as a comment.
        * **{{ ui-key.startrek.blocks-desktop_b-queue-form.add-issue-key-in-email-checkbox }}**: Indicates issue keys in the subject field for [emails sent from the issue page](../user/comments.md#send-comment).

        * **Do not link issues from other queues automatically**: Issue linking is not triggered when an issue key from another queue is embedded in a comment or issue description.
    * Under **{{ ui-key.startrek.blocks-desktop_b-queue-form.integration-settings }}**: {#integration}
        * **Show "Commits" tab**: Show or hide the **{{ ui-key.startrek.blocks-desktop_b-page_type_queue.tab_commits }}** tab on the queue and issue pages. The tab shows all [commits that are linked to issues](../user/ticket-links.md#section_commit).


        * **{{ ui-key.startrek.blocks-desktop_b-queue-form.projects }}**: Show or hide the [Projects](project-new.md) tab on the queue page.


1. Click **{{ ui-key.startrek.blocks-desktop_b-queue-form.save }}**.
