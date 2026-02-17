---
subcategory: Smart Web Security
---

# yandex_sws_security_profile (DataSource)

Get information about SecurityProfile. For more information, see [the official documentation](https://yandex.cloud/docs/smartwebsecurity/concepts/profiles).

This data source is used to define SecurityProfile that can be used by other resources.

{% note warning %}

One of `security_profile_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing SWS Security Profile.
//
data "yandex_sws_security_profile" "by-id" {
  security_profile_id = yandex_sws_security_profile.my-profile.id
}

data "yandex_sws_security_profile" "by-name" {
  name = yandex_sws_security_profile.my-profile.name
}
```

## Arguments & Attributes Reference

- `advanced_rate_limiter_profile_id` (String). Advanced rate limiter profile ID to use with this security profile. Set empty to use default.
- `analyze_request_body` [Block]. Analyze request body.
  - `size_limit` (Number). 
  - `size_limit_action` (String). 
- `captcha_id` (String). Captcha ID to use with this security profile. Set empty to use default.
- `cloud_id` (String). The `Cloud ID` which resource belongs to. If it is not provided, the default provider `cloud-id` is used.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `default_action` (String). Action to perform if none of rules matched. Possible values: `ALLOW` or `DENY`.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `security_profile_id` (String). ID of the security profile.
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
    - `mode` (String). Mode of protection. Possible values: `FULL` (full protection means that the traffic will be checked based on ML models and behavioral analysis, with suspicious requests being sent to SmartCaptcha) or `API` (API protection means checking the traffic based on ML models and behavioral analysis without sending suspicious requests to SmartCaptcha. The suspicious requests will be blocked).
  - `waf` [Block]. Web Application Firewall (WAF) rule, see [WAF rules](https://yandex.cloud/en/docs/smartwebsecurity/concepts/rules#waf-rules).
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
    - `mode` (String). Mode of protection. Possible values: `FULL` (full protection means that the traffic will be checked based on ML models and behavioral analysis, with suspicious requests being sent to SmartCaptcha) or `API` (API protection means checking the traffic based on ML models and behavioral analysis without sending suspicious requests to SmartCaptcha. The suspicious requests will be blocked).
    - `waf_profile_id` (**Required**)(String). ID of WAF profile to use in this rule.


