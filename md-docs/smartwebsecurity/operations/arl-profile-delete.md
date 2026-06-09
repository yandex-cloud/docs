# Удалить профиль ARL

Прежде чем удалить профиль ARL, необходимо удалить его из всех связанных [профилей безопасности](../concepts/profiles.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль ARL](../concepts/arl.md).
  1. Перейдите в сервис **Smart Web Security**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/arl.svg) **Профили ARL**.
  1. В строке с нужным профилем ARL в поле **Подключенные профили безопасности** выберите профиль безопасности, в котором используется данный профиль ARL.
  1. Справа сверху нажмите **Редактировать**. В открывшемся окне:

      1. В списке **Профиль ARL** выберите другой профиль ARL или нажмите **Очистить**.
      1. Нажмите кнопку **Сохранить**.
  1. Таким же способом удалите профиль ARL из всех других связанных профилей безопасности.
  1. Вернитесь на страницу профиля ARL, который вы хотите удалить.
  1. Справа сверху нажмите ![recycle-bin](../../_assets/console-icons/trash-bin.svg) **Удалить** и подтвердите удаление.

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы удалить [профиль ARL](../concepts/arl.md), созданный с помощью Terraform:

  1. Откройте файл конфигураций Terraform и удалите фрагмент с описанием ресурса `yandex_sws_advanced_rate_limiter_profile`:

      {% cut "Пример описания профиля ARL в конфигурации Terraform" %}
      
      ```hcl
      # Профиль ARL

      resource "yandex_sws_advanced_rate_limiter_profile" "arl-profile" {
        name        = "<имя_профиля>"
        description = "<описание_профиля>"

        # Правило 1

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
              request_uri {
                path {
                  exact_match = "/api"
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
          * `condition` — [условие](../concepts/conditions.md) применения правила. Необязательный параметр. Описание условий см. в [документации провайдера](../../terraform/resources/sws_advanced_rate_limiter_profile.md), в разделе описания структуры `advanced_rate_limiter_rule.static_quota.condition`.
        * `dynamic_quota` — способ подсчета запросов, при котором считаются группы запросов, объединенных одной или несколькими характеристиками. Может быть указан только один из блоков: `static_quota` или `dynamic_quota`.
          * `action` — действие при превышении лимита. Единственное возможное значение — `DENY`.
          * `limit` — максимальное количество разрешенных запросов за период.
          * `period` — период времени в секундах, в течение которого считается лимит.
          * `condition` — условие применения правила. Необязательный параметр. Описание условий см. в [документации провайдера](../../terraform/resources/sws_advanced_rate_limiter_profile.md), в разделе описания структуры `advanced_rate_limiter_rule.dynamic_quota.condition`.
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
       
          В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
       1. Примените изменения конфигурации:
       
          ```bash
          terraform apply
          ```
       
       1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

       Проверить удаление ресурсов можно в [консоли управления](https://console.yandex.cloud).

- API {#api}

  Воспользуйтесь методом REST API [delete](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/delete.md) для ресурса [AdvancedRateLimiterProfile](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/index.md) или вызовом gRPC API [AdvancedRateLimiterProfile/Delete](../advanced_rate_limiter/api-ref/grpc/AdvancedRateLimiterProfile/delete.md).

{% endlist %}