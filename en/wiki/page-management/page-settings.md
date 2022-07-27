# Page settings

{% note alert %}

Settings can be edited by the {% if audience == "external" %}page author or the administrator of the [organization](../overview.md#access).{% else %}page author only. If the author of a page is no longer a Yandex employee, send an email to [tools@](mailto:tools@yandex-team.ru). Your request will be handled by the internal services support team.{% endif %}

{% endnote %}

Using settings, you can add page authors, change the owner, set permissions to view and edit pages, configure a redirect, comments, and keywords.

To go to the page settings:

1. Open the page.

1. In the upper-right corner of the page, click ![](../../_assets/wiki/svg/actions-icon.svg) **Actions** and select **Settings** or add `.settings` at the end of the page URL in the address bar.

## Page authors {#author}

Edit page [authors](edit-owner.md). They can manage [page access permissions](access-setup.md).

## Configuring access to a page

Edit [access rights](access-setup.md) to the page to set which users can view and edit it.

## Adding a cover

You can add a cover to each page, which is the background of the upper part where the owner of the page, its title, and the date of the last update are indicated.

To set a cover:

  1. In the upper-right corner of the page, click ![](../../_assets/wiki/svg/actions-icon.svg) **Actions** and select![](../../_assets/wiki/svg/add-cover.svg) **Add cover**.

  1. In the **Select cover** menu, click on the cover you like and it immediately applies to the page.

  1. Close the cover selection window.

{% if audience == "internal" %}

## Translating a page

1. In the upper-right corner of the page, click ![](../../_assets/wiki/svg/actions-icon.svg) **Actions** and select **Translate page**.

1. Click **English** or **Russian** to translate the content of the Wiki page into the selected language.

{% note alert %}

Please note that the Wiki interface itself won't change: only the content of the page is translated.
{% endif %}

{% endnote %}

## Redirects {#redirect}

In this field, specify the address of the page where the user will be automatically redirected from this page.

In addition, this setting is filled in automatically if the page was [moved to another cluster](move-page.md). The old page address will then automatically redirect users to the new page.

## Comments {#comments}

To prevent users from adding comments to a page, disable this feature:

* Click **Comments** and set **Disabled**.

* To make sure the new setting value isn't applied to subpages, uncheck the checkbox to the right of **Comments**.

* Click **Save**.

