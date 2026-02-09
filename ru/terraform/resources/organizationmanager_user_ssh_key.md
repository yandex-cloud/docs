---
subcategory: Identity Hub
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/organizationmanager_user_ssh_key.md
---

# yandex_organizationmanager_user_ssh_key (Resource)



## Example usage

```terraform
//
// Create a new OrganizationManager User SSH Key.
//
resource "yandex_organizationmanager_user_ssh_key" "my_user_ssh_key" {
  organization_id = "some_organization_id"
  subject_id      = "some_subject_id"
  data            = "ssh_key_data"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). package: yandex.cloud.organizationmanager.v1filename: yandex/cloud/organizationmanager/v1/user_ssh_key.proto
- `data` (**Required**)(String). package: yandex.cloud.organizationmanager.v1filename: yandex/cloud/organizationmanager/v1/user_ssh_key.proto
- `expires_at` (String). Used for temporary keys, if empty the key doesn't expire
- `fingerprint` (*Read-Only*) (String). package: yandex.cloud.organizationmanager.v1filename: yandex/cloud/organizationmanager/v1/user_ssh_key.proto
- `id` (String). package: yandex.cloud.organizationmanager.v1filename: yandex/cloud/organizationmanager/v1/user_ssh_key_service.proto
- `name` (String). package: yandex.cloud.organizationmanager.v1filename: yandex/cloud/organizationmanager/v1/user_ssh_key.proto
- `organization_id` (**Required**)(String). package: yandex.cloud.organizationmanager.v1filename: yandex/cloud/organizationmanager/v1/user_ssh_key.proto
- `subject_id` (**Required**)(String). package: yandex.cloud.organizationmanager.v1filename: yandex/cloud/organizationmanager/v1/user_ssh_key.proto
- `user_ssh_key_id` (String). package: yandex.cloud.organizationmanager.v1filename: yandex/cloud/organizationmanager/v1/user_ssh_key_service.proto

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_organizationmanager_user_ssh_key.<resource Name> <resource Id>
terraform import yandex_organizationmanager_user_ssh_key.my_user_ssh_key ...
```
