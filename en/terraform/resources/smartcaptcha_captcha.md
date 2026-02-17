---
subcategory: Smart Captcha
---

# yandex_smartcaptcha_captcha (Resource)

A Captcha resource.

## Example usage

```terraform
// 
// Simple SmartCaptcha example.
//
resource "yandex_smartcaptcha_captcha" "demo-captcha-simple" {
  deletion_protection = true
  name                = "demo-captcha-simple"
  complexity          = "HARD"
  pre_check_type      = "SLIDER"
  challenge_type      = "IMAGE_TEXT"

  allowed_sites = [
    "example.com",
    "example.ru"
  ]
}
```
```terraform
//
// Advanced SmartCaptcha example.
//
resource "yandex_smartcaptcha_captcha" "demo-captcha-advanced" {
  deletion_protection = true
  name                = "demo-captcha-advanced"
  complexity          = "HARD"
  pre_check_type      = "SLIDER"
  challenge_type      = "IMAGE_TEXT"

  allowed_sites = [
    "example.com",
    "example.ru"
  ]

  override_variant {
    uuid        = "xxx"
    description = "override variant 1"

    complexity     = "EASY"
    pre_check_type = "CHECKBOX"
    challenge_type = "SILHOUETTES"
  }

  override_variant {
    uuid        = "yyy"
    description = "override variant 2"

    complexity     = "HARD"
    pre_check_type = "CHECKBOX"
    challenge_type = "KALEIDOSCOPE"
  }

  security_rule {
    name                  = "rule1"
    priority              = 11
    description           = "My first security rule. This rule it's just example to show possibilities of configuration."
    override_variant_uuid = "xxx"

    condition {
      host {
        hosts {
          exact_match = "example.com"
        }
        hosts {
          exact_match = "example.net"
        }
      }

      uri {
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

  security_rule {
    name                  = "rule2"
    priority              = 555
    description           = "Second rule"
    override_variant_uuid = "yyy"

    condition {
      uri {
        path {
          prefix_match = "/form"
        }
      }
    }
  }

  security_rule {
    name                  = "rule3"
    priority              = 99999
    description           = "Empty condition rule"
    override_variant_uuid = "yyy"
  }
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
- `pre_check_type` (String). Basic check type of the captcha.
- `style_json` (String). JSON with variables to define the captcha appearance. For more details see generated JSON in cloud console.
- `suspend` (*Read-Only*) (Bool). Determines that the captcha is currently in restricted mode, see [SmartCaptcha restricted mode](/docs/smartcaptcha/concepts/restricted-mode).
- `turn_off_hostname_check` (Bool). Turn off host name check, see [Domain validation](/docs/smartcaptcha/concepts/domain-validation).
- `override_variant` [Block]. List of variants to use in security_rules
  - `challenge_type` (String). Additional task type of the captcha.
  - `complexity` (String). Complexity of the captcha.
  - `description` (String). Optional description of the rule. 0-512 characters long.
  - `pre_check_type` (String). Basic check type of the captcha.
  - `uuid` (String). Unique identifier of the variant.
- `security_rule` [Block]. List of security rules.
  - `condition` [Block]. The condition for matching the rule.
    - `headers` [Block]. Captcha request headers.
      - `name` (**Required**)(String). Name of header (case insensitive).
      - `value` [Block]. Value of the header.
        - `exact_match` (String). package: yandex.cloud.smartcaptcha.v1
filename: yandex/cloud/smartcaptcha/v1/captcha.proto

        - `exact_not_match` (String). package: yandex.cloud.smartcaptcha.v1
filename: yandex/cloud/smartcaptcha/v1/captcha.proto

        - `pire_regex_match` (String). package: yandex.cloud.smartcaptcha.v1
filename: yandex/cloud/smartcaptcha/v1/captcha.proto

        - `pire_regex_not_match` (String). package: yandex.cloud.smartcaptcha.v1
filename: yandex/cloud/smartcaptcha/v1/captcha.proto

        - `prefix_match` (String). package: yandex.cloud.smartcaptcha.v1
filename: yandex/cloud/smartcaptcha/v1/captcha.proto

        - `prefix_not_match` (String). package: yandex.cloud.smartcaptcha.v1
filename: yandex/cloud/smartcaptcha/v1/captcha.proto

    - `host` [Block]. Host where captcha placed.
      - `hosts` [Block]. List of hosts. OR semantics implied.
        - `exact_match` (String). package: yandex.cloud.smartcaptcha.v1
filename: yandex/cloud/smartcaptcha/v1/captcha.proto

        - `exact_not_match` (String). package: yandex.cloud.smartcaptcha.v1
filename: yandex/cloud/smartcaptcha/v1/captcha.proto

        - `pire_regex_match` (String). package: yandex.cloud.smartcaptcha.v1
filename: yandex/cloud/smartcaptcha/v1/captcha.proto

        - `pire_regex_not_match` (String). package: yandex.cloud.smartcaptcha.v1
filename: yandex/cloud/smartcaptcha/v1/captcha.proto

        - `prefix_match` (String). package: yandex.cloud.smartcaptcha.v1
filename: yandex/cloud/smartcaptcha/v1/captcha.proto

        - `prefix_not_match` (String). package: yandex.cloud.smartcaptcha.v1
filename: yandex/cloud/smartcaptcha/v1/captcha.proto

    - `source_ip` [Block]. The IP address of the requester.
      - `geo_ip_match` [Block]. package: yandex.cloud.smartcaptcha.v1
filename: yandex/cloud/smartcaptcha/v1/captcha.proto

        - `locations` (List Of String). ISO 3166-1 alpha 2. OR semantics implied.
      - `geo_ip_not_match` [Block]. package: yandex.cloud.smartcaptcha.v1
filename: yandex/cloud/smartcaptcha/v1/captcha.proto

        - `locations` (List Of String). ISO 3166-1 alpha 2. OR semantics implied.
      - `ip_ranges_match` [Block]. package: yandex.cloud.smartcaptcha.v1
filename: yandex/cloud/smartcaptcha/v1/captcha.proto

        - `ip_ranges` (List Of String). List of IP ranges. OR semantics implied.
      - `ip_ranges_not_match` [Block]. package: yandex.cloud.smartcaptcha.v1
filename: yandex/cloud/smartcaptcha/v1/captcha.proto

        - `ip_ranges` (List Of String). List of IP ranges. OR semantics implied.
    - `uri` [Block]. URI where captcha placed.
      - `path` [Block]. Path of the URI [RFC3986](https://datatracker.ietf.org/doc/html/rfc3986#section-3.3).
        - `exact_match` (String). package: yandex.cloud.smartcaptcha.v1
filename: yandex/cloud/smartcaptcha/v1/captcha.proto

        - `exact_not_match` (String). package: yandex.cloud.smartcaptcha.v1
filename: yandex/cloud/smartcaptcha/v1/captcha.proto

        - `pire_regex_match` (String). package: yandex.cloud.smartcaptcha.v1
filename: yandex/cloud/smartcaptcha/v1/captcha.proto

        - `pire_regex_not_match` (String). package: yandex.cloud.smartcaptcha.v1
filename: yandex/cloud/smartcaptcha/v1/captcha.proto

        - `prefix_match` (String). package: yandex.cloud.smartcaptcha.v1
filename: yandex/cloud/smartcaptcha/v1/captcha.proto

        - `prefix_not_match` (String). package: yandex.cloud.smartcaptcha.v1
filename: yandex/cloud/smartcaptcha/v1/captcha.proto

      - `queries` [Block]. List of query matchers. AND semantics implied.
        - `key` (**Required**)(String). Key of the query parameter.
        - `value` [Block]. Value of the query parameter.
          - `exact_match` (String). package: yandex.cloud.smartcaptcha.v1
filename: yandex/cloud/smartcaptcha/v1/captcha.proto

          - `exact_not_match` (String). package: yandex.cloud.smartcaptcha.v1
filename: yandex/cloud/smartcaptcha/v1/captcha.proto

          - `pire_regex_match` (String). package: yandex.cloud.smartcaptcha.v1
filename: yandex/cloud/smartcaptcha/v1/captcha.proto

          - `pire_regex_not_match` (String). package: yandex.cloud.smartcaptcha.v1
filename: yandex/cloud/smartcaptcha/v1/captcha.proto

          - `prefix_match` (String). package: yandex.cloud.smartcaptcha.v1
filename: yandex/cloud/smartcaptcha/v1/captcha.proto

          - `prefix_not_match` (String). package: yandex.cloud.smartcaptcha.v1
filename: yandex/cloud/smartcaptcha/v1/captcha.proto

  - `description` (String). Optional description of the rule. 0-512 characters long.
  - `name` (**Required**)(String). Name of the rule. The name is unique within the captcha. 1-50 characters long.
  - `override_variant_uuid` (String). Variant UUID to show in case of match the rule. Keep empty to use defaults.
  - `priority` (Number). Priority of the rule. Lower value means higher priority.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_smartcaptcha_captcha.<resource Name> <resource Id>
terraform import yandex_smartcaptcha_captcha.demo-captcha-simple ...
```
