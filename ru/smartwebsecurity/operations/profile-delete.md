---
title: Как удалить профиль безопасности {{ sws-full-name }}
description: Следуя данной инструкции, вы сможете удалить профиль безопасности {{ sws-full-name }}.
---

# Удалить профиль безопасности

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль безопасности](../concepts/profiles.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. В строке с нужным профилем нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../cli/quickstart.md) для удаления [профиля безопасности](../concepts/profiles.md):

     ```bash
     yc smartwebsecurity security-profile delete --help
     ```

  1. Чтобы посмотреть список имеющихся профилей безопасности в каталоге по умолчанию, выполните команду:

     {% include [security-profile-list-command](../../_includes/smartwebsecurity/security-profile-list-command.md) %}

  1. Чтобы удалить профиль безопасности, выполните команду, указав имя или идентификатор профиля:

     ```bash
     yc smartwebsecurity security-profile delete <имя_или_идентификатор_профиля_безопасности>
     ```

  1. Чтобы убедиться, что профиль безопасности удален, повторно выполните команду:

     ```bash
     yc smartwebsecurity security-profile list
     ```

     {% note info %}
     
     Удаление профиля безопасности может повлиять на доступ к виртуальным хостам, к которым он подключен.
     
     {% endnote %}

  Подробнее о команде `yc smartwebsecurity security-profile delete` читайте в [справочнике CLI](../../cli/cli-ref/smartwebsecurity/cli-ref/security-profile/delete.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы удалить профиль безопасности {{ sws-full-name }}, созданный с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием профиля.

     {% cut "Пример описания профиля безопасности в конфигурации {{ TF }}" %}
     
     ```hcl
     resource "yandex_sws_security_profile" "demo-profile-simple" {
       name                             = "<имя_профиля_безопасности>"
       default_action                   = "DENY"
       captcha_id                       = "<идентификатор_капчи>"
       advanced_rate_limiter_profile_id = "<идентификатор_ARL_профиля>"

       # Правило Smart Protection
       security_rule {
         name     = "smart-protection"
         priority = 99999

         smart_protection {
           mode = "API"
         }
       }

       #Базовое правило
       security_rule {
         name = "base-rule-geo"
         priority = 100000
         rule_condition {
           action = "ALLOW"
           condition {
             source_ip {
               geo_ip_match {
                 locations = ["ru", "kz"]
               }
             }
           }
         }
       }

       # Правило c WAF профилем
       security_rule {
         name     = "waf"
         priority = 88888

         waf {
           mode           = "API"
           waf_profile_id = "<идентификатор_WAF_профиля>"
         }
       }
     }
     ```

     {% endcut %}

  1. Примените изменения:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить удаление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

  ```bash
  yc smartwebsecurity security-profile list
  ```

- API {#api}

  Воспользуйтесь методом REST API [delete](../api-ref/SecurityProfile/delete.md) для ресурса [SecurityProfile](../api-ref/SecurityProfile/) или вызовом gRPC API [SecurityProfileService/Delete](../api-ref/grpc/SecurityProfile/delete.md).

{% endlist %}
