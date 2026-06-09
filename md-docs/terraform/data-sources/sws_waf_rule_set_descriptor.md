# yandex_sws_waf_rule_set_descriptor (DataSource)



## Example usage

```terraform
//
// Get information about existing SWS WAF Rule Descriptor
//
data "yandex_sws_waf_rule_set_descriptor" "owasp4" {
  name    = "OWASP Core Ruleset"
  version = "4.0.0"
}
```

## Arguments & Attributes Reference

- `id` (String). ID of the rule set
- `name` (**Required**)(String). Name of the RuleSetDescriptor resource to return.
- `rule_set_descriptor_id` (*Read-Only*) (String). ID of the rule set
- `rules` [Block]. List of rules
  - `anomaly_score` (*Read-Only*) (Number). Numeric anomaly value, i.e., a potential attack indicator.
 The higher this value, the more likely it is that the request that satisfies the rule is an attack.
 See [documentation](../../smartwebsecurity/concepts/waf.md#anomaly).
  - `id` (String). ID of the rule
  - `paranoia_level` (*Read-Only*) (Number). Paranoia level classifies rules according to their aggression.
 The higher the paranoia level, the better your protection, but also the higher the probability of WAF false positives.
 See [documentation](../../smartwebsecurity/concepts/waf.md#paranoia).
  - `rule_set_descriptor_id` (*Read-Only*) (String). ID of the rule
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
- `version` (**Required**)(String). Version of the RuleSetDescriptor resource to return.