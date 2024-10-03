# Publishing a form
A form can be filled out once created. You can publish your form using a direct link, embed it in a website, or share a link to the form on social media. If you're using [{{ forms-full-name }} for business](forms-for-org.md), you can [embed the form on a {{ wiki-full-name }} page](../wiki/actions/forms.md).

When publishing a form, you can [set restrictions](restrictions.md) by date or the total number of  responses or only allow employees of {{ org-full-name }} organization to fill out the form.


{% note info %}

You can make changes to the form and its settings even after publication.

{% endnote %}

## Publishing a form using a link {#section_link}

As soon as a form is created, it becomes available via a direct link. To get a link to a form:

1. Select the form and click **{{ ui-key.forms.common.blocks_share.button-share }}** above the list of questions.

1. To copy the form address, click ![](../_assets/forms/icon-copy.png) in the **Link** field.   

1. To share the link on social media or in a messenger, click the icon next to the **Link** field.

All published forms are available to be filled out at the address specified in the **Link** field.


{% note info %}

If you want to use English for standard {{ forms-full-name }} messages like warnings about fields that are filled in incorrectly, change the domain from `.ru` to `.com` in the link.

{% endnote %}


## Generating a private link {#personal-link}

To distribute private links to your form, for example, among your promo participants, generate keysets with unique links. A user can fill out a form using a link from the keyset only once.

{% note warning %}

The generated keysets allow distributing forms before they are published. If you click **Publish** in the form builder, the generated keysets will stop working as unique links: if you follow them, you can fill out the form multiple times.

{% endnote %}

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

1. Select the form and click **{{ ui-key.forms.common.blocks_share.button-share }}** above the list of questions.

1. Copy the form code from the **Iframe embed code** field.

1. Paste it into the HTML code of the page where you want to put the form.

   To adjust the size, change the `width` parameter value. You can specify the size in percentage or pixels. For example, if you want the form to fit the page width, specify `width="100%"`.


## Publishing the form on {{ wiki-name }} {#publish-wiki}


{% note warning %}

Only users of [{{ forms-full-name }} for business](forms-for-org.md) can work with {{ wiki-name }}.

{% endnote %}


To publish a form on a {{ wiki-full-name }} page:

1. Select the form and click **{{ ui-key.forms.common.blocks_share.button-share }}** above the list of questions.

1. Copy the form code from the **Embed code for {{ wiki-name }}** field.

1. Paste the code in text on a Wiki page.


## Unpublishing the form {#unpublish}

To stop accepting responses and unpublish the form:

1. Select the form and click **{{ ui-key.forms.common.blocks_share.button-share }}** above the list of questions.

1. Click **Unpublish**.
