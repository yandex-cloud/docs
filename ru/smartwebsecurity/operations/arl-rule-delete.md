---
title: Удалить правило из профиля ARL
description: Следуя данной инструкции, вы сможете удалить правило из профиля ARL.
---

# Удалить правило из профиля ARL

Базовые правила, а также правила Smart Protection и WAF [удаляются из профиля безопасности](rule-delete.md). 

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль ARL](../concepts/arl.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}**.
  1. Выберите профиль, в котором вы хотите удалить правило.
  1. В блоке **{{ ui-key.yacloud.smart-web-security.arl.section_rules }}** в строке с нужным правилом нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы удалить правило [профиля ARL](../concepts/arl.md), созданное с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и в описании профиля ARL `yandex_sws_advanced_rate_limiter_profile` удалите блок `advanced_rate_limiter_rule` с правилом безопасности.

      {% cut "Пример описания профиля ARL в конфигурации {{ TF }}" %}
      
      ```hcl
      # Профиль ARL

      resource "yandex_sws_advanced_rate_limiter_profile" "arl-profile" {
        name        = "<имя_профиля>"
        description = "<описание_профиля>"

        ...

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

      {% endcut %}

  1. Примените изменения:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

       Проверить удаление ресурсов можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом REST API [update](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/update.md) для ресурса [AdvancedRateLimiterProfile](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/index.md) или вызовом gRPC API [AdvancedRateLimiterProfile/Update](../advanced_rate_limiter/api-ref/grpc/AdvancedRateLimiterProfile/update.md).

{% endlist %}