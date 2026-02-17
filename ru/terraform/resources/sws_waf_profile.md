---
subcategory: Smart Web Security
---

# yandex_sws_waf_profile (Resource)

Creates a WAF Profile in the specified folder. For more information, see [the official documentation](https://yandex.cloud/docs/smartwebsecurity/quickstart#waf).

## Example usage

```terraform
//
// Create a new SWS WAF Profile (Empty).
//
resource "yandex_sws_waf_profile" "empty" {
  // NOTE: this WAF profile do not contains any rules enabled.
  // See the next example to see how to enable default set of rules. 
  name = "waf-profile-dummy"

  core_rule_set {
    inbound_anomaly_score = 2
    paranoia_level        = 1
    rule_set {
      name    = "OWASP Core Ruleset"
      version = "4.0.0"
    }
  }
}
```
```terraform
//
// Create a new SWS WAF Profile (Default).
//
locals {
  waf_paranoia_level = 1
}

data "yandex_sws_waf_rule_set_descriptor" "owasp4" {
  name    = "OWASP Core Ruleset"
  version = "4.0.0"
}

resource "yandex_sws_waf_profile" "default" {
  name = "waf-profile-default"

  core_rule_set {
    inbound_anomaly_score = 2
    paranoia_level        = local.waf_paranoia_level
    rule_set {
      name    = "OWASP Core Ruleset"
      version = "4.0.0"
    }
  }

  dynamic "rule" {
    for_each = [
      for rule in data.yandex_sws_waf_rule_set_descriptor.owasp4.rules : rule
      if rule.paranoia_level >= local.waf_paranoia_level
    ]
    content {
      rule_id     = rule.value.id
      is_enabled  = true
      is_blocking = false
    }
  }

  analyze_request_body {
    is_enabled        = true
    size_limit        = 8
    size_limit_action = "IGNORE"
  }
}
```

## Arguments & Attributes Reference

- `cloud_id` (String). The `Cloud ID` which resource belongs to. If it is not provided, the default provider `cloud-id` is used.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `match_all_rule_sets` (Bool). 
- `name` (String). The resource name.
- `analyze_request_body` [Block]. Parameters for request body analyzer.
  - `is_enabled` (Bool). Possible to turn analyzer on and turn if off.
  - `size_limit` (Number). Maximum size of body to pass to analyzer. In kilobytes.
  - `size_limit_action` (String). Action to perform if maximum size of body exceeded. Possible values: `IGNORE` and `DENY`.
- `core_rule_set` [Block]. Core rule set settings. See [Basic rule set](https://yandex.cloud/en/docs/smartwebsecurity/concepts/waf#rules-set) for details.
  - `inbound_anomaly_score` (Number). Anomaly score. Enter an integer within the range of 2 and 10000. The higher this value, the more likely it is that the request that satisfies the rule is an attack. See [Rules](https://yandex.cloud/en/docs/smartwebsecurity/concepts/waf#anomaly) for more details.
  - `paranoia_level` (Number). Paranoia level. Enter an integer within the range of 1 and 4. Paranoia level classifies rules according to their aggression. The higher the paranoia level, the better your protection, but also the higher the probability of WAF false positives. See [Rules](https://yandex.cloud/en/docs/smartwebsecurity/concepts/waf#paranoia) for more details. NOTE: this option has no effect on enabling or disabling rules, it is used only as recommendation for user to enable all rules with paranoia_level <= this value.
  - `rule_set` [Block]. Rule set settings. See [Basic rule set](https://yandex.cloud/en/docs/smartwebsecurity/concepts/waf#rules-set) for details.
    - `id` (String). Id of the rule set.
    - `name` (String). Name of the rule set.
    - `type` (String). Type of the rule set.
    - `version` (**Required**)(String). Version of the rule set.
- `exclusion_rule` [Block]. List of exclusion rules. See [Rules](https://yandex.cloud/en/docs/smartwebsecurity/concepts/waf#exclusion-rules).
  - `description` (String). Description of the rule. 0-512 characters long.
  - `log_excluded` (Bool). Records the fact that an exception rule is triggered.
  - `name` (String). Name of exclusion rule.
  - `condition` [Block]. 
    - `authority` [Block]. 
      - `authorities` [Block]. 
        - `exact_match` (String). 
        - `exact_not_match` (String). 
        - `pire_regex_match` (String). 
        - `pire_regex_not_match` (String). 
        - `prefix_match` (String). 
        - `prefix_not_match` (String). 
    - `headers` [Block]. 
      - `name` (String). 
      - `value` [Block]. 
        - `exact_match` (String). 
        - `exact_not_match` (String). 
        - `pire_regex_match` (String). 
        - `pire_regex_not_match` (String). 
        - `prefix_match` (String). 
        - `prefix_not_match` (String). 
    - `http_method` [Block]. 
      - `http_methods` [Block]. 
        - `exact_match` (String). 
        - `exact_not_match` (String). 
        - `pire_regex_match` (String). 
        - `pire_regex_not_match` (String). 
        - `prefix_match` (String). 
        - `prefix_not_match` (String). 
    - `request_uri` [Block]. 
      - `path` [Block]. 
        - `exact_match` (String). 
        - `exact_not_match` (String). 
        - `pire_regex_match` (String). 
        - `pire_regex_not_match` (String). 
        - `prefix_match` (String). 
        - `prefix_not_match` (String). 
      - `queries` [Block]. 
        - `key` (**Required**)(String). 
        - `value` [Block]. 
          - `exact_match` (String). 
          - `exact_not_match` (String). 
          - `pire_regex_match` (String). 
          - `pire_regex_not_match` (String). 
          - `prefix_match` (String). 
          - `prefix_not_match` (String). 
    - `source_ip` [Block]. Source IP.
      - `geo_ip_match` [Block]. Locations to include.
        - `locations` (List Of String). Locations to include.
      - `geo_ip_not_match` [Block]. Locations to exclude.
        - `locations` (List Of String). Locations to exclude.
      - `ip_ranges_match` [Block]. IP ranges to include.
        - `ip_ranges` (List Of String). IP ranges to include.
      - `ip_ranges_not_match` [Block]. IP ranges to exclude.
        - `ip_ranges` (List Of String). IP ranges to exclude.
  - `exclude_rules` [Block]. Exclude rules.
    - `exclude_all` (Bool). Set this option true to exclude all rules.
    - `rule_ids` (List Of String). List of rules to exclude.
- `rule` [Block]. Settings for each rule in rule set.
  - `is_blocking` (Bool). Determines is it rule blocking or not.
  - `is_enabled` (Bool). Determines is it rule enabled or not.
  - `rule_id` (**Required**)(String). Rule ID.
- `rule_set` [Block]. Rule set.
  - `action` (String). Action of the rule set.
  - `is_enabled` (Bool). Determines is it rule set enabled or not.
  - `priority` (Number). Priority of the rule set.
  - `core_rule_set` [Block]. Core rule set.
    - `inbound_anomaly_score` (Number). Inbound anomaly score of the rule set.
    - `paranoia_level` (Number). Paranoia level of the rule set.
    - `rule_set` [Block]. Rule set.
      - `id` (String). ID of the rule set.
      - `name` (String). Name of the rule set.
      - `type` (String). Type of the rule set.
      - `version` (**Required**)(String). Version of the rule set.
  - `ml_rule_set` [Block]. List of ML rule sets.
    - `rule_group` [Block]. List of rule groups.
      - `action` (String). Action of the rule group.
      - `id` (String). ID of the rule group.
      - `inbound_anomaly_score` (Number). Inbound anomaly score.
      - `is_enabled` (Bool). Is the rule group enabled.
    - `rule_set` [Block]. Rule set of the ML rule set.
      - `id` (String). ID of the rule set.
      - `name` (String). Name of the rule set.
      - `type` (String). Type of the rule set.
      - `version` (**Required**)(String). Version of the rule set.
  - `ya_rule_set` [Block]. Yandex rule set.
    - `rule_group` [Block]. List of rule groups.
      - `action` (String). Action of the rule group.
      - `id` (String). ID of the rule group.
      - `inbound_anomaly_score` (Number). Inbound anomaly score.
      - `is_enabled` (Bool). Is the rule group enabled.
    - `rule_set` [Block]. Rule set of the Yandex rule set.
      - `id` (String). ID of the rule set.
      - `name` (String). Name of the rule set.
      - `type` (String). Type of the rule set.
      - `version` (**Required**)(String). Version of the rule set.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_sws_waf_profile.<resource Name> <resource Id>
terraform import yandex_sws_waf_profile.default ...
```
