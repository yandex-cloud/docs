# Create a form

## Create a form {#create-form}

To conduct a survey, collect votes, accept requests, or take orders, create a form:

1. {% include [forms-versions](../_includes/forms/forms-versions.md) %}

1. Select a [template for your form](#section_dyd_dnx_cgb) or click **Create a form** on the top panel.

1. To change the name of the form, hover over **New form** and click the ![](../_assets/forms/edit.png) icon.

1. On the **Constructor** tab, [add prompts](add-questions.md) for the user to respond to.
To [create a test or quiz](tests.md), use prompts from the **Tests and quizzes** category.

1. Customize the [appearance of the form](appearance.md).

1. To see what your form will look like when you publish it, click **Preview**.

1. To limit the timeframe for accepting responses or the number of respondents, use the [options on the **Settings**](restrictions.md)  tab. By default, no limits are set.

1. To use data from responses in other services, [configure integration](notifications.md).

1. [Publish the form](publish.md).

{% if audience == "external" %}

{% note info %}

If you're using [{{ forms-full-name }} for business](forms-for-org.md), you can give your employees [access to edit the form](forms-settings.md#section_vcf_h5b_tbb).

{% endnote %}

{% else %}

If necessary, you can grant [access to edit the form](forms-settings.md#section_vcf_h5b_tbb) to other employees at Yandex.

{% endif %}

## Copy a form {#sec_copy_form}

To create a new form based on an existing one, copy the form and edit it:

1. In the upper panel, go to **My forms**.

1. Select a form and hover over it.

1. Click ![](../_assets/forms/context-menu.png) and select **Copy**.
A success message will appear at the top of the window.

1. Click **Go to form**. A page for editing the form will open.

1. [Edit prompts](add-questions.md) and adjust the settings for the new form.

## Use a template {#section_dyd_dnx_cgb}

{{ forms-full-name }} has several templates for popular form types. To create a form based on a template:

1. Go to [{{ forms-full-name }} home page]{% if audience == "external" %}({{ link-forms-admin }}){% else %}({{ link-forms-admin-ya }}){% endif %}.

1. Select a template:
    - **Feedback form**: collect user reviews.
    - **Questionnaire**: conduct surveys on any topics.
    - **Application**: accept requests for services and orders.
    - **Registration for an event**: accept applications for event participation.

    To create a form from scratch, select **From scratch**.

1. To see what the form with your selected template will look like after you publish it, click **For the user**.

1. Click **Create form from template**.

{% if audience == "draft" %} ![](../_assets/forms/templates.png) {% endif %}

