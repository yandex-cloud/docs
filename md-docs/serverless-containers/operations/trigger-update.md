# Изменить триггер в Serverless Containers

Вы можете изменить все параметры, кроме типа триггера и запускаемого ресурса.

{% note info %}

Изменения применятся в течение пяти минут.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится триггер.
  1. Перейдите в сервис **Serverless Containers**.
  1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **Триггеры**.
  1. Выберите триггер, параметры которого хотите изменить.
  1. В правом верхнем углу страницы нажмите **Редактировать**.
  1. Измените параметры триггера и нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы узнать имя или уникальный идентификатор триггера, [получите](trigger-list.md) список триггеров в каталоге.

  1. Посмотрите описание команды CLI для обновления параметров триггера:

      ```bash
      yc serverless trigger update <тип_триггера> --help
      ```

  1. Измените параметры триггера, например переименуйте его:

      ```bash
      yc serverless trigger update <тип_триггера> <имя_триггера> \
        --new-name <новое_имя_триггера> 
      ```

      Результат:

      ```text
      id: a1s5msktijh2********
      folder_id: b1gmit33hgh2********
      created_at: "2022-10-24T15:19:15.353909857Z"
      name: my-trigger
      rule:
        object_storage:
          event_type:
          - OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT
          - OBJECT_STORAGE_EVENT_TYPE_DELETE_OBJECT
          - OBJECT_STORAGE_EVENT_TYPE_UPDATE_OBJECT
          bucket_id: s3-for-trigger
          prefix: dev
          suffix: 12.jpg
          invoke_container:
            container_id: bba5jb38o8h2********
            service_account_id: aje3932acdh2********
            retry_settings:
              retry_attempts: "1"
              interval: 10s
            dead_letter_queue:
              queue-id: yrn:yc:ymq:ru-central1:aoek49ghmkh2********:dlq
              service-account-id: aje3932acdh2********
      status: ACTIVE
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Откройте файл конфигурации Terraform и измените параметры ресурса `function_trigger`:

      ```hcl
      resource "yandex_function_trigger" "my_trigger" {
        name        = "<имя_таймера>"
        timer {
          cron_expression = "<cron-выражение>"
          payload         = "<сообщение>"
        }
        container {
          id                 = "<идентификатор_контейнера>"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
          retry_attempts     = <количество_повторных_вызовов>
          retry_interval     = <интервал_между_повторными_вызовами>
        }
        dlq {
          queue_id           = "<идентификатор_очереди_DLQ>"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
        }
      }
      ```

      Где:

      * `name` — имя таймера. Формат имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      * `timer` — параметры триггера:
          * `cron_expression` — расписание вызова контейнера в формате [cron-выражения](../concepts/trigger/timer.md#cron-expression).
          * `payload` — сообщение, которое будет передаваться в функцию при срабатывании таймера. Длина строки должна быть не более 4096 символов.

      * `container` — параметры контейнера, который будет запускать триггер:

          * `id` — идентификатор контейнера.
          * `service_account_id` — идентификатор сервисного аккаунта с правами на вызов контейнера.

          * `retry_attempts` — количество повторных вызовов, которые будут сделаны, прежде чем триггер отправит сообщение в Dead Letter Queue. Необязательный параметр. Допустимые значения — от 1 до 5, значение по умолчанию — 1.
          * `retry_interval` — время, через которое будет сделан повторный вызов контейнера, если текущий завершился неуспешно. Необязательный параметр. Допустимые значения — от 10 до 60 секунд, значение по умолчанию — 10 секунд.

      * `dlq` — параметры очереди сообщений Dead Letter Queue:
          * `queue_id` — идентификатор очереди Dead Letter Queue.
          * `service_account_id` — идентификатор сервисного аккаунта с правами на запись в очередь Dead Letter Queue.

      Более подробную информацию о параметрах ресурса `function_trigger` см. в [документации провайдера](../../terraform/resources/function_trigger.md).

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

      Проверить изменения можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

      ```bash
      yc serverless trigger list
      ```

- API {#api}

  Чтобы изменить параметры триггера, воспользуйтесь методом REST API [update](../triggers/api-ref/Trigger/update.md) для ресурса [Trigger](../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Update](../triggers/api-ref/grpc/Trigger/update.md).

{% endlist %}