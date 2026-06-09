# Изменить правило в профиле ARL

В [профиле ARL](../concepts/arl.md) можно изменить только правила ARL. Базовые [правила](../concepts/rules.md), а также правила Smart Protection и WAF [изменяются в профиле безопасности](rule-update.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится профиль ARL.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}**.
  1. Выберите профиль, в котором вы хотите изменить правило.
  1. В строке с нужным правилом нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**. В открывшемся окне:
      1. Измените основные параметры правила:
          * **{{ ui-key.yacloud.common.name }}**.
          * **{{ ui-key.yacloud.common.description }}**.
          * **Приоритет** правила. Чем меньше значение параметра, тем больший приоритет у правила.
          * Настройку опции логирования без блокировки запросов (dry run).

      1. В блоке **{{ ui-key.yacloud.smart-web-security.arl.column_rule-conditions }}** определите трафик, для анализа которого будет использоваться правило:
         * `{{ ui-key.yacloud.component.condition-column.condition_full-trafic }}` — правило будет использоваться для анализа всего трафика.
         * `При условии` — правило будет использоваться для анализа трафика, заданного в поле **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}**:
             * `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}` — IP-адрес, диапазон адресов, регион адресов или [список адресов](../concepts/lists.md);
             * `{{ ui-key.yacloud.component.condition-column.condition_name-header }}` — строка в заголовке HTTP;
             * `{{ ui-key.yacloud.component.condition-column.condition_name-requestUri }}` — путь запроса;
             * `{{ ui-key.yacloud.component.condition-column.condition_name-host }}` — домен, на который пришел запрос;
             * `{{ ui-key.yacloud.component.condition-column.condition_name-httpMethod }}` — метод запроса;
             * `{{ ui-key.yacloud.component.condition-column.condition_name-cookie }}` — строка в заголовке cookie.
             * `Bot name` — имена легитимных ботов, принадлежащих различным компаниям и сервисам.
             * `Bot category` — категории верифицированных ботов по их назначению или характеру действий.
             * `Verified bot` — фильтрация по признаку верификации бота (`да` или `нет`).
             * `Bot score` — фильтрация по уровню роботизированности запроса: от `0` (самый низкий уровень, человек) до `100` (самый высокий уровень, бот).
             * `FingerPrint` — [отпечаток](../concepts/botes.md#fingerprint) SSL/TLS‑соединения.
         
             Вы можете задать несколько условий. Для этого в поле **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** выберите все необходимые типы условий.
         
             Вы также можете задать несколько условий одного типа. Для этого в секции с нужным условием нажмите кнопку ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.condition-column.condition_and }}** или ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.condition-column.condition_or }}**.
         
             Чтобы удалить условие, нажмите ![options](../../_assets/console-icons/trash-bin.svg).

      1. Измените способ подсчета запросов и характеристики, по которым запросы будут объединяться в группы:

          * `{{ ui-key.yacloud.smart-web-security.arl.label_rule-without-grouping }}` — считать каждый запрос по отдельности.
          * `По характеристикам` — считать группы запросов, объединенных одной или несколькими характеристиками. 
          
              * Выберите характеристику для группировки:
          
                  Автоматическая группировка | Группировка по ключу
                  ---|---
                  `Request path` — путь запроса | `HTTP cookie` —  строка в заголовке cookie
                  `HTTP method` — метод запроса | `HTTP header` — строка в заголовке HTTP
                  `IP-адрес` — IP-адрес, с которого пришел запрос | `Query params` — строка в параметрах запроса.
                  `Регион` — регион, которому принадлежат IP-адреса запросов |
                  `Host` — домен, на который пришел запрос |
          
                  Для группировки по ключу, укажите значение ключа.
          
              * (Опционально) Включите опцию `Учитывать регистр`, чтобы характеристики с одинаковыми значениями, но в разном регистре попадали в разные группы.
          
          Задайте лимит запросов или лимит запросов на группу, а также временной интервал (от `1 секунды` до `60 минут`), за который рассчитывать лимит. Все запросы сверх лимита будут блокироваться.

      1. В блоке **При превышении лимита запросов** выберите действие:
         
         * **Блокировать запросы свыше лимита** (доступно без группировки запросов) — заблокировать все запросы, которые поступят в период, заданный в лимите запросов.
         * **Временно блокировать все запросы** (доступно при группировке запросов) и укажите период времени, в течение которого запросы будут блокироваться.
         * **Показать капчу для запросов свыше лимита** — отправлять на капчу все запросы, которые поступят в период, заданный в лимите запросов. Капчу можно настроить в [профиле безопасности](profile-create.md), к которому подключен профиль ARL.
      
      1. Выберите или [создайте](template-create.md) шаблон ответа, который будет возвращаться клиенту при срабатывании правила. По умолчанию используется стандартный шаблон {{ yandex-cloud }}.
      1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.arl.label_save-rule }}**.

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы изменить правило в профиле ARL:

  1. Откройте файл конфигурации {{ TF }} и в описании профиля ARL `yandex_sws_advanced_rate_limiter_profile` измените блок `advanced_rate_limiter_rule` с правилом безопасности.

      ```hcl
      # Профиль ARL

      resource "yandex_sws_advanced_rate_limiter_profile" "arl-profile" {
        name        = "<имя_профиля>"
        description = "<описание_профиля>"


        # Правило 1

        advanced_rate_limiter_rule {
          name        = "<новое_имя_правила>"
          priority    = <новый_приоритет_правила>
          description = "<новое_описание_правила>"
          dry_run     = true

          static_quota {
            action = "DENY"
            limit  = <новый_лимит_правила>
            period = <новый_период_правила>
            condition {
              request_uri {
                path {
                  exact_match = "/api"
                }
              }
            }
          }
        }

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

      Более подробную информацию о параметрах ресурса `yandex_sws_advanced_rate_limiter_profile`, см. в [документации провайдера]({{ tf-provider-resources-link }}/sws_advanced_rate_limiter_profile).

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
       
          В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
       1. Примените изменения конфигурации:
       
          ```bash
          terraform apply
          ```
       
       1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

       Проверить изменение ресурсов можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом REST API [update](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/update.md) для ресурса [AdvancedRateLimiterProfile](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/index.md) или вызовом gRPC API [AdvancedRateLimiterProfile/Update](../advanced_rate_limiter/api-ref/grpc/AdvancedRateLimiterProfile/update.md).

{% endlist %}

### См. также {#see-also}

* [{#T}](rule-delete.md)