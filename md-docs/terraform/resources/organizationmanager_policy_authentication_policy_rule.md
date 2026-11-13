[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Identity Hub > Resources > organizationmanager_policy_authentication_policy_rule

# yandex_organizationmanager_policy_authentication_policy_rule (Resource)




## Arguments & Attributes Reference

- `applications_exclude` (Set Of String). List of IDs of applications not affected by the authentication policy rule.
 Empty list matches no applications.
- `applications_include` (Set Of String). List of IDs of applications affected by the authentication policy rule.
 Empty list matches all applications.
- `created_at` (*Read-Only*) (String). Creation timestamp.
- `description` (String). Description of an authentication policy rule. 0-256 characters long.
- `effect` (String). Effect to apply when the rule matches.
- `id` (String). ID of the authentication policy rule to retrieve.
- `labels` (Map Of String). Labels of the authentication policy rule.
- `name` (**Required**)(String). Name of the authentication policy rule.
 The name is unique within the organization and contains 1-63 characters.
- `networks_exclude` (Set Of String). Source IP ranges in CIDR notation excluded from the authentication policy rule.
 Empty list matches no sources.
- `networks_include` (Set Of String). Source IP ranges in CIDR notation that the authentication policy rule applies to.
 Empty list matches any source and is functionally equal to ["0.0.0.0/0", "::0/0"].
- `obligations` [Block]. Obligations to satisfy when the effect is ALLOW_WITH_OBLIGATIONS.
  - `reauthentication_required` [Block]. Require full authentication again.
    - `ttl` (**Required**)(String). Maximum age of an authentication that can satisfy this obligation.
  - `skip_mfa` [Block]. Allow skipping the organization's current MFA requirements.
    - `require_once` (Bool). If true, the organization's current MFA requirements must have been satisfied at least once
 during the current session.
  - `step_up_required` [Block]. Require step-up authentication.
    - `acr_id` (**Required**)(String). ACR ID required to satisfy this obligation.
    - `ttl` (**Required**)(String). Maximum age of a factor verification that can satisfy this obligation.
- `organization_id` (**Required**)(String). ID of the organization that the authentication policy rule belongs to.
- `rule_id` (String). ID of the authentication policy rule to retrieve.
- `status` (*Read-Only*) (String). Status of the authentication policy rule.
- `subjects_exclude` (Set Of String). List of IDs of subjects not affected by the authentication policy rule.
 Empty list matches no subjects.
- `subjects_include` (Set Of String). List of IDs of subjects affected by the authentication policy rule.
 Empty list matches all subjects and is functionally equal to ["allUsers"].
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
- `updated_at` (*Read-Only*) (String). Modification timestamp.