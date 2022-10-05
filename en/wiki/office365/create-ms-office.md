# Creating a Microsoft Office 365 document in {{wiki-name}}

To embed an MS Office 365 document in {{wiki-name}}, create a new **Word, Excel, or PowerPoint** page and link it to the document in one of the following ways:

* [Create a new Office 365 document through the {{wiki-name}} interface.](#new-from-wiki)

* [Provide a link to an existing document](#embed-existing) that is saved on Sharepoint or in your OneDrive personal folder.

* [Upload a document from your PC using the {{wiki-name}} interface.](#import-doc)

By default, an embedded cloud document occupies the entire page and no other content can be added to it. If you need to add it, you can [embed a document in a page using an iframe](embed-iframe.md).

## Creating a new document from the {{wiki-name}} interface {#new-from-wiki}

Using the {{wiki-name}} interface, you can create a Word, Excel, or PowerPoint document on Sharepoint and embed it in a new Wiki page.

1. Click {{wiki-name}} **Create** in the upper panel.

1. Select the **Word, Excel, or PowerPoint** page type.

1. Set the page title and address in the same way as when [creating a regular Wiki page](../create-page.md).

1. Choose **Create a new Microsoft 365 document**.

1. Select the type of document to create.

1. Click **Create**. As a result, an empty document is created on Sharepoint and embedded in a new Wiki page.

1. To add content to the document, click [**Edit in cloud**](co-edit.md#edit-button) on the Wiki page. The document opens in a new browser tab in the Office 365 application.

1. To control access to the document, edit the [Wiki page access settings](../page-management/access-setup.md). By default, the **Like the parent page** option applies to a new page. Learn more in [Configuring access to documents](doc-access.md).

{% note alert %}

To view the document you created, be sure to [log in to Office 365](ms-office.md#office-login). If you don't have an MS Office 365 license, submit a request using the [form](https://help.yandex-team.ru/?form=soft).

{% endnote %}

## Embedding an existing document in a new page {#embed-existing}

If you have documents that you store in the Office 365 corporate cloud, you can embed them in Wiki pages. Documents intended for a wide audience should be stored on a [Sharepoint shared website]({{link-sharepoint-common}}) in your project or department folder.

{% note alert %}

If your documents are stored in your OneDrive personal folder, before embedding them in {{wiki-name}}, [move them to a shared website](doc-access.md#move-doc). Otherwise, in case of your dismissal or revocation of the Office 365 license, all files in your personal folder are deleted.

{% endnote %}

To embed a document in a new page:

1. Find the file on the [Sharepoint portal]({{link-sharepoint-common}}) or in your [OneDrive personal folder]({{link-sharepoint-personal}}) and make sure that you granted access to it to the users you want to share the file with in {{wiki-name}}.

If the file is stored on a Sharepoint shared website, it's available to all full-time and freelance employees by default. Learn more in [Configuring access to documents](doc-access.md).

1. Copy the link to the document or get the embed code.
    * Open the document in your browser and copy the link from the address bar.
    * Open the document folder on the [Sharepoint portal]({{link-sharepoint-common}}) or in your [OneDrive personal cluster]({{link-sharepoint-personal}}). Hover over the document, click ![](../../_assets/wiki/share-opt.png), and select **Copy link**.

   Via the link, the document is embedded with default parameters. To customize the appearance of the document on the page and other parameters, use the embed code.

   {% cut "How to get the embed code" %}
   1. Open the document.
   1. Select **File** → **Share** → **Embed** (in the PowerPoint menu: **File** → **Share** → **Embed**).
   1. Configure the document embed parameters.
   1. Copy text from the **Embed Code** field.

   {% endcut %}

1. Click {{wiki-name}} **Create** in the upper panel.

1. Select the **Word, Excel, or PowerPoint** page type.

1. Just like when creating a Wiki page, name the page and choose the cluster to place it in.

1. Choose **Add an existing Microsoft 365 document**.

1. In the **Document code** field, paste the embed code or document link.

1. Click **Create**.

   This embeds the document in the Wiki page you created.

{% note alert %}

If the document was created through the Sharepoint interface, the access settings of the Wiki page the document is embedded in do not apply to it. You can only manage access to these documents through the Sharepoint interface. Learn more in [Configuring access to documents](doc-access.md).

{% endnote %}

## Creating a page from a local document {#import-doc}

Using the {{wiki-name}} interface, you can upload a DOCX, XLSX, or PPTX document to Sharepoint and embed it in a new Wiki page.

1. Click {{wiki-name}} **Create** in the upper panel.

1. Select the **Word, Excel, or PowerPoint** page type.

1. Just like when creating a Wiki page, name the page and choose the cluster to place it in.

1. Choose **Upload documents from your computer**.

1. Click **Upload file**and select the document to embed in the Wiki page.

1. Click **Create**.
As a result, the selected file is uploaded to Sharepoint by a robot and embedded in the created Wiki page.

1. To control access to the document, edit the [Wiki page access settings](../page-management/access-setup.md). By default, the **Like the parent page** option applies to a new page. Learn more in [Configuring access to documents](doc-access.md).

{% note alert %}

To view the document you created, be sure to [log in to Office 365](ms-office.md#office-login). If you don't have an MS Office 365 license, submit a request using the [form](https://help.yandex-team.ru/?form=soft).

{% endnote %}

