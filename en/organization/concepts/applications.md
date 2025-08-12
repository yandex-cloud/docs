---
title: Applications in {{ org-full-name }}
description: In {{ org-name }}, you can authenticate {{ yandex-cloud }} users in external applications using SAML and OIDC applications with single sign-on technology.
---

# Applications in {{ org-full-name }}

{% include [note-preview](../../_includes/note-preview.md) %}

Your [organization's](./organization.md) users can authenticate in external applications using [single sign-on](https://en.wikipedia.org/wiki/Single_sign-on) (SSO). With this in mind, {{ org-name }} allows creating _applications_, i.e., {{ yandex-cloud }} [resources](../../overview/roles-and-resources.md#resources) containing integration settings for {{ org-full-name }} as an _identity provider_ (IdP) on the one hand and a third-party _service provider_ (SP) on the other.

{{ org-name }} supports the [SAML](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language) and [OpenID Connect](https://en.wikipedia.org/wiki/OpenID#OpenID_Connect_(OIDC)) (OIDC) single sign-on standards.

The role of service providers can be played by various SSO-enabled services, either based on the [SaaS](https://en.wikipedia.org/wiki/Software_as_a_service) or [on-premise](https://en.wikipedia.org/wiki/On-premises_software) model, e.g., [{{ yandex-360 }}](https://360.yandex.ru/), [GitHub](https://github.com/), [GitLab](https://about.gitlab.com/), [Jenkins](https://www.jenkins.io/), [Jira](https://www.atlassian.com/software/jira), and many more.

## SAML applications {#saml}

In {{ org-name }}, you can [create](../operations/applications/saml-create.md) SAML applications that allow configuring SAML-based single sign-on on the {{ org-name }} side and provide the values you need to set up integration on the service provider's side.

The external applications can only be accessed by {{ yandex-cloud }} organization users either explicitly [added](../operations/applications/saml-create.md#users-and-groups) to the relevant SAML application or belonging to [user groups](./groups.md) explicitly added to it.

{% include [saml-app-admin-role](../../_includes/organization/saml-app-admin-role.md) %}

### SAML collaboration diagram {#saml-scheme}

The basic concept of user authentication via SAML-based single sign-on is as described below:

1. The {{ yandex-cloud }} user selects SSO authentication on the external application's (service provider's) authentication page.
1. The service provider sends a SAML request to {{ org-name }} (identity provider) and redirects the user to the {{ org-name }}'s login URL.
1. The user authenticates in {{ org-name }} with their credentials.
1. If {{ org-name }} has a SAML app corresponding to this external application, the authenticated user is [added](../operations/applications/saml-create.md#users-and-groups) to this SAML app, and the received SAML request is correct, {{ org-name }} sends a signed SAML response containing the user's attributes to the service provider.
1. The service provider checks the SAML response and its signature for correctness and, if successful, grants the user access to the external application.
1. As soon as the user logs out of the external application, the service provider sends a SAML request to {{ org-name }} and redirects the user to the {{ org-name }}'s logout URL.

The parties exchange SAML data in [XML](https://en.wikipedia.org/wiki/XML) format.

### Identity provider ({{ org-name }}) side setup {#saml-idp-setup}

For the integration to work correctly on the {{ org-name }} side, you need to set up several integration parameters in your SAML application. Get the required values for these parameters from your service provider:

* `{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}`: Unique service provider ID.

    The value must be the same on the service provider's and {{ org-name }} side.
* `{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}`: URL {{ org-name }} will send the SAML response to.

    The ACS URL must follow the `https` schema. You can only use an encryption-free protocol for testing purposes on a local host (`http://127.0.0.1` and `http://localhost` values).

    {% include [saml-app-acs-url-paragraph](../../_includes/organization/saml-app-acs-url-paragraph.md) %}

    You can specify multiple URLs/ACS indexes.

    {% include [saml-app-acs-url-warn](../../_includes/organization/saml-app-acs-url-warn.md) %}

* `{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-signature-mode_ipXQ7 }}`: SAML response elements that will be digitally signed:

    {% include [saml-app-sign-mode](../../_includes/organization/saml-app-sign-mode.md) %}

#### User and group attributes {#saml-attributes}

By default, a new SAML app is created with a specific set of user-related _attributes_ {{ org-name }} will provide to the service provider. This set includes:

Attribute name | Attribute value | Provided value
--- | --- | ---
`NameID` | `SubjectClaims.preferred_username` | user ID
`givenname` | `SubjectClaims.given_name` | user's full name
`fullname` | `SubjectClaims.name` | user's first name
`surname` | `SubjectClaims.family_name` | user's last name
`emailaddress` | `SubjectClaims.email` | user's email address

After you create a SAML application, you can [add, modify, and delete](../operations/applications/saml-create.md#setup-attributes) the following user attributes:

{% include [saml-app-assertion-list](../../_includes/organization/saml-app-assertion-list.md) %}

{% include [saml-app-nameid-assertion](../../_includes/organization/saml-app-nameid-assertion.md) %}

In addition to the user attributes mentioned above, the SAML response may contain the group attribute whose value is the list of [groups](./groups.md) the user is a member of. You can specify any name and one of the following values for this attribute:

{% include [saml-app-group-assertion](../../_includes/organization/saml-app-group-assertion.md) %}

{% note info %}

If no value is set for a user attribute on the {{ org-name }} side, this attribute will not be present in the SAML response.

{% endnote %}

### Service provider (external application) side setup {#saml-sp-setup}

For the integration to work correctly on the service provider's side, you need to set up a number of integration parameters. Depending on the options supported by your service provider, you can [set these settings](../operations/applications/saml-create.md#setup-sp) manually or automatically by uploading an XML metadata file or specifying a metadata URL.

The download link for the XML metadata file and the metadata URL are available on the app info page in the [{{ cloud-center }} interface]({{ link-org-cloud-center }}/apps). The same page offers the integration parameter values for manual configuration:

{% include [saml-app-sp-parameter-list](../../_includes/organization/saml-app-sp-parameter-list.md) %}

Additionally, the user attributes set up on the {{ org-name }} side must be set up and able to be correctly processed on the service provider's side.

#### Digital signature verification key certificate {#saml-certificate}

In addition to setting up the above parameters, make sure the service provider configuration includes a certificate the service provider will use to verify the digital signature {{ org-name }} will sign its SAML responses with.

{% include [saml-app-cert-intro-phrase](../../_includes/organization/saml-app-cert-intro-phrase.md) %}

If using automatic configuration via a metadata file or URL, you do not have to install the certificate manually: the metadata already contains the required certificate and it is installed automatically.

You can [issue](../operations/applications/saml-update.md#update-cert) new digital signature verification key certificates for the SAML app and activate them at any time.

{% include [saml-app-cert-update-warn](../../_includes/organization/saml-app-cert-update-warn.md) %}

You must additionally specify on the service provider's side what data will be signed in the identity provider's SAML responses:
* Only provided user attributes.
* Full SAML response.
* Full SAML response and, separately, the provided attributes.

The signing mode configured on the service provider's side must be the same as the signing mode on the {{ org-name }} side.

## OIDC apps {#oidc}

In {{ org-name }}, you can [create](../operations/applications/oidc-create.md) OpenID Connect (OIDC) applications that allow configuring OIDC-based single sign-on on the {{ org-name }} side and provide the values you need to set up integration on the service provider's side.

The external applications can only be accessed by {{ yandex-cloud }} organization users either explicitly [added](../operations/applications/oidc-create.md#users-and-groups) to the relevant OIDC application or belonging to [user groups](./groups.md) explicitly added to it.

{% include [oidc-app-admin-role](../../_includes/organization/oidc-app-admin-role.md) %}

Every OIDC application requires an OAuth client, which is created in a user-specified [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) and is inherently linked to the OIDC app. An OAuth client is created and deleted automatically when, respectively, creating and deleting an OIDC app.

### OIDC collaboration diagram {#oidc-scheme}

The basic concept of user authentication via OIDC-based single sign-on is as described below:

1. The {{ yandex-cloud }} user selects SSO authentication on the external application's (service provider's) authentication page.
1. The service provider sends an authentication request to {{ org-name }} (identity provider) and redirects the user to the {{ org-name }}'s login URL specified in the `{{ ui-key.yacloud_org.application.overview.oauth_field_auth_endpoint }}` field.
1. The user authenticates in {{ org-name }} with their credentials.
1. If {{ org-name }} has an OIDC app mapped to this external application, the authenticated user is added to this OIDC app, and the received authentication request is correct, {{ org-name }} sends an authorization code to the service provider and redirects the user back to the external app.
1. At the address specified in the `{{ ui-key.yacloud_org.application.overview.oauth_field_token_endpoint }}` field, the service provider requests an [ID token](../../iam/concepts/authorization/id-token.md) and access token from {{ org-name }}. The request contains the [app secret](#oidc-secret), which {{ org-name }} uses to verify the request.
1. If the service provider sent a valid secret, {{ org-name }} sends an ID token and access token to the service provider.
1. The service provider checks the received ID token using a public key that it [got](https://{{ auth-main-host }}/oauth/jwks/keys) from {{ yandex-cloud }} using the ID from the `kid` field of the ID token header. If the check is successful, the service provider grants the user access to the external application.

The parties exchange OIDC data in [JSON](https://en.wikipedia.org/wiki/JSON) format.

### OIDC app secret {#oidc-secret}

An _app secret_ is generated by users on the OIDC app side in {{ org-name }}. It is a random fixed-length string starting with the `yccs__` prefix.

An app secret must be specified in the integration settings on the service provider side and will be used to verify requests coming from the service provider.

The lifetime of an OIDC app secret is unlimited. At the same time, you can [generate](../operations/applications/oidc-update.md#update-secret) any number of new secrets in the app at any time or delete them.

{% note warning %}

Once a secret is deleted in the OIDC app, remember to provide a new secret in the integration settings on the service provider side.

{% endnote %}

{{ yandex-cloud }} does not store OIDC app secrets, and the user can only see them when creating them. Once you refresh or close the browser page where a secret has been generated, the content of that secret becomes unavailable.

### Identity provider ({{ org-name }}) side setup {#oidc-idp-setup}

For the integration to work correctly on the {{ org-name }} side, you need to [specify](../operations/applications/oidc-create.md#setup-idp) the [redirect URI](#oidc-redirect-uri) address (addresses) in the OIDC app, select user [attributes](#oidc-user-attributes) to send to the service provider, and generate an [app secret](#oidc-secret). Before configuring your OIDC application in {{ org-name }}, get the redirect URI address (addresses) from your service provider.

#### Redirect URI {#oidc-redirect-uri}

_Redirect URI_ is an address on the external application side where the user will get redirected if successfully authenticated in {{ org-name }}.

The redirect URI must follow the `https` schema. You can only use an encryption-free protocol for testing purposes on a local host (`http://127.0.0.1` and `http://localhost` values).

In an OIDC app, you can specify multiple redirect URI addresses at the same time.

#### User attributes {#oidc-attributes}

In the OIDC app settings, you can specify the user attributes defined by the values selected in the **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-scopes_hEuar }}** field to send to the service provider in an ID token:

{% include [oidc-app-attribute-scopes](../../_includes/organization/oidc-app-attribute-scopes.md) %}

In a new OIDC app, all attributes except `groups` are selected by default.

### Service provider (external application) side setup {#oidc-sp-setup}

For the integration to work correctly on the service provider's side, you need to set up a number of integration parameters. Depending on the options supported by your service provider, you can [configure these settings](../operations/applications/oidc-create.md#setup-sp) manually or automatically by specifying a configuration URL.

A configuration URL gives the service provider the values of all settings required for configuring the integration. You can find it in the **{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}** field under **{{ ui-key.yacloud_org.application.overview.oauth_service_section_title }}** on the OIDC app information page in the [{{ cloud-center }} interface]({{ link-org-cloud-center }}/apps). The same page offers the integration setting values for manual configuration:

{% include [oidc-app-sp-parameter-list](../../_includes/organization/oidc-app-sp-parameter-list.md) %}

In addition to the above-mentioned settings, you also need to specify an [app secret](#oidc-secret) on the service provider side.

#### See also {#see-also}

* [{#T}](../operations/applications/saml-create.md)
* [{#T}](../operations/applications/saml-update.md)
* [{#T}](../operations/applications/saml-deactivate-remove.md)
* [{#T}](../operations/applications/oidc-create.md)
* [{#T}](../operations/applications/oidc-update.md)
* [{#T}](../operations/applications/oidc-deactivate-remove.md)