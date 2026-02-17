---
subcategory: Smart Web Security
---

# yandex_sws_security_profile (Resource)

With security profiles you can protect your infrastructure from DDoS attacks at the application level (L7).

Creates a Security Profile in the specified folder. For more information, see [the official documentation](https://yandex.cloud/docs/smartwebsecurity/concepts/profiles).

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
- `cloud_id` (String). The `Cloud ID` which resource belongs to. If it is not provided, the default provider `cloud-id` is used.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `default_action` (String). Action to perform if none of rules matched. Possible values: `ALLOW` or `DENY`.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `analyze_request_body` [Block]. Analyze request body.
  - `size_limit` (Number). 
  - `size_limit_action` (String). 
- `security_rule` [Block]. List of security rules.

{% note warning %}

Exactly one rule specifier: `smart_protection` or `rule_condition` or `waf` should be specified.

{% endnote %}


  - `description` (String). Optional description of the rule. 0-512 characters long.
  - `dry_run` (Bool). This mode allows you to test your security profile or a single rule.
  - `name` (String). Name of the rule. The name is unique within the security profile. 1-50 characters long.
  - `priority` (Number). Determines the priority for checking the incoming traffic.
  - `rule_condition` [Block]. Rule actions, see [Rule actions](https://yandex.cloud/en/docs/smartwebsecurity/concepts/rules#rule-action).
    - `action` (String). Action to perform if this rule matched. Possible values: `ALLOW` or `DENY`.
    - `condition` [Block]. The condition for matching the rule. You can find all possibilities of condition in [gRPC specs](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/smartwebsecurity/v1/security_profile.proto).
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
      - `source_ip` [Block]. 
        - `geo_ip_match` [Block]. 
          - `locations` (List Of String). 
        - `geo_ip_not_match` [Block]. 
          - `locations` (List Of String). 
        - `ip_ranges_match` [Block]. 
          - `ip_ranges` (List Of String). 
        - `ip_ranges_not_match` [Block]. 
          - `ip_ranges` (List Of String). 
  - `smart_protection` [Block]. Smart Protection rule, see [Smart Protection rules](https://yandex.cloud/en/docs/smartwebsecurity/concepts/rules#smart-protection-rules).
    - `mode` (String). Mode of protection. Possible values: `FULL` (full protection means that the traffic will be checked based on ML models and behavioral analysis, with suspicious requests being sent to SmartCaptcha) or `API` (API protection means checking the traffic based on ML models and behavioral analysis without sending suspicious requests to SmartCaptcha. The suspicious requests will be blocked).
    - `condition` [Block]. The condition for matching the rule. You can find all possibilities of condition in [gRPC specs](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/smartwebsecurity/v1/security_profile.proto).
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
      - `source_ip` [Block]. 
        - `geo_ip_match` [Block]. 
          - `locations` (List Of String). 
        - `geo_ip_not_match` [Block]. 
          - `locations` (List Of String). 
        - `ip_ranges_match` [Block]. 
          - `ip_ranges` (List Of String). 
        - `ip_ranges_not_match` [Block]. 
          - `ip_ranges` (List Of String). 
  - `waf` [Block]. Web Application Firewall (WAF) rule, see [WAF rules](https://yandex.cloud/en/docs/smartwebsecurity/concepts/rules#waf-rules).
    - `mode` (String). Mode of protection. Possible values: `FULL` (full protection means that the traffic will be checked based on ML models and behavioral analysis, with suspicious requests being sent to SmartCaptcha) or `API` (API protection means checking the traffic based on ML models and behavioral analysis without sending suspicious requests to SmartCaptcha. The suspicious requests will be blocked).
    - `waf_profile_id` (**Required**)(String). ID of WAF profile to use in this rule.
    - `condition` [Block]. The condition for matching the rule. You can find all possibilities of condition in [gRPC specs](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/smartwebsecurity/v1/security_profile.proto).
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
      - `source_ip` [Block]. 
        - `geo_ip_match` [Block]. 
          - `locations` (List Of String). 
        - `geo_ip_not_match` [Block]. 
          - `locations` (List Of String). 
        - `ip_ranges_match` [Block]. 
          - `ip_ranges` (List Of String). 
        - `ip_ranges_not_match` [Block]. 
          - `ip_ranges` (List Of String).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_sws_security_profile.<resource Name> <resource Id>
terraform import yandex_sws_security_profile.demo-profile-simple ...
```
