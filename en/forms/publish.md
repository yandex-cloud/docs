# Publish a form

{% if audience == "external" %}
The form is available for filling out immediately after it's created. You can publish the form using a direct link, embed it in a site, or share a link to the form on social media. If you use [{{ forms-full-name }} for business](forms-for-org.md), you can [embed the form on a {{ wiki-full-name }}](../wiki/actions/forms.md) page.
{% else %}
To make the form available to be filled out, click **Publish** above the prompt list. After that, you can invite users to fill out the form via a direct link, embed the form in the website, or post it on {{ wiki-name }} or in {{ tracker-name }}.
{% endif %}

When publishing a form, you can [set restrictions](restrictions.md) by date and the total number of responses {% if audience == "external" %} or allow only employees of your organization to fill out the form {{ org-full-name }}{% endif %}.

{% if audience == "external" and locale == "ru" %}
If you're using the form to collect respondents' personal data, please comply with [Service Terms of use]({{ link-forms-legal }}).
{% endif %}

{% note info %}

You can make changes to the form and its settings even after publication.

{% endnote %}

## Publish using a link {#section_link}

The form is available via a direct link immediately after it's created. To get a link to the form:

1. Select the form and click **Share** above the prompt list.

1. To copy the form address, click ![](../_assets/forms/icon-copy.png) in the **Link** field.
{% if audience == "internal" %}If you created a form in your [internal admin panel](new-form.md#instance), you can use it for an anonymous survey. To do this, copy the form address from the **Link to anonymous form** field.{% endif %}

1. {% if audience == "internal" %}Send the link to users or post it publicly.{% else %}To share a link on social media or in messengers, click the icon to the right of the **Link** field.{% endif %}

All published forms are available to be filled out at the address specified in the **Link** field.

{% if audience == "external" %}

{% note info %}

If you want to use English for standard {{ forms-full-name }} messages like warnings about incorrectly filled in fields, change the domain from `.ru` to `.com` in the link.

{% endnote %}

{% endif %}

## Publish on a site {#section_c21_gdb_42b}

To publish a form on your site:

1. Select the form and click **Share** above the prompt list.

1. Copy the form code from the **Iframe embed code** field.

1. Paste it into the HTML code of the page where you want to put the form.
To adjust the size, change the `width` parameter value. You can specify the size in percentages or pixels. For example, if you want the form to fit the page width, specify `width="100%"`.

## Publish on {{ wiki-name }} {#section_xvx_g2c_tbb}

{% if audience == "external" %}

{% note warning %}

Only users of [{{ forms-full-name }} for business](forms-for-org.md) can work with {{ wiki-name }}.

{% endnote %}

{% endif %}

To publish a form on a {{ wiki-full-name }} page:

1. Select the form and click **Share** above the prompt list.

1. Copy the form code from the **Embed code for {{ wiki-name }}** field.

1. Paste the code into the text on the wiki page.

{% if audience == "internal" %}

## Add to {{ tracker-name }} {#section_znn_4yv_lgb}

In the [internal admin panel for forms](new-form.md#instance), you can [configure the form for creating tasks](create-task.md#setup) and embed it in the interface {{ tracker-name }}. This form will be displayed on the task creation page next to the standard form. It will help users create tasks based on a specific template without being distracted by unnecessary fields and parameters. To learn more about forms in {{ tracker-name }}, see [Help{{ tracker-full-name }}](https://docs.yandex-team.ru/cloud/tracker/manager/attach-form).

{% endif %}

## Remove from publication {#section_lvx_52c_tbb}

To stop accepting responses and remove the form from publication:

1. Select the form and click **Share** above the prompt list.

1. Click **Remove from publication**.

