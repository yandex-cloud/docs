# Accepting requests by mail and via forms

User requests are converted to {{ tracker-name }} issues before they are processed. Most users tend to send their requests via email or a website. In any case, users outside your company don't have access to {{ tracker-name }}.

This is why we recommend setting up your request processing pipeline in a way that lets you receive requests via email or forms created in [{{ forms-full-name }}]({{ link-forms }}).

### Accepting requests by email {#mail}

To accept user requests by email, set up the email address of the queue. All emails sent to this address will automatically be converted to {{ tracker-name }} issues.



1. Go to **Mailboxes** in the queue settings and [add a queue address](manager/queue-mail.md#section_gwv_hqb_hgb).

    If you can't create such an address, this means your organization doesn't have its own domain. You need a domain to create mailboxes and newsletters. This includes creating queue addresses. A domain is free to [add in {{ ya-360 }}]({{ support-business-domain }}).

1. If the users sending you requests are not your organization's employees, [allow receiving emails from external addresses](manager/queue-mail.md#mail_tasks).


If the issue was created from an email, you can respond to the requester right from the issue page (for example, you can ask for additional information or notify them when the issue is solved). To do this, [configure sending emails from issue pages](#send_mail).

### Accepting requests via forms {#form}

Accepting requests via forms is a better choice if you want users to provide specific data. Your forms may include a list of required and optional questions, and the answers may be saved in the issue parameters in {{ tracker-name }}.

1. Go to [{{ forms-full-name }}]({{ link-forms }}) and create a new form.

1. Add questions that let users provide relevant information necessary to register their request.

1. Set up [integration with {{ tracker-name }}](../forms/create-task.md) for the form:

    1. Specify your queue and other issue parameters.

    1. Use the **Issue description** field to add answers to the questions included in your form.

    1. If you want to save a specific answer in your issue parameters, add an issue field, click **Variables** → **Answer**, and choose the corresponding question.

    1. Save your integration settings.

1. [Publish](../forms/publish.md#section_link) your form: embed it in a website or provide a link.

