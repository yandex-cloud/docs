# Use a form as a template for creating issues

{% note warning %}

By default, queue settings can only be accessed by the queue owner.

{% endnote %}

You can use Yandex.Forms to set up your form to act as a template for creating issues as well as integrate it with the {{ tracker-name }} interface. Such form will be displayed on the issue creation page next to the basic one. It will help users create issues by following a preset template without feeling distracted by other fields and parameters.

## Step 1. Create and configure your form {#section_ovd_5hl_1gb}

1. {% if audience == "external" %} Go to [Yandex.Forms]({{ link-forms }}). If it isn't activated, contact your organization's administration.{% else %}Go to [Yandex.Forms]({{ link-forms }}).{% endif %}

1. [Create]{% if audience == "external" %}{% if locale == "ru" %} (https://yandex.ru/support/connect-forms/common/new-form.html){% else %}(https://yandex.com/support/connect-forms/common/new-form.html){% endif %}{% else %}(https://doc.yandex-team.ru/forms/external/new-form.html){% endif %} a new form from scratch or use the **Issue for {{ tracker-name }}** template.

   Set up your form's fields to collect data needed for issue creation.

1. Configure the name of the form. This name will be displayed in the {{ tracker-name }} interface during issue creation.

2. Set up [{{ tracker-name }} integration]{% if audience == "external" %}{% if locale == "ru" %}(https://yandex.ru/support/connect-forms/common/create-task.html){% else %}(https://yandex.com/support/connect-forms/common/notifications.html#notifications__section_rvr_4jc_tbb){% endif %}{% else %}(https://doc.yandex-team.ru/forms/external/create-task.html){% endif %} for your form.

3. [Publish]{% if audience == "external" %}{% if locale == "ru" %} (https://yandex.ru/support/connect-forms/common/publish.html#publish__section_lmk_gvb_tbb){% else %}(https://yandex.com/support/connect-forms/common/publish.html#publish__section_lmk_gvb_tbb){% endif %}{% else %}(https://doc.yandex-team.ru/forms/external/publish.html){% endif %} the form and copy the link to it from the **Link** field.

## Step 2. Connect your form to the queue {#section_xxj_fll_1gb}

1. Go to [{{ tracker-name }}]{% if audience == "external" %}({{ link-tracker }}){% else %}({{ link-tracker-ya }}){% endif %}.

1. Open the [queue page](../user/queue.md).

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Administration**.

1. Go to **Form integration** and click **Add form**.

1. Paste the link to the form.

1. Add the name and description for your form. You can view them in the form selection window when creating an issue.

1. Click **Add**.

