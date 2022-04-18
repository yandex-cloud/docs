# Restrict page viewing

You can restrict access to a page for other users if you are the page's owner:

1. Open the page.

1. At the top of the page, click the button that displays the page's access status (**Available to all employees** is set by default).

1. Specify who will be able to view the page:

   * **Same as the parent page**: The access level is carried over from the parent page.

   * **All staff employees**: All employees of your organization.

   * **Only authors**: Only the page owners can view and edit the page.

   * **Specific employees**: Specify the usernames of people to be granted viewing and editing access.

   {% note alert %}

   Changing access settings for [{{ wiki-name }} home page]({{ link-homepage }}) is not recommended.

   By default, the owner of the {{ wiki-name }} home page is a service account. If this page's access mode is set to "Only page owners", all other users will be blocked from accessing the page. To make the page accessible to other users, follow the link [{{ link-homepage-access }}]({{ link-homepage-access }}) to change access settings.

   {% endnote %}

1. Click **Save**.

Users who don't have access to the page will not be able to view or edit it. You can also allow viewing and [prohibit users from editing the page](read-only.md).

## How to access restricted pages {#request}

If the page owner restricted access to a page, you can send a request to access it.

1. Open the page you want to access.

1. Submit access request. Specify if you wish to have access granted to a group of users.

1. Click **Submit**.

You will get access to the page after at least one of the page owners approves your request.

{% note warning %}

{% if audience == "external" %}You can submit an access request even if the page owner no longer works at the organization. organization admin will receive and process your request.

If the administrator doesn't have access to the page, they can [assign a new page owner](page-settings.md).
{% else %}
If the page owner no longer works at Yandex, click **Become page owner**. Your request will be forwarded to the internal service support team for processing.
{% endif %}

{% endnote %}

{% if audience == "internal" %}

## Access to {{ wiki-name }} for external employees {#outstaff}

External Yandex employees are employees of the [Business Support team (outstaff)](https://staff.yandex-team.ru/departments/outstaff) and [External consultants](https://staff.yandex-team.ru/departments/ext).

{{ wiki-name }} is used to store confidential information or documents under NDA. This is why external consultants and employees from Business Support departments cannot access the pages by default.

An external consultant or member of the Business Support team may be granted access to the pages if they have the **external** role on {{ wiki-name }}. Usually, the role is automatically assigned to an employee when they are linked to a department or an ABC service.

### Requesting access to {#request-access}

You can request the **external** role for individual employees or groups of employees in [the {{ wiki-name }} system in IDM](https://idm.yandex-team.ru/system/wiki/). Do not request this role for the entire Business Support team.

If you're a manager of a Business Support unit, and your team needs to access the pages on a regular basis, you can request the **outstaffmanager** role for yourself via IDM. A user with this role can grant access to all other employees even if they don't have the **external** role. The **outstaffmanager** role is approved by the Information Security team.

{% endif %}

#### See also

* [{#T}](read-only.md)

* [{#T}](edit-owner.md)

* [{#T}](move-page.md)

