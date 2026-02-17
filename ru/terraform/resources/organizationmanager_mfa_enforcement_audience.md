---
subcategory: Identity Hub
---

# yandex_organizationmanager_mfa_enforcement_audience (Resource)

MFA enforcement audience resource

## Example usage

```terraform
//
// Example OrganizationManager MFA Enforcement.
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

//
// Create a new OrganizationManager MFA Enforcement Audience.
//
resource "yandex_organizationmanager_mfa_enforcement_audience" "example_mfa_enforcement_audience" {
  mfa_enforcement_id = yandex_organizationmanager_mfa_enforcement.example_mfa_enforcement.id
  subject_id         = "your_subject_id"
}
```

## Arguments & Attributes Reference

- `mfa_enforcement_id` (**Required**)(String). MFA enforcement id
- `subject_id` (**Required**)(String). Subject id


