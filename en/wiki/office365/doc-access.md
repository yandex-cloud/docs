# Configuring access to cloud documents

Access to a cloud document is configured depending on the way it was created:

* Use the Wiki page access settings if you created a new cloud document or uploaded a file via the {{wiki-name}} interface.

* Use the Sharepoint access settings if you created a document through the Office 365 interface and then embedded it in a Wiki page.

## Managing access via a Wiki page {#wiki-access}

If you created a new cloud document or uploaded a file through the {{wiki-name}} interface, to change the document access rights, use the Wiki page settings: click the access setup button at the top of the page and select [access mode](../page-management/access-setup.md).

Users who have limited access to the Wiki page won't be able to read and edit the embedded document through the {{wiki-name}} interface.

{% note alert %}

The access rights configured in {{wiki-name}} are synced with the access rights on the Office 365 portal. If you configure access rights via the Sharepoint interface, they will be overwritten by the Wiki page settings when syncing them.

{% endnote %}

## Managing access through the Office 365 interface {#access-list}

If you created documents through the Office 365 portal interface and want to [embed them in Wiki pages](create-ms-office.md#embed-existing), configure access rights to the documents or folders storing them. Otherwise, the documents may be unavailable to {{wiki-name}} users.

{% note alert %}

Wiki page access settings do not apply to documents created through the Office 365 portal interface.
When embedding such a document in a Wiki page, a warning saying "Access to this document was configured by the author on the Sharepoint portal" appears.

{% endnote %}

By default, documents that are stored in one's [OneDrive personal folder]({{link-sharepoint-personal}}) are only available to the author. Documents that are stored on a [Sharepoint shared site]({{link-sharepoint-common}}) are available to all Yandex full-timers and contractors. To share a document, you can [move it to a shared site](doc-access.md#move-doc).

To configure access rights for a document or folder:

1. Find the desired document or folder on the [Sharepoint portal]({{link-sharepoint-common}}) or in your [OneDrive personal folder]({{link-sharepoint-personal}}).

1. Hover over the document or folder, click ![](../../_assets/wiki/share-opt.png), and select **Access management**.

1. In the panel that opens, under **Direct access**, enter the name of an employee or the name of a group and set the access level: **Can edit** or **Can view**.

   To specify a Staff department, enter the last part of the department link. For example, for the [<q>Documentation service</q>](https://staff.yandex-team.ru/departments/yandex_infra_tech_doc_dep78367), specify `yandex_infra_tech_doc_dep78367`.

   {% note alert %}

   If you need to grant permissions to access a folder or website to a wide range of users (one or more groups totaling more than 200-300 people), get the approval of the Information Security service. To do this, submit a request via the [form](https://forms.yandex-team.ru/surveys/106156/).
Access rights granted to a wide audience without being authorized by the Information Security Service are revoked automatically.

   {% endnote %}

1. Click **Grant access**.

### Moving a document from a personal folder to a shared website {#move-doc}

By default, documents that are stored in one's [OneDrive personal folder]({{link-sharepoint-personal}}) are only available to the author.

If your documents are intended for a wide audience, store them on a[Sharepoint shared website]({{link-sharepoint-common}}). You can create a folder for your project or department there and store work materials to be shared in it. To maintain order in the repository, don't store your documents in the root directory.

If your documents are stored in the OneDrive personal folder, move them to a shared website before embedding them in {{wiki-name}}. Otherwise, in case of your dismissal or revocation of the Office 365 license, all files in your personal folder are deleted.

To move a document:

1. Find the desired document in your [OneDrive personal folder]({{link-sharepoint-personal}}).

1. Hover over the document, click ![](../../_assets/wiki/share-opt.png), and select **Move**.

1. In the panel that opens, under **Location**, select **Yandex** → **Group site** → **Documents** and choose your department or project folder. If there is no such folder, you can create one.

1. Click **Move here**.

### Accessing a document via a link {#share-link}

If you want other users to work with a document in the Office 365 interface, you can enable access to the document via a link.

{% note alert %}

This method doesn't work for embedding a document in {{wiki-name}}.

{% endnote %}

1. Find the desired document [on the Sharepoint portal]({{link-sharepoint-common}}) or in your [OneDrive personal folder]({{link-sharepoint-personal}}). Hover over the document and click ![](../../_assets/wiki/access.png).
If the document is open, select **File** → **Share** → **Share** (in the PowerPoint menu: **File** → **Share** → **Share with people**).

1. To set up access with the link, click **People you specify can edit**.

1. To send the link by email, enter the usernames or email addresses and click **Send**.

1. To copy the link, click **Copy link**.

