---
title: Изменить правило в профиле ARL
description: Следуя данной инструкции, вы сможете изменить правило в профиле ARL.
---

# Изменить правило в профиле ARL

В [профиле ARL](../concepts/arl.md) можно изменить только правила ARL. Базовые [правила](../concepts/rules.md), а также правила Smart Protection и WAF [изменяются в профиле безопасности](rule-update.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится профиль ARL.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}**.
  1. Выберите профиль, в котором вы хотите изменить правило.
  1. В строке с нужным правилом нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**. В открывшемся окне:
      1. Измените основные параметры правила:
          * **{{ ui-key.yacloud.common.name }}**.
          * **{{ ui-key.yacloud.common.description }}**.
          * **Приоритет** правила. Чем меньше значение параметра, тем больший приоритет у правила.
          * Настройку опции логирования без блокировки запросов (dry run).

      1. {% include [arl-rule-traffic-conditions](../../_includes/smartwebsecurity/arl-rule-traffic-conditions.md) %}

      1. Измените способ подсчета запросов и характеристики, по которым запросы будут объединяться в группы:

          {% include [arl-rule-request-count](../../_includes/smartwebsecurity/arl-rule-request-count.md) %}

      1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.arl.label_save-rule }}**.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы изменить правило в профиле ARL:

  1. Откройте файл конфигурации {{ TF }} и в описании профиля ARL `yandex_sws_advanced_rate_limiter_profile` измените блок `advanced_rate_limiter_rule` с правилом безопасности.

      ```hcl
      # Профиль ARL

      resource "yandex_sws_advanced_rate_limiter_profile" "arl-profile" {
        name        = "<имя_профиля>"
        description = "<описание_профиля>"


        # Правило 1

        advanced_rate_limiter_rule {
          name        = "<новое_имя_правила>"
          priority    = <новый_приоритет_правила>
          description = "<новое_описание_правила>"
          dry_run     = true

          static_quota {
            action = "DENY"
            limit  = <новый_лимит_правила>
            period = <новый_период_правила>
            condition {
              request_uri {
                path {
                  exact_match = "/api"
                }
              }
            }
          }
        }

        # Правило 2

        advanced_rate_limiter_rule {
          name        = "<имя_правила>"
          priority    = <приоритет_правила>
          description = "<описание_правила>"
          dry_run     = true
  
          static_quota {
            action = "DENY"
            limit  = <лимит_правила>
            period = <период_правила>
            condition {
              source_ip {
                geo_ip_match {
                  locations = ["ru", "kz"]
                }
              }
            }
          }
        }
      }
      ```

      Более подробную информацию о параметрах ресурса `yandex_sws_advanced_rate_limiter_profile`, см. в [документации провайдера]({{ tf-provider-resources-link }}/sws_advanced_rate_limiter_profile).

  1. Примените изменения:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

       Проверить изменение ресурсов можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом REST API [update](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/update.md) для ресурса [AdvancedRateLimiterProfile](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/index.md) или вызовом gRPC API [AdvancedRateLimiterProfile/Update](../advanced_rate_limiter/api-ref/grpc/AdvancedRateLimiterProfile/update.md).

{% endlist %}

### См. также {#see-also}

* [{#T}](rule-delete.md)
