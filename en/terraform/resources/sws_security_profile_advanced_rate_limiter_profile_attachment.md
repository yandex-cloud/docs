---
subcategory: Unknown
---

# yandex_sws_security_profile_advanced_rate_limiter_profile_attachment (Resource)

Attaches an Advanced Rate Limiter profile to a Smart Web Security profile. Do not manage `advanced_rate_limiter_profile_id` in `yandex_sws_security_profile` when using this resource.

## Example usage

```terraform
resource "yandex_sws_advanced_rate_limiter_profile" "arl" {
  name = "example-arl-profile"

  advanced_rate_limiter_rule {
    name     = "example-rule"
    priority = 1
    dry_run  = true

    static_quota {
      action = "DENY"
      limit  = 1000
      period = 60
    }
  }
}

resource "yandex_sws_security_profile" "security_profile" {
  name                     = "example-security-profile"
  default_action           = "ALLOW"
  disallow_data_processing = false
}

resource "yandex_sws_security_profile_advanced_rate_limiter_profile_attachment" "attachment" {
  security_profile_id              = yandex_sws_security_profile.security_profile.id
  advanced_rate_limiter_profile_id = yandex_sws_advanced_rate_limiter_profile.arl.id
}
```

## Arguments & Attributes Reference

- `advanced_rate_limiter_profile_id` (**Required**)(String). ID of the Advanced Rate Limiter profile.
- `id` (String). 
- `security_profile_id` (**Required**)(String). ID of the Smart Web Security profile.
- `timeouts` [Block]. 
  - `create` (String). 
  - `delete` (String). 
  - `read` (String).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
#!/bin/bash

terraform import yandex_sws_security_profile_advanced_rate_limiter_profile_attachment.attachment '<security_profile_id>/<advanced_rate_limiter_profile_id>'
```
