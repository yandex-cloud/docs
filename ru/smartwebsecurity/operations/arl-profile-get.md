---
title: Получить информацию о профиле безопасности ARL {{ sws-full-name }}
description: Следуя данной инструкции, вы сможете получить информацию о профиле безопасности ARL {{ sws-full-name }}.
---

# Получить информацию о профиле ARL

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль ARL](../concepts/arl.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}**.
  1. Выберите нужный профиль.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о профиле.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы получить информацию о [ARL профиле](../concepts/arl.md) {{ sws-full-name }}, созданном с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

     ```hcl
     data "yandex_sws_advanced_rate_limiter_profile" "default" {
        name = yandex_sws_advanced_rate_limiter_profile.default.name
     }

     output "profile-created" {
       value = data.yandex_sws_advanced_rate_limiter_profile.default.created_at
     }
     ```

     Где:
     * `data "yandex_sws_advanced_rate_limiter_profile"` — описание профиля ARL в качестве источника данных:
       * `name` — имя профиля ARL.
     * `output "profile-created"` — выходная переменная, которая содержит информацию о временной метке создания профиля ARL:
       * `value` — возвращаемое значение.

     Вместо `created_at` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_sws_advanced_rate_limiter_profile` см. в [документации провайдера]({{ tf-provider-datasources-link }}/sws_advanced_rate_limiter_profile).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

     ```bash
     terraform output
     ```

     Результат:

     ```text
     profile-created = "2024-12-15T12:21:20Z"
     ```

- API {#api}

  Воспользуйтесь методом REST API [get](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/get.md) для ресурса [AdvancedRateLimiterProfile](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/index.md) или вызовом gRPC API [AdvancedRateLimiterProfile/Get](../advanced_rate_limiter/api-ref/grpc/AdvancedRateLimiterProfile/get.md).

{% endlist %}
