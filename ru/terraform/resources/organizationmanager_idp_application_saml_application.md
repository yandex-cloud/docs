---
subcategory: Identity Hub
---

# yandex_organizationmanager_idp_application_saml_application (Resource)

A SAML application resource.

## Example usage

```terraform
//
// Create a new OrganizationManager Idp SAML Application.
//
resource "yandex_organizationmanager_idp_application_saml_application" "example_saml_app" {
  name            = "example-saml-app"
  organization_id = "your_organization_id"
  description     = "Example SAML application"

  service_provider = {
    entity_id = "https://example.com/saml/metadata"

    acs_urls = [
      {
        url = "https://example.com/saml/acs"
      }
    ]

    slo_urls = [
      {
        url              = "https://example.com/saml/slo"
        protocol_binding = "HTTP_POST"
      }
    ]
  }

  attribute_mapping = {
    name_id = {
      format = "EMAIL"
    }

    attributes = [{
      name  = "email"
      value = "SubjectClaims.email"
    }, {
      name  = "firstName"
      value = "SubjectClaims.given_name"
    }, {
      name  = "lastName"
      value = "SubjectClaims.family_name"
    }]
  }

  security_settings = {
    signature_mode = "RESPONSE_AND_ASSERTIONS"
  }

  labels = {
    environment = "production"
    app-type    = "saml"
  }
}
```

## Arguments & Attributes Reference

- `application_id` (String). ID of the SAML application to return.
- `attribute_mapping` [Block]. Attribute mapping configuration for the SAML application.
  - `attributes` [Block]. List of attribute mappings.
    - `name` (**Required**)(String). Name of the SAML attribute.
    - `value` (**Required**)(String). Value of the SAML attribute.
  - `name_id` [Block]. NameID configuration for the SAML application.
    - `format` (**Required**)(String). Format of the NameID.
    - `value` (*Read-Only*) (String). Value of the NameID.
- `created_at` (*Read-Only*) (String). Creation timestamp.
- `description` (String). Description of the SAML application.
- `group_claims_settings` [Block]. Group claims settings for the SAML application.
  - `group_attribute_name` (String). Name of the SAML attribute that contains group information.
  - `group_distribution_type` (String). Distribution type for group claims.
- `id` (String). ID of the SAML application to return.
- `identity_provider_metadata` [Block]. Identity provider metadata for the SAML application.
  - `issuer` (*Read-Only*) (String). Identity provider issuer identifier.
  - `metadata_url` (*Read-Only*) (String). Identity provider metadata URL.
  - `slo_url` (*Read-Only*) (String). Identity provider Single Logout URL.
  - `sso_url` (*Read-Only*) (String). Identity provider Single Sign-On URL.
- `labels` (Map Of String). Resource labels as `` key:value `` pairs.
- `name` (**Required**)(String). Name of the SAML application.
- `organization_id` (**Required**)(String). ID of the organization that the application belongs to.
- `security_settings` [Block]. Security settings for the SAML application.
  - `signature_certificate_id` (String). ID of the signature certificate to use.
  - `signature_mode` (String). Signature mode for SAML messages.
- `service_provider` [Block]. Service provider configuration for the SAML application.
  - `acs_urls` [Block]. Assertion Consumer Service URLs.
    - `index` (Number). Optional index for the assertion consumer service.
    - `url` (**Required**)(String). The URL where SAML responses are sent.
  - `entity_id` (**Required**)(String). Service provider entity ID.
  - `slo_urls` [Block]. Single Logout Service URLs.
    - `protocol_binding` (**Required**)(String). Protocol binding supported by the logout endpoint.
    - `response_url` (String). Optional separate URL for logout responses.
    - `url` (**Required**)(String). The URL where logout requests are sent.
- `status` (*Read-Only*) (String). Current status of the SAML application.
- `updated_at` (*Read-Only*) (String). Modification timestamp.


