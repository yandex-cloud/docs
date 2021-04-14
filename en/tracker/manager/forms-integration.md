# Forms

In [Yandex.Forms]{% if audience == "external" %}({{ link-forms }}){% else %}({{ link-forms-ya }}){% endif %}, you can set up integration with {{ tracker-name }} to automatically create issues using data from forms.

You can post your forms on websites or add them to websites and wiki pages. Using these forms, even users without access to {{ tracker-name }} can create issues on their own. Forms make it much more convenient to [process user requests sent to the support team](../support-process.md#mail_forms) or collect support requests.

{% if audience == "internal" %}If you want to use a form as a template for quickly creating standardized issues, [embed the form on the issue creation page in {{ tracker-name }}](attach-form.md).{% endif %}

To set up forms for issue creation:

1. {% if audience == "external" %} Go to [Yandex.Forms]({{ link-forms }}). If it isn't activated, contact your organization's administration.{% else %}Go to [Yandex.Forms]({{ link-forms-ya }}).{% endif %}

1. [Create]{% if audience == "external" %}({{ support-forms-create }}){% else %}({{ support-forms-create-ya }}){% endif %} a new form.
Set up your form to collect data needed for issue creation.

1. Set up [{{ tracker-name }} integration]{% if audience == "external" %}({{ support-forms-tracker }}){% else %}({{ support-forms-tracker-ya }}){% endif %}:

    1. Specify your queue and other issue parameters.

    1. Use the **Issue description** field to add answers to the questions included in your form.

    1. If you want to save a specific answer in your issue parameters, add an issue field in the integration settings, click **Variables** → **Answer**, and choose the corresponding question.
You can also [create](../user/create-param.md) a new field if the one you need isn't available in the issue parameters.

    1. Save your integration settings.
The form will send out notifications containing lists of user answers to {{ tracker-name }}, and {{ tracker-name }} will then create issues based on those lists.

    {% if audience == "internal" %}

    {% note tip %}

    If you need to create an issue with a [checklist](../user/checklist.md) through the form, use the integration [<q>HTTP.Request to handle</q>](https://doc.yandex-team.ru/forms/external/http-request.html#http-request__resolve-problems-checklist).

    {% endnote %}

    {% endif %}

{% if audience == "external" %}

1. Set up [access rights to the form]({{ support-forms-access }}).
Any user can fill out the form by default. If you want, you can reserve this right for just your organization's employees.

{% endif %}

1. [Publish]{% if audience == "external" %}({{ support-forms-publish }}){% else %}({{ support-forms-publish-ya }}){% endif %} the form. Your form will be accessible via a link specified in the **Link** field.

Once the form is published, you can [embed it in a wiki page]{% if audience == "external" %}({{ support-forms-wiki }}){% else %}({{ support-forms-wiki-ya }}){% endif %}, [post it on a website]{% if audience == "external" %}({{ support-forms-embed }}){% else %}({{ support-forms-embed-ya }}), or [add it to the issue creation page](../manager/attach-form.md) in the {{ tracker-name }}{% endif %} interface.

Read more about Yandex.Forms in the [Help]{% if audience == "external" %}({{ support-forms-main }}){% else %}({{ support-forms-main-ya }}){% endif %}.

