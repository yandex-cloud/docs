---
subcategory: Identity Hub
---

# yandex_organizationmanager_mfa_enforcement (DataSource)

MFA enforcement resource

## Example usage

```terraform
//
// OrganizationManager MFA Enforcement.
//
data "yandex_organizationmanager_mfa_enforcement" "example_mfa_enforcement" {
  acr_id 	 	      = "any-mfa"
}
```

## Arguments & Attributes Reference

- `acr_id` (**Required**)(String). acr id of the MFA enforcement
- `apply_at` (String). the MFA enforcement application start time.
- `created_at` (*Read-Only*) (String). creation timestamp
- `description` (String). description of the MFA enforcement
- `enroll_window` (**Required**)(String). the time window during which the user is allowed to create an MFA profile. 
 this window is measured relative to the MFA enforcement application start time
 and the user's most recent successful authentication that falls under the rule 
 (or the user's creation time, if there has been no authentication).
- `id` (String). id of the MFA enforcement
- `mfa_enforcement_id` (String). id of the MFA enforcement
- `name` (**Required**)(String). name of the MFA enforcement
- `organization_id` (**Required**)(String). organization id of the MFA enforcement
- `status` (String). MFA enforcement status
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
- `ttl` (**Required**)(String). the period during which the entered MFA factor is considered valid and the 
 corresponding acr is regarded as satisfied


