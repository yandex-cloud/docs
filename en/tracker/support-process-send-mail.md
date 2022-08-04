# Sending emails from the issue page

If you want to respond to a user request, you can send them an email right from the issue page in {{ tracker-name }}. Their response to you will then be added as a comment to the corresponding issue. This lets you keep all correspondence right on the issue page, so you don't have to waste time with a dedicated email client.

To send emails from the issue page, do the following:

### Step 1. Configure email integration in your queue

1. Go to **Mailboxes** in the queue settings and [add a queue address](manager/queue-mail.md#section_gwv_hqb_hgb)

    If you want to send issues from the issue page, you need a shared queue address. Responses sent to the queue address will be added to issue comments.

    If you can't create such an address, this means your organization doesn't have its own domain. You need a domain to create mailboxes and newsletters. This includes creating queue addresses. A domain is free to [add in {{ ya-360 }}]({{ support-business-domain }}).

1. [Set up sender names and signatures](manager/queue-mail.md#section_ffq_gqb_hgb) if needed.

1. If the users aren't your organization's employees, [allow sending emails from issue pages to external addresses](manager/queue-mail.md#send_outside).

### Step 2. Send emails from the issue page

1. Open any issue in the support team queue.

1. Enable the **Email** option above the comment box and specify the recipient's address.

    If the issue was [generated from a user email](#mail), the requester's email address will be automatically added to the **To** field.

    If you're [using forms to process user requests](#form), ask users to provide their email address in the form and save their responses in the issue's <q>From</q> field. In this case, the **To** field will still be automatically filled in with the requester's email address.

1. Click **Submit**.

### Step 3. Automate your workflow

- If you want to quickly send preset messages from the issue page, [configure macros](manager/create-macroses.md).

- [Use triggers](manager/trigger-examples.md#notify_mail) to automatically notify users when certain events occur.

