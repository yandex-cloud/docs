---
subcategory: Identity Hub
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/organizationmanager_idp_application_saml_application.md
---

# yandex_organizationmanager_idp_application_saml_application (DataSource)

A SAML application resource.

## Example usage

```terraform
//
// Get information about existing OrganizationManager Idp SAML Application.
//
data "yandex_organizationmanager_idp_application_saml_application" "saml_app" {
  application_id = "some_application_id"
}

output "my_saml_app.name" {
  value = data.yandex_organizationmanager_idp_application_saml_application.saml_app.name
}

output "my_saml_app.organization_id" {
  value = data.yandex_organizationmanager_idp_application_saml_application.saml_app.organization_id
}

output "my_saml_app.status" {
  value = data.yandex_organizationmanager_idp_application_saml_application.saml_app.status
}
```

## Arguments & Attributes Reference

- `application_id` (String). ID of the SAML application to return.
- `attribute_mapping` [FW-Block]. Attribute mapping configuration for the SAML application.
  - `attributes` [FW-Block]. List of attribute mappings.
    - `name` (**Required**)(String). Name of the SAML attribute.
    - `value` (**Required**)(String). Value of the SAML attribute.
  - `name_id` [FW-Block]. NameID configuration for the SAML application.
    - `format` (**Required**)(String). Format of the NameID.
    - `value` (*Read-Only*) (String). Value of the NameID.
- `created_at` (*Read-Only*) (String). Creation timestamp.
- `description` (String). Description of the SAML application.
- `group_claims_settings` [FW-Block]. Group claims settings for the SAML application.
  - `group_attribute_name` (String). Name of the SAML attribute that contains group information.
  - `group_distribution_type` (String). Distribution type for group claims.
- `id` (String). ID of the SAML application to return.
- `identity_provider_metadata` [FW-Block]. Identity provider metadata for the SAML application.
  - `issuer` (*Read-Only*) (String). Identity provider issuer identifier.
  - `metadata_url` (*Read-Only*) (String). Identity provider metadata URL.
  - `slo_url` (*Read-Only*) (String). Identity provider Single Logout URL.
  - `sso_url` (*Read-Only*) (String). Identity provider Single Sign-On URL.
- `labels` (Map Of String). Resource labels as `` key:value `` pairs.
- `name` (**Required**)(String). Name of the SAML application.
- `organization_id` (**Required**)(String). ID of the organization that the application belongs to.
- `security_settings` [FW-Block]. Security settings for the SAML application.
  - `signature_certificate_id` (String). ID of the signature certificate to use.
  - `signature_mode` (String). Signature mode for SAML messages.
- `service_provider` [FW-Block]. Service provider configuration for the SAML application.
  - `acs_urls` [FW-Block]. Assertion Consumer Service URLs.
    - `index` (Number). Optional index for the assertion consumer service.
    - `url` (**Required**)(String). The URL where SAML responses are sent.
  - `entity_id` (**Required**)(String). Service provider entity ID.
  - `slo_urls` [FW-Block]. Single Logout Service URLs.
    - `protocol_binding` (**Required**)(String). Protocol binding supported by the logout endpoint.
    - `response_url` (String). Optional separate URL for logout responses.
    - `url` (**Required**)(String). The URL where logout requests are sent.
- `status` (*Read-Only*) (String). Current status of the SAML application.
- `updated_at` (*Read-Only*) (String). Modification timestamp.


