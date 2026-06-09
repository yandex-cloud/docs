# Изменить основные параметры профиля безопасности

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль безопасности](../concepts/profiles.md).
  1. Перейдите в сервис **Smart Web Security**.
  1. На панели слева выберите ![shield-check](../../_assets/console-icons/shield-check.svg) **Профили безопасности**.
  1. В строке с нужным профилем нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
  1. В открывшемся окне измените параметры:

      * **Имя**.
      * **Описание**.
      * [**Метки**](../../resource-manager/concepts/labels.md). Чтобы добавить новую метку, нажмите кнопку **Добавить метку**.
      * **Действие для базового правила по умолчанию** — `Запретить` или `Разрешить`.
      * **Профиль ARL** — выберите или создайте [профиль ARL](../concepts/arl.md).
      * Выберите или создайте капчу [SmartCaptcha](../../smartcaptcha/index.md) для проверки подозрительных запросов.
      * Выберите или [создайте](template-create.md) шаблон ответа, который будет возвращаться клиенту при срабатывании любого правила в профиле. По умолчанию используется стандартный шаблон Yandex Cloud.
      * (опционально) Настройте опцию **Анализировать тело запроса (макс. 8 КБ)**, выбрав действие при превышении максимального размера:
        
        * `Не анализировать тело запроса`
        * `Блокировать запрос`
  1. Включите или отключите использование информации об HTTP-запросах для улучшения моделей машинного обучения в разделе **Обучение ML-моделей**.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../cli/quickstart.md) для изменения основных параметров [профиля безопасности](../concepts/profiles.md):

     ```bash
     yc smartwebsecurity security-profile update --help
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

  1. Чтобы изменить основные параметры профиля безопасности, выполните команду:

     ```bash
     yc smartwebsecurity security-profile update \
        --name <имя_профиля_безопасности> \
        --new-name <новое_имя_профиля_безопасности> \
        --description "<описание_профиля>" \
        --labels <ключ_метки_1>=<значение_метки_1>,<ключ_метки_2>=<значение_метки_2>,...,<ключ_метки_n>=<значение_метки_n> \
        --default-action <действие> \
        --captcha-id <идентификатор_капчи> \
        --security-rules-file <путь_к_файлу_с_правилами_безопасности>
     ```

     Где:

     * `--name` — имя профиля безопасности. Обязательный параметр. Вместо имени профиля безопасности вы можете передать его идентификатор в параметре `--id`.
     * `--new-name` — новое имя профиля безопасности. Необязательный параметр если имя профиля не изменяется.
     * `--description` — текстовое описание профиля безопасности. Необязательный параметр.
     * `--labels` — список [меток](../../resource-manager/concepts/labels.md) для добавления в профиль в формате `КЛЮЧ=ЗНАЧЕНИЕ`. Необязательный параметр. Например: `--labels foo=baz,bar=baz'`.
     * `--default-action` — действие, которое следует выполнить для трафика, который не попал под условия других правил. Необязательный параметр. По умолчанию установлено значение `allow`, разрешающее все запросы к сервису. Чтобы запретить запросы, установите значение `deny`.
     * `--captcha-id` — идентификатор капчи [SmartCaptcha](../../smartcaptcha/index.md) для проверки подозрительных запросов. Необязательный параметр.
     * `--security-rules-file` — путь к файлу с описанием правил безопасности в формате [YAML](https://ru.wikipedia.org/wiki/YAML). Необязательный параметр. Например:

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
         - name: rule-condition-allow
           description: Let's show how to whitelist IP.
           priority: "2"
           rule_condition:
             action: ALLOW
             condition:
               source_ip:
                 ip_ranges_match:
                   ip_ranges:
                     - 44.44.44.44-44.44.44.45
                     - 44.44.44.77
         - name: smart-protection-full
           description: Enable smart protection. Allow to show captcha on /search prefix.
           priority: "11"
           smart_protection:
             mode: FULL
             condition:
               request_uri:
                 path:
                   prefix_match: /search
         - name: smart-protection-api
           description: Enable smart protection with mode API. We are not expect to see captcha on /api prefix.
           priority: "10"
           smart_protection:
             mode: API
             condition:
               request_uri:
                 path:
                   prefix_match: /api
         ```
         
         Где: `priority` — [приоритет](../concepts/rules.md#rules-order) правила.
         
         {% endcut %}

     Результат:

     ```text
     id: fev6q4qqnn2q********
     folder_id: b1g07hj5r6i********
     cloud_id: b1gia87mbaom********
     name: my-sample-profile
     new-name: my-update-profile
     description: "my update description"
     labels: label1=value1,label2=value2
     default_action: DENY
     created_at: "2024-07-25T19:21:05.039610Z"
     ```

  Подробнее о команде `yc smartwebsecurity security-profile update` читайте в [справочнике CLI](../../cli/cli-ref/smartwebsecurity/cli-ref/security-profile/update.md).


- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы изменить параметры профиля безопасности Yandex Smart Web Security, созданного с помощью Terraform:

  1. Откройте файл конфигурации Terraform и измените фрагмент с описанием профиля.

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

      Более подробную информацию о параметрах ресурса `yandex_sws_security_profile` в Terraform, см. в [документации провайдера](../../terraform/resources/sws_security_profile.md).

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

  Проверить изменение ресурсов можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/index.md):

  ```bash
  yc smartwebsecurity security-profile get <идентификатор_профиля_безопасности>
  ```

- API {#api}

  Воспользуйтесь методом REST API [update](../api-ref/SecurityProfile/update.md) для ресурса [SecurityProfile](../api-ref/SecurityProfile/index.md) или вызовом gRPC API [SecurityProfileService/Update](../api-ref/grpc/SecurityProfile/update.md).

{% endlist %}

### См. также {#see-also}

* [Добавить правило в профиль безопасности](rule-add.md)
* [Изменить правило в профиле безопасности](rule-update.md)
* [Подключить профиль безопасности к ресурсу](host-connect.md)
* [Удалить профиль безопасности](profile-delete.md)