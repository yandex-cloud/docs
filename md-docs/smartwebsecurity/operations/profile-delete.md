# Удалить профиль безопасности

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль безопасности](../concepts/profiles.md).
  1. Перейдите в сервис **Smart Web Security**.
  1. На панели слева выберите ![shield-check](../../_assets/console-icons/shield-check.svg) **Профили безопасности**.
  1. В строке с нужным профилем нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
  1. Подтвердите удаление.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../cli/quickstart.md) для удаления [профиля безопасности](../concepts/profiles.md):

     ```bash
     yc smartwebsecurity security-profile delete --help
     ```

  1. Чтобы посмотреть список имеющихся профилей безопасности в каталоге по умолчанию, выполните команду:

     ```bash
     yc smartwebsecurity security-profile list
     ```
     
     Результат:
     
     ```text
     +----------------------+-------------------+---------------------+----------------+------------+-------------+
     |          ID          |       NAME        |       CREATED       | DEFAULT ACTION | CAPTCHA ID | RULES COUNT |
     +----------------------+-------------------+---------------------+----------------+------------+-------------+
     | fev3s055oq64******** | my-new-profile    | 2024-08-05 06:57:18 | DENY           |            |           1 |
     | fevlqk8vei9p******** | my-sample-profile | 2024-08-05 06:57:28 | DENY           |            |           2 |
     +----------------------+-------------------+---------------------+----------------+------------+-------------+
     ```

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

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы удалить профиль безопасности Yandex Smart Web Security, созданный с помощью Terraform:

  1. Откройте файл конфигурации Terraform и удалите фрагмент с описанием профиля.

     {% cut "Пример описания профиля безопасности в конфигурации Terraform" %}
     
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

       1. В терминале перейдите в директорию с конфигурационным файлом.
       1. Проверьте корректность конфигурации с помощью команды:
       
          ```bash
          terraform validate
          ```
       
          Если конфигурация является корректной, появится сообщение:
       
          ```bash
          Success! The configuration is valid.
          ```
       
       1. Выполните команду:
       
          ```bash
          terraform plan
          ```
       
          В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
       1. Примените изменения конфигурации:
       
          ```bash
          terraform apply
          ```
       
       1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

  Проверить удаление ресурсов можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/index.md):

  ```bash
  yc smartwebsecurity security-profile list
  ```

- API {#api}

  Воспользуйтесь методом REST API [delete](../api-ref/SecurityProfile/delete.md) для ресурса [SecurityProfile](../api-ref/SecurityProfile/index.md) или вызовом gRPC API [SecurityProfileService/Delete](../api-ref/grpc/SecurityProfile/delete.md).

{% endlist %}