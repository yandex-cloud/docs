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
- `organization_id` (String). ID of the organization.
- `ssh_certificate_settings` [Block]. 
  - `enabled` (Bool). 
- `user_ssh_key_settings` [Block]. 
  - `allow_manage_own_keys` (Bool). 
  - `enabled` (Bool).


