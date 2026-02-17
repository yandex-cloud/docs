---
subcategory: Smart Web Security
---

# yandex_sws_advanced_rate_limiter_profile (Resource)

Creates an SWS Advanced Rate Limiter (ARL) profile in the specified folder. For more information, see [the official documentation](https://yandex.cloud/docs/smartwebsecurity/quickstart#arl).

## Example usage

```terraform
//
// Create a new SWS Advanced Rate Limiter Profile.
//
resource "yandex_sws_advanced_rate_limiter_profile" "demo-profile" {
  name = "demo-profile"

  advanced_rate_limiter_rule {
    name        = "rule1"
    priority    = 10
    description = "First test rule"
    dry_run     = true

    static_quota {
      action = "DENY"
      limit  = 10000000
      period = 1
      condition {
        request_uri {
          path {
            exact_match = "/api"
          }
        }
      }
    }
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
- `name` (String). The resource name.
- `advanced_rate_limiter_rule` [Block]. List of rules.

{% note warning %}

Exactly one rule specifier: `static_quota` or `dynamic_quota` should be specified.

{% endnote %}


  - `description` (String). Description of the rule. 0-512 characters long.
  - `dry_run` (Bool). This allows you to evaluate backend capabilities and find the optimum limit values. Requests will not be blocked in this mode.
  - `name` (String). Name of the rule. The name is unique within the ARL profile. 1-50 characters long.
  - `priority` (Number). Determines the priority in case there are several matched rules. Enter an integer within the range of 1 and 999999. The rule priority must be unique within the entire ARL profile. A lower numeric value means a higher priority.
  - `dynamic_quota` [Block]. Dynamic quota. Grouping requests by a certain attribute and limiting the number of groups.
    - `action` (String). Action in case of exceeding this quota. Possible values: `DENY`.
    - `limit` (Number). Desired maximum number of requests per period.
    - `period` (Number). Period of time in seconds.
    - `characteristic` [Block]. List of characteristics.

{% note warning %}

Exactly one characteristic specifier: `simple_characteristic` or `key_characteristic` should be specified.

{% endnote %}


      - `case_insensitive` (Bool). Determines case-sensitive or case-insensitive keys matching.
      - `key_characteristic` [Block]. Characteristic based on key match in the Query params, HTTP header, and HTTP cookie attributes. See [Rules](https://yandex.cloud/docs/smartwebsecurity/concepts/arl#requests-counting) for more details.
        - `type` (String). Type of key characteristic. Possible values: `COOKIE_KEY`, `HEADER_KEY`, `QUERY_KEY`.
        - `value` (String). String value of the key.
      - `simple_characteristic` [Block]. Characteristic automatically based on the Request path, HTTP method, IP address, Region, and Host attributes. See [Rules](https://yandex.cloud/docs/smartwebsecurity/concepts/arl#requests-counting) for more details.
        - `type` (String). Type of simple characteristic. Possible values: `REQUEST_PATH`, `HTTP_METHOD`, `IP`, `GEO`, `HOST`.
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
  - `static_quota` [Block]. Static quota. Counting each request individually.
    - `action` (String). Action in case of exceeding this quota. Possible values: `DENY`.
    - `limit` (Number). Desired maximum number of requests per period.
    - `period` (Number). Period of time in seconds.
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
# terraform import yandex_sws_advanced_rate_limiter_profile.<resource Name> <resource Id>
terraform import yandex_sws_advanced_rate_limiter_profile.demo-profile ...
```
