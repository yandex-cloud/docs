[Документация Yandex Cloud](../../index.md) > [Yandex Smart Web Security](../index.md) > [Пошаговые инструкции](index.md) > Профили безопасности > Удалить правило

# Удалить правило из профиля безопасности

Из [профиля безопасности](../concepts/profiles.md) можно удалить базовые правила, а также правила Smart Protection и WAF. Правила ARL [удаляются из профиля ARL](arl-rule-delete.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный профиль безопасности.
  1. Перейдите в сервис **Smart Web Security**.
  1. На панели слева выберите ![shield-check](../../_assets/console-icons/shield-check.svg) **Профили безопасности**.
  1. Выберите профиль, в котором вы хотите удалить [правило](../concepts/rules.md).
  1. На вкладке **Правила безопасности** в строке с нужным правилом нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
  1. Подтвердите удаление.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

  1. Обновите профиль безопасности, применив к нему измененную [YAML](https://ru.wikipedia.org/wiki/YAML)-конфигурацию правил безопасности, предварительно удалив из нее ненужные правила:
  
     1. Чтобы получить YAML-конфигурацию уже имеющихся в профиле правил безопасности, выполните команду, указав имя или идентификатор профиля безопасности:

         ```bash
         yc smartwebsecurity security-profile get <имя_или_идентификатор_профиля_безопасности>
         ```

         {% cut "Результат:" %}

         ```yaml
         id: fev450d61ucv********
         folder_id: b1gt6g8ht345********
         cloud_id: b1gia87mbaom********
         labels:
           label1: value1
           label2: value2
         name: my-new-profile
         description: my description
         default_action: DENY
         security_rules:
           - name: rule-condition-deny
             priority: "11111"
             dry_run: true
             rule_condition:
               action: DENY
               condition:
                 authority:
                   authorities:
                     - exact_match: example.com
                     - exact_match: example.net
                 http_method:
                   http_methods:
                     - exact_match: GET
                     - exact_match: POST
                 request_uri:
                   path:
                     prefix_match: /search
                   queries:
                     - key: firstname
                       value:
                         pire_regex_match: .ivan.
                     - key: lastname
                       value:
                         pire_regex_not_match: .petr.
                 headers:
                   - name: User-Agent
                     value:
                       pire_regex_match: .curl.
                   - name: Referer
                     value:
                       pire_regex_not_match: .bot.
                 source_ip:
                   ip_ranges_match:
                     ip_ranges:
                       - 1.2.33.44
                       - 2.3.4.56
                   ip_ranges_not_match:
                     ip_ranges:
                       - 8.8.0.0/16
                       - 10::1234:1abc:1/64
                   geo_ip_match:
                     locations:
                       - ru
                       - es
                   geo_ip_not_match:
                     locations:
                       - us
                       - fm
                       - gb
             description: My first security rule. This rule it's just example to show possibilities of configuration.
           - name: rule-condition-allow
             priority: "2"
             rule_condition:
               action: ALLOW
               condition:
                 source_ip:
                   ip_ranges_match:
                     ip_ranges:
                       - 44.44.44.44-44.44.44.45
                       - 44.44.44.77
             description: Let's show how to whitelist IP.
           - name: smart-protection-full
             priority: "11"
             smart_protection:
               mode: FULL
               condition:
                 request_uri:
                   path:
                     prefix_match: /search
             description: Enable smart protection. Allow to show captcha on /search prefix.
           - name: smart-protection-api
             priority: "10"
             smart_protection:
               mode: API
               condition:
                 request_uri:
                   path:
                     prefix_match: /api
             description: Enable smart protection with mode API. We are not expect to see captcha on /api prefix.
         created_at: "2024-08-05T17:54:48.898624Z"
         ```

         {% endcut %}

     1. Скопируйте в любой текстовый редактор и сохраните в файл текущую конфигурацию правил (содержимое блока `security_rules`), удалив из нее лишние правила, например:

         {% cut "security-rules.yaml" %}

         ```yaml
         - name: rule-condition-deny
           description: My first security rule. This rule it's just example to show possibilities of configuration.
           priority: "11111"
           dry_run: true
           rule_condition:
             action: DENY
             condition:
               authority:
                 authorities:
                   - exact_match: example.com
                   - exact_match: example.net
               http_method:
                 http_methods:
                   - exact_match: GET
                   - exact_match: POST
               request_uri:
                 path:
                   prefix_match: /search
                 queries:
                   - key: firstname
                     value:
                       pire_regex_match: .ivan.
                   - key: lastname
                     value:
                       pire_regex_not_match: .petr.
               headers:
                 - name: User-Agent
                   value:
                     pire_regex_match: .curl.
                 - name: Referer
                   value:
                     pire_regex_not_match: .bot.
               source_ip:
                 ip_ranges_match:
                   ip_ranges:
                     - 1.2.33.44
                     - 2.3.4.56
                 ip_ranges_not_match:
                   ip_ranges:
                     - 8.8.0.0/16
                     - 10::1234:1abc:1/64
                 geo_ip_match:
                   locations:
                     - ru
                     - es
                 geo_ip_not_match:
                   locations:
                     - us
                     - fm
                     - gb
         ```

         {% endcut %}

         {% note alert %}
           
         При изменении правил в профиле безопасности все существующие правила будут удалены. Поэтому YAML-файл с изменениями должен содержать полный набор правил, который будет действовать в профиле безопасности.
           
         {% endnote %}

     1. Чтобы внести изменения в профиль безопасности, выполните команду, указав имя или идентификатор профиля:
    
         ```bash
         yc smartwebsecurity security-profile update <имя_или_идентификатор_профиля_безопасности> \
            --security-rules-file <путь_к_файлу_с_правилами_безопасности>
         ```

         Где `--security-rules-file` — путь к [YAML](https://ru.wikipedia.org/wiki/YAML)-файлу с описанием правил безопасности.

         {% cut "Результат:" %}

         ```yaml
         id: fev450d61ucv********
         folder_id: b1gt6g8ht345********
         cloud_id: b1gia87mbaom********
         labels:
           label1: value1
           label2: value2
         name: my-new-profile
         description: my description
         default_action: DENY
         security_rules:
           - name: rule-condition-deny
             priority: "11111"
             dry_run: true
             rule_condition:
               action: DENY
               condition:
                 authority:
                   authorities:
                     - exact_match: example.com
                     - exact_match: example.net
                 http_method:
                   http_methods:
                     - exact_match: GET
                     - exact_match: POST
                 request_uri:
                   path:
                     prefix_match: /search
                   queries:
                     - key: firstname
                       value:
                         pire_regex_match: .ivan.
                     - key: lastname
                       value:
                         pire_regex_not_match: .petr.
                 headers:
                   - name: User-Agent
                     value:
                       pire_regex_match: .curl.
                   - name: Referer
                     value:
                       pire_regex_not_match: .bot.
                 source_ip:
                   ip_ranges_match:
                     ip_ranges:
                       - 1.2.33.44
                       - 2.3.4.56
                   ip_ranges_not_match:
                     ip_ranges:
                       - 8.8.0.0/16
                       - 10::1234:1abc:1/64
                   geo_ip_match:
                     locations:
                       - ru
                       - es
                   geo_ip_not_match:
                     locations:
                       - us
                       - fm
                       - gb
             description: My first security rule. This rule it's just example to show possibilities of configuration.
         created_at: "2024-08-05T17:54:48.898624Z"
         ```

         {% endcut %}

  Подробнее о команде `yc smartwebsecurity security-profile update` читайте в [справочнике CLI](../../cli/cli-ref/smartwebsecurity/cli-ref/security-profile/update.md).

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Откройте файл конфигурации Terraform и в описании профиля безопасности `yandex_sws_security_profile` удалите нужный блок `security_rule` с правилом безопасности:

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

      Подробнее о параметрах ресурса `yandex_sws_security_profile` в [документации провайдера](../../terraform/resources/sws_security_profile.md).

  1. Создайте ресурсы:

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

  Проверить изменение ресурсов можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/index.md):

  ```bash
  yc smartwebsecurity security-profile get <идентификатор_профиля_безопасности>
  ```

- API {#api}

  Воспользуйтесь методом REST API [update](../api-ref/SecurityProfile/update.md) для ресурса [SecurityProfile](../api-ref/SecurityProfile/index.md) или вызовом gRPC API [SecurityProfileService/Update](../api-ref/grpc/SecurityProfile/update.md).

{% endlist %}