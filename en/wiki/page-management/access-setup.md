# Configuring access to a page

Edit access rights for the page to set which users can view and edit it. You can only grant access permissions to users who are members of your organization.

{% note alert %}

Access settings can be edited by a [page author](../roles.md) or [organization](../overview.md#access) administrator.

{% endnote %}

To configure page permissions:

1. In the top-right corner of the page, click ![](../../_assets/wiki/svg/actions-icon.svg) **Actions** and select ![](../../_assets/wiki/svg/access-setup.svg) **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-page-more-panel.settings }}** or click the button that specifies the page access mode (by default, **Available to all employees**).


   {% note tip %}

   If you are an organization administrator and you cannot access the page, you can only request access from the page author.

   {% endnote %}


1. Specify who the page will be available to:

* **All employees**: To all employees of your organization.

* **Only authors**: The page will only be available to its [authors](../roles.md) and the organization's administrator.

* **Specific employees**: Specify the usernames of people or the group to grant access to.

* **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-widget.access_to_parent }}**: Access level is inherited from the parent page.

{% note alert %}

It is not recommended to change the access settings for the [{{ wiki-name }} homepage]({{ link-homepage }}).

By default, the author of the {{ wiki-name }} home page is a service account. If the "Only authors" access type is selected for this page, other users can't access it. To allow others to access the page, click the [{{ link-homepage-access }}]({{ link-homepage-access }}) link and change the access parameters.

{% endnote %}

1. Click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-editor-struct.page_save }}**.

Users who have no access to the page will not be able to view and edit it. You can also allow users to view the page, but [prohibit its editing](#read-only).

## Getting access to a page with restricted access {#request}

If a page's author has restricted access to it, you can always request access permissions.

1. Open the page you want to access.

1. Write a request. If access is to be granted to a group of users, specify this.

1. Click **Request access**.

You will get access to the page as soon as one of the page authors approves your request.

{% note warning %}

If the author of a page no longer works for the organization, you can also submit a request for access permissions. The request is forwarded to the organization administrator who will handle it.

If the administrator doesn't have access to the page, they can [assign a new author](page-settings.md) for it.

{% endnote %}


## Prohibiting page editing {#read-only}

By default, all users who have access to a page can edit it. You can make the page read-only if you are its author:

1. Open the page.

1. In the top-right corner of the page, click ![](../../_assets/wiki/svg/actions-icon.svg) **Actions** and select ![](../../_assets/wiki/svg/access-setup.svg) **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-page-more-panel.settings }}**.

1. In the **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-widget.page-settings }}** window, select **Only the authors can edit the page**. Users who have [access to the page](access-setup.md) can view it, but cannot edit it.

   {% note info %}

   The administrator of the [organization](../overview.md#access) can edit the page even if its author prohibited editing it. 

   {% endnote %}

#### See also

* [{#T}](move-page.md)
