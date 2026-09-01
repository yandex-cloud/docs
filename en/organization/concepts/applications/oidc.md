---
title: OIDC apps in {{ org-full-name }}
description: In {{ org-full-name }}, you can authenticate {{ yandex-cloud }} users to external applications using OIDC apps with OpenID Connect single sign-on.
---

# OIDC apps


In {{ org-full-name }}, you can [create](../../operations/applications/oidc-create.md) OpenID Connect (OIDC) applications that allow configuring OIDC-based single sign-on on the {{ org-full-name }} side and provide the values you need to set up integration on the service provider's side.

The external applications can only be accessed by {{ yandex-cloud }} organization users either explicitly [added](../../operations/applications/oidc-create.md#users-and-groups) to the relevant OIDC application or belonging to [user groups](../groups.md) explicitly added to it.

{% include [auth-policy-applications-tip](../../../_includes/organization/auth-policy-applications-tip.md) %}

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

Every OIDC application requires an OAuth client, which is created in a user-specified [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) and is inherently linked to the OIDC app. An OAuth client is created and deleted automatically when creating and deleting an OIDC app, respectively.

## OIDC collaboration diagram {#oidc-scheme}

The parties exchange OIDC data in [JSON](https://en.wikipedia.org/wiki/JSON) format.

The basic concept of user authentication via OIDC-based single sign-on is as described below:

{% include [OIDC authentication diagram](../../../_mermaid/other/identity-hub/oidc-authentication.md) %}

1. The {{ yandex-cloud }} user selects SSO authentication on the external application's (service provider's) authentication page.
1. The service provider sends an authentication request to {{ org-full-name }} (identity provider) and redirects the user to the {{ org-full-name }}'s login URL specified in the `{{ ui-key.yacloud_org.application.overview.oauth_field_auth_endpoint }}` field.
1. The user authenticates in {{ org-full-name }} with their credentials.
1. If {{ org-full-name }} has an OIDC app mapped to this external application, the authenticated user is added to this OIDC app, and the received authentication request is correct, {{ org-full-name }} sends an authorization code to the service provider and redirects the user back to the external app.
1. At the address specified in the `{{ ui-key.yacloud_org.application.overview.oauth_field_token_endpoint }}` field, the service provider requests an [ID token](../../../iam/concepts/authorization/id-token.md) and access token from {{ org-full-name }}. The request contains the [app secret](#oidc-secret), which {{ org-full-name }} uses to verify the request.
1. If the service provider sent a valid secret, {{ org-full-name }} sends an ID token and access token to the service provider.
1. The service provider checks the received ID token using a public key that it [got](https://{{ auth-main-host }}/oauth/jwks/keys) from {{ yandex-cloud }} using the ID from the `kid` field of the ID token header. If the check is successful, the service provider grants the user access to the external application.

{% note info %}

The diagram shows the interaction between the parties when using an OIDC app of the [{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}](#oidc-web) type. When using the [{{ ui-key.yacloud_org.organization.apps.spa-title_1mhon }}](#oidc-single-page) and [{{ ui-key.yacloud_org.organization.apps.native-title_1VrmN }}](#oidc-native) app types, the steps of app secret query and verification are excluded from the process.

{% endnote %}

## Types of OIDC apps in {{ org-full-name }} {#oidc-application-types}

Depending on their presets, {{ org-full-name }} OIDC apps can be of one of these types:

* [{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}](#oidc-web)
* [{{ ui-key.yacloud_org.organization.apps.spa-title_1mhon }}](#oidc-single-page)
* [{{ ui-key.yacloud_org.organization.apps.native-title_1VrmN }}](#oidc-native)

You select the type when creating the app; once the app is created, you cannot change its type.

{% include [oidc-app-types-ui-notice](../../../_includes/organization/oidc-app-types-ui-notice.md) %}

### {{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }} apps {#oidc-web}

OIDC apps of the `{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}` type are optimized for user authentication to external web apps with a server end (backend), where the [application secret](#oidc-secret) can be safely stored.

`{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}` apps support the application secret: depending on setup, the secret can be [provided](#secret-delivery) in the `Authorization: Basic` HTTP header and/or the body of the POST request. By default, apps are set up to provide the secret via all available methods.

By default, `{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}` apps require service providers to use the [PKCE](#pkce) security extension; however, you can turn off this requirement in app settings.

The [Redirect URI](#oidc-redirect-uri) of `{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}` apps must follow the `https` schema. You can only use an encryption-free protocol for testing purposes on a local host (`http://127.0.0.1` and `http://localhost` values).

### {{ ui-key.yacloud_org.organization.apps.spa-title_1mhon }} apps {#oidc-single-page}

OIDC apps of the `{{ ui-key.yacloud_org.organization.apps.spa-title_1mhon }}` type are optimized for user authentication to external [SPA](https://en.wikipedia.org/wiki/Single-page_application) applications. SPA applications are typically in-browser apps built on the [JavaScript](https://en.wikipedia.org/wiki/JavaScript) or [TypeScript](https://www.typescriptlang.org/) frameworks ([React](https://react.dev/), [Vue](https://vuejs.org/), [Angular](https://angular.dev/), etc.).

`{{ ui-key.yacloud_org.organization.apps.spa-title_1mhon }}` apps do not support the use of the application secret.

`{{ ui-key.yacloud_org.organization.apps.spa-title_1mhon }}` apps require service providers to use the [PKCE](#pkce) security extension, and you cannot turn off this requirement in app settings.

The [Redirect URI](#oidc-redirect-uri) of `{{ ui-key.yacloud_org.organization.apps.spa-title_1mhon }}` apps must follow the `https` schema. You can only use an encryption-free protocol for testing purposes on a local host (`http://127.0.0.1` and `http://localhost` values).

### {{ ui-key.yacloud_org.organization.apps.native-title_1VrmN }} apps {#oidc-native}

OIDC apps of the `{{ ui-key.yacloud_org.organization.apps.native-title_1VrmN }}` type are a good fit for user authentication to external mobile or desktop applications installed on their devices.

`{{ ui-key.yacloud_org.organization.apps.native-title_1VrmN }}` apps do not support the use of the application secret.

`{{ ui-key.yacloud_org.organization.apps.native-title_1VrmN }}` applications require service providers to use the [PKCE](#pkce) security extension, and you cannot turn off this requirement in app settings.

The [Redirect URI](#oidc-redirect-uri) of `{{ ui-key.yacloud_org.organization.apps.native-title_1VrmN }}` apps supports any valid URI scheme.

## OIDC app secret {#oidc-secret}

An _app secret_ is generated by users on the OIDC app side in {{ org-full-name }}. It is a random fixed-length string starting with the `yccs__` prefix.

A secret can only be used in [{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}](#oidc-web) apps. No application secret is used in [{{ ui-key.yacloud_org.organization.apps.spa-title_1mhon }}](#oidc-single-page) and [{{ ui-key.yacloud_org.organization.apps.native-title_1VrmN }}](#oidc-native) apps.

An app secret must be specified in the integration settings on the service provider side and will be used to verify requests coming from the service provider.

The lifetime of an OIDC app secret is unlimited. At the same time, you can [generate](../../operations/applications/oidc-update.md#update-secret) any number of new secrets in the app at any time or delete them.

{% note warning %}

Once a secret is deleted in the OIDC app, remember to provide a new secret in the integration settings on the service provider side.

{% endnote %}

{{ yandex-cloud }} does not store OIDC app secrets, and the user can only see them when creating them. Once you refresh or close the browser page where a secret has been generated, the content of that secret becomes unavailable.

### Methods of providing the application secret {#secret-delivery}

During user authentication, the application secret can be delivered from the service provider to the identity provider using the following methods:

* `{{ ui-key.yacloud_org.application.overview.oauth_field_auth_method_client_secret_basic }}`: The application secret is provided in the `Authorization: Basic` HTTP header.
* `{{ ui-key.yacloud_org.application.overview.oauth_field_auth_method_client_secret_basic }}`: The application secret is provided in the body of the POST request.

In `{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}` apps, you can select one or both methods at the same time.

In `{{ ui-key.yacloud_org.organization.apps.spa-title_1mhon }}` and `{{ ui-key.yacloud_org.organization.apps.native-title_1VrmN }}` apps, no secret is used; therefore, no secret delivery method can be configured.

## PKCE {#pkce}

[PKCE](https://www.rfc-editor.org/info/rfc7636/) (_Proof Key for Code Exchange_) is a security extension used in [OAuth 2.0](https://www.rfc-editor.org/info/rfc6749/) to minimize the risk of authentication data interception.

By default, OIDC apps of all [types](#oidc-web) require the service provider to use the PKCE extension (i.e., to transmit `code_challenge` when requesting authorization and `code_verifier` when exchanging the code for tokens). For [{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}](#oidc-web) apps, this requirement can be turned off. You cannot turn off the PKCE requirement for [{{ ui-key.yacloud_org.organization.apps.spa-title_1mhon }}](#oidc-single-page) and [{{ ui-key.yacloud_org.organization.apps.native-title_1VrmN }}](#oidc-native) apps.

## Identity provider ({{ org-full-name }}) side setup {#oidc-idp-setup}

For the integration to work correctly on the {{ org-full-name }} side, you need to [specify](../../operations/applications/oidc-create.md#setup-idp) the [redirect URI](#oidc-redirect-uri) address (addresses) in the OIDC app, select user [attributes](#oidc-user-attributes) to send to the service provider, and generate an [app secret](#oidc-secret). Before configuring your OIDC application in {{ org-full-name }}, get the redirect URI address (addresses) from your service provider.

### Redirect URI {#oidc-redirect-uri}

_Redirect URI_ is an address on the external application side where the user will get redirected if successfully authenticated in {{ org-full-name }}.

For [{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}](#oidc-web) and [{{ ui-key.yacloud_org.organization.apps.spa-title_1mhon }}](#oidc-single-page) apps, the Redirect URI must follow the `https` schema. You can only use an encryption-free protocol in apps of these types for testing purposes on a local host (`http://127.0.0.1` and `http://localhost`).

In [{{ ui-key.yacloud_org.organization.apps.native-title_1VrmN }}](#oidc-native) apps, [Redirect URIs](#oidc-redirect-uri) support any valid URI schema.

You can specify several Redirect URI addresses in your OIDC apps at the same time.

### User attributes {#oidc-attributes}

In the OIDC app settings, you can specify the user attributes defined by the values selected in the **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-scopes_hEuar }}** field to send to the service provider in an ID token:

{% include [oidc-app-attribute-scopes](../../../_includes/organization/oidc-app-attribute-scopes.md) %}

In a new OIDC app, all attributes except `groups` are selected by default.

## Service provider (external application) side setup {#oidc-sp-setup}

For the integration to work correctly on the service provider's side, you need to set up a number of integration parameters. Depending on the options supported by your service provider, you can [configure these settings](../../operations/applications/oidc-create.md#setup-sp) manually or automatically by specifying a configuration URL.

A configuration URL gives the service provider the values of all settings required for configuring the integration. You can find it in the **{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}** field under **{{ ui-key.yacloud_org.application.overview.oauth_service_section_title }}** on the OIDC app information page in the [{{ cloud-center }} interface]({{ link-org-cloud-center }}/apps). The same page offers the integration setting values for manual configuration:

{% include [oidc-app-sp-parameter-list](../../../_includes/organization/oidc-app-sp-parameter-list.md) %}

In addition to the above-mentioned parameters, you have to specify an [application secret](#oidc-secret) on the service provider side when configuring integration with [{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}](#oidc-web) apps.

#### Useful links {#see-also}

* [{#T}](../../operations/applications/oidc-create.md)
* [{#T}](../../operations/applications/oidc-update.md)
* [{#T}](../../operations/applications/oidc-deactivate-remove.md)
* [{#T}](../../../security/domains/iam-checklist.md)
* [{#T}](./saml.md)

