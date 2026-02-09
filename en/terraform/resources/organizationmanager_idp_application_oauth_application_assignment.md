---
subcategory: Identity Hub
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/organizationmanager_idp_application_oauth_application_assignment.md
---

# yandex_organizationmanager_idp_application_oauth_application_assignment (Resource)

OAuth application assignment resource

## Example usage

```terraform
//
// Create a new OrganizationManager Idp OAuth Application Assignment.
//
resource "yandex_iam_oauth_client" "example_client" {
  name      = "example-oauth-client"
  folder_id = "your_folder_id"
  scopes    = ["iam"]
}

resource "yandex_organizationmanager_idp_application_oauth_application" "example_app" {
  organization_id = "your_organization_id"
  name           = "example-oauth-app"
  description    = "Example OAuth application"

  client_grant = {
    client_id         = yandex_iam_oauth_client.example_client.id
    authorized_scopes = ["openid", "profile", "email"]
  }

  group_claims_settings = {
    group_distribution_type = "ALL_GROUPS"
  }
}

resource "yandex_organizationmanager_idp_application_oauth_application_assignment" "example_assignment" {
  application_id = yandex_organizationmanager_idp_application_oauth_application.example_app.application_id
  subject_id     = "your_subject_id"
}
```

## Arguments & Attributes Reference

- `application_id` (**Required**)(String). OAuth application id
- `subject_id` (**Required**)(String). Subject id


