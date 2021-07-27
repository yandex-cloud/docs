---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# SAML-compatible identity federations

Yandex.Cloud supports [SAML 2.0](https://wiki.oasis-open.org/security)-based identity federations. This is a popular markup language to enable Single Sign-On (SSO), a technology that lets users access multiple apps without having to enter their username and password every time. For example, whenever you visit a site and see the _Sign in with Yandex_, _Google_, or _Facebook_ buttons, these are examples of the Single Sign-On system at work.

This approach is called _identity federation_, it's when all the information about usernames and passwords is stored by a trusted _Identity Provider_ (IdP). The Service Provider (SP), such as Yandex.Cloud, redirects the user to authenticate with the Identity Provider (IdP) server.

## What do I need identity federations for in Yandex.Cloud? {#saml-federation-usage}

Large companies usually have a pre-configured system for managing users and access to their networks, such as Active Directory. A company like this may employ thousands of people, which makes it difficult to create a Yandex account for each employee and quickly delete it whenever anyone leaves the company.

{% include [about-saml-federations](../../../_includes/iam/about-saml-federations.md) %}

Since the authentication process takes place on the IdP server side, you can configure more reliable user data verification with things like two-factor authentication or USB tokens.

## How authentication occurs in a federation {#saml-authentication}

{% include [federated-user-auth](../../../_includes/iam/federated-user-auth.md) %}

The authentication process is shown in the diagram:

![image](../../../_assets/iam/federations/saml-authentication.svg)

1. The user opens a console login link in the browser.

1. If this is the first time the user authenticates, the console redirects them to the IdP server for authentication.

    If the user was already authenticated, this information is saved in the browser cookie. If the cookie is still valid, the management console authenticates the user immediately and redirects them to the home page. The cookie lifetime is specified when the federation is created.

    If the cookie expires, the console forwards the user to the IdP server for re-authentication.

1. The IdP server shows the authentication page to the user. For example, it prompts them to enter their username and password.

1. The user enters the data required for authentication on the IdP server.

1. If authentication is successful, the IdP server sends the user's browser back to the management console login page.

1. The management console asks IAM whether this user is added to the cloud. If the user is added, the management console authenticates the user and redirects them to the home page.

