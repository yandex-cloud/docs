```hcl
resource "yandex_organizationmanager_mfa_enforcement" "example_mfa_policy" {
  name            = "<policy_name>"
  organization_id = "<organization_ID>"
  acr_id          = "<authentication_factor_type>"
  ttl             = "<lifetime>"
  status          = "<policy_status>"
  apply_at        = "<activation_time>"
  enroll_window   = "<creation_deadline>"
  description     = "<policy_description>"
}
```