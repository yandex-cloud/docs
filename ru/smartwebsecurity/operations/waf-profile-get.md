---
title: Как получить информацию о профиле WAF {{ sws-full-name }}
description: Следуя данной инструкции, вы сможете получить информацию о профиле WAF {{ sws-full-name }}.
---

# Получить информацию о профиле WAF

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль WAF](../concepts/waf.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Выберите нужный профиль.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о профиле:
     * Основные параметры профиля.
     * Профили безопасности, к которым подключен профиль WAF.
     * Наборы правил, включенные в профиль, количество активных правил в каждом наборе, уровень аномальности и паранойи для набора OWASP.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы получить информацию о [WAF профиле](../concepts/waf.md) {{ sws-full-name }}, созданном с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

     ```hcl
     data "yandex_sws_waf_profile" "default" {
       name = "<имя_WAF_профиля>"
     }

     output "profile-created" {
       value = data.yandex_sws_waf_profile.default.created_at
     }
     ```

     Где:
     * `data "yandex_sws_waf_profile"` — описание WAF профиля в качестве источника данных:
       * `name` — имя WAF профиля.
     * `output "profile-created"` — выходная переменная, которая содержит информацию о временной метке создания WAF профиля:
       * `value` — возвращаемое значение.

     Вместо `created_at` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_sws_waf_profile` см. в [документации провайдера]({{ tf-provider-datasources-link }}/sws_waf_profile).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

     ```bash
     terraform output
     ```

     Результат:

     ```text
     profile-created = "2024-12-13T17:45:34Z"
     ```

- API {#api}

  Чтобы получить информацию о [WAF профиле](../concepts/waf.md) {{ sws-full-name }}, воспользуйтесь методом REST API [get](../waf/api-ref/WafProfile/get.md) для ресурса [WafProfile](../waf/api-ref/WafProfile/index.md) или вызовом gRPC API [WafProfile/Get](../waf/api-ref/grpc/WafProfile/get.md).

{% endlist %}