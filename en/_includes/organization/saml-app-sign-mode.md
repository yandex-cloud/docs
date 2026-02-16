* `{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.signature-mode-assertions_thJgN }}`: Only provided attributes will be signed. This is a default value.
* `{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.signature-mode-response_x7SKD }}`: The full SAML response will be signed.
* `{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.signature-mode-response-and-assertions_u2j6T }}`: The full SAML response and, separately, the provided attributes will be signed.

{% note warning %}

The signing mode configured for the SAML app on the {{ org-name }} side must be the same as the signing mode on the service provider's side.

{% endnote %}