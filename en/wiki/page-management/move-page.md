# Changing a page address

You can change the address of a page and move it to another cluster. Pages can be moved one by one or together with subpages.

To move a page to another cluster:

1. Open the page.

1. In the upper-right corner of the page, click ![](../../_assets/wiki/svg/actions-icon.svg) **Actions** and select **Move** (for dynamic tables ![](../../_assets/wiki/table-settings-footer.png) → **Move**).

1. Enter a new page address.

1. If you want to move the page together with all its subpages, choose **Move subpages**.

1. If you want to change the page name, choose **Rename page**.

1. Click **Move**.

Specifics of moving pages:

* If you selected the **Move subpages** option, subpages will be moved even if you don't have access rights to them.

* The values of access rights to the page and subpages are fixed and saved when moving them.

* The old page address will then automatically *redirect* users to the new page. You can [cancel a redirect](#redirect).

* Files located on the page are moved to its new address. Files at the old page address are deleted. Once you cancel a redirect, the files will only remain on the page at the new address.

## Canceling a redirect {#redirect}

To cancel an automatic user redirect to a new page address:

1. Open the page at the new address. You'll see a notification about a redirect from the page located at the old address under the page title.

1. Follow the link. This opens the page at the old address with `?noredirect` added to the page URL.

1. Click **Delete redirect**. This opens the [page settings](page-settings.md).

1. Delete the redirect address in the **Redirect** setting. To do this, click ![](../../_assets/wiki/button_del_setting.png) and save the changes.

1. To update the data, click anywhere on the page and confirm the changes.

From now on, the pages at the old and new addresses are not linked to each other.

{% note warning %}

Once you cancel a redirect, the files located on the page will only remain at the new address.

{% endnote %}

#### See also

* [{#T}](access-setup.md)

* [{#T}](../edit-page.md)

* [{#T}](../delete-page.md)

