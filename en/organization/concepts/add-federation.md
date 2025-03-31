# SAML-compatible identity federations

{{ yandex-cloud }} supports [SAML 2.0](https://wiki.oasis-open.org/security)-based identity federations. This is a popular markup language to enable Single Sign-On (SSO), a technology that allows users to access multiple apps without having to enter their username and password every time. For example, whenever you visit a website and see the _Sign in with Yandex_, _Google_, or _Facebook_ buttons, all these are examples of the single sign-on system at work.

This technology is called _identity federation_, which implies storing all usernames and passwords with a trusted _Identity Provider (IdP)_. While a service provider (SP), e.g., {{ yandex-cloud }}, refers users to the identity provider's (IdP's) server for authentication.

If your company has a user and access management system (e.g., Active Directory or Google Workspace), you can use it to authenticate employees in {{ org-full-name }}. In which case you do not need to create a new Yandex account for every employee. They can get access to {{ yandex-cloud }} services using their corporate accounts.

## Configuring federations in {{ org-full-name }} {#federation-usage}

Using identity federations, you can configure a single sign-on (SSO) system and use corporate accounts for authentication in {{ org-name }}. In this case, your corporate account management system acts as an identity provider (IdP).

In {{ org-name }}, you can create an identity federation with any credential management service (identity provider) that supports the [SAML]({{ link-saml }}) protocol.

Information about user logins and passwords is stored by the identity provider. When a user logs in to {{ org-name }}, they are directed to the identity provider (IdP) server for authentication. If authentication is successful, the user gets access to {{ yandex-cloud }} services.

Since authentication takes place on the IdP server side, you can configure a more secure user data verification, such as two-factor authentication or USB tokens.

You can set up identity federations for different identity providers:

* [Active Directory](../tutorials/federations/integration-adfs.md).
* [Google Workspace](../tutorials/federations/integration-gworkspace.md).
* [{{ microsoft-idp.entra-id-full }}](../tutorials/federations/integration-azure.md).
* [Keycloak](../tutorials/federations/integration-keycloak.md).
* [Other SAML-compatible identity providers](../operations/setup-federation.md).

### Signing authentication requests {#encrypted-assertions}

You can enable signing authentication requests with a digital signature for additional security. You need to additionally set up a relying party trust between your {{ org-name }} identity federation and your identity provider (IdP).

#### Setting up a relying party trust between an identity federation and an IdP {#build-trust}

You set up a relying party trust between an {{ org-name }} identity federation and an identity provider in two steps:

* Setting up a relying party trust on the identity federation side.

    When informing {{ org-name }} that a user has been authenticated, the identity provider signs the message with its own certificate. For {{ org-name }} to verify the signature, download and [add](../operations/setup-federation.md#add-certificate-fed) the certificate to your identity federation.

    {% include [federation-certificates-note](../../_includes/organization/federation-certificates-note.md) %}

* Setting up a relying party trust on the IdP server side.

    When the {{ org-name }} identity federation sends a request to the identity provider, it signs such requests with a {{ yandex-cloud }} SAML certificate. For the identity provider to be able to verify the signature, download and add a {{ yandex-cloud }} SAML certificate to your IdP server.

    A {{ yandex-cloud }} SAML certificate is valid for 5 years. You can view the certificate expiration date when creating an identity federation or updating its settings.

    {{ yandex-cloud }} generates a new SAML certificate automatically before the previous certificate's expiration date. Make sure to [start](../operations/renew-yc-certificate.md) using the new SAML certificate before the previous one expires.

### User group mapping {#group-mapping}

{% include notitle [preview](../../_includes/note-preview-by-request.md) %}

In [organizations](organization.md) with many [users](membership.md), you may need to issue the same access permissions for {{ yandex-cloud }} resources to more than one user. In which case it is easier to issue roles and permissions to [groups](groups.md) rather than individual users.

If you have configured user groups in your identity provider or plan to do so, [set up user group mapping](../operations/federation-group-mapping.md) between the identity provider and {{ org-name }}. Users in the identity provider's groups will be granted the same access permissions to {{ yandex-cloud }} resources as their respective groups in {{ org-name }}.

## Authenticating in a federation {#saml-authentication}

{% include [federated-user-auth](../../_includes/iam/federated-user-auth.md) %}

The authentication process is shown in the diagram:

![image](../../_assets/iam/federations/saml-authentication.svg)

1. The user opens a console login link in the browser.

1. If this is the first time the user authenticates, the console redirects them to the IdP server for authentication.

    If the user was already authenticated, this information is saved in the browser cookie. If the cookie is still valid, the management console authenticates the user immediately and redirects them to the home page. The cookie lifetime is specified when the federation is created.

    If the cookie expires, the console forwards the user to the IdP server for re-authentication.

    You can also require re-authentication in the federation settings. When this option is enabled, the IdP will reauthenticate the user when the session expires in {{ yandex-cloud }}.

1. The IdP server shows the authentication page to the user. For example, it prompts them to enter their username and password.

1. The user enters the data required for authentication on the IdP server.

1. If authentication is successful, the IdP server sends the user's browser back to the management console login page.

1. The management console asks IAM whether this user is added to the cloud. If the user is added, the management console authenticates the user and redirects them to the home page.

{% note info %}

In an identity federation, the user interacts both with the IdP and the {{ yandex-cloud }} management console. This does not require network access between the IdP and {{ yandex-cloud }}.

{% endnote %}

