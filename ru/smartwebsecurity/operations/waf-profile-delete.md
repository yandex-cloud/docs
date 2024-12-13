---
title: Удалить профиль WAF
description: Следуя данной инструкции, вы сможете удалить профиль WAF.
---

# Удалить профиль WAF

Прежде чем удалить профиль WAF, необходимо удалить все правила WAF из связанных профилей безопасности.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль WAF](../concepts/waf.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Сохраните или запомните идентификатор профиля, который вы хотите удалить.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/profiles.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}** и выберите [профиль безопасности](../concepts/profiles.md), в котором используется профиль WAF, который вы хотите удалить.
  1. На вкладке **{{ ui-key.yacloud.smart-web-security.overview.title_security-rules }}** удалите правила профиля WAF:

     1. В фильтре **{{ ui-key.yacloud.smart-web-security.label_search-rule-type }}** выберите `{{ ui-key.yacloud.smart-web-security.overview.label_waf-rule }}`.
     1. В строке с правилом, которое относится к профилю WAF с нужным идентификатором, нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
     1. Подтвердите удаление.
  1. Таким же способом удалите правила WAF из всех связанных профилей безопасности.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. В строке с нужным профилем нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы удалить WAF профиль {{ sws-full-name }}, созданный с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием WAF профиля.

     {% cut "Пример описания WAF профиля в конфигурации {{ TF }}" %}

     ```hcl
      # В базовом наборе будут активны правила этого уровня паранойи и ниже
      locals {
        waf_paranoia_level = 1
      }

      # Источник данных OWASP Core Rule Set
      data "yandex_sws_waf_rule_set_descriptor" "owasp4" {
        name    = "OWASP Core Ruleset"
        version = "4.0.0"
      }

      # WAF профиль
      resource "yandex_sws_waf_profile" "default" {
        name = "<имя_WAF_профиля>"

        # Базовый набор правил
        core_rule_set {
          inbound_anomaly_score = 2
          paranoia_level        = local.waf_paranoia_level
          rule_set {
            name    = "OWASP Core Ruleset"
            version = "4.0.0"
          }
        }

        # Активируем правила из базового набора, если их уровень паранойи не выше заданного в переменной waf_paranoia_level
        dynamic "rule" {
          for_each = [
            for rule in data.yandex_sws_waf_rule_set_descriptor.owasp4.rules : rule
            if rule.paranoia_level <= local.waf_paranoia_level
          ]
          content {
            rule_id     = rule.value.id
            is_enabled  = true
            is_blocking = false
          }
        }

        analyze_request_body {
          is_enabled        = true
          size_limit        = 8
          size_limit_action = "IGNORE"
        }
      }
     ```

     {% endcut %}

  1. Примените изменения:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить удаление ресурсов можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом REST API [delete](../waf/api-ref/WafProfile/delete.md) для ресурса [WafProfile](../waf/api-ref/WafProfile/) или вызовом gRPC API [WafProfile/Delete](../waf/api-ref/grpc/WafProfile/delete.md).

{% endlist %}
