---
title: Добавить правило-исключение WAF
description: Следуя данной инструкции, вы сможете создать правило-исключение для WAF.
---

# Добавить правило-исключение WAF

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль WAF](../concepts/waf.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Выберите профиль, в который вы хотите добавить [правило-исключение](../concepts/waf.md#exclusion-rules).
  1. В меню слева перейдите на вкладку ![image](../../_assets/console-icons/file-xmark.svg) **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rules }}** и нажмите кнопку **{{ ui-key.yacloud.smart-web-security.waf.label_create-exclusion-rule }}**. В открывшемся окне:
      1. Введите имя правила-исключения.
      1. (опционально) Введите описание.
      1. (опционально) Включите опцию **{{ ui-key.yacloud.smart-web-security.waf.field_logging }}**, чтобы логировать факты срабатывания правил-исключений.
      1. В блоке **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rule-rules-section }}** выберите правила из базового набора, для которых будет срабатывать исключение:
          * `{{ ui-key.yacloud.smart-web-security.waf.value_exclude-all-yes }}` — исключение будет срабатывать для всех правил.
          * `{{ ui-key.yacloud.smart-web-security.waf.value_exclude-all-no }}` — исключение будет срабатывать для выбранных правил.

              Нажмите **{{ ui-key.yacloud.smart-web-security.waf.action_exclusion-rule-add-rules }}**, чтобы выбрать правила из базового набора.

      1. {% include [waf-rule-traffic-conditions](../../_includes/smartwebsecurity/waf-rule-traffic-conditions.md) %}

      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и измените фрагмент с описанием профиля безопасности `yandex_sws_waf_profile`: добавьте блок `exclusion_rule` c правилом-исключением WAF.

      ```hcl
      # WAF профиль
      resource "yandex_sws_waf_profile" "default" {
        name = "waf-profile-default"
        core_rule_set {
          inbound_anomaly_score = 2
          paranoia_level        = local.waf_paranoia_level
          rule_set {
            name    = "OWASP Core Ruleset"
            version = "4.0.0"
          }
        }

        ...

        # Правило-исключение
        exclusion_rule {
          name = "<имя правила-исключения>"
          exclude_rules {
            exclude_all = <true_или_false>
            rule_ids    = ["идентификатор_правила_1","идентификатор_правила_2"]
          }
        }
      }
      ```

      Где:
      * `exclusion_rule` — правило-исключение:
         * `name` — имя правила-исключения.
         * `exclude_rules` — параметры правила-исключения:
            * `exclude_all` — исключение будет срабатывать для всех правил. Возможные значения `false` или `true`.
            * `rule_ids` — список идентификаторов правил из базового набора, для которых будет срабатывать исключение. Чтобы указать отдельные правила, для параметра `exclude_all` установите значение `false`.

      Более подробную информацию о параметрах ресурса `sws_waf_profile` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/sws_waf_profile).

  1. Создайте ресурсы:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить изменение ресурсов можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом REST API [update](../waf/api-ref/WafProfile/update.md) для ресурса [WafProfile](../waf/api-ref/WafProfile/) или вызовом gRPC API [WafProfile/Update](../waf/api-ref/grpc/WafProfile/update.md).

{% endlist %}

### См. также {#see-also}

* [{#T}](configure-set-rules.md)
* [{#T}](exclusion-rule-delete.md)
* [{#T}](rule-add.md)
