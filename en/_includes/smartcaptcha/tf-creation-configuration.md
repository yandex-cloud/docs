
```hcl
resource "yandex_smartcaptcha_captcha" "demo-advanced-smartcaptcha" {
  name                = "<captcha_name>"
  style_json          = "<captcha_appearance>"
  complexity          = "<challenge_difficulty>"
  pre_check_type      = "<main_challenge_type>"
  challenge_type      = "<additional_challenge_type>"

  allowed_sites = [
    "<first_host>",
    "<second_host>"
  ]

  # First challenge variant
  override_variant {
    uuid        = "<variant_1_ID>"
    description = "<variant_1_description>"

    complexity     = "<challenge_difficulty>"
    pre_check_type = "<main_challenge>"
    challenge_type = "<additional_challenge>"
  }

  # Second challenge variant 
  override_variant {
    uuid        = "<variant_2_ID"
    description = "<variant_2_description>"

    complexity     = "<challenge_difficulty>"
    pre_check_type = "<main_challenge>"
    challenge_type = "<additional_challenge>"
  }

  # First rule
  security_rule {
    name                  = "<rule_1_name>"
    priority              = <rule_1_priority>
    description           = "<rule_1_description>"
    override_variant_uuid = "<challenge_variant_ID>"

    condition {
      host {
        hosts {
          exact_match = "example.com"
        }
        hosts {
          exact_match = "example.net"
        }
      }
    }
  }

  # Second rule
  security_rule {
    name                  = "<rule_2_name>"
    priority              = <rule_2_priority>
    description           = "<rule_2_description>"
    override_variant_uuid = "<challenge_variant_ID>"

    condition {
      source_ip {
        geo_ip_match {
          locations = ["ru", "es"]
        }
      }
    }
  }
}
```