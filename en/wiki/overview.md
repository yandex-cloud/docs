# {{ wiki-name }} overview

{{ wiki-full-name }} is a service to create a corporate knowledge base for company employees to populate and update.

On {{ wiki-name }} pages, you can store information that employees need for work: memos, useful links and contacts, instructions, project documentation, and personal notes. {{ wiki-name }} gives company employees additional capabilities for collaboration: they can share information, search for answers to frequently asked questions, and hold discussions in the page comment section.



## Access to {{ wiki-full-name }} {#access}

Users registered in [{{ org-full-name }}](../organization/) can work in {{ wiki-full-name }}. An organization's own knowledge base is created in {{ wiki-full-name }}, which is only accessible to its employees. To learn how to enable {{ wiki-full-name }}, see [{#T}](enable-wiki.md).

To access {{ wiki-name }}, [log in to the account](login.md) you use to work in your organization.

If a company has a system for user and access management (such as Active Directory or Google Workspace), employees can use their corporate accounts to log in to the organization in {{ yandex-cloud }} and get access to {{ wiki-name }} using a Single Sign-On (SSO) system. To do this, the administrator of the organization needs to set up an identity federation. Read more in the {{ org-full-name }} documentation under [{#T}](../organization/add-federation.md).


## {{ wiki-full-name }} Features {#features}

- [Create pages and clusters](quick-guide.md) with text, images, tables, and links.
   The maximum number of pages per organization is 10,000.

- Format your pages in the [new editor](./wysiwyg-create.md) with visual markup tools or in the old editor using the [Markdown](static-markup.md) markup. The new editor also allows you to enable Markdown as an additional feature.

- [Attach files](attach-file.md) to a page.
   The maximum total size of all files per organization is 5 GB.

- Track user edits to pages in the [history of changes](history.md). You can compare two versions of a page or restore a version from the history.

- [Structure](structure.md) information in {{ wiki-name }} by creating a page tree and linking the pages with cross-references.

- To quickly find information on {{ wiki-name }}, use the [search](search.md), subscribe to pages, and add them to your [favorites](notifications.md).

- Configure [access rights to pages](page-management/access-setup.md): you can make a page accessible to all or some employees, restrict editing, or prohibit viewing a page.

- Integrate {{ wiki-name }} with {{ tracker-full-name }} and {{ forms-full-name }} to add:

   * [Lists of issues from {{ tracker-full-name }}](actions/tracker.md).

   * [Surveys and request forms from {{ forms-full-name }}](actions/forms.md).

