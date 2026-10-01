```hcl
# Declaring local variables
locals {
  # In the basic set, rules of this paranoia level and below will be enabled
  waf_paranoia_level = 1

  # OWASP Core Ruleset identification
  ruleset_name    = "OWASP Core Ruleset"
  ruleset_version = "4.0.0"
  ruleset_id      = "OWASP_CRS_4_0_0"
  ruleset_type    = "CORE"
}

# OWASP Core Rule Set data source
data "yandex_sws_waf_rule_set_descriptor" "source" {
  name    = local.ruleset_name
  version = local.ruleset_version
}

# WAF profile
resource "yandex_sws_waf_profile" "default" {
  name = "configure-set-rules"

  # Basic rule set
  rule_set {
    action     = "CAPTCHA"
    is_enabled = true
    priority   = 1
    core_rule_set {
      inbound_anomaly_score = 2
      paranoia_level        = local.waf_paranoia_level
      rule_set {
        name    = local.ruleset_name
        version = local.ruleset_version
        id      = local.ruleset_id
        type    = local.ruleset_type
      }
    }
  }

  # Exclusion rule
  exclusion_rule {
    name = "test-exclusion-1"

    condition {
      source_ip {
        ip_ranges_match {
          ip_ranges = [
            "192.0.2.0/24",
            "198.51.100.0/24"
          ]
        }
        ip_ranges_not_match {
          ip_ranges = [
            "203.0.113.10/32",
            "203.0.113.0/24"
          ]
        }
      }
    }

    exclude_rules {
      exclude_all = false
      rule_ids = [
        "owasp-crs-v4.8.0-id942330-attack-sqli",
        "owasp-crs-v4.8.0-id920202-protocol-enforcement"
      ]
    }

  }
}
```