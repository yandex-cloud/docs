# Changing the page address

You can change the page address or move it to another cluster. You can move pages one at a time or include subpages.

To move a page to a different cluster, do the following:

1. Open a page.

1. In the upper-right corner of the page, click ![](../../_assets/wiki/ico-actions.png) **Action** and select **Move** (for dynamic tables, ![](../../_assets/wiki/table-settings-footer.png) → **Move**).

1. Set a new page address.

1. If you want to move a page with all subpages, choose **Move subpages**.

1. If you want to change the page name, choose **Rename page**.

1. Click **Move**.

Things to note about moving pages:

* If you selected the **Move subpages** option, subpages will be moved even if you don't have access rights to them.

* All access rights to pages and subpages are carried over during the move.

* A service page at the old page address will automatically *redirect* users to the new page. You can also [cancel the redirect](#redirect).

* Files located on the page are moved to the new address. At the same time, files located at the old address are deleted. When you cancel the redirect, the files will only be stored at the new address.

## How to cancel a redirect {#redirect}

To cancel the auto-redirect to the new page address:

1. Open the page at the new address. A notification about redirecting from the old page is displayed under the heading.

1. Follow the link. This will take you to the page at the old address. `? will be added to the page address.noredirect`.

1. Click **Remove redirect**. [Page settings](page-settings.md) will open.

1. In the**Redirect** setting, delete the redirect address. To do this, click ![](../../_assets/wiki/button_del_setting.png) and save changes.

1. To update data, click anywhere on the page and confirm changes.

Now the pages at the old and the new addresses are not linked to each other.

{% note warning %}

When you cancel the redirect, the files will only be stored at the new address.

{% endnote %}

#### See also

* [{#T}](access-setup.md)

* [{#T}](../edit-page.md)

* [{#T}](../delete-page.md)

