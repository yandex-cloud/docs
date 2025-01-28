# Identity federations

Using [{{ org-full-name }}](../../organization/), you can configure Single Sign-On authentication in {{ yandex-cloud }} through your Identity Provider, such as Active Directory or Google Workspace. 

This authentication approach is called an identity federation: company employees use their corporate accounts and only authenticate in the corporate authentication system. To access resources in {{ yandex-cloud }}, they don't need Yandex ID accounts.

For operations within an identity federation, the Identity Provider must support the SAML 2.0 standard.

## What's next {#what-is-next}

* Learn how to [add a user](../operations/users/create.md#add-user-sso) from an identity federation.
* Learn about setting up an identity federation in the [{{ org-full-name }}](../../organization/concepts/add-federation.md) documentation.
