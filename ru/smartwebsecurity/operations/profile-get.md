---
title: Получить информацию о профиле безопасности {{ sws-full-name }}
description: Следуя данной инструкции, вы сможете получить информацию о профиле безопасности {{ sws-full-name }}.
---

# Получить информацию о профиле безопасности

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль безопасности](../concepts/profiles.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Выберите нужный профиль безопасности.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о профиле.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о [профиле безопасности](../concepts/profiles.md):

      ```bash
      yc smartwebsecurity security-profile --help
      ```

  1. Получите информацию о профиле безопасности, указав его имя или идентификатор:

      ```bash
      yc smartwebsecurity security-profile get <имя_профиля_безопасности>
      ```

      Результат:

      ```text
      id: fev0mcqgth1q********
      folder_id: b1geoelk7fld********
      name: demo-profile-simple
      default_action: ALLOW
      security_rules:
        - name: smart-protection
          priority: "99999"
          smart_protection:
            mode: API
        - name: rule-condition-2
          priority: "1"
          rule_condition:
            action: ALLOW
            condition:
              authority:
                authorities:
                  - exact_match: example.com
                  - exact_match: example.net
      created_at: "2024-11-20T17:49:53.615527Z"
      cloud_id: b1gia87mbaom********
      captcha_id: bpna2egcj76e********
      advanced_rate_limiter_profile_id: fevihb5krdcp********
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы получить информацию о [профиле безопасности](../concepts/profiles.md) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

     ```hcl
     data "yandex_sws_security_profile" "my-profile" {
       security_profile_id = "<идентификатор_профиля_безопасности>"
     }

     output "profile-created" {
       value = data.yandex_sws_security_profile.my-profile.created_at
     }
     ```

     Где:
     * `data "yandex_sws_security_profile"` — описание профиля безопасности в качестве источника данных:
       * `security_profile_id` — идентификатор профиля безопасности.
     * `output "profile-created"` — выходная переменная, которая содержит информацию о временной метке создания профиля безопасности:
       * `value` — возвращаемое значение.

     Вместо `created_at` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_sws_security_profile` см. в [документации провайдера]({{ tf-provider-datasources-link }}/sws_security_profile).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

     ```bash
     terraform output
     ```

     Результат:

     ```text
     profile-created = "2024-11-20T17:49:53Z"
     ```

- API {#api}

  Чтобы получить подробную информацию о [профиле безопасности](../concepts/profiles.md), воспользуйтесь методом REST API [get](../api-ref/SecurityProfile/get.md) для ресурса [SecurityProfile](../api-ref/SecurityProfile/index.md) или вызовом gRPC API [SecurityProfile/Get](../api-ref/grpc/SecurityProfile/get.md) и передайте в запросе идентификатор нужного профиля безопасности в параметре `securityProfileId`.

{% endlist %}

#### См. также {#see-also}

* [{#T}](operation-logs.md)
