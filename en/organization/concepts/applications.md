---
title: Applications in {{ org-full-name }}
description: In {{ org-name }}, you can authenticate {{ yandex-cloud }} users in external applications using SAML and OIDC applications with the single sign-on technology.
---

# Applications in {{ org-full-name }}

{% include [note-preview](../../_includes/note-preview.md) %}

Your [organization's](./organization.md) users can authenticate in external applications using [single sign-on](https://en.wikipedia.org/wiki/Single_sign-on) (SSO). With this in mind, {{ org-name }} allows creating _applications_, i.e., {{ yandex-cloud }} [resources](../../overview/roles-and-resources.md#resources) containing integration settings for {{ org-full-name }} as an _identity provider_ (IdP) on one side and a third-party _service provider_ (SP) on the other.

The role of service providers can be played by various SSO-enabled services, either based on the [SaaS](https://en.wikipedia.org/wiki/Software_as_a_service) or [on-premise](https://en.wikipedia.org/wiki/On-premises_software) model, e.g., [{{ yandex-360 }}](https://360.yandex.ru/), [GitHub](https://github.com/), [GitLab](https://about.gitlab.com/), [Jenkins](https://www.jenkins.io/), [Jira](https://www.atlassian.com/software/jira), and many more.

## SAML applications {#saml}

In {{ org-name }}, you can [create](../operations/applications/saml-create.md) SAML applications that allow configuring [SAML](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language)-based single sign-on on the {{ org-name }} side and provide the values you need to set up integration on the service provider's side.

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

Make sure the user attributes configured on the {{ org-name }} side are set up and can be processed correctly on the service provider's side.

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

#### See also {#see-also}

* [{#T}](../operations/applications/saml-create.md)
* [{#T}](../operations/applications/saml-update.md)
* [{#T}](../operations/applications/saml-deactivate-remove.md)