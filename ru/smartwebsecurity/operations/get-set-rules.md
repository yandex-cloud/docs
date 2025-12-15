---
title: Получить информацию о наборе правил WAF
description: Следуя данной инструкции, вы сможете получить информацию о наборе правил для профиля WAF.
---

# Получить информацию о наборе правил WAF

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль WAF](../concepts/waf.md).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Выберите профиль, в котором находится нужный набор правил.
  1. В разделе **{{ ui-key.yacloud.smart-web-security.advanced_waf.sets_priority_section.section_title }}** отобразится информация о наборах правил:
     * Версия набора правил.
     * Количество активных правил.
     * Порог аномальности и уровень паранойи (для набора OWASP).

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы получить информацию о [наборе правил WAF](../concepts/waf.md#rules-set) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

      ```hcl
      data "yandex_sws_waf_rule_set_descriptor" "owasp4" {
        name    = "OWASP Core Ruleset"
        version = "4.0.0"
      }

      output "waf_rules" {
        value = data.yandex_sws_waf_rule_set_descriptor.owasp4.rules
      }
      ```

      Где:

      * `data "yandex_sws_waf_rule_set_descriptor"` — описание набора правил WAF в качестве источника данных:
        * `name` — имя набора правил WAF.
        * `version` — версия набора правил.
      * `output "waf_rules"` — выходная переменная, которая содержит информацию о наборе правил WAF:
        * `value` — возвращаемое значение.

      Вместо `rules` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_sws_waf_rule_set_descriptor` см. в [документации провайдера]({{ tf-provider-datasources-link }}/sws_waf_rule_set_descriptor).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      waf_rules = tolist([
        {
          "anomaly_score" = 5
          "id" = "owasp-crs-v4.0.0-id******-method-enforcement"
          "paranoia_level" = 1
        },
      ...
        {
          "anomaly_score" = 5
          "id" = "owasp-crs-v4.0.0-id******-attack-java"
          "paranoia_level" = 4
        },
      ])
      ```

- API {#api}

  Воспользуйтесь методом REST API [get](../waf/api-ref/WafProfile/get.md) для ресурса [WafProfile](../waf/api-ref/WafProfile/) или вызовом gRPC API [WafProfile/Get](../waf/api-ref/grpc/WafProfile/get.md).

{% endlist %}