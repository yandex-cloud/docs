[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Smart Web Security > Resources > sws_security_profile

# yandex_sws_security_profile (Resource)

A SecurityProfile resource.

## Example usage

```terraform
//
// Create a new SWS Security Profile (Simple).
//
resource "yandex_sws_security_profile" "demo-profile-simple" {
  name           = "demo-profile-simple"
  default_action = "ALLOW"

  security_rule {
    name     = "smart-protection"
    priority = 99999

    smart_protection {
      mode = "API"
    }
  }
}
```
```terraform
//
// Create a new SWS Security Profile (Advanced).
//
resource "yandex_sws_security_profile" "demo-profile-advanced" {
  name                             = "demo-profile-advanced"
  default_action                   = "ALLOW"
  captcha_id                       = "<captcha_id>"
  advanced_rate_limiter_profile_id = "<arl_id>"

  security_rule {
    name     = "smart-protection"
    priority = 99999

    smart_protection {
      mode = "API"
    }
  }

  security_rule {
    name     = "waf"
    priority = 88888

    waf {
      mode           = "API"
      waf_profile_id = "<waf_id>"
    }
  }

  security_rule {
    name     = "rule-condition-1"
    priority = 1

    rule_condition {
      action = "ALLOW"

      condition {
        authority {
          authorities {
            exact_match = "example.com"
          }
          authorities {
            exact_match = "example.net"
          }
        }
      }
    }
  }

  security_rule {
    name     = "rule-condition-2"
    priority = 2

    rule_condition {
      action = "DENY"

      condition {
        http_method {
          http_methods {
            exact_match = "DELETE"
          }
          http_methods {
            exact_match = "PUT"
          }
        }
      }
    }
  }

  security_rule {
    name     = "rule-condition-3"
    priority = 3

    rule_condition {
      action = "DENY"

      condition {
        request_uri {
          path {
            prefix_match = "/form"
          }
          queries {
            key = "firstname"
            value {
              pire_regex_match = ".*ivan.*"
            }
          }
          queries {
            key = "lastname"
            value {
              pire_regex_match = ".*petr.*"
            }
          }
        }

        headers {
          name = "User-Agent"
          value {
            pire_regex_match = ".*curl.*"
          }
        }
        headers {
          name = "Referer"
          value {
            pire_regex_not_match = ".*bot.*"
          }
        }

        source_ip {
          ip_ranges_match {
            ip_ranges = ["1.2.33.44", "2.3.4.56"]
          }
          ip_ranges_not_match {
            ip_ranges = ["8.8.0.0/16", "10::1234:1abc:1/64"]
          }
          geo_ip_match {
            locations = ["ru", "es"]
          }
          geo_ip_not_match {
            locations = ["us", "fm", "gb"]
          }
        }
      }
    }
  }
}
```

## Arguments & Attributes Reference

- `advanced_rate_limiter_profile_id` (String). Advanced rate limiter profile ID to use with this security profile. Set empty to use default.
- `captcha_id` (String). Captcha ID to use with this security profile. Set empty to use default.
- `cloud_id` (String). ID of the cloud that the security profile belongs to.
- `created_at` (*Read-Only*) (String). Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
- `custom_page_id` (*Read-Only*) (String). ID of the default custom page shown to the user when a request is denied.
- `default_action` (**Required**)(String). Action to perform if none of rules matched.
- `description` (String). Optional description of the security profile.
- `disallow_data_processing` (*Read-Only*) (Bool). Disables the use of HTTP request data for training and improving the service's ML models.
- `folder_id` (String). ID of the folder that the security profile belongs to.
- `id` (String). ID of the SecurityProfile resource to return.
- `labels` (Map Of String). Labels as `` key:value `` pairs. Maximum of 64 per resource.
- `log_group_id` (*Read-Only*) (String). ID of the Cloud Logging log group to write SWS logs to.
- `log_options` [Block]. Configures logging of requests processed by SWS to Audit Trails and Cloud Logging.
  - `discard_allow_percentage` (*Read-Only*) (Number). Percentage of ALLOW verdicts to discard from logging (0-100).
  - `enable` (*Read-Only*) (Bool). Enables logging of requests processed by SWS.
  - `enabled_actions` (*Read-Only*) (List Of String). List of verdicts for which requests will be logged.
  - `enabled_modules` (*Read-Only*) (List Of String). List of modules whose requests will be logged.
  - `log_group_id` (*Read-Only*) (String). ID of the Cloud Logging log group to write SWS logs to.
  - `outputs` (*Read-Only*) (List Of String). List of log destinations: Cloud Logging and/or Audit Trails.
- `name` (**Required**)(String). Name of the security profile. The name is unique within the folder. 1-50 characters long.
- `security_profile_id` (String). ID of the SecurityProfile resource to return.
- `analyze_request_body` [Block]. Parameters for request body analyzer.
  - `size_limit` (Number). Maximum size of body to pass to analyzer. In kilobytes.
  - `size_limit_action` (**Required**)(String). Action to perform if maximum size of body exceeded.
- `security_rule` [Block]. List of security rules.
  - `custom_page_id` (String). ID of the custom page shown to the user when the rule denies a request.
  - `description` (String). Optional description of the rule. 0-512 characters long.
  - `dry_run` (Bool). This mode allows you to test your security profile or a single rule.
 For example, you can have the number of alarms for a specific rule displayed.
 Note: if this option is true, no real action affecting your traffic regarding this rule will be taken.
  - `name` (**Required**)(String). Name of the rule. The name is unique within the security profile. 1-50 characters long.
  - `priority` (Number). Determines the priority for checking the incoming traffic.
 Enter an integer within the range of 1 and 999999.
 The rule priority must be unique within the entire security profile.
 A lower numeric value means a higher priority.
 The default_action has the lowest priority.
  - `rule_condition` [Block]. Rule actions, see [Rule actions](../../smartwebsecurity/concepts/rules.md#rule-action).
    - `action` (**Required**)(String). Action to perform if this rule matched.
    - `condition` [Block]. The condition for matching the rule.
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
  - `smart_protection` [Block]. Smart Protection rule, see [Smart Protection rules](../../smartwebsecurity/concepts/rules.md#smart-protection-rules).
    - `mode` (**Required**)(String). Mode of protection.
    - `condition` [Block]. The condition for matching the rule.
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
  - `waf` [Block]. Web Application Firewall (WAF) rule, see [WAF rules](../../smartwebsecurity/concepts/rules.md#waf-rules).
    - `mode` (**Required**)(String). Mode of protection.
    - `waf_profile_id` (**Required**)(String). ID of WAF profile to use in this rule.
    - `condition` [Block]. The condition for matching the rule.
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
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](../../cli/quickstart.md).

```shell
# terraform import yandex_sws_security_profile.<resource Name> <resource Id>
terraform import yandex_sws_security_profile.demo-profile-simple ...
```