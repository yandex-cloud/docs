---
subcategory: Identity Hub
---

# yandex_organizationmanager_idp_application_oauth_application (Resource)

An OAuth application resource.

## Example usage

```terraform
//
// Create a new OrganizationManager Idp Application OAuth Application.
//
resource "yandex_organizationmanager_idp_application_oauth_application" "example_app" {
  organization_id = "some_organization_id"
  name           = "example-oauth-app"
  description    = "Example OAuth application"

  client_grant = {
    client_id         = "some_client_id"
    authorized_scopes = ["openid", "profile", "email"]
  }

  group_claims_settings = {
    group_distribution_type = "ALL_GROUPS"
  }

  labels = {
    env = "production"
    app = "example"
  }
}
```

## Arguments & Attributes Reference

- `application_id` (String). ID of the OAuth application to return.
 To get the OAuth application ID, make a [ApplicationService.List] request.
- `client_grant` [Block]. Represents current connection to the OAuth client with specified scopes
  - `authorized_scopes` (Set Of String). List of authorized client scopes by the application
  - `client_id` (**Required**)(String). OAuth client id
- `created_at` (*Read-Only*) (String). Creation timestamp.
- `description` (String). Description of the application. 0-256 characters long.
- `group_claims_settings` [Block]. Settings of the group claims
  - `group_distribution_type` (String). Represents current distribution type of the groups. I.e. which groups are visible for the application users.
- `id` (String). ID of the OAuth application to return.
 To get the OAuth application ID, make a [ApplicationService.List] request.
- `labels` (Map Of String). Resource labels as `` key:value `` pairs.
- `name` (**Required**)(String). Name of the application.
 The name is unique within the organization. 3-63 characters long.
- `organization_id` (**Required**)(String). ID of the organization that the application belongs to.
- `status` (*Read-Only*) (String). Current status of the application.
- `updated_at` (*Read-Only*) (String). Modification timestamp.


