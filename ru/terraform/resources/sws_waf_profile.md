---
subcategory: Smart Web Security
---

# yandex_sws_waf_profile (Resource)



## Example usage

```terraform
//
// Create a new SWS WAF Profile (Minimal).
//
resource "yandex_sws_waf_profile" "minimal" {
  // NOTE: WAF profile must have at least one rule set, otherwise backend
  // rejects the request with `waf profile must have at least one rule`.
  // See the next example to see how to enable a default set of rules.
  name = "waf-profile-minimal"

  rule_set {
    action     = "DENY"
    is_enabled = true
    priority   = 1
    core_rule_set {
      inbound_anomaly_score = 2
      paranoia_level        = 1
      rule_set {
        name    = "OWASP Core Ruleset"
        version = "4.0.0"
        type    = "CORE"
      }
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

  rule_set {
    action     = "DENY"
    is_enabled = true
    priority   = 1
    core_rule_set {
      inbound_anomaly_score = 2
      paranoia_level        = local.waf_paranoia_level
      rule_set {
        name    = "OWASP Core Ruleset"
        version = "4.0.0"
        type    = "CORE"
      }
    }
  }

  dynamic "rule" {
    for_each = [
      for rule in data.yandex_sws_waf_rule_set_descriptor.owasp4.rules : rule
      if rule.paranoia_level <= local.waf_paranoia_level
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

- `cloud_id` (String). ID of the cloud that the WAF profile belongs to.
- `created_at` (*Read-Only*) (String). Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
- `description` (String). Optional description of the WAF profile.
- `folder_id` (String). ID of the folder that the WAF profile belongs to.
- `id` (String). ID of the WafProfile resource to return.
- `labels` (Map Of String). Labels as `` key:value `` pairs. Maximum of 64 per resource.
- `match_all_rule_sets` (Bool). Determines
- `name` (**Required**)(String). Name of the WAF profile. The name is unique within the folder. 1-50 characters long.
- `waf_profile_id` (String). ID of the WafProfile resource to return.
- `analyze_request_body` [Block]. The parameter is deprecated. Parameters for request body analyzer.
  - `is_enabled` (Bool). Possible to turn analyzer on and turn if off.
  - `size_limit` (Number). Maximum size of body to pass to analyzer. In kilobytes.
  - `size_limit_action` (String). Action to perform if maximum size of body exceeded.
- `core_rule_set` [Block]. The parameter is deprecated. Core rule set settings.
  - `inbound_anomaly_score` (Number). Anomaly score.
 Enter an integer within the range of 2 and 10000.
 The higher this value, the more likely it is that the request that satisfies the rule is an attack.
 See [Rules](/docs/smartwebsecurity/concepts/waf#anomaly) for more details.
  - `paranoia_level` (Number). Paranoia level.
 Enter an integer within the range of 1 and 4.
 Paranoia level classifies rules according to their aggression. The higher the paranoia level, the better your protection,
 but also the higher the probability of WAF false positives.
 See [Rules](/docs/smartwebsecurity/concepts/waf#paranoia) for more details.
 NOTE: this option has no effect on enabling or disabling rules.
 it is used only as recommendation for user to enable all rules with paranoia_level <= this value.
  - `rule_set` [Block]. Rule set.
    - `id` (String). ID of rule set.
    - `name` (**Required**)(String). Name of rule set.
    - `type` (String). Type of rule set.
    - `version` (**Required**)(String). Version of rule set.
- `exclusion_rule` [Block]. List of exclusion rules. See [Rules](/docs/smartwebsecurity/concepts/waf#exclusion-rules).
  - `description` (String). Optional description of the rule. 0-512 characters long.
  - `log_excluded` (Bool). Records the fact that an exception rule is triggered.
  - `name` (**Required**)(String). Name of exclusion rule.
  - `condition` [Block]. The condition for matching traffic.
    - `authority` [Block]. Match authority (Host header).
      - `authorities` [Block]. List of authorities. OR semantics implied.
        - `defined` (Bool). Matches if the field is defined.
        - `exact_match` (String). Exact match condition.
        - `exact_not_match` (String). Exact not match condition.
        - `pire_regex_match` (String). PIRE regex match condition.
        - `pire_regex_not_match` (String). PIRE regex not match condition.
        - `prefix_match` (String). Prefix match condition.
        - `prefix_not_match` (String). Prefix not match condition.
        - `lists_matchers` [Block]. Matches against string and regular expression lists.
          - `reg_exp_lists_match` [Block]. Regular expression lists to match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `reg_exp_lists_not_match` [Block]. Regular expression lists to not match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `str_lists_match` [Block]. String lists to match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `str_lists_not_match` [Block]. String lists to not match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
      - `authority_matcher` [Block]. Authority matcher.
        - `defined` (Bool). Matches if the field is defined.
        - `exact_match` (String). Exact match condition.
        - `exact_not_match` (String). Exact not match condition.
        - `pire_regex_match` (String). PIRE regex match condition.
        - `pire_regex_not_match` (String). PIRE regex not match condition.
        - `prefix_match` (String). Prefix match condition.
        - `prefix_not_match` (String). Prefix not match condition.
        - `lists_matchers` [Block]. Matches against string and regular expression lists.
          - `reg_exp_lists_match` [Block]. Regular expression lists to match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `reg_exp_lists_not_match` [Block]. Regular expression lists to not match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `str_lists_match` [Block]. String lists to match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `str_lists_not_match` [Block]. String lists to not match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
    - `bot_category` [Block]. Match bot category.
      - `bot_category_lists_match` [Block]. Bot category lists to match with.
        - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
      - `bot_category_lists_not_match` [Block]. Bot category lists to not match with.
        - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
    - `bot_name` [Block]. Match bot name.
      - `bot_name_lists_match` [Block]. Bot name lists to match with.
        - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
      - `bot_name_lists_not_match` [Block]. Bot name lists to not match with.
        - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
    - `bot_score` [Block]. Match bot score.
      - `value` [Block]. List of integer matchers for bot score. OR semantics implied.
        - `eq_match` [Block]. Equal condition.
          - `value` (Number). Value to match against.
        - `ge_match` [Block]. Greater than or equal condition.
          - `value` (Number). Lower bound value (inclusive).
        - `le_match` [Block]. Less than or equal condition.
          - `value` (Number). Upper bound value (inclusive).
        - `ne_match` [Block]. Not equal condition.
          - `value` (Number). Value to not match against.
    - `cookies` [Block]. Match cookies.
      - `name` (**Required**)(String). Name of the cookie parametr.
      - `value` [Block]. Value of the cookie parametr.
        - `defined` (Bool). Matches if the field is defined.
        - `exact_match` (String). Exact match condition.
        - `exact_not_match` (String). Exact not match condition.
        - `pire_regex_match` (String). PIRE regex match condition.
        - `pire_regex_not_match` (String). PIRE regex not match condition.
        - `prefix_match` (String). Prefix match condition.
        - `prefix_not_match` (String). Prefix not match condition.
        - `lists_matchers` [Block]. Matches against string and regular expression lists.
          - `reg_exp_lists_match` [Block]. Regular expression lists to match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `reg_exp_lists_not_match` [Block]. Regular expression lists to not match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `str_lists_match` [Block]. String lists to match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `str_lists_not_match` [Block]. String lists to not match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
    - `finger_print` [Block]. Match fingerprint.
      - `ja3_matcher` [Block]. JA3 fingerprint matcher.
        - `defined` (Bool). Matches if the field is defined.
        - `exact_match` (String). Exact match condition.
        - `exact_not_match` (String). Exact not match condition.
        - `pire_regex_match` (String). PIRE regex match condition.
        - `pire_regex_not_match` (String). PIRE regex not match condition.
        - `prefix_match` (String). Prefix match condition.
        - `prefix_not_match` (String). Prefix not match condition.
        - `lists_matchers` [Block]. Matches against string and regular expression lists.
          - `reg_exp_lists_match` [Block]. Regular expression lists to match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `reg_exp_lists_not_match` [Block]. Regular expression lists to not match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `str_lists_match` [Block]. String lists to match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `str_lists_not_match` [Block]. String lists to not match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
      - `ja3_ranges` [Block]. List of JA3 fingerprint matchers. OR semantics implied.
        - `defined` (Bool). Matches if the field is defined.
        - `exact_match` (String). Exact match condition.
        - `exact_not_match` (String). Exact not match condition.
        - `pire_regex_match` (String). PIRE regex match condition.
        - `pire_regex_not_match` (String). PIRE regex not match condition.
        - `prefix_match` (String). Prefix match condition.
        - `prefix_not_match` (String). Prefix not match condition.
        - `lists_matchers` [Block]. Matches against string and regular expression lists.
          - `reg_exp_lists_match` [Block]. Regular expression lists to match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `reg_exp_lists_not_match` [Block]. Regular expression lists to not match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `str_lists_match` [Block]. String lists to match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `str_lists_not_match` [Block]. String lists to not match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
      - `ja4_matcher` [Block]. JA4 fingerprint matcher.
        - `defined` (Bool). Matches if the field is defined.
        - `exact_match` (String). Exact match condition.
        - `exact_not_match` (String). Exact not match condition.
        - `pire_regex_match` (String). PIRE regex match condition.
        - `pire_regex_not_match` (String). PIRE regex not match condition.
        - `prefix_match` (String). Prefix match condition.
        - `prefix_not_match` (String). Prefix not match condition.
        - `lists_matchers` [Block]. Matches against string and regular expression lists.
          - `reg_exp_lists_match` [Block]. Regular expression lists to match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `reg_exp_lists_not_match` [Block]. Regular expression lists to not match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `str_lists_match` [Block]. String lists to match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `str_lists_not_match` [Block]. String lists to not match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
      - `ja4_ranges` [Block]. List of JA4 fingerprint matchers. OR semantics implied.
        - `defined` (Bool). Matches if the field is defined.
        - `exact_match` (String). Exact match condition.
        - `exact_not_match` (String). Exact not match condition.
        - `pire_regex_match` (String). PIRE regex match condition.
        - `pire_regex_not_match` (String). PIRE regex not match condition.
        - `prefix_match` (String). Prefix match condition.
        - `prefix_not_match` (String). Prefix not match condition.
        - `lists_matchers` [Block]. Matches against string and regular expression lists.
          - `reg_exp_lists_match` [Block]. Regular expression lists to match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `reg_exp_lists_not_match` [Block]. Regular expression lists to not match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `str_lists_match` [Block]. String lists to match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `str_lists_not_match` [Block]. String lists to not match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
    - `headers` [Block]. Match HTTP headers.
      - `name` (**Required**)(String). Name of header (case insensitive).
      - `value` [Block]. Value of the header.
        - `defined` (Bool). Matches if the field is defined.
        - `exact_match` (String). Exact match condition.
        - `exact_not_match` (String). Exact not match condition.
        - `pire_regex_match` (String). PIRE regex match condition.
        - `pire_regex_not_match` (String). PIRE regex not match condition.
        - `prefix_match` (String). Prefix match condition.
        - `prefix_not_match` (String). Prefix not match condition.
        - `lists_matchers` [Block]. Matches against string and regular expression lists.
          - `reg_exp_lists_match` [Block]. Regular expression lists to match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `reg_exp_lists_not_match` [Block]. Regular expression lists to not match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `str_lists_match` [Block]. String lists to match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `str_lists_not_match` [Block]. String lists to not match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
    - `http_method` [Block]. Match HTTP method.
      - `http_method_matcher` [Block]. HTTP method matcher.
        - `defined` (Bool). Matches if the field is defined.
        - `exact_match` (String). Exact match condition.
        - `exact_not_match` (String). Exact not match condition.
        - `pire_regex_match` (String). PIRE regex match condition.
        - `pire_regex_not_match` (String). PIRE regex not match condition.
        - `prefix_match` (String). Prefix match condition.
        - `prefix_not_match` (String). Prefix not match condition.
        - `lists_matchers` [Block]. Matches against string and regular expression lists.
          - `reg_exp_lists_match` [Block]. Regular expression lists to match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `reg_exp_lists_not_match` [Block]. Regular expression lists to not match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `str_lists_match` [Block]. String lists to match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `str_lists_not_match` [Block]. String lists to not match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
      - `http_methods` [Block]. List of HTTP methods. OR semantics implied.
        - `defined` (Bool). Matches if the field is defined.
        - `exact_match` (String). Exact match condition.
        - `exact_not_match` (String). Exact not match condition.
        - `pire_regex_match` (String). PIRE regex match condition.
        - `pire_regex_not_match` (String). PIRE regex not match condition.
        - `prefix_match` (String). Prefix match condition.
        - `prefix_not_match` (String). Prefix not match condition.
        - `lists_matchers` [Block]. Matches against string and regular expression lists.
          - `reg_exp_lists_match` [Block]. Regular expression lists to match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `reg_exp_lists_not_match` [Block]. Regular expression lists to not match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `str_lists_match` [Block]. String lists to match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `str_lists_not_match` [Block]. String lists to not match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
    - `request_uri` [Block]. Match Request URI.
      - `path` [Block]. Path of the URI [RFC3986](https://datatracker.ietf.org/doc/html/rfc3986#section-3.3).
        - `defined` (Bool). Matches if the field is defined.
        - `exact_match` (String). Exact match condition.
        - `exact_not_match` (String). Exact not match condition.
        - `pire_regex_match` (String). PIRE regex match condition.
        - `pire_regex_not_match` (String). PIRE regex not match condition.
        - `prefix_match` (String). Prefix match condition.
        - `prefix_not_match` (String). Prefix not match condition.
        - `lists_matchers` [Block]. Matches against string and regular expression lists.
          - `reg_exp_lists_match` [Block]. Regular expression lists to match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `reg_exp_lists_not_match` [Block]. Regular expression lists to not match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `str_lists_match` [Block]. String lists to match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
          - `str_lists_not_match` [Block]. String lists to not match with.
            - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
      - `queries` [Block]. List of query matchers. AND semantics implied.
        - `key` (**Required**)(String). Key of the query parameter.
        - `value` [Block]. Value of the query parameter.
          - `defined` (Bool). Matches if the field is defined.
          - `exact_match` (String). Exact match condition.
          - `exact_not_match` (String). Exact not match condition.
          - `pire_regex_match` (String). PIRE regex match condition.
          - `pire_regex_not_match` (String). PIRE regex not match condition.
          - `prefix_match` (String). Prefix match condition.
          - `prefix_not_match` (String). Prefix not match condition.
          - `lists_matchers` [Block]. Matches against string and regular expression lists.
            - `reg_exp_lists_match` [Block]. Regular expression lists to match with.
              - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
            - `reg_exp_lists_not_match` [Block]. Regular expression lists to not match with.
              - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
            - `str_lists_match` [Block]. String lists to match with.
              - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
            - `str_lists_not_match` [Block]. String lists to not match with.
              - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
    - `source_ip` [Block]. Match IP.
      - `asn_lists_match` [Block]. ASN lists to match with.
        - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
      - `asn_lists_not_match` [Block]. ASN lists to not match with.
        - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
      - `asn_ranges_match` [Block]. ASN ranges to match with.
        - `asn_ranges` (List Of Number). List of ASN values to match against. OR semantics implied.
      - `asn_ranges_not_match` [Block]. ASN ranges to not match with.
        - `asn_ranges` (List Of Number). List of ASN values to match against. OR semantics implied.
      - `geo_ip_match` [Block]. Geo locations to match with.
        - `locations` (List Of String). ISO 3166-1 alpha 2. OR semantics implied.
      - `geo_ip_not_match` [Block]. Geo locations to not match with.
        - `locations` (List Of String). ISO 3166-1 alpha 2. OR semantics implied.
      - `ip_lists_match` [Block]. IP lists to match with.
        - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
      - `ip_lists_not_match` [Block]. IP lists to not match with.
        - `list_ids` (List Of String). List of list IDs to match against. OR semantics implied.
      - `ip_ranges_match` [Block]. IP ranges to match with.
        - `ip_ranges` (List Of String). List of IP ranges. OR semantics implied.
      - `ip_ranges_not_match` [Block]. IP ranges to not match with.
        - `ip_ranges` (List Of String). List of IP ranges. OR semantics implied.
    - `verified_bot` [Block]. Match verified bot.
      - `verified` [Block]. Matches if the bot is verified or not.
        - `match` (Bool). Boolean value to match against.
  - `exclude_rules` [Block]. Exclude rules.
    - `exclude_all` (Bool). Set this option true to exclude all rules.
    - `rule_ids` (List Of String). List of rules to exclude.
  - `request_condition` [Block]. Additional condition applied to specific parts of the request to refine when the exclusion is triggered.
    - `body_matcher` [Block]. Matcher for request body.
      - `body_value` [Block]. package: yandex.cloud.smartwebsecurity.v1.waf
filename: yandex/cloud/smartwebsecurity/v1/waf/waf_profile.proto

        - `case_sensitive` (Bool). package: yandex.cloud.smartwebsecurity.v1.waf
filename: yandex/cloud/smartwebsecurity/v1/waf/waf_profile.proto

        - `value` (String). package: yandex.cloud.smartwebsecurity.v1.waf
filename: yandex/cloud/smartwebsecurity/v1/waf/waf_profile.proto

    - `cookie_matcher` [Block]. Matcher for request cookies.
      - `cookie_name` [Block]. package: yandex.cloud.smartwebsecurity.v1.waf
filename: yandex/cloud/smartwebsecurity/v1/waf/waf_profile.proto

        - `case_sensitive` (Bool). package: yandex.cloud.smartwebsecurity.v1.waf
filename: yandex/cloud/smartwebsecurity/v1/waf/waf_profile.proto

        - `value` (String). package: yandex.cloud.smartwebsecurity.v1.waf
filename: yandex/cloud/smartwebsecurity/v1/waf/waf_profile.proto

    - `header_matcher` [Block]. Matcher for request headers.
      - `header_name` [Block]. package: yandex.cloud.smartwebsecurity.v1.waf
filename: yandex/cloud/smartwebsecurity/v1/waf/waf_profile.proto

        - `case_sensitive` (Bool). package: yandex.cloud.smartwebsecurity.v1.waf
filename: yandex/cloud/smartwebsecurity/v1/waf/waf_profile.proto

        - `value` (String). package: yandex.cloud.smartwebsecurity.v1.waf
filename: yandex/cloud/smartwebsecurity/v1/waf/waf_profile.proto

    - `param_matcher` [Block]. Matcher for request query parameters.
      - `param_name` [Block]. package: yandex.cloud.smartwebsecurity.v1.waf
filename: yandex/cloud/smartwebsecurity/v1/waf/waf_profile.proto

        - `case_sensitive` (Bool). package: yandex.cloud.smartwebsecurity.v1.waf
filename: yandex/cloud/smartwebsecurity/v1/waf/waf_profile.proto

        - `value` (String). package: yandex.cloud.smartwebsecurity.v1.waf
filename: yandex/cloud/smartwebsecurity/v1/waf/waf_profile.proto

- `rule` [Block]. Settings for each rule in rule set.
  - `is_blocking` (Bool). Determines is it rule blocking or not.
  - `is_enabled` (Bool). Determines is it rule enabled or not.
  - `rule_id` (**Required**)(String). Rule ID.
- `rule_set` [Block]. List of rule sets.
  - `action` (String). Action to perfome on rule set match.
  - `is_enabled` (Bool). Determines is it rule set enabled or not.
  - `priority` (Number). Priority of rule set.
  - `core_rule_set` [Block]. Core rule set settings. See [Basic rule set](/docs/smartwebsecurity/concepts/waf#rules-set) for details.
    - `inbound_anomaly_score` (Number). Matcher for request headers.
    - `paranoia_level` (Number). Matcher for request cookies.
    - `rule_set` [Block]. Matcher for request query parameters.
      - `id` (String). ID of rule set.
      - `name` (**Required**)(String). Name of rule set.
      - `type` (String). Type of rule set.
      - `version` (**Required**)(String). Version of rule set.
  - `ml_rule_set` [Block]. Yandex Machine learning rule set settings.
    - `rule_groups` [Block]. package: yandex.cloud.smartwebsecurity.v1.waf
filename: yandex/cloud/smartwebsecurity/v1/waf/waf_profile.proto

      - `action` (String). List of rules to exclude.
      - `id` (String). Set this option true to exclude all rules.
      - `inbound_anomaly_score` (Number). package: yandex.cloud.smartwebsecurity.v1.waf
filename: yandex/cloud/smartwebsecurity/v1/waf/waf_profile.proto

      - `is_enabled` (Bool). package: yandex.cloud.smartwebsecurity.v1.waf
filename: yandex/cloud/smartwebsecurity/v1/waf/waf_profile.proto

    - `rule_set` [Block]. package: yandex.cloud.smartwebsecurity.v1.waf
filename: yandex/cloud/smartwebsecurity/v1/waf/waf_profile.proto

      - `id` (String). ID of rule set.
      - `name` (**Required**)(String). Name of rule set.
      - `type` (String). Type of rule set.
      - `version` (**Required**)(String). Version of rule set.
  - `ya_rule_set` [Block]. Yandex rule set settings.
    - `rule_group` [Block]. package: yandex.cloud.smartwebsecurity.v1.waf
filename: yandex/cloud/smartwebsecurity/v1/waf/waf_profile.proto

      - `action` (String). List of rules to exclude.
      - `id` (String). Set this option true to exclude all rules.
      - `inbound_anomaly_score` (Number). package: yandex.cloud.smartwebsecurity.v1.waf
filename: yandex/cloud/smartwebsecurity/v1/waf/waf_profile.proto

      - `is_enabled` (Bool). package: yandex.cloud.smartwebsecurity.v1.waf
filename: yandex/cloud/smartwebsecurity/v1/waf/waf_profile.proto

    - `rule_set` [Block]. package: yandex.cloud.smartwebsecurity.v1.waf
filename: yandex/cloud/smartwebsecurity/v1/waf/waf_profile.proto

      - `id` (String). ID of rule set.
      - `name` (**Required**)(String). Name of rule set.
      - `type` (String). Type of rule set.
      - `version` (**Required**)(String). Version of rule set.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_sws_waf_profile.<resource Name> <resource Id>
terraform import yandex_sws_waf_profile.default ...
```
