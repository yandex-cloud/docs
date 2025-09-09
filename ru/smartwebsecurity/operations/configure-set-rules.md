---
title: Настроить наборы правил WAF
description: Следуя данной инструкции, вы сможете настроить наборы правил для профиля WAF.
---

# Настроить наборы правил WAF

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль WAF](../concepts/waf.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Выберите профиль, в котором вы хотите настроить наборы правил.
  1. Напротив нужного набора нажмите кнопку ![image](../../_assets/console-icons/gear.svg) **Настроить**.
  
  1. Чтобы настроить набор OWASP:
  
     1. Установите **{{ ui-key.yacloud.smart-web-security.waf.label_anomaly-threshold }}** — суммарную [аномальность](../concepts/waf.md#anomaly) сработавших правил, при которой запрос будет заблокирован.

        Рекомендуется начинать с порога аномальности `25` и постепенно снижать его до `5`. Чтобы снизить порог аномальности, отработайте ложные срабатывания WAF на легитимные запросы. Для этого подберите правила из базового набора и [настройте правила-исключения](exclusion-rule-add.md).
      
        Для тестирования порогов аномальности используйте режим **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry run)**. Режим включается при добавлении в профиль безопасности правила WAF.

     1. Установите **{{ ui-key.yacloud.smart-web-security.waf.label_paranoia-level }}**.

        [Уровень паранойи](../concepts/waf.md#paranoia) классифицирует правила по степени агрессивности. Чем выше уровень паранойи, тем лучше уровень защиты, но и больше вероятность ложных срабатываний WAF. 
     
     1. Проверьте включенные в набор правила, при необходимости включите дополнительные или уберите ненужные. При работе с правилами обращайте внимание на значение их аномальности и уровень паранойи. 

        Любое правило из набора можно сделать блокирующим. Запрос, соответствующий такому правилу, будет заблокирован независимо от установленного порога аномальности. Чтобы сделать правило блокирующим, нажмите ![image](../../_assets/console-icons/ban.svg) справа от него. Если в профиле безопасности включен режим **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry run)**, запросы блокироваться не будут.
  
  1. Чтобы настроить набор Yandex Ruleset:
     
     1. Включите [группы правил](../concepts/waf.md#yandex-ruleset), которые должны работать в наборе
      
        Yandex Ruleset позволяет настроить каждую группу правил индивидуально.
     
     1. Раскройте и укажите параметры каждой включенной группы правил:
        1. (Опционально) Измените **Порог аномальности** от `1` до `10000`. По умолчанию установлено значение `7`, поскольку правила набора Yandex Ruleset дают наименьшее количество ложноположительных срабатываний.

        1. Выберите действие **При превышении порога**, которое будет выполняться с запросом. Сейчас доступна только блокировка запроса.
        1. Отключите правила, которые не должны работать в наборе.
        1. Если правило должно сразу блокировать запрос независимо от суммарной аномальности, нажмите ![image](../../_assets/console-icons/ban.svg) справа от него.

  1. Чтобы настроить набор Yandex ML Ruleset:
     1. Включите правила, которые должны работать в наборе.
     1. (Опционально) Измените **Порог аномальности** от `1` до `100`. По умолчанию установлено значение `90`. При низком пороге аномальности могут часто происходить ложные срабатывания.
     
  1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.waf.label_save-settings }}**.

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Вы можете динамически включить все правила из базового набора, если их уровень паранойи не выше заданного в пользовательской переменной. Для динамически настроенных правил можно вручную изменить параметры. Например, сделать правило блокирующим и сделать активным правило, у которого уровень паранойи выше, чем задан в переменной.

  1. Откройте файл конфигурации {{ TF }} и измените фрагмент с описанием профиля безопасности `yandex_sws_waf_profile`: добавьте блок `rule` c правилом безопасности или блок `dynamic "rule"` с динамически настраиваемыми правилами.

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

      Где:
      * `dynamic "rule"` — динамическая активация правил из базового набора, если их уровень паранойи не выше заданного в переменной `waf_paranoia_level`. Для динамически настроенных правил можно вручную изменить параметры. Например, сделать правило блокирующим или сделать активным правило, у которого уровень паранойи выше, чем указан в переменной.
         * `rule_id` — идентификатор правила.
         * `is_enabled` — флаг включения или отключения правила.
         * `is_blocking` — флаг, который назначает правило [блокирующим](../concepts/waf.md#anomaly).

      Более подробную информацию о параметрах ресурса `sws_waf_profile` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/sws_waf_profile).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить изменение ресурсов можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом REST API [update](../waf/api-ref/WafProfile/update.md) для ресурса [WafProfile](../waf/api-ref/WafProfile/) или вызовом gRPC API [WafProfile/Update](../waf/api-ref/grpc/WafProfile/update.md).

{% endlist %}

При каждом изменении или добавлении новых правил в профиле WAF включайте режим **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**. Активируйте правило только после того, как логи подтвердят его корректную работу. Это поможет избежать ложных срабатываний и обеспечит стабильную работу вашего сайта или веб-приложения.

### См. также {#see-also}

* [{#T}](exclusion-rule-add.md)
* [{#T}](rule-add.md)
* [{#T}](../tutorials/sws-basic-protection.md)
