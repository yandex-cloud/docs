# Accept requests {% if audience == "internal" %}by mail and{% endif %} via forms

User requests are converted to {{ tracker-name }} issues before they are processed. Most users tend to send their requests {% if audience == "internal" %}via email or{% endif %} a website. In any case, {% if audience == "external" %}users outside your organization and{% else %}external users{% endif %} don't have access to {{ tracker-name }}.

This is why we recommend setting up your request processing pipeline in a way that lets you receive requests {% if audience == "internal" %}via email or{% endif %} forms created in [Yandex.Forms]{% if audience == "external" %}({{ link-forms }}){% else %}({{ link-forms-ya }}){% endif %}.

{% if audience == "internal" %}

### Accept requests by email {#mail}

To accept requests by email, {% if audience == "external" %}set up a queue email address{% else %}[set up an email address for the queue](manager/queue-mail.md#sec-mail-yandex) that will create issues from user requests{% endif %}. All emails sent to this address will automatically be converted to {{ tracker-name }} issues.

{% if audience == "external" %}

1. Go to the queue settings, the **Mailboxes** [tab, and add a queue address](manager/queue-mail.md#section_gwv_hqb_hgb).

   <!-- If you can't create such an address, this means your organization doesn't have its own domain. You need a domain to create mailboxes and newsletters. This includes creating queue addresses. You can [add a domain for free in Yandex.Connect](https://yandex.ru/support/connect/add-domain.html).-->

1. If the users sending you requests are not your organization's employees, [allow receiving emails from external addresses](manager/queue-mail.md#mail_tasks).

{% endif %}

If the issue was created from an email, you can respond to the requester right from the issue page (for example, you can ask for additional information or notify them when the issue is solved). To do this, [configure sending email from issue pages](#send_mail).

### Accept requests via forms {#form}

{% endif %}

Accepting requests via forms is a better choice if you want users to provide specific data. Your forms may include a list of required and optional questions, and the answers may be saved in the issue parameters in {{ tracker-name }}.

1. Go to [Yandex.Forms]{% if audience == "external" %}({{ link-forms }}){% else %}({{ link-forms-ya }}){% endif %} and create a new form.

1. Add questions that let users provide relevant information necessary to register their request.

2. Set up [{{ tracker-name }} integration]{% if audience == "external" %}({{ support-forms-tracker }}){% else %}({{ support-forms-tracker-ya }}){% endif %} for the form:

    1. Specify your queue and other issue parameters.

    2. Use the **Issue description** field to add answers to the questions included in your form.

    3. If you want to save a specific answer in your issue parameters, add an issue field, click **Variables** → **Answer**, and choose the corresponding question.

    4. Save your integration settings.

3. [Publish]{% if audience == "external" %}({{ support-forms-publish }}){% else %}({{ support-forms-publish-ya }}){% endif %} your form: embed it in a website or provide a link.

