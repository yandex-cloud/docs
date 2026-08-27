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
  name = "waf-profile-owasp"

  # Набор правил
  rule_set {
    action     = "DENY"
    is_enabled = true
    priority   = 1

    # Базовый набор правил
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

  # Активируем правила из базового набора, если их уровень паранойи не выше заданного в переменной waf_paranoia_level
  dynamic "rule" {
    for_each = [
      for rule in data.yandex_sws_waf_rule_set_descriptor.source.rules : rule
      if rule.paranoia_level <= local.waf_paranoia_level
    ]
    content {
      rule_id     = rule.value.id
      is_enabled  = true
      is_blocking = false
    }
  }
}
```