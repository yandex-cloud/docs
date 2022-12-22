# Publishing a form
{% if audience == "external" %}
A form can be filled out once created. You can publish your form using a direct link, embed it in a website, or share a link to the form on social media. If you're using [{{ forms-full-name }} for business](forms-for-org.md), you can [embed the form on a {{ wiki-full-name }} page](../wiki/actions/forms.md).
{% else %}
To make the form available for filling out, click **Publish** above the prompt list. Next, you can invite users to fill out the form via a direct link, embed it in a website, or post it on {{ wiki-name }} or in {{ tracker-name }}.
{% endif %}

When publishing a form, you can [set restrictions](restrictions.md) by date or the total number of {% if audience == "external" %} responses or only allow employees of {{ org-full-name }}{% endif %} organization to fill out the form.

{% if audience == "external" and locale == "ru" %}
If you're going to use the form to collect respondents' personal data, be sure to meet the [Terms of Use]({{ link-forms-legal }}).
{% endif %}

{% note info %}

You can make changes to the form and its settings even after publication.

{% endnote %}

## Publishing a form using a link {#section_link}

As soon as a form is created, it becomes available via a direct link. To get a link to a form:

1. Select the form and click **Share** above the list of questions.

1. To copy the form address, click ![](../_assets/forms/icon-copy.png) in the **Link** field.
   {% if audience == "internal" %}If you created your form in the [internal admin panel](go-to-forms.md), you can use it to conduct an anonymous poll. To do this, copy the form address from the **Link to anonymous form** field.{% endif %}

1. {% if audience == "internal" %}Send the link to users or post it on public resources.{% else %}To share the link on social media or in a messenger, click the icon next to the **Link** field.{% endif %}

All published forms are available to be filled out at the address specified in the **Link** field.

{% if audience == "external" %}

{% note info %}

If you want to use English for standard {{ forms-full-name }} messages like warnings about fields that are filled in incorrectly, change the domain from `.ru` to `.com` in the link.

{% endnote %}

{% endif %}

## Generating a private link {#personal-link}

To distribute private links to your form, for example, among your promo participants, generate keysets with unique links.

Every link from the keyset can only be used once.  You can use the keys to distribute unpublished forms.

To generate the keys:
1. Select a form and go to **Settings** → **Private links to form**.
1. Click **Generate keys**.
1. Enter the name for the keyset and the number of keys.
1. Click **Generate**: the new keyset will show up in the list.

Links to the form are stored in the keyset's XLS file. To get links to your form, export this file and copy links from it.

{% note info %}

To deactivate unused keys, click ![](../_assets/forms/svg/settings.svg) → **deactivate**. The link will change its status to **deactivated**.

{% endnote %}

## Publishing on a website {#publish-site}

To publish a form on your website:

1. Select the form and click **Share** above the list of questions.

1. Copy the form code from the **Iframe embed code** field.

1. Paste it into the HTML code of the page where you want to put the form.
   To adjust the size, change the `width` parameter value. You can specify the size in percentage or pixels. For example, if you want the form to fit the page width, specify `width="100%"`.

{% if audience == "internal" %}

## Set up the form ID {#customize-id}

To have an option to replace your form without updating a link to it, set up a special form ID. This will enable you to assign the same ID to another form and replace your old form with the new one.

To set up the ID for your form:

1. Select the form and open the **Settings** → **Additional** tab.

1. Fill in the **Form ID** field. Use digits, Latin characters, underscores, and dashes in the ID.
   The standard form ID will also remain valid.

1. Generating a form link with the new ID:

   * [Get a link](#section_link) and replace the form ID with the new one: `{{ link-forms }}surveys/<ID>/`.

   * To publish the form on your site, [copy the iframe embed code](#publlish-site) and replace the form ID in the link `<iframe src="{{ link-forms }}surveys/<ID>/...`.

{% endif %}

## Publishing the form on {{ wiki-name }} {#publish-wiki}

{% if audience == "external" %}

{% note warning %}

Only users of [{{ forms-full-name }} for business](forms-for-org.md) can work with {{ wiki-name }}.

{% endnote %}

{% endif %}

To publish a form on a {{ wiki-full-name }} page:

1. Select the form and click **Share** above the list of questions.

1. Copy the form code from the **Embed code for {{ wiki-name }}** field.

1. Paste the code in text on a Wiki page.

{% if audience == "internal" %}

## Adding the form to {{ tracker-name }} {#publish-tracker}

In the [internal form admin panel](go-to-forms.md), you can [set up a form for creating issues](create-task.md#setup) and embed it in the {{ tracker-name }} interface. This form will be displayed on the issue creation page next to the standard one. It will help users create issues based on a certain template without being distracted by unnecessary fields and parameters. To learn more about forms in {{ tracker-name }}, see [Help {{ tracker-full-name }}](https://docs.yandex-team.ru/cloud/tracker/manager/attach-form).

{% endif %}

## Unpublishing the form {#unpublish}

To stop accepting responses and unpublish the form:

1. Select the form and click **Share** above the list of questions.

1. Click **Unpublish**.
