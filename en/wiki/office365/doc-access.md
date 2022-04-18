# Configure access to cloud documents

The procedure for configuring access depends on how the cloud document was created:

* Use the Wiki page access settings if you created a new cloud document or uploaded a file via the {{wiki-name}} interface.

* Use the Sharepoint access settings if you created a document in the Office 365 interface and embedded it on a Wiki page.

## Managing access rights via Wiki pages {#wiki-access}

If you created a new cloud document or uploaded a file via the {{wiki-name}} interface, use the Wiki page settings to change access rights: click the button for configuring access rights at the top of the page and select [access mode](../page-management/access-setup.md).

Users with limited access to a Wiki page won't be able to read or edit the embedded document via the {{wiki-name}} interface.

{% note alert %}

Access rights set to {{wiki-name}} are synchronized with access rights on the Office 365 portal. Access rights configured in the Sharepoint interface will be overwritten by the Wiki page settings during synchronization.

{% endnote %}

## Managing access rights via the Office 365 interface {#access-list}

If you created a document in the Office 365 interface and want to [embed it on Wiki pages](create-ms-office.md#embed-existing), configure access rights to the documents or folders they are located in. Otherwise, the documents may not be accessible to {{wiki-name}} users.

{% note alert %}

Wiki page access settings do not apply to documents created in the Office 365 interface.
When you embed such a document on a Wiki page, the warning will show up: "Access to this document was configured by the owner on the Sharepoint portal".

{% endnote %}

By default, documents stored in the [personal OneDrive folder]({{link-sharepoint-personal}}) can only be accessed by their owner. Documents stored on [Sharepoint]({{link-sharepoint-common}}) can be accessed by all internal and external Yandex employees. To share a document, you can [move it to the shared site](doc-access.md#move-doc).

To configure access rights for a document or folder:

1. Find the document or folder on the [Sharepoint portal]({{link-sharepoint-common}}) or in your [personal OneDrive folder]({{link-sharepoint-personal}}).

1. Hover your cursor over the document and click ![](../../_assets/wiki/share-opt.png) and choose **Manage access**.

1. On the panel that opens up in the **Direct access** block, enter the name of the employee or the group name and the required access level: **Can edit** or **Can view**.
   * To grant access to all internal employees, use the **Yandex.All.Staff** group. To grant access to all external employees, use **Yandex.All.Outstaff**.
   * To grant access to all Yandex employees (internal and external), add both groups: **Yandex.All.Staff** and **Yandex.All.Outstaff**.
   * There aren't dedicated access groups for separate divisions and departments.

    {% note alert %}

    If you grant access to a large group of employees, turn off the **Notify users** option. Otherwise, all members of the group will receive notifications by mail.

    {% endnote %}

1. Click **Grant access**.

### Moving a document from a personal folder to a shared site {#move-doc}

By default, documents stored in the [personal OneDrive folder]({{link-sharepoint-personal}}) can only be accessed by their owner.

If your shared documents are intended for a large audience, store them on the [Sharepoint site]({{link-sharepoint-common}}). On the portal, you can create a folder for your project or department and use it to store documents for public use. To keep the storage space neat and tidy, avoid moving documents in the root folder.

If your documents are stored in a personal OneDrive folder, move them to a shared site before embedding them on {{wiki-name}}. Otherwise, the files in your personal folder will be deleted in case you leave the organization or your Office 365 license is revoked.

To move a document:

1. Find the document in your [personal OneDrive folder]({{link-sharepoint-personal}}).

1. Hover your cursor over the document and click ![](../../_assets/wiki/share-opt.png) and choose **Move**.

1. On the panel that opens up in the **Locations** block, select **Yandex** → **Group website** → **Documents**, then select your department or project folder. If there is no such folder, you can create a new one.

1. Click **Move here**.

### Accessing documents via link {#share-link}

If you want other users to work with a document in the Office 365 interface, you can share access to the document via a link.

{% note alert %}

You can't use this method for embedding a document on {{wiki-name}}.

{% endnote %}

1. Find the document on the [Sharepoint portal]({{link-sharepoint-common}}) or in your [personal OneDrive folder]({{link-sharepoint-personal}}). Hover your cursor over the document and click ![](../../_assets/wiki/access.png).
If the document is open, select **File** → **Share** → **Share** (in PowerPoint, **File** → **Shared access** → **Share with other users**).

1. To set up access rights via the link, click **Specified users can edit**.

1. To send the link by mail, enter usernames or email addresses and click **Send**.

1. To copy the link, click **Copy link**.

