---
title: Изменить правило-исключение WAF
description: Следуя данной инструкции, вы сможете изменить правило-исключение для WAF.
---

# Изменить правило-исключение WAF

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль WAF](../concepts/waf.md).
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Выберите профиль, в котором вы хотите изменить [правило-исключение](../concepts/waf.md#exclusion-rules).
  1. Перейдите на вкладку **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rules }}**.
  1. В строке с нужным правилом нажмите ![options](../../_assets/console-icons/ellipsis.svg) → ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Измените имя и описание правила-исключения.
  1. (опционально) Включите опцию **{{ ui-key.yacloud.smart-web-security.waf.field_logging }}**, чтобы логировать факты срабатывания правил-исключений.
  1. {% include [waf-rule-rules-section](../../_includes/smartwebsecurity/waf-rule-rules-section.md) %}
  1. {% include [waf-rule-request-condition](../../_includes/smartwebsecurity/waf-rule-request-condition.md) %}
  1. {% include [waf-rule-traffic-conditions](../../_includes/smartwebsecurity/waf-rule-traffic-conditions.md) %}
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и в описании профиля безопасности `yandex_sws_waf_profile` измените блок `exclusion_rule` c правилом-исключением.

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

      Подробнее о параметрах ресурса `sws_waf_profile` в [документации провайдера]({{ tf-provider-resources-link }}/sws_waf_profile).

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить изменение ресурсов можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом REST API [update](../waf/api-ref/WafProfile/update.md) для ресурса [WafProfile](../waf/api-ref/WafProfile/) или вызовом gRPC API [WafProfile/Update](../waf/api-ref/grpc/WafProfile/update.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](exclusion-rule-add.md)
* [{#T}](exclusion-rule-delete.md)
* [{#T}](configure-set-rules.md)
