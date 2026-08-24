---
title: Как создать профиль WAF {{ sws-full-name }}
description: Следуя данной инструкции, вы сможете создать профиль WAF {{ sws-full-name }}.
---

# Создать профиль WAF

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать [профиль WAF](../concepts/waf.md).
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}** и нажмите **{{ ui-key.yacloud.smart-web-security.waf.label_create-profile }}**.
  1. Введите имя профиля.
  1. (Опционально) Введите описание.
  1. (Опционально) Добавьте профилю [метки](../../resource-manager/concepts/labels.md).
  1. Включите один или несколько [наборов правил](../concepts/waf.md#rules-set): [OWASP Core Rule Set](https://coreruleset.org/), Yandex Ruleset, Yandex ML Ruleset. Чтобы посмотреть правила, которые входят в набор, нажмите на строку с набором правил.
  1. Выберите версию набора правил.
  1. {% include [waf-verdicts](../../_includes/smartwebsecurity/waf-verdicts.md) %}
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

      ```hcl
      locals {
        # В базовом наборе будут активны правила этого уровня паранойи и ниже
        waf_paranoia_level = <уровень_паранойи>
      }

      # Источник данных — набор правил
      data "yandex_sws_waf_rule_set_descriptor" "source" {
        name    = "<имя_набора>"
        version = "<версия_набора>"
      }

      # Профиль WAF
      resource "yandex_sws_waf_profile" "default" {
        name = "<имя_WAF_профиля>"

        # Набор правил
        rule_set {
          action     = "<действие>"
          is_enabled = <true_или_false>
          priority   = <приоритет>

          # Базовый набор правил
          core_rule_set {
            inbound_anomaly_score = <порог_аномальности>
            paranoia_level        = local.waf_paranoia_level
            rule_set {
              name    = "<имя_набора>"
              version = "<версия_набора>"
              id      = "<идентификатор_набора>"
              type    = "<тип_набора>"
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

     {% cut "Пример описания профиля WAF в конфигурации {{ TF }}" %}

     {% include [waf-profile-terraform-example](../../_includes/smartwebsecurity/waf-profile-terraform-example.md) %}

     {% endcut %}

      Где:

      * `waf_paranoia_level` — [уровень паранойи](../concepts/waf.md#paranoia) классифицирует правила по степени агрессивности. Чем выше уровень паранойи, тем лучше уровень защиты, но и больше вероятность ложных срабатываний WAF.
      * `data "yandex_sws_waf_rule_set_descriptor"` — источник данных {{ TF }} для набора базовых правил. Из источника данных вы можете получить список правил и их идентификаторы.
      * `resource "yandex_sws_waf_profile"` — ресурс {{ TF }} для управления профилем WAF.

         * `name` — имя профиля WAF.
         * `rule_set` — блок правил:

             * `action` — действие, которое нужно выполнить при срабатывании набора правил:

                * `RULE_SET_ACTION_UNSPECIFIED` — разрешить запрос.
                * `DENY` — заблокировать запрос.
                * `CAPTCHA` — отправить запрос в {{ captcha-name }}.

             * `is_enabled` — флаг включения или отключения набора правил.
             * `priority` — приоритет набора правил. Возможные значения от 1 до 1000000.
             * `core_rule_set` — блок базовых правил:

                * `inbound_anomaly_score` — порог аномальности. Это суммарная [аномальность](../concepts/waf.md#anomaly) сработавших правил, при которой запрос будет заблокирован. Возможные значения от 2 до 10000. Чем выше заданное значение, тем больше вероятность того, что запрос, удовлетворяющий правилам, является атакой.
                * `paranoia_level` — [уровень паранойи](../concepts/waf.md#paranoia), классифицирует правила по степени агрессивности. Чем выше уровень паранойи, тем лучше защита, но больше вероятность ложных срабатываний. Возможные значения от 1 до 4.

                   {% note info %}

                   Уровень паранойи не влияет на включение или отключение правил, он используется только как рекомендация для пользователя включить все правила со значением `paranoia_level` меньше или равно заданному.

                   {% endnote %}

                * `rule_set` — блок с указанием набора правил. Указывается идентификатор, имя, версия и тип набора правил.

                    {% cut "Возможные значения" %}

                    {% include [waf-rule-set-terraform-values](../../_includes/smartwebsecurity/waf-rule-set-terraform-values.md) %}

                    {% endcut %}

         * `dynamic "rule"` — динамическая активация правил из базового набора, если их уровень паранойи не выше заданного в переменной `waf_paranoia_level`. Для динамически настроенных правил можно вручную [изменить параметры](configure-set-rules.md). Например, сделать правило блокирующим или сделать активным правило, у которого уровень паранойи выше, чем указан в переменной.

            * `rule_id` — идентификатор правила.
            * `is_enabled` — флаг включения или отключения правила.
            * `is_blocking` — флаг, который назначает правило [блокирующим](../concepts/waf.md#anomaly).

      Подробнее о параметрах ресурса `yandex_sws_waf_profile` в [документации провайдера]({{ tf-provider-resources-link }}/sws_waf_profile).

  1. Создайте ресурсы:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}).

  После создания профиля WAF вы можете [изменить](configure-set-rules.md) набор базовых правил и [настроить](exclusion-rule-add.md) набор правил-исключений.

- API {#api}

  Воспользуйтесь методом REST API [create](../waf/api-ref/WafProfile/create.md) для ресурса [WafProfile](../waf/api-ref/WafProfile/) или вызовом gRPC API [WafProfile/Create](../waf/api-ref/grpc/WafProfile/create.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](configure-set-rules.md)
* [{#T}](rule-add.md)
* [{#T}](profile-update.md)
* [{#T}](../tutorials/sws-basic-protection.md)
* [{#T}](waf-profile-delete.md)
