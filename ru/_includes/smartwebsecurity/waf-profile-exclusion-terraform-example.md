```hcl
# Объявление локальных переменных
locals {
  # В базовом наборе будут активны правила этого уровня паранойи и ниже
  waf_paranoia_level = 1

  # Идентификация набора правил OWASP Core Ruleset
  ruleset_name    = "OWASP Core Ruleset"
  ruleset_version = "4.0.0"
  ruleset_id      = "OWASP_CRS_4_0_0"
  ruleset_type    = "CORE"
}

# Источник данных OWASP Core Rule Set
data "yandex_sws_waf_rule_set_descriptor" "source" {
  name    = local.ruleset_name
  version = local.ruleset_version
}

# Профиль WAF
resource "yandex_sws_waf_profile" "default" {
  name = "configure-set-rules"

  # Базовый набор правил
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

  # Правило-исключение
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