[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Smart Captcha > Data Sources > smartcaptcha_captcha

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

- `allowed_sites` (*Read-Only*) (List Of String). List of allowed host names, see [Domain validation](../../smartcaptcha/concepts/domain-validation.md).
- `captcha_id` (String). ID of the Captcha resource to return.
- `challenge_type` (*Read-Only*) (String). Additional task type of the captcha.
- `client_key` (*Read-Only*) (String). Client key of the captcha, see [CAPTCHA keys](../../smartcaptcha/concepts/keys.md).
- `cloud_id` (String). ID of the cloud that the captcha belongs to.
- `complexity` (*Read-Only*) (String). Complexity of the captcha.
- `created_at` (*Read-Only*) (String). Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
- `deletion_protection` (*Read-Only*) (Bool). Determines whether captcha is protected from being deleted.
- `description` (*Read-Only*) (String). Optional description of the captcha.
- `disallow_data_processing` (*Read-Only*) (Bool). Disables the use of HTTP request data for training and improving the service's ML models.
- `folder_id` (String). ID of the folder that the captcha belongs to.
- `id` (String). ID of the Captcha resource to return.
- `labels` (*Read-Only*) (Map Of String). Labels as `` key:value `` pairs. Maximum of 64 per resource.
- `name` (String). Name of the captcha. The name is unique within the folder. 3-63 characters long.
- `override_variant` [Block]. List of variants to use in security_rules
  - `challenge_type` (*Read-Only*) (String). Additional task type of the captcha.
  - `complexity` (*Read-Only*) (String). Complexity of the captcha.
  - `description` (*Read-Only*) (String). Optional description of the rule. 0-512 characters long.
  - `pre_check_type` (*Read-Only*) (String). Basic check type of the captcha.
  - `uuid` (*Read-Only*) (String). Unique identifier of the variant.
- `pre_check_type` (*Read-Only*) (String). Basic check type of the captcha.
- `security_rule` [Block]. List of security rules.
  - `condition` [Block]. The condition for matching the rule.
    - `headers` [Block]. Captcha request headers.
      - `name` (**Required**)(String). Name of header (case insensitive).
      - `value` [Block]. Value of the header.
        - `exact_match` (*Read-Only*) (String). Exact match condition.
        - `exact_not_match` (*Read-Only*) (String). Exact not match condition.
        - `pire_regex_match` (*Read-Only*) (String). PIRE regex match condition.
        - `pire_regex_not_match` (*Read-Only*) (String). PIRE regex not match condition.
        - `prefix_match` (*Read-Only*) (String). Prefix match condition.
        - `prefix_not_match` (*Read-Only*) (String). Prefix not match condition.
    - `host` [Block]. *AND* semantics implied.
      - `host_matcher` [Block]. Host matcher.
        - `exact_match` (*Read-Only*) (String). Exact match condition.
        - `exact_not_match` (*Read-Only*) (String). Exact not match condition.
        - `pire_regex_match` (*Read-Only*) (String). PIRE regex match condition.
        - `pire_regex_not_match` (*Read-Only*) (String). PIRE regex not match condition.
        - `prefix_match` (*Read-Only*) (String). Prefix match condition.
        - `prefix_not_match` (*Read-Only*) (String). Prefix not match condition.
      - `hosts` [Block]. List of hosts. OR semantics implied.
        - `exact_match` (*Read-Only*) (String). Exact match condition.
        - `exact_not_match` (*Read-Only*) (String). Exact not match condition.
        - `pire_regex_match` (*Read-Only*) (String). PIRE regex match condition.
        - `pire_regex_not_match` (*Read-Only*) (String). PIRE regex not match condition.
        - `prefix_match` (*Read-Only*) (String). Prefix match condition.
        - `prefix_not_match` (*Read-Only*) (String). Prefix not match condition.
    - `source_ip` [Block]. The IP address of the requester.
      - `geo_ip_match` [Block]. Geo locations to match with.
        - `locations` (*Read-Only*) (List Of String). *OR semantics implied. ISO 3166-1 alpha 2
      - `geo_ip_not_match` [Block]. Geo locations to not match with.
        - `locations` (*Read-Only*) (List Of String). *OR semantics implied. ISO 3166-1 alpha 2
      - `ip_ranges_match` [Block]. IP ranges to match with.
        - `ip_ranges` (*Read-Only*) (List Of String). *OR* semantics implied.
      - `ip_ranges_not_match` [Block]. IP ranges to not match with.
        - `ip_ranges` (*Read-Only*) (List Of String). *OR* semantics implied.
    - `uri` [Block]. URI where captcha placed.
      - `path` [Block]. Path of the URI [RFC3986](https://datatracker.ietf.org/doc/html/rfc3986#section-3.3).
        - `exact_match` (*Read-Only*) (String). Exact match condition.
        - `exact_not_match` (*Read-Only*) (String). Exact not match condition.
        - `pire_regex_match` (*Read-Only*) (String). PIRE regex match condition.
        - `pire_regex_not_match` (*Read-Only*) (String). PIRE regex not match condition.
        - `prefix_match` (*Read-Only*) (String). Prefix match condition.
        - `prefix_not_match` (*Read-Only*) (String). Prefix not match condition.
      - `queries` [Block]. *AND* semantics implied
        - `key` (*Read-Only*) (String). Key of the query parameter.
        - `value` [Block]. Value of the query parameter.
          - `exact_match` (*Read-Only*) (String). Exact match condition.
          - `exact_not_match` (*Read-Only*) (String). Exact not match condition.
          - `pire_regex_match` (*Read-Only*) (String). PIRE regex match condition.
          - `pire_regex_not_match` (*Read-Only*) (String). PIRE regex not match condition.
          - `prefix_match` (*Read-Only*) (String). Prefix match condition.
          - `prefix_not_match` (*Read-Only*) (String). Prefix not match condition.
  - `description` (*Read-Only*) (String). Optional description of the rule. 0-512 characters long.
  - `name` (**Required**)(String). Name of the rule. The name is unique within the captcha. 1-50 characters long.
  - `override_variant_uuid` (*Read-Only*) (String). Variant UUID to show in case of match the rule. Keep empty to use defaults.
  - `priority` (*Read-Only*) (Number). Priority of the rule. Lower value means higher priority.
- `style_json` (*Read-Only*) (String). JSON with variables to define the captcha appearance. For more details see generated JSON in cloud console.
- `suspend` (*Read-Only*) (Bool). Determines that the captcha is currently in restricted mode, see [SmartCaptcha restricted mode](../../smartcaptcha/concepts/restricted-mode.md).
- `turn_off_hostname_check` (*Read-Only*) (Bool). Turn off host name check, see [Domain validation](../../smartcaptcha/concepts/domain-validation.md).
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).