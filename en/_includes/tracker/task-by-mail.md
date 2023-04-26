{% list tabs %}

- On any email server

   1. Create a mailbox for your queue on any mail server. All messages that arrive to this address will be converted to issues in the queue.

   1. {% include [go to settings](transition-page.md) %}

   1. In the top-right corner, click ![](../../_assets/tracker/svg/queue-settings.svg) **Queue settings**.

   1. Select **Mailboxes**.

   1. Click **Configure mail**.

   1. Set up the mailbox for receiving messages.

      1. Under **Mail for receiving emails**, in the **Email** field, specify the email address you created in Step 1, including the domain, e.g., `{{ example-account }}`. The **Login** field will be populated automatically.
      1. In the **Password** field, provide the password for your email address. If the selected email server allows you to control access to the mailbox by an application password, enter the application's password for email clients in this field. [Learn more about application passwords in the Yandex ID documentation]({{ link-yandex }}/support/id/authorization/app-passwords.html).
      1. Enter the **IMAP server address** and the email server **Port**: you need them to collect emails. You can find this data in your email account settings.
      1. To enable SSL encryption, select **Secure connection (SSL)**.
      1. If you need to process emails not only from the organization's employees but from external users as well, enable the **Accept letters not only from employees of the organization** setting.

         {% cut "Additional parameters" %}

         * **Inbox folder**: Create a folder for emails from {{ tracker-name }} and specify its name.
         * **Archive folder**: Create a folder for archiving emails from {{ tracker-name }} and specify its name.
         * **Start date of email processing**: Specify the date. Emails received prior to this date are not processed and are automatically moved to the **Archive** folder.

         {% note alert %}

         Use separate folders to collect and archive incoming emails.

         {% endnote %}

         {% endcut %}

      1. Test the created connection.

   1. Specify the parameters to create issues from your email with: the issue type and [components](../../tracker/manager/components.md).

   1. If you want the issue comments to be also sent as emails, set up a mailbox for sending messages:
      1. Under **Email for sending responses**, click ![](../../_assets/tracker/svg/add-address.svg) **Add an email**.
      1. In the **Login** field, specify the email address to send emails as issue comments from, e.g., `{{ example-account }}`.
      1. In the **Password** field, provide the password for your email address.
      1. Specify the **SMTP server address** and **Port** to enable sending emails. You can find this data in your email account settings.
      1. To enable SSL encryption, select **Secure connection (SSL)**.
      1. Set up **Signatures** for emails to send. Make sure to specify the **Nickname**, as you will need it to distinguish signatures in the common list. Your email recipients will see the nickname instead of the sender name.
      1. Test that everything is up and running: click ![](../../_assets/tracker/svg/send-email.svg) **Send a test email**.

   1. Click **Save**. The queue's email address will get running within an hour after creation.

   1. Enable sending issue comments as emails:
      1. In the queue settings, select **Basic settings**.
      1. Click **Show advanced settings** and select **Allow emails to be sent externally** under **Sending mails**.

   {% note tip %}

   To enable your employees to create issues by email, set [queue access rights](../../tracker/manager/queue-access.md) for them.

   {% endnote %}

- On a domain in Yandex 360

   1. {% include [go to settings](transition-page.md) %}

   1. In the top-right corner, click ![](../../_assets/tracker/svg/queue-settings.svg) **Queue settings**.

   1. Select **Mailboxes**.

   1. Check whether your organization has an [email domain]({{ support-business-domain }}) in {{ ya-360 }}. Otherwise, click **Add a domain** to open {{ ya-360 }} and create a domain. If you already have an email domain set up in another service, you can create a subdomain for it and [connect it to {{ ya-360 }}]({{ support-business-domain }}).

   1. Click **Configure mail**.

   1. Set up a mailbox for receiving and sending messages.
      1. In the **Email** field, specify a new email address to be used only for the queue.
      1. If you need to process emails not only from the organization's employees but from external users as well, enable the setting **Accept letters not only from employees of the organization**.

   1. Specify the parameters with which the issues should be created in the queue: the [issue type](../../tracker/manager/add-ticket-type.md) and [components](../../tracker/manager/components.md).

   1. Set up signatures for the sent emails. Make sure to specify the **Nickname**, as you will need it to distinguish signatures in the common list. Your email recipients will see the nickname instead of the sender name. Check that everything is up and running by sending a test email.

   1. Click **Create**. The queue's email address will get running within an hour after creation.

   {% note tip %}

   To enable your employees to create issues by email, set [queue access rights](../../tracker/manager/queue-access.md) for them.

   {% endnote %}

{% endlist %}