---
subcategory: Identity Hub
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/organizationmanager_mfa_enforcement.md
---

# yandex_organizationmanager_mfa_enforcement (Resource)

MFA enforcement resource

## Example usage

```terraform
//
// Create a new OrganizationManager MFA Enforcement.
//
resource "yandex_organizationmanager_mfa_enforcement" "example_mfa_enforcement" {
  name            = "example-mfa-enforcement"
  organization_id = "your_organization_id"
  acr_id 	 	      = "any-mfa"
  ttl 			      = "2h45m"
  status 		      = "MFA_ENFORCEMENT_STATUS_ACTIVE"
  enroll_window   = "2h45m"
  description     = "Description example"
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
- `ttl` (**Required**)(String). the period during which the entered MFA factor is considered valid and the 
 corresponding acr is regarded as satisfied


