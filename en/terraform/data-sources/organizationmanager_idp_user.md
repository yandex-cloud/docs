---
subcategory: Identity Hub
---

# yandex_organizationmanager_idp_user (DataSource)

A user in the Identity Provider system.

 Users are created within a userpool and can authenticate to access cloud resources.
 Each user has a unique identifier, credentials, and profile information.

## Example usage

```terraform
//
// Get information about existing OrganizationManager Idp User.
//
data "yandex_organizationmanager_idp_user" "user" {
  user_id = "some_user_id"
}

output "my_user.username" {
  value = data.yandex_organizationmanager_idp_user.user.username
}

output "my_user.full_name" {
  value = data.yandex_organizationmanager_idp_user.user.full_name
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). Timestamp when the user was created.
- `email` (String). User's email address.
- `external_id` (String). External identifier for federation with external identity systems.
 This ID can be used to link this user with an account in an external system.
- `family_name` (String). User's last name.
 Part of the user's profile information.
- `full_name` (**Required**)(String). User's full name (display name).
 This is typically shown in the UI and used for identification purposes.
- `given_name` (String). User's first name.
 Part of the user's profile information.
- `id` (String). ID of the user to return.
- `phone_number` (String). User's phone number.
- `status` (*Read-Only*) (String). Current status of the user.
 Determines whether the user can authenticate and access the system.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
- `updated_at` (*Read-Only*) (String). Timestamp when the user was last updated.
- `user_id` (String). ID of the user to return.
- `username` (**Required**)(String). Username used for authentication.
 Usually in the format of an email address.
- `userpool_id` (**Required**)(String). ID of the userpool this user belongs to.
 To get the userpool ID, make a [UserpoolService.List] request.


