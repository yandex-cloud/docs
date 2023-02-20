# Configuring access to cloud documents

The procedure for configuring access to a cloud document depends on how it was created:

* Use the Wiki page access settings if you created a new cloud document or uploaded a file through the {{ wiki-name }} interface.

* Customize Sharepoint permissions if your created a document using the Office 365 interface and then embedded it in a Wiki page.

## Managing access via a Wiki page {#wiki-access}

If you created a new cloud document or uploaded a file through the {{ wiki-name }} interface, to change permissions to access your document, use the Wiki page settings: click the access setup button at the top of the page and select [access mode](../page-management/access-setup.md).

Users with restricted access to your Wiki page won't be able to read and edit a document embedded using the {{ wiki-name }} interface.

{% note alert %}

Access permissions set up on {{ wiki-name }} are synced with Office 365 access permissions. If you set up access permissions through the Sharepoint interface, they're overwritten with the Wiki page settings when syncing them.

{% endnote %}

## Managing access via the Office 365 interface {#access-list}

If you created documents using the Office 365 interface and want to [embed them in Wiki pages](create-ms-office.md#embed-existing), set up permissions to access your documents or folders where they're located. Otherwise, these documents may be inaccessible to {{ wiki-name }} users.

{% note alert %}

The Wiki page access settings do not apply to documents created using the Office 365 interface.
When you try to add this document to a Wiki page, you'll see a warning saying "Access to this document was set up by its author in Sharepoint".

{% endnote %}

By default, documents stored in one [OneDrive personal folder]({{ link-sharepoint-personal }}) can only be accessed by their author. You can set up shared access to a document or your folder for other users.

If a number of documents should be accessible to a certain group of people, you can create a department site and [move documents](doc-access.md#move-doc) from your personal folder there.

To set up access permissions for a document or folder:

1. Find the relevant document or folder in SharePoint or your [OneDrive personal folder]({{ link-sharepoint-personal }}).

1. Hover over the document or folder, click ![](../../_assets/wiki/share-opt.png), and select **Manage Access**.

1. In the pane that opens, under **Direct Access**, enter the employee or group name and select a permission level: **Can edit** or **Can view**.

   To specify a department on Staff, enter the last part of a link to the department. For example, for the [<q>Documentation service</q>](https://staff.yandex-team.ru/departments/yandex_infra_tech_doc_dep78367), enter `yandex_infra_tech_doc_dep78367`.

   {% note alert %}

   If you need to grant folder or site access to a wide audience (one or more groups with a total count of more than 200–300 users), get approval from the Information Security service. To do this, send a request using this [form](https://forms.yandex-team.ru/surveys/106156/).
   Access permissions that are granted to a wide audience but are not authorized by the Information Security team are revoked automatically.

   {% endnote %}

1. Click **Grant Permissions**.

### Moving a document from your personal folder to a department's site {#move-doc}

By default, documents stored in one [OneDrive personal folder]({{ link-sharepoint-personal }}) can only be accessed by their author.

If your documents are intended for a wide audience, create a [Sharepoint site (section)](./create-sharepoint.md#shared-site) to store them.

If you store your documents in your OneDrive personal folder, move them to the department's site before you add them to {{ wiki-name }} Otherwise, in case of your dismissal or Office 365 license revocation, all the files in your personal folder are deleted.

To move a document:
1. Find the appropriate document in your [OneDrive personal folder]({{ link-sharepoint-personal }}).

1. Hover over the document, click ![](../../_assets/wiki/share-opt.png), and select **Move to**.

1. In the pane that opens, under **Places**, select **Yandex** → **Group site** → **Documents** and pick your department or project's folder. If it doesn't exist, create one.

1. Click **Move here**.

### Accessing a document via a link {#share-link}

If you want to allow other users to collaborate on your document in the Office 365 interface, you can grant access to it via a link.

{% note alert %}

You can't use this method to embed a document in {{ wiki-name }}.

{% endnote %}

1. Find the appropriate document on the department site or in your [OneDrive personal folder]({{ link-sharepoint-personal }}). Hover over the document and click ![](../../_assets/wiki/access.png).
   If the document is open, select **File** → **Share** → **Share** (in the PowerPoint menu: **File** → **Share** → **Share with people**).

1. To set up access permissions via a link, click **Anyone with the link can edit**.

1. To send the link by email, enter the usernames or email addresses and click **Send**.

1. To copy the link, click **Copy Link**.
