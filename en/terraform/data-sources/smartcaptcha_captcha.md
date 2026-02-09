---
subcategory: Smart Captcha
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/smartcaptcha_captcha.md
---

# yandex_smartcaptcha_captcha (DataSource)

A Captcha resource.

## Example usage

```terraform
//
// Get SmartCaptcha details by Id.
//
data "yandex_smartcaptcha_captcha" "by-id" {
  captcha_id = yandex_smartcaptcha_captcha.my-captcha.id
}
```
```terraform
//
// Get SmartCaptcha details by Name.
//
data "yandex_smartcaptcha_captcha" "by-name" {
  name = yandex_smartcaptcha_captcha.my-captcha.name
}
```

## Arguments & Attributes Reference

- `allowed_sites` (List Of String). List of allowed host names, see [Domain validation](/docs/smartcaptcha/concepts/domain-validation).
- `captcha_id` (String). ID of the Captcha resource to return.
- `challenge_type` (String). Additional task type of the captcha.
- `client_key` (*Read-Only*) (String). Client key of the captcha, see [CAPTCHA keys](/docs/smartcaptcha/concepts/keys).
- `cloud_id` (String). ID of the cloud that the captcha belongs to.
- `complexity` (String). Complexity of the captcha.
- `created_at` (*Read-Only*) (String). Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
- `deletion_protection` (Bool). Determines whether captcha is protected from being deleted.
- `description` (String). Optional description of the captcha.
- `disallow_data_processing` (Bool). If true, Yandex team won't be able to read internal data.
- `folder_id` (String). ID of the folder that the captcha belongs to.
- `id` (String). ID of the Captcha resource to return.
- `labels` (Map Of String). Resource labels as `key:value` pairs.
- `name` (String). Name of the captcha. The name is unique within the folder. 3-63 characters long.
- `override_variant` [Block]. List of variants to use in security_rules
  - `challenge_type` (String). Additional task type of the captcha.
  - `complexity` (String). Complexity of the captcha.
  - `description` (String). Optional description of the rule. 0-512 characters long.
  - `pre_check_type` (String). Basic check type of the captcha.
  - `uuid` (String). Unique identifier of the variant.
- `pre_check_type` (String). Basic check type of the captcha.
- `security_rule` [Block]. List of security rules.
  - `condition` [FW-Block]. The condition for matching the rule.
    - `headers` [FW-Block]. Captcha request headers.
      - `name` (**Required**)(String). Name of header (case insensitive).
      - `value` [FW-Block]. Value of the header.
        - `exact_match` (String). package: yandex.cloud.smartcaptcha.v1filename: yandex/cloud/smartcaptcha/v1/captcha.proto
        - `exact_not_match` (String). package: yandex.cloud.smartcaptcha.v1filename: yandex/cloud/smartcaptcha/v1/captcha.proto
        - `pire_regex_match` (String). package: yandex.cloud.smartcaptcha.v1filename: yandex/cloud/smartcaptcha/v1/captcha.proto
        - `pire_regex_not_match` (String). package: yandex.cloud.smartcaptcha.v1filename: yandex/cloud/smartcaptcha/v1/captcha.proto
        - `prefix_match` (String). package: yandex.cloud.smartcaptcha.v1filename: yandex/cloud/smartcaptcha/v1/captcha.proto
        - `prefix_not_match` (String). package: yandex.cloud.smartcaptcha.v1filename: yandex/cloud/smartcaptcha/v1/captcha.proto
    - `host` [FW-Block]. Host where captcha placed.
      - `hosts` [FW-Block]. List of hosts. OR semantics implied.
        - `exact_match` (String). package: yandex.cloud.smartcaptcha.v1filename: yandex/cloud/smartcaptcha/v1/captcha.proto
        - `exact_not_match` (String). package: yandex.cloud.smartcaptcha.v1filename: yandex/cloud/smartcaptcha/v1/captcha.proto
        - `pire_regex_match` (String). package: yandex.cloud.smartcaptcha.v1filename: yandex/cloud/smartcaptcha/v1/captcha.proto
        - `pire_regex_not_match` (String). package: yandex.cloud.smartcaptcha.v1filename: yandex/cloud/smartcaptcha/v1/captcha.proto
        - `prefix_match` (String). package: yandex.cloud.smartcaptcha.v1filename: yandex/cloud/smartcaptcha/v1/captcha.proto
        - `prefix_not_match` (String). package: yandex.cloud.smartcaptcha.v1filename: yandex/cloud/smartcaptcha/v1/captcha.proto
    - `source_ip` [FW-Block]. The IP address of the requester.
      - `geo_ip_match` [FW-Block]. package: yandex.cloud.smartcaptcha.v1filename: yandex/cloud/smartcaptcha/v1/captcha.proto
        - `locations` (List Of String). ISO 3166-1 alpha 2. OR semantics implied.
      - `geo_ip_not_match` [FW-Block]. package: yandex.cloud.smartcaptcha.v1filename: yandex/cloud/smartcaptcha/v1/captcha.proto
        - `locations` (List Of String). ISO 3166-1 alpha 2. OR semantics implied.
      - `ip_ranges_match` [FW-Block]. package: yandex.cloud.smartcaptcha.v1filename: yandex/cloud/smartcaptcha/v1/captcha.proto
        - `ip_ranges` (List Of String). List of IP ranges. OR semantics implied.
      - `ip_ranges_not_match` [FW-Block]. package: yandex.cloud.smartcaptcha.v1filename: yandex/cloud/smartcaptcha/v1/captcha.proto
        - `ip_ranges` (List Of String). List of IP ranges. OR semantics implied.
    - `uri` [FW-Block]. URI where captcha placed.
      - `path` [FW-Block]. Path of the URI [RFC3986](https://datatracker.ietf.org/doc/html/rfc3986#section-3.3).
        - `exact_match` (String). package: yandex.cloud.smartcaptcha.v1filename: yandex/cloud/smartcaptcha/v1/captcha.proto
        - `exact_not_match` (String). package: yandex.cloud.smartcaptcha.v1filename: yandex/cloud/smartcaptcha/v1/captcha.proto
        - `pire_regex_match` (String). package: yandex.cloud.smartcaptcha.v1filename: yandex/cloud/smartcaptcha/v1/captcha.proto
        - `pire_regex_not_match` (String). package: yandex.cloud.smartcaptcha.v1filename: yandex/cloud/smartcaptcha/v1/captcha.proto
        - `prefix_match` (String). package: yandex.cloud.smartcaptcha.v1filename: yandex/cloud/smartcaptcha/v1/captcha.proto
        - `prefix_not_match` (String). package: yandex.cloud.smartcaptcha.v1filename: yandex/cloud/smartcaptcha/v1/captcha.proto
      - `queries` [FW-Block]. List of query matchers. AND semantics implied.
        - `key` (**Required**)(String). Key of the query parameter.
        - `value` [FW-Block]. Value of the query parameter.
          - `exact_match` (String). package: yandex.cloud.smartcaptcha.v1filename: yandex/cloud/smartcaptcha/v1/captcha.proto
          - `exact_not_match` (String). package: yandex.cloud.smartcaptcha.v1filename: yandex/cloud/smartcaptcha/v1/captcha.proto
          - `pire_regex_match` (String). package: yandex.cloud.smartcaptcha.v1filename: yandex/cloud/smartcaptcha/v1/captcha.proto
          - `pire_regex_not_match` (String). package: yandex.cloud.smartcaptcha.v1filename: yandex/cloud/smartcaptcha/v1/captcha.proto
          - `prefix_match` (String). package: yandex.cloud.smartcaptcha.v1filename: yandex/cloud/smartcaptcha/v1/captcha.proto
          - `prefix_not_match` (String). package: yandex.cloud.smartcaptcha.v1filename: yandex/cloud/smartcaptcha/v1/captcha.proto
  - `description` (String). Optional description of the rule. 0-512 characters long.
  - `name` (**Required**)(String). Name of the rule. The name is unique within the captcha. 1-50 characters long.
  - `override_variant_uuid` (String). Variant UUID to show in case of match the rule. Keep empty to use defaults.
  - `priority` (Number). Priority of the rule. Lower value means higher priority.
- `style_json` (String). JSON with variables to define the captcha appearance. For more details see generated JSON in cloud console.
- `suspend` (*Read-Only*) (Bool). Determines that the captcha is currently in restricted mode, see [SmartCaptcha restricted mode](/docs/smartcaptcha/concepts/restricted-mode).
- `turn_off_hostname_check` (Bool). Turn off host name check, see [Domain validation](/docs/smartcaptcha/concepts/domain-validation).


