---
subcategory: Identity Hub
---

# yandex_organizationmanager_os_login_settings (DataSource)

Get information about a Yandex Cloud OS Login Settings.

## Example usage

```terraform
//
// Get information about existing OrganizationManager OS Login Settings.
//
data "yandex_organizationmanager_os_login_settings" "my_os_login_settings_settings" {
  organization_id = "some_organization_id"
}

output "my_organization_ssh_certificates_enabled" {
  value = "data.yandex_organizationmanager_os_login_settings.my_os_login_settings.ssh_certificate_settings.0.enabled"
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


