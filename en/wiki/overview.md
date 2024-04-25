# {{ wiki-name }} overview

{{ wiki-full-name }} is a service to create a corporate knowledge base for company employees to populate and update.

On {{ wiki-name }} pages, you can store information that employees need for work: memos, useful links and contacts, instructions, project documentation, and personal notes. {{ wiki-name }} gives company employees additional capabilities for collaboration: they can share information, search for answers to frequently asked questions, and hold discussions in the page comment section.



## Access to {{ wiki-full-name }} {#access}

Users registered in [{{ org-full-name }}](../organization/) can work in {{ wiki-full-name }}. An organization's own knowledge base is created in {{ wiki-full-name }}, which is only accessible to its employees. To learn how to enable {{ wiki-full-name }}, see [{#T}](enable-wiki.md).

To access {{ wiki-name }}, [log in to the account](login.md) you use to work in your organization.

If a company has a system for user and access management (such as Active Directory or Google Workspace), employees can use their corporate accounts to log in to the organization in {{ yandex-cloud }} and get access to {{ wiki-name }} using a Single Sign-On (SSO) system. To do this, the administrator of the organization needs to set up an identity federation. Read more in the {{ org-full-name }} documentation under [{#T}](../organization/concepts/add-federation.md).


## {{ wiki-full-name }} features {#features}

- [Create pages and clusters](quick-guide.md) with text, images, tables, and links.
   The maximum number of pages per organization is 10,000.

- Format your pages in the [new editor](pages-types.md#new-editor) with visual markup tools or in the old editor using the [Markdown](static-markup.md) markup. The new editor also allows you to enable Markdown as an additional feature.

- [Attach files](attach-file.md) to a page.
   The maximum total size of all files per organization is 5 GB. You can increase your file storage size by [creating](../storage/operations/buckets/create.md) and connecting your own {{ objstorage-full-name }}. To connect your storage to {{ wiki-name }}, contact our [support](feedback.md) and provide [details of the service account](../iam/operations/sa/create-access-key.md) with access to the object storage you created.

- Track user edits to pages in the [history of changes](history.md). You can compare two versions of a page or restore a version from the history.

- [Arrange](structure.md) information in {{ wiki-name }} by creating a page tree and linking pages with cross-references.

- To quickly find information in {{ wiki-name }}, use the [search](search.md), subscribe to pages, and add them to your [favorites](notifications.md).

- Configure [access to pages](page-management/access-setup.md): you can make a page accessible to all or some employees, restrict editing, or prohibit viewing a page.

- Integrate {{ wiki-name }} with {{ tracker-full-name }} and {{ forms-full-name }} to add:

   * [Lists of issues from {{ tracker-full-name }}](actions/tracker.md).

   * [Surveys and request forms from {{ forms-full-name }}](actions/forms.md).


## {{ wiki-name }} home page {#main-page}

It is a home page of your {{ wiki-name }}, and a root page for any other page. You can edit the {{ wiki-name }} [home page]({{ link-wiki }}) just like any other page.

{% note info %}

By default, the author of the {{ wiki-name }} home page is a service account. If the **Only authors** access type is selected for this page, other users cannot access it. To allow others to access the page, click the [{{ link-homepage-access }}]({{ link-homepage-access }}) link and change the access parameters.

{% endnote %}

