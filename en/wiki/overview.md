# Service overview

{{ wiki-full-name }} is a service for creating a corporate knowledge base, which is maintained and updated by users — the organization employees.

{{ wiki-name}} can be used to store any information that the organization employees may need in their work: memos, useful links and contacts, work instructions, project documentation, and personal notes. {{ wiki-name }} provides employees with additional opportunities for collaboration: they can share information, search for answers to frequently asked questions, and discuss tasks in page comments.



## Access to {{ wiki-full-name }} {#access}

{{ wiki-full-name }} can be accessed by organization employees registered on [{{ org-full-name }}](../organization/index.yaml). Each organization has its own knowledge base on {{ wiki-full-name }}, which can only be accessed by the organization employees. To learn more about setting up {{ wiki-full-name }}, read [{#T}](enable-wiki.md).

To access {{ wiki-name }}, [log in to your corporate account](login.md).

If the organization has a user and access management system (such as Active Directory or Google Workspace), employees can use their corporate accounts to log in to the {{ yandex-cloud }} organization and access {{ wiki-name }} through a Single Sign-On (SSO) system. To do this, the organization admin needs to configure identity federation. Read more in the {{ org-full-name }} documentation in the [{#T}](../organization/add-federation.md) section.


## Features {{ wiki-full-name }} {#features}

- [Create Wiki pages](quick-guide.md) with text, images, tables, and links.

- Use the [Markdown markup](static-markup.md) for text formatting: you can highlight text fragments, add titles, lists, quotes, and other elements.

- Use [edit history](history.md) to track user changes to Wiki pages. You can compare two page versions or restore a previous version from the edit history.

- To structure information on {{wiki-name}}, create cluster trees and link pages with cross-links. Learn more in [{#T}](structure.md).

- To quickly find information on {{ wiki-name }}, use the [search](search.md), subscribe to pages, and add them to [favorites](notifications.md).

- Configure [page access rights](page-management/access-setup.md): you can open the page for all or some employees, restrict editing access, or prohibit users from viewing the page.

- Use {{ wiki-name }} integration with {{ tracker-full-name }} and {{ forms-full-name }}:

  * [Adding an issue list to a page from {{ tracker-full-name }}](actions/tracker.md).

  * [Embedding a form on a page](actions/forms.md).

  * [Saving responses from the {{ forms-full-name }} form](../forms/send-wiki.md) on a Wiki page.

