# SAML-compatible identity federations

{{ yandex-cloud }} supports [SAML 2.0](https://wiki.oasis-open.org/security/saml/)-based identity federations. This is a popular markup language to enable Single Sign-On (SSO), a technology that lets users access multiple apps without having to enter their username and password every time. For example, whenever you visit a website and see the _Sign in with Yandex_, _Google_ or _Facebook_ buttons, these are examples of the Single Sign-On system at work.

This approach is called _identity federation_, it's when all the information about usernames and passwords is stored by a trusted _Identity Provider (IdP)_. While a service provider (SP), such {{ yandex-cloud }}, sends users to the identity provider's (IdP's) server for authentication.

If your company has a user and access management system (for example, Active Directory or Google Workspace), you can use it to authorize employees in {{ org-full-name }}. In this case, you don't need to create a new Yandex account for every company employee. They can get access to {{ yandex-cloud }} services using their corporate accounts.

## Configuring up federations in {{ org-full-name }} {#federation-usage}

Using identity federations, you can configure a Single Sign-On system (Single Sign-On, SSO) and use corporate accounts to authorize in {{ org-name }}. In this case, your corporate account management system acts as an identity provider (IdP).

In {{ org-name }}, you can create an identity federation with any credential management service (identity provider) that supports the [SAML]({{ link-saml }}) protocol.

Information about user logins and passwords is stored by the identity provider. When a user logs in to {{org-name}}, they're directed to the identity provider (IdP) server for authentication. If authentication is successful, the user gets access to {{ yandex-cloud }} services.

Since authentication takes place on the IdP server's side, you can configure a more secure user data verification, such as two-factor authentication or USB tokens.

You can set up identity federations for different identity providers:

* [Active Directory](operations/federations/integration-adfs.md).
* [Google Workspace](operations/federations/integration-gworkspace.md).
* [Azure Active Directory](operations/federations/integration-azure.md).
* [Keycloak](operations/federations/integration-keycloak.md).
* [Other SAML-compatible identity providers](operations/federations/integration-common.md).

## Authenticating in a federation {#saml-authentication}

{% include [federated-user-auth](../_includes/iam/federated-user-auth.md) %}


The authentication process is shown in the diagram:

![image](../_assets/iam/federations/saml-authentication.svg)

1. The user opens a console login link in the browser.

1. If this is the first time the user authenticates, the console redirects them to the IdP server for authentication.

   If the user was already authenticated, this information is saved in the browser cookie. If the cookie is still valid, the management console authenticates the user immediately and redirects them to the home page. The cookie lifetime is specified when the federation is created.

   If the cookie expires, the console forwards the user to the IdP server for re-authentication.

1. The IdP server shows the authentication page to the user. For example, it prompts them to enter their username and password.

1. The user enters the data required for authentication on the IdP server.

1. If authentication is successful, the IdP server sends the user's browser back to the management console login page.

1. The management console asks IAM whether this user is added to the cloud. If the user is added, the management console authenticates the user and redirects them to the home page.
