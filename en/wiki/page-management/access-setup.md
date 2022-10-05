# Configuring access to a page

Edit access rights for the page to set which users can view and edit it.

{% note alert %}

Access settings can be edited by the {% if audience == "external" %}[page author](../roles.md) or the administrator of the [organization](../overview.md#access).{% else %}page [author](../roles.md) only. If the author of a page is no longer a Yandex employee, send an email to [tools@](mailto:tools@yandex-team.ru). Your request will be handled by the internal services support team.{% endif %}

{% endnote %}

To configure access rights for a page:

1. In the upper-right corner of the page, click ![](../../_assets/wiki/svg/actions-icon.svg) **Actions** and select ![](../../_assets/wiki/svg/access-setup.svg) **Settings** or click the button that specifies the access mode for the page (it's **Available to all employees** by default).

   {% if audience == "external" %}

   {% note tip %}

   If you are an administrator of your organization, and you can't access the page, you can use a direct link to access the settings. To do this, add `.access` at the end of the page's URL.

   {% endnote %}

   {% endif %}

1. Specify who the page will be available to:

{% if audience == "external" %}

   * **All employees**: The page is available to all employees of your organization.
{% else %}

   * **All staff employees**: The page is available to all Yandex staff employees.
{% endif %}

   * **Only authors**: The page is available only to its [authors](../roles.md){% if audience == "external" %} and the organization's administrator.{% endif %}

   * **Specific employees**: Specify the usernames of people or the group to grant access to.

   * **Same as parent page**: The access level is inherited from the parent page.

   {% note alert %}

   It is not recommended to change the access settings for [{{ wiki-name }} home page]({{ link-homepage }}).

   By default, the author of the {{ wiki-name }} homepage is a service account. If the "Only authors" access is selected for this page, access for other users will be blocked. To remove the lock, click the link [{{ link-homepage-access }}]({{ link-homepage-access }}) and change the access parameters.

   {% endnote %}

1. Click **Save**

Users who do not have access to the page will not be able to view and edit it. You can also allow users to view the page, but [prohibit its editing](#read-only).

## Getting access to a page with restricted access {#request}

If a page's author has restricted access to it, you can always request access permissions.

1. Open the page you want to access.

1. Write a request. If access is to be granted to a group of users, specify this.

1. Click **Request access**.

After any of the page authors approves your request, you'll get access to it.

{% note warning %}

{% if audience == "external" %}If the author of a page no longer works for the organization, you can also submit a request for access permissions. The request is forwarded to the organization administrator who will handle it.

If the administrator doesn't have access to the page, they can [assign a new author](page-settings.md) for it.
{% else %}

If the author of a page is no longer a Yandex employee, click **Become an author**. Your request is forwarded to the internal services support team and they will process it.
{% endif %}

{% endnote %}

{% if audience == "internal" %}

## Access to {{ wiki-name }} for contractors {#outstaff}

Yandex contractors are [Business Support Team (outstaff)](https://staff.yandex-team.ru/departments/outstaff) members and [External consultants](https://staff.yandex-team.ru/departments/ext).

{{ wiki-name }} stores confidential information or documents subject to NDA. Therefore, access to pages for external consultants and employees from the Business Support Team units is limited by default.

To grant an employee of the Business Support Team or an external consultant access to a page, make sure they have the **external** role on {{ wiki-name }}. This role is usually assigned to an employee automatically when adding them to a unit or the ABC service.

### Requesting access {#request-access}

You can request the **external** role for individual employees or groups on your own in [the {{ wiki-name }} system in IDM](https://idm.yandex-team.ru/system/wiki/). Don't request the role for the entire Business Support Team.

If you're a team lead for employees from the Business Support Team and you often have to grant them access to certain pages, you can request the **outstaffmanager** role for yourself in IDM. A user with this role can grant access permissions to any employee even if they don't have the **external** role. The **outstaffmanager** role has to be approved by the Information Security Service employees.

{% endif %}

## Prohibiting page editing {#read-only}

By default, all users who have access to a page can edit it. You can make the page read-only if you are its author:

1. Open the page.

1. In the upper-right corner of the page, click ![](../../_assets/wiki/svg/actions-icon.svg) **Actions** and select ![](../../_assets/wiki/svg/access-setup.svg) **Settings**.

1. In the **Page settings** window, enable the option **Only the authors can edit the page**. Users who have [access to the page](access-setup.md) will be able to view it, but will not be able to edit it.

    {% note info %}

    {% if audience == "external" %}The administrator of the [organization](../overview.md#access) will be able to{% else %}The internal services support team will be able to{% endif %} edit the page even if its author has prohibited editing it. {% if audience == "internal" %}If necessary, write a request to [tools@](mailto:tools@yandex-team.ru), and they'll help.{% endif %}

    {% endnote %}

#### See also

* [{#T}](move-page.md)

