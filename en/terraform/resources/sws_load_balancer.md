---
subcategory: Smart Web Security
---

# yandex_sws_load_balancer (Resource)

A Smart Web Security load balancer resource.


## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). Creation time.
- `ddos_protection_provider` (*Read-Only*) (String). L3-L4 DDoS protection provider. Currently supported: "" or "qrator".
- `deletion_protection` (Bool). Forbids Delete() calls.
 NOTE: Deletion in status CREATING still allow even if deletion_protection is set.
- `description` (String). Description of the load balancer.
- `folder_id` (String). ID of the folder that the load balancer belongs to.
- `id` (String). ID of the load balancer to return.
- `ip_address` (*Read-Only*) (String). IP address of resulting balancer.
- `labels` (Map Of String). Resource labels as `key:value` pairs.
- `load_balancer_id` (String). ID of the load balancer to return.
- `log_group_id` (*Read-Only*) (String). Cloud logging log group ID.
 If empty string was passed to log options, this field will contain ID of default log group.
 If logs are disabled, this field will contain empty string.
- `log_options` [Block]. Cloud logging settings.
  - `disable` (Bool). Do not send logs to Cloud Logging log group.
  - `discard_rule` [Block]. Ordered list of rules, first matching rule applies.
    - `discard_percent` (Number). Percent of logs to be discarded: 0 - keep all, 100 or unset - discard all.
    - `http_code_intervals` (List Of String). Groups of HTTP codes like 4xx that should be discarded.
    - `http_codes` (List Of Number). HTTP codes that should be discarded.
  - `log_group_id` (String). ID of Cloud Logging log group.
 Keep empty to use default log group.
- `name` (**Required**)(String). Name of the load balancer.
- `region_id` (**Required**)(String). "ru-central1", "kz1", etc.
- `resource_units` (Number). Number of initially allocated resource units.
 Zero means the minimum configured for the service installation.
- `route_options` [Block]. Options that apply to all domains.
  - `modify_request_headers` [Block]. Apply the following modifications to the request headers.
    - `append` (String). Append string to the header value.
    - `name` (**Required**)(String). Name of the header.
    - `remove` (Bool). Remove the header.
    - `rename` (String). New name for a header.
    - `replace` (String). New value for a header.
  - `modify_response_headers` [Block]. Apply the following modifications to the response headers.
    - `append` (String). Append string to the header value.
    - `name` (**Required**)(String). Name of the header.
    - `remove` (Bool). Remove the header.
    - `rename` (String). New name for a header.
    - `replace` (String). New value for a header.
- `service_account_id` (String). Service account for access to certificate, securityProfile and logGroup.
- `status` (*Read-Only*) (String). Status of the load balancer.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
- `updated_at` (*Read-Only*) (String). Last time when the load balancer was modified.


