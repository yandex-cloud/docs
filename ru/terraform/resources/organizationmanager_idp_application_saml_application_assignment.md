---
subcategory: Identity Hub
---

# yandex_organizationmanager_idp_application_saml_application_assignment (Resource)

SAML application assignment resource

## Example usage

```terraform
//
// Create a new OrganizationManager Idp SAML Application Assignment.
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
  }
}

resource "yandex_organizationmanager_idp_application_saml_application_assignment" "example_assignment" {
  application_id = yandex_organizationmanager_idp_application_saml_application.example_saml_app.application_id
  subject_id     = "your_subject_id"
}
```

## Arguments & Attributes Reference

- `application_id` (**Required**)(String). SAML application id
- `subject_id` (**Required**)(String). Subject id


