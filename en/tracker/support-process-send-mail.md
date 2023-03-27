# Sending emails from the issue page

If you want to respond to a user request, you can send them an email right from the issue page in {{ tracker-name }}. If the user responds to the email, their response is added as a comment to the issue. This way you can store the entire history of your communications with the user inside the issue without wasting your time on sending emails from an email client.

To send emails from the issue page:

### Step 1. Set up email integration in the queue

1. Go to **Mailboxes** in the queue settings and [add queue address](manager/queue-mail.md).

   If you want to send issues from the issue page, you need a shared queue address. The user responses sent to the queue address will be added as issue comments.

   
   If you cannot add an address for the queue, it means that your organization does not have a domain. You need a domain to create mailboxes and newsletters, for example, to add an email address for your queue. You can [add a domain in {{ ya-360 }}]({{ support-business-domain }}) free of charge.


1. [Set up sender names and signatures](manager/queue-mail.md) if needed.

1. If the users are not your company's employees, [allow sending emails from issue pages to external addresses](manager/queue-mail.md).

### Step 2. Send emails from the issue page

1. Open any issue in the support queue.

1. Enable the **Email** option above the comment box and specify the recipient's address.

   If the issue was [generated from a user email](#mail), the requester's email address will be automatically added to the **To** field.

   If you are [using forms to process user requests](#form), ask users to provide their email address in the form and save their responses in the issue's <q>From</q> field. In this case, the **To** field will still be automatically filled in with the requester's email address.

1. Click **Send**.

### Step 3. Enable automation

- If you want to quickly send preset messages from the issue page, [configure macros](manager/create-macroses.md).

- [Use triggers](manager/trigger-examples.md#notify_mail) to automatically notify users when certain events occur.