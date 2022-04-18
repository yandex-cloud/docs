# Assign page owners

A page can have one or more owners. By default, the page owner is the user who created the page.

{% note alert %}

A new owner can be assigned by the current page owner or {% if audience == "external" %}organization admin{% else %}the internal service support team{% endif %}.

{% endnote %}

## Assign page owners {#add}

To assign another user as the page owner:

  1. Open a page.

  1. In the upper-right corner of the page, click ![](../../_assets/wiki/ico-actions.png) **Action** and go to **Settings**.

  1. Click **Page owners** and enter the username of the new page owner.

  1. Click **Save**.

## Become the owner of another user's page {#request}

To become the owner of a page created by another user:

  1. Open a page.

  1. In the upper-right corner of the page, click ![](../../_assets/wiki/ico-actions.png) **Action** and go to **Settings**.

  1. Click **Become owner** and explain why you should be assigned as the page owner.

  1. Click **Submit**.

  The current page owner will receive your request by mail. After they approve your request, you will be added to the page owner list and receive a notification by mail.

## Edit the page owner list {#edit}

{% if audience == "external" %}
The organization admin can edit the page owner list for any page:

  1. Open a page.

  1. In the upper-right corner of the page, click ![](../../_assets/wiki/ico-actions.png) **Action** and go to **Settings**.

  1. Add or remove usernames in the **Page owners** section.

  1. Click **Save**.

{% else %}
The internal service support team can edit the page owner list for any page.

If the page owner is currently employed at Yandex, but they don't have access to the Internet or a PC:

  1. Send a message to [tools@](mailto:tools@yandex-team.ru). Add the cluster owner to the recipient list.

  1. Wait for the team to process your request.

If the page owner no longer works at Yandex:

  1. Click **Become page owner**.

  1. Wait for the internal service team to process your request.

{% endif %}

#### See also

- [{#T}](access-setup.md)

- [{#T}](move-page.md)

- [{#T}](../delete-page.md)

