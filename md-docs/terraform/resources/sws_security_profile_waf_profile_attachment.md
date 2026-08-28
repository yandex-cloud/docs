[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Unknown > Resources > sws_security_profile_waf_profile_attachment

# yandex_sws_security_profile_waf_profile_attachment (Resource)

Tracks a WAF rule attachment in a Smart Web Security profile and removes the rule before the WAF profile is deleted. The WAF rule itself must be configured in `yandex_sws_security_profile`.

## Example usage

```terraform
resource "yandex_sws_waf_profile" "waf" {
  name = "example-waf-profile"

  core_rule_set {
    inbound_anomaly_score = 2
    paranoia_level        = 4
    rule_set {
      name    = "OWASP Core Ruleset"
      version = "4.0.0"
      type    = "CORE"
    }
  }

  analyze_request_body {
    is_enabled        = true
    size_limit        = 8
    size_limit_action = "IGNORE"
  }

  rule_set {
    action     = "DENY"
    is_enabled = true
    priority   = 1
    core_rule_set {
      inbound_anomaly_score = 2
      paranoia_level        = 4
      rule_set {
        name    = "OWASP Core Ruleset"
        version = "4.0.0"
        type    = "CORE"
        id      = "OWASP_CRS_4_0_0"
      }
    }
  }
}

resource "yandex_sws_security_profile" "security_profile" {
  name                     = "example-security-profile"
  default_action           = "ALLOW"
  disallow_data_processing = false

  security_rule {
    name     = "waf"
    priority = 1

    waf {
      mode           = "FULL"
      waf_profile_id = yandex_sws_waf_profile.waf.id
    }
  }
}

resource "yandex_sws_security_profile_waf_profile_attachment" "attachment" {
  security_profile_id = yandex_sws_security_profile.security_profile.id
  waf_profile_id      = yandex_sws_waf_profile.waf.id
  security_rule_name  = "waf"
}
```

## Arguments & Attributes Reference

- `id` (String). 
- `security_profile_id` (**Required**)(String). ID of the Smart Web Security profile.
- `security_rule_name` (**Required**)(String). Name of the WAF security rule managed by `yandex_sws_security_profile`.
- `waf_profile_id` (**Required**)(String). ID of the WAF profile.
- `timeouts` [Block]. 
  - `create` (String). 
  - `delete` (String). 
  - `read` (String).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](../../cli/quickstart.md).

```shell
#!/bin/bash

terraform import yandex_sws_security_profile_waf_profile_attachment.attachment '<security_profile_id>/<waf_profile_id>/<security_rule_name>'
```