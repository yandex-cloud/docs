{% list tabs %}

- On any email server

   1. Create a mailbox for your queue on any mail server. All messages that arrive to this address will be converted to issues in the queue.

   1. {% include [go to settings](transition-page.md) %}

   1. In the top-right corner, click ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

   1. Select **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-aliases }}**.

   1. Click **Configure mail**.

   1. Set up the mailbox for receiving messages:

      1. Under **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesCreateForm.mail-settings-title }}**, in the **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesCreateForm.mail-address }}** field, specify the email address you created in Step 1, including the domain, e.g., `{{ example-account }}`. The **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesCreateForm.mail-login }}** field will be populated automatically.
      1. In the **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesCreateForm.mail-password }}** field, provide the password for your email address. If the selected email server allows you to control access to the mailbox by an application password, enter the application's password for email clients in this field.

         {% note info "If the setup failed with a 404 error" %}

            Check if the POP3 or IMAP support is enabled for your mailbox in Yandex Mail: <https://mail.yandex.ru//#setup/client>.
            Select the protocol you are going to use and save the changes.

         {% endnote %}

         [Learn more about application passwords in the Yandex ID documentation]({{ link-yandex }}/support/id/authorization/app-passwords.html).

      1. Enter the **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesCreateForm.mail-imap }}** and the email server **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesCreateForm.mail-port }}**: you need them to collect emails. You can find this data in your email account settings.
      1. To enable SSL encryption, select **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesCreateForm.mail-ssl }}**.
      1. If you need to process emails not only from the organization's employees but from external users as well, enable the **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesCreateForm.mail-allow-external }}** setting.

         {% cut "Additional parameters" %}

         * **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesCreateForm.mail-incoming-folder }}**: Create a folder for emails from {{ tracker-name }} and specify its name. Any emails sent to this folder will automatically be converted to queue issues.
         * **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesCreateForm.mail-archive-folder }}**: Create a folder for archiving emails from {{ tracker-name }} and specify its name.
         * **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesCreateForm.mail-process-messages-from }}**: Set the date. Emails received prior to this date are not processed and are automatically moved to the **Archive** folder.

         {% note alert %}

         Use separate folders to collect and archive incoming emails.

         {% endnote %}

         {% endcut %}

      1. Test the created connection.

   1. Specify the parameters to create issues from your email with: the issue type and [components](../../tracker/manager/components.md).

   1. If you want the issue comments to be also sent as emails, set up a mailbox for sending messages:
      1. Under **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesFormSendPanel.send-settings-title }}**, click ![](../../_assets/tracker/svg/add-address.svg) **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesStateList.action-add-mail }}**.
      1. In the **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesFormSendPanel.send-mail-login }}** field, specify the email address to send emails as issue comments from, e.g., `{{ example-account }}`.
      1. In the **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesFormSendPanel.send-mail-password }}** field, provide the password for your email address.
      1. Specify the **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesFormSendPanel.send-mail-smtp }}** and **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesFormSendPanel.send-mail-port }}** to enable sending emails. You can find this data in your email account settings.
      1. To enable SSL encryption, select **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesFormSendPanel.send-mail-ssl }}**.
      1. Set up **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesFormSendPanel.signature-settings-title }}** for emails to send. Make sure to specify the **{{ ui-key.startrek.ui_components_page-queue-admin_Signature.alias-title }}**, as you will need it to distinguish signatures in the common list. Your email recipients will see the nickname instead of the sender name.
      1. Test that everything is up and running: click ![](../../_assets/tracker/svg/send-email.svg) **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesFormSendPanel.test-mail-button }}**.

   1. Click **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesCreateForm.save-button }}**. The queue's email address will get running within an hour after creation.

   1. Enable sending issue comments as emails:
      1. In the queue settings, select **Basic settings**.
      1. Click **Show advanced settings** and enable **Allow emails to be sent externally** under **Sending mails**.

   {% note tip %}

   To enable your employees to create issues by email, set [queue access rights](../../tracker/manager/queue-access.md) for them.

   {% endnote %}

- On a domain in {{ yandex-360 }}

   1. {% include [go to settings](transition-page.md) %}

   1. In the top-right corner, click ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

   1. Select **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-aliases }}**.

   1. Check whether your organization has an [email domain]({{ support-business-domain }}) in {{ ya-360 }}. Otherwise, click **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesStateList.action-domain }}** to open {{ ya-360 }} and create a domain. If you already have a email domain set up in another service, you can create a subdomain for it and [connect it to {{ ya-360 }}]({{ support-business-domain }}).

   1. Click **Configure mail**.

   1. Set up a mailbox for receiving and sending messages.
      1. In the **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesCreateForm.mail-address }}** field, specify a new email address to be used only for the queue.
      1. If you need to process emails not only from the organization's employees but from external users as well, enable the **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesCreateForm.mail-allow-external }}** setting.

   1. Specify the parameters with which the issues should be created in the queue: the [issue type](../../tracker/manager/add-ticket-type.md) and [components](../../tracker/manager/components.md).

   1. Set up signatures for the sent emails. Make sure to specify the **{{ ui-key.startrek.ui_components_page-queue-admin_Signature.alias-title }}**, as you will need it to distinguish signatures in the common list. Your email recipients will see the nickname instead of the sender name. Check that everything is up and running by sending a test email.

   1. Click **Create**. The queue's email address will get running within an hour after creation.

   {% note tip %}

   To enable your employees to create issues by email, set [queue access rights](../../tracker/manager/queue-access.md) for them.

   {% endnote %}

{% endlist %}