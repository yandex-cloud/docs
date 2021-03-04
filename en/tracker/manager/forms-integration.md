# Forms

In [Yandex.Forms]{% if audience == "external" %}({{ link-forms }}){% else %}({{ link-forms-ya }}){% endif %}, you can set up integration with {{ tracker-name }} to automatically create issues using data from forms.

You can post your forms on websites or add them to websites and wiki pages. Using these forms, even users without access to {{ tracker-name }} can create issues on their own. Forms make it much more convenient to [process user requests sent to the support team](../support-process.md#form) or collect support requests.

If you want to use a form as a template for quickly creating standardized issues, [embed the form on the issue creation page in {{ tracker-name }}](attach-form.md).

To set up forms for issue creation:

1. {% if audience == "external" %} Go to [Yandex.Forms]({{ link-forms }}). If it isn't activated, contact your organization's administration.{% else %}Go to [Yandex.Forms]({{ link-forms-ya }}).{% endif %}

1. [Create]{% if audience == "external" %}{% if locale == "ru" %} (https://yandex.ru/support/connect-forms/common/new-form.html){% else %}(https://yandex.com/support/connect-forms/common/new-form.html){% endif %}{% else %}(https://doc.yandex-team.ru/forms/external/new-form.html){% endif %} a new form.
Set up your form to collect data needed for issue creation.

1. Set up [{{ tracker-name }} integration]{% if audience == "external" %}{% if locale == "ru" %}(https://yandex.ru/support/connect-forms/common/create-task.html){% else %}(https://yandex.com/support/connect-forms/common/notifications.html#notifications__section_rvr_4jc_tbb){% endif %}{% else %}(https://doc.yandex-team.ru/forms/external/create-task.html){% endif %}:

    1. Specify your queue and other issue parameters.

    2. Use the **Issue description** field to add answers to the questions included in your form.

    3. If you want to save a specific answer in your issue parameters, add an issue field in the integration settings, click **Variables** → **Answer**, and choose the corresponding question.
You can also [create](../user/create-param.md) a new field if the one you need isn't available in the issue parameters.

    1. Save your integration settings.
The form will send out notifications containing lists of user answers to {{ tracker-name }}, and {{ tracker-name }} will then create issues based on those lists.

    {% if audience == "internal" %}

    {% note tip %}

    If you need to create an issue with a [checklist](../user/checklist.md) through the form, use the integration [<q>HTTP.Request to handle</q>](https://doc.yandex-team.ru/forms/external/http-request.html#http-request__resolve-problems-checklist).

    {% endnote %}

    {% endif %}

{% if audience == "external" %}

1. Set up [access rights to the form]{% if locale == "ru" %}(https://yandex.ru/support/connect-forms/common/restrictions.html#restrictions__sec_access){% else %}(https://yandex.com/support/connect-forms/common/publish.html#publish__section_wzm_g1n_xcb){% endif %}.
Any user can fill out the form by default. If you want, you can reserve this right for just your organization's employees.

{% endif %}

1. [Publish]{% if audience == "external" %}{% if locale == "ru" %} (https://yandex.ru/support/connect-forms/common/publish.html#publish__section_lmk_gvb_tbb){% else %}(https://yandex.com/support/connect-forms/common/publish.html#publish__section_lmk_gvb_tbb){% endif %}{% else %}(https://doc.yandex-team.ru/forms/external/publish.html){% endif %} the form. Your form will be accessible via a link specified in the **Link** field.

Once your form is published, you can {% if audience == "internal" %}[embed it in a wiki page](https://doc.yandex-team.ru/forms/external/publish.html#publish__section_xvx_g2c_tbb), [post it on a website](https://doc.yandex-team.ru/forms/external/publish.html#publish__section_c21_gdb_42b), or {% endif %}[add it to the issue creation page](../manager/attach-form.md) in the {{ tracker-name }} interface.

To learn more about Yandex.Forms, see [Help]{% if audience == "external" %}{% if locale == "ru" %}(https://yandex.ru/support/connect-forms/){% else %}(https://yandex.com/support/connect-forms/){% endif %}{% else %}(https://doc.yandex-team.ru/forms/){% endif %}.

{% if audience == "external" %}

[Contact support](../troubleshooting.md)

{% endif %}

