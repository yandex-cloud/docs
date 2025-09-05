---
title: Изменения в интерфейсах WAF для поддержки новых наборов правил
description: Следуя данной инструкции, вы сможете мигрировать на Web Application Firewall с поддержкой наборов правил от Яндекса.
---

# Миграция на WAF с поддержкой наборов правил от Яндекса

Web Application Firewall анализирует веб-запросы к вашим ресурсам с помощью наборов правил. Сейчас доступен один набор правил — [OWASP Core Ruleset](https://coreruleset.org). С 9 сентября 2025 года будут доступны еще два набора правил, разработанные Яндексом: Yandex Ruleset и ML WAF (Yandex Malicious Score).

Для поддержки новых наборов в интерфейсах WAF для объекта `coreRuleSet` будет добавлено обязательное поле `ruleSet`.`type`. Блок `coreRuleSet` будет находиться в блоке `ruleSet`, в котором задается приоритет (`priority`) обработки запроса набором правил.

Возможные значения поля `type`:

* `CORE` — набор правил OWASP Core Ruleset.
* `YA` — набор правил Yandex Ruleset.
* `ML` — набор правил ML WAF (Yandex Malicious Score).

По умолчанию поле `type` будет иметь значение `RULE_SET_TYPE_UNSPECIFIED` — набор правил не задан, запросы не проверяются.

Чтобы продолжить работать с WAF, добавьте новое поле в вызовы функций [API](../api-ref/authentication.md) или в манифест [{{ TF }}](../tf-ref.md). В [консоли управления]({{ link-console-main }}) действий не потребуется, все изменения будут выполнены автоматически.

{% note warning %}

С 9 сентября 2025 года поле `type` станет обязательным, описание `ruleSet` будет приниматься только в новом формате. Старый формат поддерживаться не будет.

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

  Подробнее см. описание метода REST API [update](../waf/api-ref/WafProfile/update.md) для ресурса [WafProfile](../waf/api-ref/WafProfile/).

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

  Подробнее см. описание вызова gRPC API [WafProfile/Update](../waf/api-ref/grpc/WafProfile/update.md).

{% endlist %}


### См. также {#see-also}

* [{#T}](configure-set-rules.md)
* [{#T}](waf-profile-update.md)