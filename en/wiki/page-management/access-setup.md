# Configuring access to a page

Edit access rights for the page to set which users can view and edit it.

{% note alert %}

Access settings can be edited by a {% if audience == "external" %}[page author](../roles.md) or [organization](../overview.md#access) administrator.{% else %}[page author](../roles.md) only. If the page author is no longer a Yandex employee, please contact [tools@](mailto:tools@yandex-team.ru). Your request will be handled by the internal services support team.{% endif %}

{% endnote %}

To configure page permissions:

1. In the upper-right corner of the page, click ![](../../_assets/wiki/svg/actions-icon.svg) **Actions** and select ![](../../_assets/wiki/svg/access-setup.svg) **Settings** or click the button that specifies the page access mode (by default, **Available to all employees**).

   {% if audience == "external" %}

   {% note tip %}

   If you are an administrator of your organization and you can't access the page, you can use a direct link to access the settings. To do this, add `.access` at the end of the page's URL.

   {% endnote %}

   {% endif %}

1. Specify who the page will be available to:

{% if audience == "external" %}
* **All employees**: To all employees of your organization.
{% else %}
* **All full-time employees**: To Yandex staff.
{% endif %}

* **Only authors**: The page will only be available to its [authors](../roles.md){% if audience == "external" %} and the organization's administrator.{% endif %}

* **Specific employees**: Specify the usernames of people or the group to grant access to.

* **Same as parent page**: The access level is inherited from the parent page.

{% note alert %}

It is not recommended to change the access settings for the [{{ wiki-name }} homepage]({{ link-homepage }}).

By default, the author of the {{ wiki-name }} homepage is a service account. If the "Only authors" access type is selected for this page, other users can't access it. To allow others to access the page, click the link [{{ link-homepage-access }}]({{ link-homepage-access }}) and change the access parameters.

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
If the page author is no longer a Yandex employee, click **Become an author**. Your request is forwarded to the the internal services support team members who will handle it.
{% endif %}

{% endnote %}

{% if audience == "internal" %}

## Access to {{ wiki-name }} for external employees {#outstaff}

Yandex external employees are members of the [Business support team (outstaff)](https://staff.yandex-team.ru/departments/outstaff) and [External consultants](https://staff.yandex-team.ru/departments/ext).

{{ wiki-name }} stores confidential information and documents that are subject to the NDA. Therefore, access to pages for external consultants and employees from the Business support team units is restricted.

To grant page access permissions to a member of the Business support team or external consultant, make sure they have the **external** role on {{ wiki-name }}. This role is usually assigned to an employee automatically when they are added to the respective department or the ABC service.

### Request access {#request-access}

You can request the **external** role for individual employees or groups on your own in the [{{ wiki-name }} system in IDM](https://idm.yandex-team.ru/system/wiki/). Don't request the role for the entire Business support team.

If you're a manager of employees from the Business support team and need to frequently grant them access to pages, you can request the **outstaffmanager** role for yourself in IDM. A user with this role can grant access permissions to any employees even if they don't have the **external** role. The **outstaffmanager** roles is to be approved by the Information Security service employees.

{% endif %}

## Prohibiting page editing {#read-only}

By default, all users who have access to a page can edit it. You can make the page read-only if you are its author:

1. Open the page.

1. In the upper-right corner of the page, click ![](../../_assets/wiki/svg/actions-icon.svg) **Actions** and select ![](../../_assets/wiki/svg/access-setup.svg) **Settings**.

1. In the **Page settings** window, select **Only the authors can edit the page**. Users who have [access to the page](access-setup.md) can view it, but can't edit it.

   {% note info %}

   {% if audience == "external" %}The administrator of the [organization](../overview.md#access) can{% else %}The internal services support team members can{% endif %} edit the page even if its author prohibited editing it. {% if audience == "internal" %}If necessary, write a request to [tools@](mailto:tools@yandex-team.ru). We'll do our best to help you.{% endif %}

   {% endnote %}

#### See also

* [{#T}](move-page.md)
