---
subcategory: Identity Hub
---

# yandex_organizationmanager_os_login_settings (Resource)

Allows management of OsLogin Settings within an existing Yandex Cloud Organization.

## Example usage

```terraform
//
// Create a new OrganizationManager OS Login Settings.
//
resource "yandex_organizationmanager_os_login_settings" "my_settings" {
  organization_id = "sdf4*********3fr"
  user_ssh_key_settings {
    enabled               = true
    allow_manage_own_keys = true
  }
  ssh_certificate_settings {
    enabled = true
  }
}
```

## Arguments & Attributes Reference

- `id` (String). 
- `organization_id` (**Required**)(String). The organization to manage it's OsLogin Settings.
- `ssh_certificate_settings` [Block]. SSH Certificate settings.
  - `enabled` (Bool). Enables or disables usage of SSH certificates signed by trusted Certification Authority (CA).
- `user_ssh_key_settings` [Block]. Users SSH key settings.
  - `allow_manage_own_keys` (Bool). If set to true subject is allowed to manage own ssh keys without having to be assigned specific permissions.
  - `enabled` (Bool). Enables or disables usage of ssh keys assigned to a specific subject.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_organizationmanager_os_login_settings.<resource Name> <resource Id>
terraform import yandex_organizationmanager_os_login_settings.my_settings ...
```
