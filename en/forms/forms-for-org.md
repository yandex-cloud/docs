# {{ forms-full-name }} for business

Employees of companies can use forms in their work: accept orders or requests and conduct surveys among their colleagues or clients.

Users of organizations registered on {{ yandex-cloud }} enjoy advanced features of {{ forms-full-name }} for collaboration.

## Access to forms for business {#org-access}

- You can enable {{ forms-full-name }} for business for an existing organization or create a new one. For more information about how to connect to {{ forms-full-name }} for business, see [{#T}](enable-forms.md).

   Read more about managing organizations in the [{{ org-full-name }} documentation](../organization/).

- Access to forms for business can be granted to the users of an organization registered in {{ org-full-name }}.

   If a company has a system for user and access management (such as Active Directory or Google Workspace), employees can use their corporate accounts to log in to the {{ yandex-cloud }} organization and get access to forms using a Single Sign-On (SSO) system. To do this, the administrator of the organization needs to set up an identity federation.

   For more information, see the [{{ org-full-name }}documentation](../organization/add-federation.md).

- To create and edit forms for business, go to[{{ link-forms-b2b }}]({{ link-forms-b2b }}) and [log in to your corporate account](login.md).

   If you're registered in several organizations, you can see which organization each of the forms belongs to in the list of forms.


## Features {{ forms-full-name }} for business {#business-features}

Corporate users have access to advanced functions:

- Integration with [{{ tracker-name }}](create-task.md) and [{{ wiki-name }}](send-wiki.md) services.

- [Shared access to form editing](forms-settings.md#access) for the organization employees.

- You can [allow access to filling out the form](restrictions.md#sec_access) for the organization employees only.

- You can [create groups of forms](forms-settings.md#sec_groups).

- Prompts only available in forms for business: [People](blocks-ref/people.md), [Departments](blocks-ref/departments.md), [Teams](blocks-ref/teams.md), and [Wiki](blocks-ref/wiki.md).