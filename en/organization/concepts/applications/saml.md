---
title: SAML applications in {{ org-full-name }}
description: In {{ org-full-name }}, you can authenticate {{ yandex-cloud }} users in external applications using SAML applications with single sign-on technology.
---

# SAML apps


In {{ org-full-name }}, you can [create](../../operations/applications/saml-create.md) SAML applications that allow configuring SAML-based single sign-on on the {{ org-full-name }} side and provide the values you need to set up integration on the service provider's side.

The external applications can only be accessed by {{ yandex-cloud }} organization users either explicitly [added](../../operations/applications/saml-create.md#users-and-groups) to the relevant SAML application or belonging to [user groups](../groups.md) explicitly added to it.

{% include [auth-policy-applications-tip](../../../_includes/organization/auth-policy-applications-tip.md) %}

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

## SAML collaboration diagram {#saml-scheme}

The basic concept of user authentication via SAML-based single sign-on is as described below:

{% include [SAML authentication diagram](../../../_mermaid/other/identity-hub/saml-authentication.md) %}

1. The {{ yandex-cloud }} user selects SSO authentication on the external application's (service provider's) authentication page.
1. The service provider sends a SAML request to {{ org-full-name }} (identity provider) and redirects the user to the {{ org-full-name }}'s login URL. If you enable signature verification for SAML requests from the service provider, authentication will not start for as long as the request has no signature or the signature is invalid.
1. The user authenticates in {{ org-full-name }} with their credentials.
1. If {{ org-full-name }} has a SAML app corresponding to this external application, the authenticated user is [added](../../operations/applications/saml-create.md#users-and-groups) to this SAML app, and the incoming SAML request is correct, {{ org-full-name }} will send to the service provider a signed (and encrypted if the relevant option is on) SAML response containing the user's attributes.
1. The service provider checks the SAML response and its signature for correctness and, if successful, grants the user access to the external application.
1. As soon as the user logs out of the external application, the service provider sends a SAML request to {{ org-full-name }} and redirects the user to the {{ org-full-name }}'s logout URL.

The parties exchange SAML data in [XML](https://en.wikipedia.org/wiki/XML) format.

## Identity provider ({{ org-full-name }}) side setup {#saml-idp-setup}

For the integration to work correctly on the {{ org-full-name }} side, you need to set up several integration parameters in your SAML application. Get the required values for these parameters from your service provider:

* `{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}`: Unique service provider ID.

    The value must be the same on the service provider's and {{ org-full-name }} side.
* `{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}`: URL {{ org-full-name }} will send the SAML response to.

    The ACS URL must follow the `https` schema. You can only use an encryption-free protocol for testing purposes on a local host (`http://127.0.0.1` and `http://localhost` values).

    {% include [saml-app-acs-url-paragraph](../../../_includes/organization/saml-app-acs-url-paragraph.md) %}

    You can specify multiple URLs/ACS indexes.

    {% include [saml-app-acs-url-warn](../../../_includes/organization/saml-app-acs-url-warn.md) %}

* `{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-signature-mode_ipXQ7 }}`: SAML response elements that will be digitally signed:

    {% include [saml-app-sign-mode](../../../_includes/organization/saml-app-sign-mode.md) %}

* `{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.RequestSigningSection.field-request-signing }}`: Allows you to verifying the signature of the service provider's SAML requests and suspend authentication if the request has no signature or the signature is invalid.

  To enable this feature, you need to upload the public key certificate you got from the service provider, which will be used for signature verification.

* `{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.EncryptResponseSection.field-encrypt-response }}`: Allows you to enable encryption of SAML responses to add an extra data protection layer. By default, SAML responses are only signed.

  To enable this feature, you need to upload the public key certificate you got from the service provider, which will be used for encryption.

### User and group attributes {#saml-attributes}

By default, a new SAML app is created with a specific set of user-related _attributes_ {{ org-full-name }} will provide to the service provider. This set includes:

Attribute name | Attribute value | Provided value
--- | --- | ---
`NameID` | `SubjectClaims.preferred_username` | User ID
`givenname` | `SubjectClaims.given_name` | User's full name
`fullname` | `SubjectClaims.name` | User's first name
`surname` | `SubjectClaims.family_name` | User's last name
`emailaddress` | `SubjectClaims.email` | User's email address

After you create a SAML application, you can [add, modify, and delete](../../operations/applications/saml-create.md#setup-attributes) the following user attributes:

{% include [saml-app-assertion-list](../../../_includes/organization/saml-app-assertion-list.md) %}

{% include [saml-app-nameid-assertion](../../../_includes/organization/saml-app-nameid-assertion.md) %}

In addition to the user attributes mentioned above, the SAML response may contain the group attribute whose value is the list of [groups](../groups.md) the user is a member of. You can specify any name and one of the following values for this attribute:

{% include [saml-app-group-assertion](../../../_includes/organization/saml-app-group-assertion.md) %}

{% note info %}

If no value is set for a user attribute on the {{ org-full-name }} side, this attribute will not be present in the SAML response.

{% endnote %}

## Service provider (external application) side setup {#saml-sp-setup}

For the integration to work correctly on the service provider's side, you need to set up a number of integration parameters. Depending on the options supported by your service provider, you can [set these settings](../../operations/applications/saml-create.md#setup-sp) manually or automatically by uploading an XML metadata file or specifying a metadata URL.

The download link for the XML metadata file and the metadata URL are available on the app info page in the [{{ cloud-center }} interface]({{ link-org-cloud-center }}/apps). The same page offers the integration parameter values for manual configuration:

{% include [saml-app-sp-parameter-list](../../../_includes/organization/saml-app-sp-parameter-list.md) %}

Additionally, the user attributes set up on the {{ org-full-name }} side must be set up and able to be correctly processed on the service provider's side.

### Digital signature verification key certificate {#saml-certificate}

In addition to setting up the above parameters, make sure the service provider configuration includes a certificate the service provider will use to verify the digital signature {{ org-full-name }} will sign its SAML responses with.

{% include [saml-app-cert-intro-phrase](../../../_includes/organization/saml-app-cert-intro-phrase.md) %}

If using automatic configuration via a metadata file or URL, you do not have to install the certificate manually: the metadata already contains the required certificate and it is installed automatically.

You can [issue](../../operations/applications/saml-update.md#update-cert) new digital signature verification key certificates for the SAML app and activate them at any time.

{% include [saml-app-cert-update-warn](../../../_includes/organization/saml-app-cert-update-warn.md) %}

You must additionally specify on the service provider's side what data will be signed in the identity provider's SAML responses:
* Only the provided user attributes.
* Full SAML response.
* Full SAML response and, separately, the provided attributes.

The signing mode configured on the service provider's side must be the same as the signing mode on the {{ org-full-name }} side.

#### Useful links {#see-also}

* [{#T}](../../operations/applications/saml-create.md)
* [{#T}](../../operations/applications/saml-update.md)
* [{#T}](../../operations/applications/saml-deactivate-remove.md)
* [{#T}](../../../security/domains/iam-checklist.md)
* [{#T}](./oidc.md)
