# Co-editing documents

Office 365 allows co-editing Word, Excel, and PowerPoint documents: multiple users can edit a document at the same time and save their changes. This feature also works for cloud documents embedded in Wiki pages: when editing a cloud document, it opens in the Office 365 application and you can edit it simultaneously with other users.

## Editing a document embedded in a Wiki page {#edit-button}

To edit an Office 365 document embedded in a Wiki page, click  **Edit in cloud** in the upper-right corner. The document opens in a new tab in the Office 365 application.

If you have no permission to edit the document, you'll see a message saying "You do not have access to this page". To request permission to access the document from its author, write a message and click **Access request**.

{% note alert %}

To edit documents, be sure to [log in to office.com](ms-office.md#office-login). If you don't have an MS Office 365 license, submit a request using the [form](https://help.yandex-team.ru/?form=soft).

{% endnote %}

### Switching to document co-editing using {{wiki-name}} {#shared-edit}

When preparing a document, it's often necessary to be able to make edits simultaneously or receive comments from multiple colleagues.

Previously, you would send a document to each other by email and then merge the edits made in multiple versions of the document. Or create a page in {{wiki-name}} and make changes one by one.

Now you can embed cloud documents in {{wiki-name}} and edit them simultaneously with your colleagues:

* If you already have Office 365 documents that you're editing together with your colleagues, you can continue doing that in {{wiki-name}}. Just create a **Word, Excel, or PowerPoint** page and [import your file](create-ms-office.md#import-doc).

* If you're co-editing a {{wiki-name}} page with your colleagues, [create a new cloud document](create-ms-office.md#new-from-wiki) and copy the page text there.

### Co-editing documents together with external users {#shared-edit-ext}

If you often need to collaborate on documents with your contractors who are not Yandex employees, you can grant them permission to co-edit documents in Office 365. Since external users' access to a Sharepoint shared website is prohibited by security policies, you need to create a separate website (cluster) in Sharepoint that can be accessed from outside the company.

To do this:

1. Send an email to `help@yandex-team.ru` and request that a new Sharepoint website be created for your team or department, where you can share documents with external users. In your email, explain why you need this.

1. Once HelpDesk employees create a website for you, you'll be able to [create new documents on it](create-sharepoint.md#create-sharepoint) or [move existing documents](doc-access.md#move-doc) from other Sharepoint clusters to it.

1. To invite external users to co-edit a document:
   1. Find the desired document on your Sharepoint website that external users are allowed to access.
   1. Hover over the document, click ![](../../_assets/wiki/share-opt.png), and select **Access management**.
   1. In the panel that opens, under **Direct access**, enter the email address of the external user to grant document access to and select the **Can edit** access level.
   1. Click **Grant access**.
   1. An email with a link is sent to the specified user's email address. Once the user clicks the link, an email is sent to them containing the code to be entered to access the document.

