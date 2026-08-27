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
  name = "default"

  # Базовый набор правил
  rule_set {
    action     = "DENY"
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

  # Назначаем правило блокирующим — запрос будет заблокирован независимо от порога аномальности
  rule {
    rule_id     = "owasp-crs-v4.0.0-id942330-attack-sqli"
    is_enabled  = true
    is_blocking = true
  }

  # Назначаем активным правило с уровнем паранойи 4
  rule {
    rule_id     = "owasp-crs-v4.0.0-id920202-protocol-enforcement"
    is_enabled  = true
    is_blocking = false
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