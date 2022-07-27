# Configuring access to a page

You can restrict other users' access to the page if you are its author:

1. Open the page.

1. At the top of the page, click the button that specifies the access mode for the page (by default **Available to all employees**).

1. Specify who the page will be available to:


   * **All employees**: To all employees of your organization.

   * **Only authors**: Only to authors and organization owners.

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

If the author of a page no longer works for the organization, you can also submit a request for access permissions. The request is forwarded to the organization administrator who will handle it.

If the administrator has no access to the page, they can [assign a new author](page-settings.md).

{% endnote %}


## Prohibiting page editing {#read-only}

By default, all users who have access to a page can edit it. You can make the page read-only if you are its author:

1. Open the page.

1. In the upper-right corner of the page, click ![](../../_assets/wiki/svg/actions-icon.svg) **Actions** and select **Settings**.

1. In the **Page settings** window, enable the option **Only the authors can edit the page**. Users who have [access to the page](access-setup.md) will be able to view it, but will not be able to edit it.

    {% note info %}

    The administrator of the [organization](../overview.md#access) will be able to edit the page even if its author has prohibited editing it. 

    {% endnote %}

1. To prohibit comments on the page, click **Comments**, select **Disabled** and click **Save**.

#### See also

* [{#T}](move-page.md)

