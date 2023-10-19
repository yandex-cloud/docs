# Creating an issue from an email


You can use {{ tracker-name }} to create issues from emails sent to the queue mailbox or [communicate with external users](../user/comments.md#send-comment) from the issue page. For example, this may be useful when [registering user support requests](../support-process-send-mail.md).

By default, [only the queue owner](queue-access.md) can configure a queue. To set up email integration, you will need a special email address. You can use multiple addresses to create issues of different types and with different [components](components.md).

Integration with email in {{ tracker-name }} is different for organizations in {{ yandex-cloud }} and {{ ya-360 }}.

In an {{ yandex-cloud }} organization, you can use an address created on any email server as an email address of your queue. The only condition is that the address needs to be used only for issues in the queue.

As an email address for a {{ ya-360 }} organization, you can use:
* An address created on any mail server: this must be a newly created email address used specifically for the issues of the queue.
* An address created in the organization's domain to use only for creating issues, writing comments, and as a return address when [sending emails](../user/comments.md#send-comment) to external users. You cannot log into it as in a regular mailbox in order to view or send emails.

{% include [task-by-mail](../../_includes/tracker/task-by-mail.md) %}

