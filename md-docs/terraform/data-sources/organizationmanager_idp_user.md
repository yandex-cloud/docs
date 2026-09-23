[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Identity Hub > Data Sources > organizationmanager_idp_user

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

- `company_name` (*Read-Only*) (String). User's company name.
- `created_at` (*Read-Only*) (String). Timestamp when the user was created.
- `department` (*Read-Only*) (String). User's department.
- `email` (*Read-Only*) (String). User's email address.
- `employee_id` (*Read-Only*) (String). User's employee ID
- `expires_at` (*Read-Only*) (String). Timestamp when the user account expires.
- `external_id` (*Read-Only*) (String). External identifier for federation with external identity systems.
 This ID can be used to link this user with an account in an external system.
- `family_name` (*Read-Only*) (String). User's last name.
 Part of the user's profile information.
- `full_name` (*Read-Only*) (String). User's full name (display name).
 This is typically shown in the UI and used for identification purposes.
- `given_name` (*Read-Only*) (String). User's first name.
 Part of the user's profile information.
- `id` (String). ID of the user to return.
- `job_title` (*Read-Only*) (String). User's job title.
- `password_created_at` (*Read-Only*) (String). Timestamp when the user's current password was created.
 For synchronized passwords, this is the time when the password was last set in the source directory.
- `phone_number` (*Read-Only*) (String). User's phone number.
- `status` (*Read-Only*) (String). Current status of the user.
 Determines whether the user can authenticate and access the system.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
- `updated_at` (*Read-Only*) (String). Timestamp when the user was last updated.
- `user_id` (String). ID of the user to return.
- `username` (*Read-Only*) (String). Username used for authentication.
 Usually in the format of an email address.
- `userpool_id` (*Read-Only*) (String). ID of the userpool this user belongs to.
 To get the userpool ID, make a [UserpoolService.List] request.