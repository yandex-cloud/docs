---
subcategory: Smart Web Security
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/sws_waf_profile.md
---

# yandex_sws_waf_profile (DataSource)

Get information about WAF Profile. For more information, see [the official documentation](https://yandex.cloud/docs/smartwebsecurity/quickstart#waf).
This data source is used to define WAF Profile that can be used by other resources.

{% note warning %}

One of `waf_profile_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing SWS WAF Profile.
//
data "yandex_sws_waf_profile" "by-id" {
  waf_profile_id = yandex_sws_waf_profile.my-profile.id
}

data "yandex_sws_waf_profile" "by-name" {
  name = yandex_sws_waf_profile.my-profile.name
}
```

## Arguments & Attributes Reference

- `analyze_request_body` [Block]. Parameters for request body analyzer.
  - `is_enabled` (Bool). Possible to turn analyzer on and turn if off.
  - `size_limit` (Number). Maximum size of body to pass to analyzer. In kilobytes.
  - `size_limit_action` (String). Action to perform if maximum size of body exceeded. Possible values: `IGNORE` and `DENY`.
- `cloud_id` (String). The `Cloud ID` which resource belongs to. If it is not provided, the default provider `cloud-id` is used.
- `core_rule_set` [Block]. Core rule set settings. See [Basic rule set](https://yandex.cloud/en/docs/smartwebsecurity/concepts/waf#rules-set) for details.
  - `inbound_anomaly_score` (Number). Anomaly score. Enter an integer within the range of 2 and 10000. The higher this value, the more likely it is that the request that satisfies the rule is an attack. See [Rules](https://yandex.cloud/en/docs/smartwebsecurity/concepts/waf#anomaly) for more details.
  - `paranoia_level` (Number). Paranoia level. Enter an integer within the range of 1 and 4. Paranoia level classifies rules according to their aggression. The higher the paranoia level, the better your protection, but also the higher the probability of WAF false positives. See [Rules](https://yandex.cloud/en/docs/smartwebsecurity/concepts/waf#paranoia) for more details. NOTE: this option has no effect on enabling or disabling rules, it is used only as recommendation for user to enable all rules with paranoia_level <= this value.
  - `rule_set` [Block]. Rule set settings. See [Basic rule set](https://yandex.cloud/en/docs/smartwebsecurity/concepts/waf#rules-set) for details.
    - `id` (String). Id of the rule set.
    - `name` (String). Name of the rule set.
    - `type` (String). Type of the rule set.
    - `version` (**Required**)(String). Version of the rule set.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `exclusion_rule` [Block]. List of exclusion rules. See [Rules](https://yandex.cloud/en/docs/smartwebsecurity/concepts/waf#exclusion-rules).
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
  - `description` (String). Description of the rule. 0-512 characters long.
  - `exclude_rules` [Block]. Exclude rules.
    - `exclude_all` (Bool). Set this option true to exclude all rules.
    - `rule_ids` (List Of String). List of rules to exclude.
  - `log_excluded` (Bool). Records the fact that an exception rule is triggered.
  - `name` (String). Name of exclusion rule.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `match_all_rule_sets` (Bool). 
- `name` (String). The resource name.
- `rule` [Block]. Settings for each rule in rule set.
  - `is_blocking` (Bool). Determines is it rule blocking or not.
  - `is_enabled` (Bool). Determines is it rule enabled or not.
  - `rule_id` (**Required**)(String). Rule ID.
- `rule_set` [Block]. Rule set.
  - `action` (String). Action of the rule set.
  - `core_rule_set` [Block]. Core rule set.
    - `inbound_anomaly_score` (Number). Inbound anomaly score of the rule set.
    - `paranoia_level` (Number). Paranoia level of the rule set.
    - `rule_set` [Block]. Rule set.
      - `id` (String). ID of the rule set.
      - `name` (String). Name of the rule set.
      - `type` (String). Type of the rule set.
      - `version` (**Required**)(String). Version of the rule set.
  - `is_enabled` (Bool). Determines is it rule set enabled or not.
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
  - `priority` (Number). Priority of the rule set.
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
- `waf_profile_id` (String). ID of the WAF profile.


