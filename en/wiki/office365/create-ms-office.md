# Creating Microsoft Office 365 documents in {{ wiki-name }}

To embed an Office 365 document in {{ wiki-name }}, create a new page of the **Word, Excel, PowerPoint** type and link it to the document in one of the following ways:

* [Create a new Office 365 document using the {{ wiki-name }} interface.](#new-from-wiki)

* [Specify a link to an existing document](#embed-existing) that is stored in SharePoint or your OneDrive personal folder.

* [Upload a document from your PC using the {{ wiki-name }} interface.](#import-doc)

By default, an embedded cloud document takes the entire page, so you can't add any other content to it. However, you can [embed a document in your page using an iframe](embed-iframe.md) if you need to add more content.

## Creating a new document from the {{ wiki-name }} interface {#new-from-wiki}

Using the {{ wiki-name }} interface, you can create a Word, Excel, or PowerPoint document in SharePoint and add it to a new Wiki page.

1. On the top panel in {{ wiki-name }} click **Create**.

1. Select the **Word, Excel, PowerPoint** page type.

1. Set the page title and address in the same way as when [creating a regular Wiki page](../create-page.md).

1. Select the **Create a new Microsoft 365 document** method.

1. Select the type of the document to create.

1. Click **Create**. As a result, an empty document is created in SharePoint and embedded in the new Wiki page.

1. To add content to the document, click [**Edit in cloud**](co-edit.md#edit-button) on the Wiki page. The document opens in a new browser tab in the Office 365 app.

1. To manage access to the document, change the [Wiki page access settings](../page-management/access-setup.md). By default, the **Same as parent page** access level applies to a new page. For more information, see [Configuring access to documents](doc-access.md).

{% note alert %}

If you aren't [signed in to Office 365](ms-office.md#office-login), you can't view the created document. If you don't have an Office 365 license, send a request via the [form](https://help.yandex-team.ru/?form=soft).

{% endnote %}

## Embedding an existing document in a new page {#embed-existing}

If you have documents in the Office 365 corporate cloud storage, you can embed them in Wiki pages. Documents intended for a wide audience should be stored in your [project or department's site](./create-sharepoint.md#shared-site).

{% note alert %}

If you store your documents in your OneDrive personal folder, move them to the department's site before you add them to {{ wiki-name }} Otherwise, in case of your dismissal or Office 365 license revocation, all the files in your personal folder are deleted.

{% endnote %}

To embed a document in a new page:

1. Find the desired file in [SharePoint]({{ link-sharepoint-common }}) or [your OneDrive personal folder]({{ link-sharepoint-personal }}) and make sure that the users you want to share the file with on {{ wiki-name }} are allowed to access it.

1. Copy a link to the document and get the embed code.
   * Open the document in your browser and copy the link from the address bar.
   * Open the folder with the document in [SharePoint]({{ link-sharepoint-common }}) or [your OneDrive personal area]({{ link-sharepoint-personal }}). Hover over the document, click ![](../../_assets/wiki/share-opt.png), and select **Copy Link**.

   The document is embedded via the link with the default parameters. To customize the document's appearance on your page and other parameters, use the embed code.

   {% cut "How to get the embed code" %}

   1. Open the document.
   1. Select **File** → **Share** → **Embed** (for a presentation in PowerPoint, **File** → **Share** → **Embed**).
   1. Set the document embed parameters.
   1. Copy the text from the **Embed Code** field.

   {% endcut %}

1. On the top panel in {{ wiki-name }} click **Create**.

1. Select the **Word, Excel, PowerPoint** page type.

1. Just like when creating a regular Wiki page, enter a name and select the cluster to place the page in.

1. Select the **Add an existing Microsoft 365 document** method.

1. In the **Document code** field, enter the embed code or document link.

1. Click **Create**.

   This embeds the document in the created Wiki page.

{% note alert %}

If you created your document through the SharePoint interface, the access settings of the page it's added to don't apply to it. You can only manage access to documents like this in the SharePoint interface. For more information, see [Configuring access to documents](doc-access.md).

{% endnote %}

## Creating a page from a local document {#import-doc}

You can use the {{ wiki-name }} interface to upload a DOCX, XLSX, or PPTX file to SharePoint and embed it in a new Wiki page.

1. On the top panel in {{ wiki-name }} click **Create**.

1. Select the **Word, Excel, PowerPoint** page type.

1. Just like when creating a regular Wiki page, enter a name and select the cluster to place the page in.

1. Select the **Upload documents from your computer** method.

1. Click **Upload file** and pick the document to be added to the Wiki page.

1. Click **Create**.
   As a result, the selected file is uploaded to SharePoint as a robot and embedded into the created Wiki page.

1. To manage access to the document, change the [Wiki page access settings](../page-management/access-setup.md). By default, the **Same as parent page** access level applies to a new page. For more information, see [Configuring access to documents](doc-access.md).

{% note alert %}

If you aren't [signed in to Office 365](ms-office.md#office-login), you can't view the created document. If you don't have an Office 365 license, send a request via the [form](https://help.yandex-team.ru/?form=soft).

{% endnote %}
