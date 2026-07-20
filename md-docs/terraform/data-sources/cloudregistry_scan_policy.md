[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Cloud Registry > Data Sources > cloudregistry_scan_policy

# yandex_cloudregistry_scan_policy (DataSource)




## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). Output only. Creation timestamp.
- `description` (String). Description of the scan policy.
 The maximum string length in characters is 256.
- `disabled` (Bool). Turns off scan policy.
- `id` (String). ID of the scan policy.
- `name` (String). Name of the scan policy.
- `registry_id` (**Required**)(String). ID of the registry that the scan policy belongs to.
 Required. The maximum string length in characters is 50.
- `rules` [Block]. The rules of scan policy.
  - `push_rule` [Block]. Description of on-push scan rule.
    - `disabled` (Bool). Turns off scan rule.
    - `paths` (List Of String). List of paths that are scanned with rule. Child paths are included into parent node. "*" - means all artifacts in registry
  - `schedule_rules` [Block]. Description of time based rescan rule.
    - `amount` (Number). Amount of time units for the scan interval.
    - `disabled` (Bool). Turns off scan rule.
    - `interval_unit` (String). Unit for the scan interval.
    - `paths` (List Of String). List of paths that are scanned with rule. Child paths are included into parent node. "*" - means all artifacts in registry
- `scan_policy_id` (String). ID of the scan policy.
- `scan_policy_options` [Block]. Scan policy options.
  - `scan_lang_packages` (*Read-Only*) (Bool). Flag indicating whether language packages should be scanned.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).