---
title: Изменить правило-исключение WAF
description: Следуя данной инструкции, вы сможете изменить правило-исключение для WAF.
---

# Изменить правило-исключение WAF

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль WAF](../concepts/waf.md).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Выберите профиль, в котором вы хотите изменить [правило-исключение](../concepts/waf.md#exclusion-rules).
  1. В меню слева перейдите на вкладку ![image](../../_assets/console-icons/file-xmark.svg) **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rules }}**.
  1. В строке с нужным правилом нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**. В открывшемся окне:
      1. Измените имя и описание правила-исключения.
      1. (опционально) Включите опцию **{{ ui-key.yacloud.smart-web-security.waf.field_logging }}**, чтобы логировать факты срабатывания правил-исключений.
      1. В поле **{{ ui-key.yacloud.smart-web-security.waf.label_exclusion-rule-exclude-rules }}** выберите:
          * **Все правила** — исключение будет срабатывать для всех правил.
          * **Выбранные правила** — исключение будет срабатывать для выбранных правил. Нажмите **{{ ui-key.yacloud.smart-web-security.waf.action_exclusion-rule-add-rules }}**, чтобы выбрать правила.

      1. В блоке **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rule-rules-section }}** выберите:
          * **Весь запрос** — исключение будет применяться ко всему HTTP-запросу.
          * **Часть запроса** — исключение будет применяться только к той части запроса, которая указана в параметрах. Остальной запрос будет проверяться в соответствии с настройками WAF-профиля.

             В поле **Параметры исключений** выберите один или несколько параметров: `HTTP body`, `Cookie`, `HTTP header` или `Query params`. Для каждого параметра задайте значение. При необходимости включите опцию **Учитывать регистр**.

             Чтобы добавить еще одно значение для параметра, нажмите ![plus-sign](../../_assets/console-icons/plus.svg) **или**.

      1. {% include [waf-rule-traffic-conditions](../../_includes/smartwebsecurity/waf-rule-traffic-conditions.md) %}

      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

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

      Более подробную информацию о параметрах ресурса `sws_waf_profile` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/sws_waf_profile).

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить изменение ресурсов можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом REST API [update](../waf/api-ref/WafProfile/update.md) для ресурса [WafProfile](../waf/api-ref/WafProfile/) или вызовом gRPC API [WafProfile/Update](../waf/api-ref/grpc/WafProfile/update.md).

{% endlist %}

### Полезные ссылки {#see-also}

* [{#T}](exclusion-rule-add.md)
* [{#T}](exclusion-rule-delete.md)
* [{#T}](configure-set-rules.md)
