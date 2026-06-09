# Удалить правило из профиля ARL

Базовые правила, а также правила Smart Protection и WAF [удаляются из профиля безопасности](rule-delete.md). 

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль ARL](../concepts/arl.md).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}**.
  1. Выберите профиль, в котором вы хотите удалить правило.
  1. В блоке **{{ ui-key.yacloud.smart-web-security.arl.section_rules }}** в строке с нужным правилом нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление.

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы удалить правило [профиля ARL](../concepts/arl.md), созданное с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и в описании профиля ARL `yandex_sws_advanced_rate_limiter_profile` удалите блок `advanced_rate_limiter_rule` с правилом безопасности.

      {% cut "Пример описания профиля ARL в конфигурации {{ TF }}" %}
      
      ```hcl
      # Профиль ARL

      resource "yandex_sws_advanced_rate_limiter_profile" "arl-profile" {
        name        = "<имя_профиля>"
        description = "<описание_профиля>"

        ...

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

      Где:
      * `name` — имя профиля ARL.
      * `description` — описание профиля ARL. Необязательный параметр.
      * `labels` — [метки](../../resource-manager/concepts/labels.md) профиля ARL. Необязательный параметр.
      * `advanced_rate_limiter_rule` — блок правил.
        * `name` — имя правила.
        * `priority` — приоритет правила, уникальное число от `1` до `999999`. Первыми применяются правила с меньшим числовым значением.
        * `description` — описание правила. Необязательный параметр.
        * `dry_run` — флаг пробного запуска. Установите значение `true`, чтобы протестировать правило и оценить нагрузку на веб-сервис. В этом режиме запросы блокироваться не будут, но информация о срабатывании правила будет записываться в логи. Необязательный параметр.
        * `static_quota` — способ подсчета запросов, при котором считается каждый запрос по отдельности, без группировки. Может быть указан только один из блоков: `static_quota` или `dynamic_quota`.
          * `action` — действие при превышении лимита. Единственное возможное значение — `DENY`.
          * `limit` — максимальное количество разрешенных запросов за период.
          * `period` — период времени в секундах, в течение которого считается лимит.
          * `condition` — [условие](../concepts/conditions.md) применения правила. Необязательный параметр. Описание условий см. в [документации провайдера]({{ tf-provider-resources-link }}/sws_advanced_rate_limiter_profile), в разделе описания структуры `advanced_rate_limiter_rule.static_quota.condition`.
        * `dynamic_quota` — способ подсчета запросов, при котором считаются группы запросов, объединенных одной или несколькими характеристиками. Может быть указан только один из блоков: `static_quota` или `dynamic_quota`.
          * `action` — действие при превышении лимита. Единственное возможное значение — `DENY`.
          * `limit` — максимальное количество разрешенных запросов за период.
          * `period` — период времени в секундах, в течение которого считается лимит.
          * `condition` — условие применения правила. Необязательный параметр. Описание условий см. в [документации провайдера]({{ tf-provider-resources-link }}/sws_advanced_rate_limiter_profile), в разделе описания структуры `advanced_rate_limiter_rule.dynamic_quota.condition`.
          * `characteristic` - описание характеристик для группировки запросов. Может быть указан один из блоков: `simple_characteristic` или `key_characteristic`.
            * `case_insensitive`: `true` — не учитывать регистр, `false` — учитывать регистр. 
            * `key_characteristic` — блок параметров, для которых надо указать ключ (строку) для группировки запросов.
              * `type` – тип группировки. Возможные значения: `COOKIE_KEY`, `HEADER_KEY`, `QUERY_KEY`.
              * `value` — значение ключа (строка), по которому будут группироваться запросы.
            *  `simple_characteristic` — блок параметров с автоматической группировкой. Т.е. запросы группируются автоматически по указанному параметру.
               *  `type` – тип группировки. Возможные значения: `REQUEST_PATH`, `HTTP_METHOD`, `IP`, `GEO`, `HOST`.

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
       
          В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
       1. Примените изменения конфигурации:
       
          ```bash
          terraform apply
          ```
       
       1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

       Проверить удаление ресурсов можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом REST API [update](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/update.md) для ресурса [AdvancedRateLimiterProfile](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/index.md) или вызовом gRPC API [AdvancedRateLimiterProfile/Update](../advanced_rate_limiter/api-ref/grpc/AdvancedRateLimiterProfile/update.md).

{% endlist %}