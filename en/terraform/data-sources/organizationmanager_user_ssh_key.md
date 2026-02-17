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


