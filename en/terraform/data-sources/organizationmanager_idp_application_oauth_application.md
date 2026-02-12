---
subcategory: Identity Hub
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/organizationmanager_idp_application_oauth_application.md
---

# yandex_organizationmanager_idp_application_oauth_application (DataSource)

An OAuth application resource.

## Example usage

```terraform
//
// Get information about existing OrganizationManager Idp Application OAuth Application.
//
data "yandex_organizationmanager_idp_application_oauth_application" "app" {
  application_id = "some_application_id"
}

output "my_app.name" {
  value = data.yandex_organizationmanager_idp_application_oauth_application.app.name
}

output "my_app.status" {
  value = data.yandex_organizationmanager_idp_application_oauth_application.app.status
}

output "my_app.client_id" {
  value = data.yandex_organizationmanager_idp_application_oauth_application.app.client_grant.client_id
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


