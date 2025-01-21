---
title: Как создать профиль безопасности WAF {{ sws-full-name }}
description: Следуя данной инструкции, вы сможете создать профиль безопасности WAF {{ sws-full-name }}.
---

# Создать профиль WAF

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать [профиль WAF](../concepts/waf.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}** и нажмите кнопку **{{ ui-key.yacloud.smart-web-security.waf.label_create-profile }}**.
  1. Введите имя профиля.
  1. (опционально) Введите описание.
  1. (опционально) Добавьте профилю [метки](../../resource-manager/concepts/labels.md).
  1. По умолчанию в профиле WAF включен набор базовых правил [OWASP Core Rule Set](https://coreruleset.org/). Нажмите на строку с набором правил, чтобы посмотреть правила, которые в него входят.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

      ```hcl
      # В базовом наборе будут активны правила этого уровня паранойи и ниже
      locals {
        waf_paranoia_level = <уровень_паранойи>
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
          inbound_anomaly_score = <порог_аномальности>
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
      ```

      Где:
      * `waf_paranoia_level` — [уровень паранойи](../concepts/waf.md#paranoia) классифицирует правила по степени агрессивности. Чем выше уровень паранойи, тем лучше уровень защиты, но и больше вероятность ложных срабатываний WAF.
      * `data "yandex_sws_waf_rule_set_descriptor"` — источник данных {{ TF }} для набора базовых правил. Из источника данных вы можете получить список правил и их идентификаторы.
      * `resource "yandex_sws_waf_profile"` — ресурс {{ TF }} для управления WAF профилем.
         * `name` — имя WAF профиля.
         * `core_rule_set` — блок базовых правил:
            * `inbound_anomaly_score` — порог аномальности. Это суммарная [аномальность](../concepts/waf.md#anomaly) сработавших правил, при которой запрос будет заблокирован. Возможные значения от 2 до 10000. Чем выше заданное значение, тем больше вероятность того, что запрос, удовлетворяющий правилам, является атакой.
            * `paranoia_level` — [уровень паранойи](../concepts/waf.md#paranoia), классифицирует правила по степени агрессивности. Чем выше уровень паранойи, тем лучше защита, но больше вероятность ложных срабатываний. Возможные значения от 1 до 4.

              {% note info %}

              Уровень паранойи не влияет на включение или отключение правил, он используется только как рекомендация для пользователя включить все правила со значением `paranoia_level` меньше или равно заданному.

              {% endnote %}

            * `rule_set` — блок с указанием набора правил. Указывается `name` — имя и `version` — версия набора правил.

         * `dynamic "rule"` — динамическая активация правил из базового набора, если их уровень паранойи не выше заданного в переменной `waf_paranoia_level`. Для динамически настроенных правил можно вручную [изменить параметры](configure-set-rules.md). Например, сделать правило блокирующим или сделать активным правило, у которого уровень паранойи выше, чем указан в переменной.
            * `rule_id` — идентификатор правила.
            * `is_enabled` — флаг включения или отключения правила.
            * `is_blocking` — флаг, который назначает правило [блокирующим](../concepts/waf.md#anomaly).

      Более подробную информацию о параметрах ресурса `yandex_sws_waf_profile` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/sws_waf_profile).

  1. Создайте ресурсы:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}).

  После создания WAF профиля вы можете [настроить набор базовых правил](configure-set-rules.md) и [правил-исключений](exclusion-rule-add).

- API {#api}

  Воспользуйтесь методом REST API [create](../waf/api-ref/WafProfile/create.md) для ресурса [WafProfile](../waf/api-ref/WafProfile/) или вызовом gRPC API [WafProfile/Create](../waf/api-ref/grpc/WafProfile/create.md).

{% endlist %}

### См. также {#see-also}

* [{#T}](configure-set-rules.md)
* [{#T}](rule-add.md)
* [{#T}](profile-update.md)
* [{#T}](waf-profile-delete.md)
