---
title: Как создать профиль ARL {{ sws-full-name }}
description: Следуя данной инструкции, вы сможете создать профиль ARL {{ sws-full-name }}.
---

# Создать профиль ARL

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать [профиль ARL](../concepts/arl.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}** и нажмите кнопку **{{ ui-key.yacloud.smart-web-security.arl.label_create-profile }}**.
  1. Введите имя профиля.
  1. (Опционально) Введите описание.
  1. (Опционально) Добавьте профилю [метки](../../resource-manager/concepts/labels.md).
  1. [Добавьте](arl-rule-add.md) правила ARL.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы создать [профиль ARL](../concepts/arl.md):

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

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
      }
      ```

      {% include [arl-profile-parameters](../../_includes/smartwebsecurity/arl-profile-parameters.md) %}

      Более подробную информацию о параметрах ресурса `yandex_sws_advanced_rate_limiter_profile`, см. в [документации провайдера]({{ tf-provider-resources-link }}/sws_advanced_rate_limiter_profile).

  1. Создайте ресурсы:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

       {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}).

  После создания профиля ARL вы можете [добавить правило в профиль](arl-rule-add.md).

- API {#api}

  Воспользуйтесь методом REST API [create](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/create.md) для ресурса [AdvancedRateLimiterProfile](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/index.md) или вызовом gRPC API [AdvancedRateLimiterProfile/Create](../advanced_rate_limiter/api-ref/grpc/AdvancedRateLimiterProfile/create.md).

{% endlist %}

### См. также {#see-also}

* [{#T}](arl-rule-add.md)
* [{#T}](profile-update.md)
* [{#T}](arl-profile-delete.md)
