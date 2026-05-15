---
subcategory: Identity Hub
---

# yandex_organizationmanager_user_ssh_key (DataSource)



## Example usage

```terraform
//
// Get information about existing OrganizationManager User SSH Key.
//
data "yandex_organizationmanager_user_ssh_key" "my_user_ssh_key" {
  user_ssh_key_id = "some_user_ssh_key_id"
}

output "my_user_ssh_key_name" {
  value = "data.yandex_organizationmanager_user_ssh_key.my_user_ssh_key.name"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). package: yandex.cloud.organizationmanager.v1
filename: yandex/cloud/organizationmanager/v1/user_ssh_key.proto

- `data` (**Required**)(String). package: yandex.cloud.organizationmanager.v1
filename: yandex/cloud/organizationmanager/v1/user_ssh_key.proto

- `expires_at` (String). Used for temporary keys, if empty the key doesn't expire
- `fingerprint` (*Read-Only*) (String). package: yandex.cloud.organizationmanager.v1
filename: yandex/cloud/organizationmanager/v1/user_ssh_key.proto

- `id` (String). package: yandex.cloud.organizationmanager.v1
filename: yandex/cloud/organizationmanager/v1/user_ssh_key_service.proto

- `name` (String). package: yandex.cloud.organizationmanager.v1
filename: yandex/cloud/organizationmanager/v1/user_ssh_key.proto

- `organization_id` (**Required**)(String). package: yandex.cloud.organizationmanager.v1
filename: yandex/cloud/organizationmanager/v1/user_ssh_key.proto

- `subject_id` (**Required**)(String). package: yandex.cloud.organizationmanager.v1
filename: yandex/cloud/organizationmanager/v1/user_ssh_key.proto

- `user_ssh_key_id` (String). package: yandex.cloud.organizationmanager.v1
filename: yandex/cloud/organizationmanager/v1/user_ssh_key_service.proto

- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).


