---
title: Добавить правило-исключение WAF
description: Следуя данной инструкции, вы сможете создать правило-исключение для WAF.
---

# Добавить правило-исключение WAF

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль WAF](../concepts/waf.md).
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Выберите профиль, в который вы хотите добавить [правило-исключение](../concepts/waf.md#exclusion-rules).
  1. Выберите ![image](../../_assets/console-icons/file-xmark.svg) **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rules }}** и нажмите **{{ ui-key.yacloud.smart-web-security.waf.label_create-exclusion-rule }}**.
  1. Введите имя правила-исключения.
  1. (Опционально) Введите описание.
  1. (Опционально) Включите опцию **{{ ui-key.yacloud.smart-web-security.waf.field_logging }}**, чтобы логировать факты срабатывания правил-исключений.
  1. {% include [waf-rule-rules-section](../../_includes/smartwebsecurity/waf-rule-rules-section.md) %}
  1. {% include [waf-rule-request-condition](../../_includes/smartwebsecurity/waf-rule-request-condition.md) %}
  1. {% include [waf-rule-traffic-conditions](../../_includes/smartwebsecurity/waf-rule-traffic-conditions.md) %}
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и измените фрагмент с описанием профиля WAF `yandex_sws_waf_profile`: добавьте блок `exclusion_rule` с правилом-исключением WAF.

      ```hcl
      # Профиль WAF
      resource "yandex_sws_waf_profile" "default" {
        name = "waf-profile-default"

        ...

        # Правило-исключение
        exclusion_rule {
          name = "<имя_правила-исключения>"
          condition {
            source_ip {
              ip_ranges_match {
                ip_ranges = [
                  "<диапазон_IP-адресов_1>",
                  "<диапазон_IP-адресов_2>",
                  ...
                  "<диапазон_IP-адресов_n>"
                ]
              }
              ip_ranges_not_match {
                ip_ranges = [
                  "<диапазон_IP-адресов_3>",
                  "<диапазон_IP-адресов_4>",
                  ...
                  "<диапазон_IP-адресов_y>"
                ]
              }
            }
          }

          exclude_rules {
            exclude_all = <true_или_false>
            rule_ids    = [
              "идентификатор_правила_1",
              "идентификатор_правила_2",
              ...
              "идентификатор_правила_n"
            ]
          }
        }
      }
      ```

     {% cut "Пример настройки правил-исключений профиля WAF в конфигурации {{ TF }}" %}

     {% include [waf-profile-exclusion-terraform-example](../../_includes/smartwebsecurity/waf-profile-exclusion-terraform-example.md) %}

     {% endcut %}

      Где:

      * `exclusion_rule` — правило-исключение:

         * `name` — имя правила-исключения.
         * `condition` — [условия](../concepts/conditions.md), при которых будет срабатывать правило-исключение. В приведенном примере применяется условие по IP-адресу источника трафика.

            В блоке `condition` вы можете использовать одновременно несколько разных типов условий.

         * `exclude_rules` — параметры правила-исключения:

            * `exclude_all` — исключение будет срабатывать для всех правил. Возможные значения: `false` или `true`.
            * `rule_ids` — список идентификаторов правил из базового набора, для которых будет срабатывать исключение. Чтобы указать отдельные правила, для параметра `exclude_all` установите значение `false`.

      Подробнее о параметрах ресурса `yandex_sws_waf_profile` в [документации провайдера]({{ tf-provider-resources-link }}/sws_waf_profile).

  1. Примените изменения:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Вы можете проверить изменение ресурсов в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом REST API [update](../waf/api-ref/WafProfile/update.md) для ресурса [WafProfile](../waf/api-ref/WafProfile/) или вызовом gRPC API [WafProfile/Update](../waf/api-ref/grpc/WafProfile/update.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](configure-set-rules.md)
* [{#T}](exclusion-rule-delete.md)
* [{#T}](rule-add.md)
