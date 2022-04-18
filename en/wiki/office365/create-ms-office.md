# Creating a Microsoft Office 365 document in {{wiki-name}}

To embed an Office 365 document on {{wiki-name}}, create a new **Word, Excel, or PowerPoint** page and link it to the document using one of the following methods:

* [Create a new Office 365 document in the {{wiki-name}} interface.](#new-from-wiki)

* [Provide a link to an existing document](#embed-existing) stored on the Sharepoint portal or in your personal OneDrive folder.

* [Upload the document from your computer in the {{wiki-name}} interface.](#import-doc)

By default, the embedded cloud document takes up the entire page, and no other content can be added to the page. If you need to, you can [embed another document on the page using iframe](embed-iframe.md).

## Create a new document from the {{wiki-name}} interface {#new-from-wiki}

Use the {{wiki-name}} interface to create a Word, Excel, or PowerPoint document on the Sharepoint portal and embed it on a new Wiki page.

1. In the top {{wiki-name}} menu, click **Create**.

1. Select the page type: **Word, Excel, or PowerPoint**.

1. Enter the page name and address in the same way as when [creating a Wiki page](../create-page.md).

1. Choose **Create a new Microsoft 365 document**.

1. Select the type of document you want to create.

1. Click **Create**. An empty document will be created on the Sharepoint portal and embedded on a new Wiki page.

1. To add content to the document, click [**Cloud editing**](co-edit.md#edit-button) on the Wiki page. The document will then open in Office 365 in a new browser tab.

1. To manage access permissions to your document, change the [Wiki page access settings](../page-management/access-setup.md). By default, the **Same as parent page** option is applied to new pages. For more information, see [Configure access to documents](doc-access.md).

{% note alert %}

If you aren't [logged in to the Office 365 portal](ms-office.md#office-login), you won't be able to view the created document. If you don't have an Office 365 license, send a request via this [form](https://help.yandex-team.ru/?form=soft).

{% endnote %}

## Embed an existing document on a new page {#embed-existing}

If you have documents stored in the Office 365 corporate cloud, you can embed those documents on Wiki pages. Documents to be viewed by a large audience should be stored on the [Sharepoint site]({{link-sharepoint-common}}) in your project or department folder.

{% note alert %}

If your documents are stored in a personal OneDrive folder, [transfer them to a shared site](doc-access.md#move-doc) before you embed them on {{wiki-name}}. Otherwise, the files in your personal folder will be deleted in case you leave the organization or your Office 365 license is revoked.

{% endnote %}

To embed a document on a new page:

1. Find the file on the [Sharepoint portal]({{link-sharepoint-common}}) or in your [personal OneDrive folder]({{link-sharepoint-personal}}) and make sure it can be accessed by the users you want to share the file with on {{wiki-name}}.
By default, any file stored on the common Sharepoint site can be accessed by all internal and external employees. For more information, see [Configure access to documents](doc-access.md).

1. Copy the link to the document or get the embed code.
    * Open the document in the browser and copy the link from the address bar.
    * Open the folder with the document on the [Sharepoint portal]({{link-sharepoint-common}}) or in your [personal section in OneDrive]({{link-sharepoint-personal}}). Hover your cursor over the document, click ![](../../_assets/wiki/share-opt.png), and choose **Copy link**.

   Via the link, the document will be embedded using the default parameters. To customize how your document appears on the page and configure other parameters, use the embed code.

   {% cut "How to get the embed code" %}
   
   1. Open the document.
   1. In the menu, select **File** → **Share** → **Embed** (in PowerPoint, **File** → **Shared access** → **Embed**).
   1. Configure embedding parameters for the document.
   1. Copy the text from the **Embed code** field.

   {% endcut %}

1. In the top {{wiki-name}} menu, click **Create**.

1. Select the page type: **Word, Excel, or PowerPoint**.

1. Just like you do when creating a Wiki page, enter the page name and choose the cluster where the page will be stored.

1. Choose **Add an existing Microsoft 365 document**.

1. Insert the embed code or a link to the document in the **Document code** field.

1. Click **Create**.

   The document will be embedded on the Wiki page you've created.

{% note alert %}

If the document was created in the Sharepoint interface, the access settings of its parent Wiki page will not apply to the document. You can only manage access to such documents in the Sharepoint interface. For more information, see [Configure access to documents](doc-access.md).

{% endnote %}

## Create a page from a local document {#import-doc}

Upload a DOCX, XLSX, or PPTX file from the {{wiki-name}} interface to the Sharepoint portal and embed the file on a new Wiki page.

1. In the top {{wiki-name}} menu, click **Create**.

1. Select the page type: **Word, Excel, or PowerPoint**.

1. Just like you do when creating a Wiki page, enter the page name and choose the cluster where the page will be stored.

1. Choose **Upload a document from your computer**.

1. Click **Upload a file** and select the document you want to embed on the Wiki page.

1. Click **Create**.
The selected file will be uploaded to the Sharepoint portal through a robot account and embedded on the Wiki page you've created.

1. To manage access permissions to your document, change the [Wiki page access settings](../page-management/access-setup.md). By default, the **Same as parent page** option is applied to new pages. For more information, see [Configure access to documents](doc-access.md).

{% note alert %}

If you aren't [logged in to the Office 365 portal](ms-office.md#office-login), you won't be able to view the created document. If you don't have an Office 365 license, send a request via this [form](https://help.yandex-team.ru/?form=soft).

{% endnote %}

