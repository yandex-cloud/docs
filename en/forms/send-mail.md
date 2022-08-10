# Send message

You can set up integration of your form with Yandex.Mail so that a notification is sent automatically when the user fills out the form.

## Configure notifications {#setup}

1. Select a form and go to **Integration**.

1. Select a [group of actions](notifications.md#add-integration) for which you want to set up sending of emails and click ![](../_assets/forms/mail-notification-new.png) **Mail**.

1. In the action settings section, fill out the fields:

    - **To**: The email address the notification is sent to. You can list multiple addresses separated by commas or specify a variable.

        - To send a notification to the form owner's email, {% if audience == "internal" %}click the ![](../_assets/forms/add-var.png) icon and{% endif %} select the **Form author's email** variable.

        - To send a notification to the {% if audience == "external" %}Yandex{% endif %} email the user was logged in to when filling out the form, select the **Email** variable. {% if audience == "external" %} This is only available for users of [{{ forms-full-name }} for business](forms-for-org.md).{% endif %}

        - To send a notification to the address the user gave in response to a prompt, add a **Response to prompt** variable and select the <q>Email</q> prompt type.

    {% if audience == "internal" %}

    - **From**: The email address the notification is sent from. Only use emails on allowed domains:

        - `market.yandex.ru`

        - `contest.yandex.ru`

        - `o.yandex.ru`

        - `support.yandex.ru`

        - `yandex-team.ru`

        - `forms.yandex.ru`

        If the field uses the [variable](vars.md), its content must also be an email address with a permitted domain. If the field is not filled in, the email will be sent from the default address. If you used an address with a domain not included in the permitted list, the notification won't be sent.

    {% endif %}

    - **Sender**: The sender name you want the recipient to see.

    - **Send response to**: The email the recipient can send responses to. If you don't specify the return email address, your respondents won't be able to reach you by email.

    - **Subject**: The subject of your email.

    - **Text**: The text of your email.

    - If necessary, add headers to the message. Specify a name and value for each header.

    You can insert a response to a prompt or other form data in any field:

    - Select a field and click the ![](../_assets/forms/add-var.png) icon on the right.

    - Select a [variable](vars.md) from the list that you want to add. For example, you can add a variable to address the user by their name or to include their [test results](tests.md) in the email.

    ![](../_assets/forms/mail-var-example-new.png)

1. To attach a file from your computer to the email, click the **Attach file** button.

   To attach the files that the user sent in response to the form to your email, select prompts like <q>File</q> from the **Attach files from responses to prompts** list.</p> 

1. To display a message informing the user that an email was sent after they filled out the form, enable the **Show messages about action results** option under the name of the action.

1. Click **Save**.

To send multiple email notifications at once, add new actions using the ![](../_assets/forms/mail-notification-new.png) **Mail** button at the bottom of the action group.

If you want notifications to only be sent to users who gave certain responses, [set your conditions](notifications.md#section_xlw_rjc_tbb).

## Troubleshooting {#troubleshooting}

If you set up email notifications but aren't getting emails when your form is filled out, check your spam folder and see if there are errors when sending emails.

### Check your spam folder

If you aren't receiving email notifications, check your <q>Spam</q> folder. If emails from {{ forms-full-name }} were sent to the spam folder, mark them as <q>Not spam</q>.

{% if audience == "external" %} If you use your own mail server, <q>whitelist</q> the sender address: `form_id@forms-mailer.yaconnect.com`.{% endif %}

### Check the text of the email

The mail server can block an email if its text is missing or looks like spam. Add or edit the text of the email.

### Check for errors when sending emails

1. Open the form with notification issues and click **Integration** at the top of the page.

1. Check for an error message in your notification settings.

1. If there's an error message, try [restarting sending notifications](notifications.md#status).

1. If the problem persists, [contact support {{ forms-full-name }}](feedback.md).

### If there are no spam notifications or error messages

If you have no notifications in the <q>Spam</q> folder or errors in the **Integration** tab, the email may be blocked by the recipient's mail server. To find out why the email is blocked:

1. Open the form with notification issues and click **Integration** at the top of the page.

1. In the email notification settings, go to the **Send response to** field and enter your personal or work email.

1. The next time the mail server blocks a notification from the form, an error message will be sent to the email that you specified. Copy the text of the message.

1. [Contact {{ forms-full-name }}](feedback.md) support and add the error message that you received to your request.

