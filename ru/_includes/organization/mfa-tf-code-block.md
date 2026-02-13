```hcl
resource "yandex_organizationmanager_mfa_enforcement" "example_mfa_policy" {
  name            = "<имя_политики>"
  organization_id = "<идентификатор_организации>"
  acr_id          = "<тип_фактора_аутентификации>"
  ttl             = "<время_жизни>"
  status          = "<статус_политики>"
  apply_at        = "<время_активации>"
  enroll_window   = "<срок_создания>"
  description     = "<описание_политики>"
}
```