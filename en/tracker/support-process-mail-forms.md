# Accepting requests by email and via forms

User requests are converted to {{ tracker-name }} issues before they are processed. Most users prefer sending messages by email or through a website. In addition to this, the users outside your company do not have access to {{ tracker-name }}.

This is why we recommend setting up your request processing pipeline in a way that allows you to receive requests via email or forms created in [{{ forms-full-name }}]({{ link-forms }}).

## Accepting requests by email {#mail}


* A mailbox on any email server, suitable for {{ yandex-cloud }} and {{ ya-360 }} organizations. An email address must be newly created and used specifically for the queue issues.
* A mailbox in the {{ ya-360 }} domain, only suitable for {{ ya-360 }}organizations. An email address should only be used for creating issues, writing comments, and as a return address when [sending emails](user/comments.md#send-comment) to external users. You cannot log into it as in a regular mailbox in order to view or send emails.

{% include [task-by-mail](../_includes/tracker/task-by-mail.md) %}


## Accepting requests via forms {#form}

It is convenient to use forms to collect requests, if you expect certain data from the user. Your forms may include a list of required and optional questions, and the answers may be saved in the issue parameters in {{ tracker-name }}.

1. Go to [{{ forms-full-name }}]({{ link-forms }}) and create a new form.

1. Add questions that allow users to provide relevant information that is required to register their request.

1. Set up [integration with {{ tracker-name }}](../forms/create-task.md) for the form.

   1. Specify the queue and other issue parameters.

   1. Use the **{{ ui-key.startrek.blocks-desktop_b-create-ticket-form.fill-desc }}** field to add answers to the questions included in your form.

   1. If you want to save a specific answer in your issue parameters, add an issue field, click **{{ ui-key.startrek.blocks-desktop_trigger-action.webhook-variables }}** → **Answer**, and choose the corresponding question.

   1. Save your integration settings.


1. [Publish](../forms/publish.md#section_link) your form: embed it in a website or provide a link.