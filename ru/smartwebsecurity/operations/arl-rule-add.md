---
title: Добавить правило в профиль ARL
description: Следуя данной инструкции, вы сможете добавить правило в профиль ARL.
---

# Добавить правило в профиль ARL

В [профиле ARL](../concepts/arl.md) можно добавить только правила ARL. Базовые [правила](../concepts/rules.md), а также правила Smart Protection и WAF [добавляются в профиле безопасности](rule-add.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится профиль ARL.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}**.
  1. Выберите профиль, в который вы хотите добавить правило.
  1. Нажмите кнопку ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}** и в открывшемся окне:

      {% include [add-arl-rule](../../_includes/smartwebsecurity/add-arl-rule.md) %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы добавить правило в [профиль ARL](../concepts/arl.md):

    1. Откройте файл конфигурации {{ TF }} и измените фрагмент с описанием ресурса `yandex_sws_advanced_rate_limiter_profile`: добавьте блок `advanced_rate_limiter_rule` с правилом безопасности.

        ```hcl
        # Профиль ARL

        resource "yandex_sws_advanced_rate_limiter_profile" "arl-profile" {
          name        = "<имя_профиля>"
          description = "<описание_профиля>"

          # Правило 1

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
  
        {% include [arl-profile-parameters](../../_includes/smartwebsecurity/arl-profile-parameters.md) %}
  
        Более подробную информацию о параметрах ресурса `yandex_sws_advanced_rate_limiter_profile`, см. в [документации провайдера]({{ tf-provider-resources-link }}/sws_advanced_rate_limiter_profile).
  
    1. Примените изменения:
  
         {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

         Проверить изменение ресурсов можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  [Получите](arl-profile-get.md) информацию о профиле ARL и затем внесите изменения в профиль ARL с помощью метода REST API [update](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/update.md) для ресурса [AdvancedRateLimiterProfile](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/index.md) или вызова gRPC API [AdvancedRateLimiterProfile/Update](../advanced_rate_limiter/api-ref/grpc/AdvancedRateLimiterProfile/update.md).

{% endlist %}

### См. также {#see-also}

* [{#T}](rule-update.md)
* [{#T}](rule-delete.md)
