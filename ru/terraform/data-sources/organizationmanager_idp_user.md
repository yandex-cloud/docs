---
subcategory: Identity Hub
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/organizationmanager_idp_user.md
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
- `updated_at` (*Read-Only*) (String). Timestamp when the user was last updated.
- `user_id` (String). ID of the user to return.
- `username` (**Required**)(String). Username used for authentication.
 Usually in the format of an email address.
- `userpool_id` (**Required**)(String). ID of the userpool this user belongs to.
 To get the userpool ID, make a [UserpoolService.List] request.


