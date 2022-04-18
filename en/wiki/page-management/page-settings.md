# Page settings

{% note alert %}

Settings can be edited by the {% if audience == "external" %}[page owner](edit-owner.md) or [admin of the organization](../overview.md#access).{% else %}only by the [page owner](edit-owner.md). If the page owner no longer works at Yandex, write a message to [tools@](mailto:tools@yandex-team.ru). The request will be processed by the internal service support team.{% endif %}

{% endnote %}

You can use settings to specify page owners, redirect addresses, set keywords, or disable user comments.

To go to page settings:

1. Open a page.

1. In the upper-right corner of the page, click ![](../../_assets/wiki/ico-actions.png) **Action** and choose **Settings** or simply write `.settings` at the end of the page address in your address bar.

## Keywords {#key-words}

To help users find pages via the {{ wiki-name }} search bar, try [adding keywords](../add-key-words.md).

## Page owners {#owner}

Assign additional [page owners](edit-owner.md). They will be able to manage [page access rights](access-setup.md).

## Redirects {#redirect}

In this field, specify the page address users will be automatically redirected to from the current page.

This field is filled in automatically if the page has been [moved to another cluster](move-page.md). A service page at the old address will automatically redirect users to the new page.

## Comments {#comments}

To prevent users from commenting on a page, disable this option:

* Click on the **Comments** setting and choose **Disabled**.

* Uncheck the box to the right of **Comments** so that the new setting doesn't apply to subpages.

* Click **Save**.

## Restricting page editing

To make a page read-only, enable **Only the author can edit the page**. Read more about [restricting page editing](read-only.md).

