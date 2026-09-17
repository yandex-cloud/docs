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
  name = "default"

  # Basic rule set
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

  # Turning the rule into a blocking one: the request will be blocked regardless of the anomaly threshold
  rule {
    rule_id     = "owasp-crs-v4.0.0-id942330-attack-sqli"
    is_enabled  = true
    is_blocking = true
  }

  # Enabling the rule with paranoia level 4
  rule {
    rule_id     = "owasp-crs-v4.0.0-id920202-protocol-enforcement"
    is_enabled  = true
    is_blocking = false
  }

  # Enabling rules from the basic set if their paranoia level is not higher than the value defined in the waf_paranoia_level variable
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