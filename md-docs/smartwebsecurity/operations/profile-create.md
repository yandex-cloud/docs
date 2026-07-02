[Документация Yandex Cloud](../../index.md) > [Yandex Smart Web Security](../index.md) > [Пошаговые инструкции](index.md) > Профили безопасности > Создать профиль

# Создать профиль безопасности

{% note info %}

Чтобы сделать вашу защиту более эффективной, мы используем информацию об HTTP-запросах для развития моделей машинного обучения (ML). Вы можете отключить использование этой информации в [консоли управления](https://console.yandex.cloud) при создании профиля безопасности или позднее в его настройках.

{% endnote %}

![profiles-rules](../../_assets/smartwebsecurity/profiles-rules.svg)

Для работы с профилем безопасности, который подключается к балансировщику, потребуется сервисный аккаунт с ролями `monitoring.editor`, `smart-web-security.admin`, `certificate-manager.admin` и `logging.writer`. Подробнее в разделе [Назначение роли сервисному аккаунту](../../iam/operations/sa/assign-role-for-sa.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать [профиль безопасности](../concepts/profiles.md).
  1. Перейдите в сервис **Smart Web Security**.
  1. На панели слева выберите ![shield-check](../../_assets/console-icons/shield-check.svg) **Профили безопасности**.
  1. Нажмите кнопку **Создать профиль**.
  1. Выберите один из вариантов создания:
      * **По преднастроенному шаблону** (рекомендуется).

        Преднастроенный профиль содержит:
        
        * [базовое правило](../concepts/rules.md#base-rules) по умолчанию, включенное для всего трафика с [типом действия](../concepts/rules.md#rule-action) `Разрешить`;
        * [правило Smart Protection](../concepts/rules.md#smart-protection-rules) `sp-rule-1`, включенное для всего трафика, с типом действия `Полная защита`.
        
      * **С чистого листа**. Профиль содержит только базовое правило по умолчанию, включенное для всего трафика.

  1. Введите имя профиля.
  1. (Опционально) Введите описание.
  1. (Опционально) Добавьте профилю [метки](../../resource-manager/concepts/labels.md).
  1. В поле **Действие для базового правила по умолчанию** выберите, что делать с трафиком, который не попал под условия других правил: `Запретить` или `Разрешить`.
  1. Выберите или создайте [профиль ARL](arl-profile-create.md), чтобы установить лимиты на количество запросов.
  1. Выберите или создайте капчу [Yandex SmartCaptcha](../../smartcaptcha/index.md) для проверки подозрительных запросов:

        * `По умолчанию` — контролируется на стороне Yandex Cloud, параметры капчи:
          * [Основное задание](../../smartcaptcha/concepts/tasks.md#main-task) — **Чекбокс**.
          * [Дополнительное задание](../../smartcaptcha/concepts/tasks.md#additional-task) — ![image](../../_assets/console-icons/picture.svg) **Силуэты**.
          * Сложность дополнительного задания — **Легкая**.
          * Внешний вид — **Стандартный**.
                
          Плата за использование капчи `По умолчанию` включена в стоимость Smart Web Security.
        * `Собственная капча` — вы можете [настроить](../../smartcaptcha/operations/create-captcha.md) сложность, типы основного и дополнительного заданий, а также внешний вид капчи.
        
          {% note info %}
        
          Чтобы использовать собственную капчу, выберите в ее настройках опцию **Отключить проверку домена**.
        
          {% endnote %}
           
          Плата за использование собственной капчи взимается в соответствии с [тарификацией](../../smartcaptcha/pricing.md) SmartCaptcha.

  1. Выберите или [создайте](template-create.md) шаблон ответа, который будет возвращаться клиенту при срабатывании любого правила в профиле. По умолчанию используется стандартный шаблон Yandex Cloud.
  1. (опционально) Настройте опцию **Анализировать тело запроса (макс. 8 КБ)**, выбрав действие при превышении максимального размера:
     
     * `Не анализировать тело запроса`
     * `Блокировать запрос`
  
  1. (Опционально) Включите **Запись логов** и настройте логирование:
     1. В поле **Записывать логи в** выберите, какие логи будут записываться: **Cloud Logging**, **Audit Trails**.
     1. Для Cloud Logging выберите или создайте [лог-группу](../../logging/concepts/log-group.md) Cloud Logging, в которую будут записываться логи.
     1. Для записи в логи можно выбрать только те запросы, для которых сработали:
        * **Базовые правила**.
        * Правила **Smart Protection**.
        * Правила **Web Application Firewall**.
        * Правила **Advanced Rate Limiter**.
        * Все выбранные правила применили действие (вердикт) **DENY и CAPTCHA**.
        * Все выбранные правила применили действие **ALLOW** (легитимные запросы).
  
     Настройка логирования описана в разделе [Настроить логирование через Smart Web Security](configure-logging.md).

  1. Нажмите кнопку ![plus-sign](../../_assets/console-icons/plus.svg) **Добавить правило**.
  1. В окне создания правила:

      1. Введите имя правила.
      1. (опционально) Введите описание.
      1. Задайте приоритет правила. Добавляемое правило будет иметь более высокий приоритет, чем преднастроенные правила.
      
          {% note info %}
          
          Чем меньше значение параметра, тем больший приоритет у правила. Приоритеты преднастроенных правил:
          * базовое правило по умолчанию — `1000000`;
          * правило Smart Protection с полной защитой — `999900`.
          
          {% endnote %}
      
          Приоритет правил описан в разделе [Общие принципы работы правил](../concepts/rules.md#rules-order).
      
      1. (опционально) Включите опцию **Только логирование (dry run)**, если вы хотите только фиксировать информацию о трафике, который соответствует заданным условиям, но не применять к нему никаких действий.
      1. Выберите тип правила:
          * [**Базовое**](../concepts/rules.md#base-rules) — правило, которое по заданным условиям разрешает, запрещает или отправляет трафик в [Yandex SmartCaptcha](../../smartcaptcha/index.md).
          * [**Smart Protection**](../concepts/rules.md#smart-protection-rules) — правило, которое отправляет трафик на автоматический анализ с помощью алгоритмов машинного обучения и поведенческого анализа. Подозрительные запросы отправляются в Yandex SmartCaptcha для дополнительной верификации.
          * [**Web Application Firewall**](../concepts/rules.md#waf-rules) — правило, которое подключает набор правил из профиля WAF. Подозрительные запросы отправляются в Yandex SmartCaptcha.
      
              Для правила WAF выберите или [создайте профиль WAF](waf-profile-create.md).
      1. Выберите [действие](../concepts/rules.md#rule-action):
          * Для базового правила: 
            * `Запретить`;
            * `Разрешить`;
            * `Показать капчу` — будет показана капча, выбранная в профиле безопасности.
          * Для правила Smart Protection или WAF:
      
            * `Полная защита` — после проверки подозрительные запросы отправляются в SmartCaptcha.
            * `Защита API` — после проверки подозрительные запросы блокируются.
      
      1. (Опционально) Выберите или [создайте](template-create.md) шаблон ответа, который будет возвращаться клиенту при срабатывании правила. По умолчанию используется стандартный шаблон Yandex Cloud.
      1. В блоке **Условия на трафик** определите трафик, для анализа которого будет использоваться правило:
         * `Весь трафик` — правило будет использоваться для анализа всего трафика.
         * `При условии` — правило будет использоваться для анализа трафика, заданного в поле **Условия**:
             * `IP` — IP-адрес, диапазон адресов, регион адресов или [список адресов](../concepts/lists.md);
             * `HTTP header` — строка в заголовке HTTP;
             * `Request URI` — путь запроса;
             * `Host` — домен, на который пришел запрос;
             * `HTTP method` — метод запроса;
             * `Cookie` — строка в заголовке cookie.
             * `Bot name` — имена легитимных ботов, принадлежащих различным компаниям и сервисам.
             * `Bot category` — категории верифицированных ботов по их назначению или характеру действий.
             * `Verified bot` — фильтрация по признаку верификации бота (`да` или `нет`).
             * `Bot score` — фильтрация по уровню роботизированности запроса: от `0` (самый низкий уровень, человек) до `100` (самый высокий уровень, бот).
             * `FingerPrint` — [отпечаток](../concepts/botes.md#fingerprint) SSL/TLS‑соединения.
         
             Вы можете задать несколько условий. Для этого в поле **Условия** выберите все необходимые типы условий.
         
             Вы также можете задать несколько условий одного типа. Для этого в секции с нужным условием нажмите кнопку ![plus-sign](../../_assets/console-icons/plus.svg) **и** или ![plus-sign](../../_assets/console-icons/plus.svg) **или**.
         
             Чтобы удалить условие, нажмите ![options](../../_assets/console-icons/trash-bin.svg).
      
      1. Нажмите кнопку **Добавить**.

  1. Если для базового правила по умолчанию установлено действие `Запретить` и запросы отправляются на проверку в SmartCaptcha, [добавьте](captcha-rule.md) разрешающее правило.
  1. Последовательно добавьте все правила, которые вы хотите задействовать в профиле.

      В блоке **Правила безопасности** в таблице появятся созданные вами правила.
  1. (Опционально) Включите или отключите использование информации об HTTP-запросах для улучшения моделей машинного обучения в разделе **Обучение ML-моделей**.
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../cli/quickstart.md) для создания [профиля безопасности](../concepts/profiles.md):

     ```bash
     yc smartwebsecurity security-profile create --help
     ```

  1. Чтобы создать профиль безопасности, выполните команду:

     ```bash
     yc smartwebsecurity security-profile create \
        --name <имя_профиля_безопасности> \
        --description "<описание_профиля>" \
        --labels <ключ_метки_1>=<значение_метки_1>,<ключ_метки_2>=<значение_метки_2>,...,<ключ_метки_n>=<значение_метки_n> \
        --default-action <действие> \
        --captcha-id <идентификатор_капчи> \
        --security-rules-file <путь_к_файлу_с_правилами>
     ```

     Где:

     * `--name` — имя профиля безопасности. Обязательный параметр. Если задать только имя профиля без дополнительных параметров, в профиле безопасности будет создано одно [базовое правило](../concepts/rules.md#base-rules).
     * `--description` — текстовое описание профиля безопасности. Необязательный параметр.
     * `--labels` — список [меток](../../resource-manager/concepts/labels.md) для добавления в профиль в формате `КЛЮЧ=ЗНАЧЕНИЕ`. Необязательный параметр. Например: `--labels foo=baz,bar=baz'`.
     * `--default-action` — действие, которое следует выполнить для трафика, который не попал под условия других правил. Необязательный параметр. По умолчанию установлено значение `allow`, разрешающее все запросы к сервису. Чтобы запретить запросы, установите значение `deny`.
     * `--captcha-id` — идентификатор капчи [Yandex SmartCaptcha](../../smartcaptcha/index.md) для проверки подозрительных запросов. Необязательный параметр.
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
     description: "my description"
     labels: label1=value1,label2=value2
     default_action: DENY
     created_at: "2024-07-25T19:21:05.039610Z"
     ```

  Подробнее о команде `yc smartwebsecurity security-profile create` читайте в [справочнике CLI](../../cli/cli-ref/smartwebsecurity/cli-ref/security-profile/create.md).

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле Terraform параметры ресурсов, которые необходимо создать:

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

        # Базовое правило
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

      Где:
      * `name` — имя профиля безопасности.
      * `default_action` — действие для базового правила по умолчанию. Будет применяться к трафику, который не попал под условия других правил.  Возможные значения: `ALLOW` — разрешает все запросы к сервису, `DENY` — запрещает.
      * `captcha_id` — идентификатор капчи [Yandex SmartCaptcha](../../smartcaptcha/index.md) для проверки подозрительных запросов. Необязательный параметр.
      * `advanced_rate_limiter_profile_id` — идентификатор [ARL профиля безопасности](../concepts/arl.md). Необязательный параметр.
      * `security_rule` — описание [правила](../concepts/rules.md) безопасности:
         * `name` — имя правила безопасности.
         * `priority` — [приоритет](../concepts/rules.md#rules-order) правила. Возможные значения — от 1 до 1000000.
         * `smart_protection` — описание [правила Smart Protection](../concepts/rules.md#smart-protection-rules), включенное для всего трафика, с указанным типом действия в параметре `mode`.
            * `mode` — [действие правила](../concepts/rules.md#rule-action). Возможные значения: `FULL` — полная защита (подозрительные запросы отправляются на капчу) или `API` — защита API (подозрительные запросы блокируются).
         * `waf` — описание правила Web Application Firewall. Чтобы добавить правило WAF, сначала надо [создать профиль WAF](waf-profile-create.md). Необязательный блок параметров, содержит:
            * `waf_profile_id` — идентификатор [WAF профиля](../concepts/waf.md).

      Если не указать тип правила `smart_protection` или `waf`, будет создано базовое правило с простой фильтрацией по заданным условиям в блоке `rule_condition`.

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

  Terraform создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/index.md):

  ```bash
  yc smartwebsecurity security-profile get <идентификатор_профиля_безопасности>
  ```

- API {#api}

  Воспользуйтесь методом REST API [create](../api-ref/SecurityProfile/create.md) для ресурса [SecurityProfile](../api-ref/SecurityProfile/index.md) или вызовом gRPC API [SecurityProfileService/Create](../api-ref/grpc/SecurityProfile/create.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [Подключить профиль безопасности к ресурсу](host-connect.md)
* [Изменить основные параметры профиля безопасности](profile-update.md)
* [Удалить профиль безопасности](profile-delete.md)