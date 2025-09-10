---
title: Changing WAF interfaces to support new rule sets
description: Follow this guide to migrate to Web Application Firewall with Yandex rule set support.
---

# Migrating to WAF with Yandex rule set support

Web Application Firewall analyzes requests to your resources using rule sets. Previously, only one rule set is available: [OWASP Core Ruleset](https://coreruleset.org). Starting September 9, 2025, two new rule sets developed by Yandex will also become available: Yandex Ruleset and ML WAF (Yandex Malicious Score).

To support new rule sets, the `coreRuleSet` object in the WAF interfaces will get a mandatory field: `ruleSet`.`type`. The `coreRuleSet` section will be nested into the `ruleSet` section, which sets the `priority` for processing a request by a rule set.

The `type` field may get the following values:

* `CORE`: OWASP Core rule set.
* `YA`: Yandex rule set.
* `ML`: ML WAF (Yandex Malicious Score) rule set.

By default, the `type` field will have the `RULE_SET_TYPE_UNSPECIFIED` value, which means the requests will not be checked by any rule set.

To continue working with WAF, add this new field to the [API](../api-ref/authentication.md) function calls or [{{ TF }}](../tf-ref.md) manifest. In the [management console]({{ link-console-main }}), you will not to do anything, since all changes will be applied automatically.

{% note warning %}

Starting September 9, 2025, the `type` field will become mandatory, while the `ruleSet` description will be only accepted in the new format. The previous format will no longer be supported.

{% endnote %}

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  ```hcl
  rule_set {
    action     = "DENY"
    is_enabled = true
    priority   = 1

    core_rule_set {
      inbound_anomaly_score = 2
      paranoia_level        = local.waf_paranoia_level

      rule_set {
        name    = "OWASP Core Ruleset"
        type    = "CORE"
        version = "4.0.0"
      }
    }
  }
  ```

- API REST {#api}

  ```json
  "coreRuleSet": {
    "inboundAnomalyScore": 2,
    "paranoiaLevel": 2,
    "ruleSet": {
      "name": "OWASP Core Ruleset",
      "type": "CORE",
      "version": "4.0.0"
    }
  }
  ```

  For more information, see the [update](../waf/api-ref/WafProfile/update.md) REST API method description for the [WafProfile](../waf/api-ref/WafProfile/) resource.

- API gRPC {#api-grpc}

  ```json
  "core_rule_set": {
    "inbound_anomaly_score": 2,
    "paranoia_level": 2,
    "rule_set": {
      "name": "OWASP Core Ruleset",
      "version": "4.0.0",
      "type": "CORE"
    }
  }
  ```

  For more information, see the [WafProfile/Update](../waf/api-ref/grpc/WafProfile/update.md) gRPC API call description.

{% endlist %}


### See also {#see-also}

* [{#T}](configure-set-rules.md)
* [{#T}](waf-profile-update.md)