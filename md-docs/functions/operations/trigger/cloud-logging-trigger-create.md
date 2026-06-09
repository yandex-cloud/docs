# Создать триггер для {{ cloud-logging-name }}, который вызывает функцию {{ sf-name }}

Создайте [триггер для {{ cloud-logging-name }}](../../concepts/trigger/cloud-logging-trigger.md), который будет вызывать [функцию](../../concepts/function.md) {{ sf-name }} при добавлении записей в [лог-группу](../../../logging/concepts/log-group.md).

## Перед началом работы {#before-you-begin}

Для создания триггера вам понадобятся:

* Функция, которую триггер будет вызывать. Если у вас нет функции:

    * [Создайте функцию](../function/function-create.md).
    * [Создайте версию функции](../function/version-manage.md).

* (Опционально) Очередь [Dead Letter Queue](../../concepts/dlq.md), куда будут перенаправляться сообщения, которые не смогла обработать функция. Если у вас нет очереди, [создайте ее](../../../message-queue/operations/message-queue-new-queue.md).

* [Сервисные аккаунты](../../../iam/concepts/users/service-accounts.md) с правами на вызов функции и (опционально) запись в очередь Dead Letter Queue. Вы можете использовать один и тот же сервисный аккаунт или разные. Если у вас нет сервисного аккаунта, [создайте его](../../../iam/operations/sa/create.md).

* Лог-группа, при добавлении записей в которую триггер будет запускаться. Если у вас нет лог-группы, [создайте ее](../../../logging/operations/create-group.md).

## Создать триггер {#trigger-create}

{% note info %}

Триггер начинает работать в течение 5 минут после создания.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

    1. На панели слева выберите ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Введите имя и описание триггера.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_logging }}`.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_logging }}** укажите:

        * Лог-группу.
        * (Опционально) Типы ресурсов, например функции {{ sf-name }} `serverless.function`.
        * (Опционально) Идентификаторы ваших ресурсов или ресурсов {{ yandex-cloud }}, например функций {{ sf-name }}.
        * (Опционально) Потоки логирования.
        * (Опционально) Уровни логирования.
        
        Триггер срабатывает, когда в указанную лог-группу добавляют записи, которые соответствуют всем опциональным настройкам. Если опциональная настройка не задана, триггер срабатывает при любом ее значении.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}** укажите:

        * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cutoff }}**. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда.
        * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_size }}**. Допустимые значения от 1 до 100, значение по умолчанию — 1.

        Триггер группирует сообщения не дольше указанного времени ожидания и отправляет их в функцию. Число сообщений при этом не превышает указанный размер группы.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}** выберите функцию и укажите:

        * [{{ ui-key.yacloud.serverless-functions.triggers.form.field_function-tag }}](../../concepts/function.md#tag).
        * [{{ ui-key.yacloud.serverless-functions.triggers.form.field_function_service-account }}](../../../iam/concepts/users/service-accounts.md), от имени которого будет вызываться функция.

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_retry-interval }}** укажите время, через которое будет сделан повторный вызов функции, если текущий завершился неуспешно. Допустимые значения — от 10 до 60 секунд, значение по умолчанию — 10 секунд.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_retry-attempts }}** укажите количество повторных вызовов функции, которые будут сделаны, прежде чем триггер отправит сообщение в Dead Letter Queue. Допустимые значения — от 1 до 5, значение по умолчанию — 1.

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** выберите очередь Dead Letter Queue и сервисный аккаунт с правами на запись в нее.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы создать триггер, который вызывает функцию, выполните команду:

    ```bash
    yc serverless trigger create logging \
      --name <имя_триггера> \
      --log-group-name <имя_лог-группы> \
      --batch-size <размер_группы_сообщений> \
      --batch-cutoff <максимальное_время_ожидания> \
      --resource-ids <идентификатор_ресурса> \
      --resource-types <тип_ресурса> \
      --stream-names <поток_логирования> \
      --log-levels <уровень_логирования> \
      --invoke-function-id <идентификатор_функции> \
      --invoke-function-service-account-id <идентификатор_сервисного_аккаунта> \
      --retry-attempts <количество_повторных_вызовов> \
      --retry-interval <интервал_между_повторными_вызовами> \
      --dlq-queue-id <идентификатор_очереди_Dead_Letter_Queue> \
      --dlq-service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где:

    * `--name` — имя триггера.
    * `--log-group-name` — имя лог-группы, при добавлении записей в которую будет вызываться функция.

    * `--batch-size` — размер группы сообщений. Необязательный параметр. Допустимые значения от 1 до 10, значение по умолчанию — 1.
    * `--batch-cutoff` — максимальное время ожидания. Необязательный параметр. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда. Триггер группирует сообщения не дольше `batch-cutoff` и отправляет их в функцию. Число сообщений при этом не превышает `batch-size`.

    * `--resource-ids` — идентификаторы ваших ресурсов или ресурсов {{ yandex-cloud }}, например функций {{ sf-name }}. Необязательный параметр.
    * `--resource-types` — типы ресурсов, например функции {{ sf-name }} `serverless.function`. Необязательный параметр.
    * `--stream-names` — потоки логирования. Необязательный параметр.
    * `--log-levels` — уровни логирования. Необязательный параметр.
      Триггер срабатывает, когда в указанную лог-группу добавляют записи, которые соответствуют всем следующим параметрам: `resource-ids`, `resource-types`, `stream-names` и `log-levels`. Если параметр не задан, триггер срабатывает при любом его значении.

    * `--invoke-function-id` — идентификатор функции.
    * `--invoke-function-service-account-id` — идентификатор сервисного аккаунта с правами на вызов функции.
    * `--retry-attempts` — количество повторных вызовов, которые будут сделаны, прежде чем триггер отправит сообщение в Dead Letter Queue. Необязательный параметр. Допустимые значения — от 1 до 5, значение по умолчанию — 1.
    * `--retry-interval` — время, через которое будет сделан повторный вызов функции, если текущий завершился неуспешно. Необязательный параметр. Допустимые значения — от 10 до 60 секунд, значение по умолчанию — 10 секунд.
    * `--dlq-queue-id` — идентификатор очереди Dead Letter Queue. Необязательный параметр.
    * `--dlq-service-account-id` — идентификатор сервисного аккаунта с правами на запись в очередь Dead Letter Queue. Необязательный параметр.

    Результат:

    ```text
    id: a1sfe084v4**********
    folder_id: b1g88tflru**********
    created_at: "2019-12-04T08:45:31.131391Z"
    name: logging-trigger
    rule:
      logging:
        log-group-name: default
        resource_type:
          - serverless.functions
        resource_id:
          - d4e1gpsgam78********
        stream_name:
          - test
        levels:
          - INFO
        batch_settings:
          size: "1"
          cutoff: 1s
        invoke_function:
          function_id: d4eofc7n0m**********
          function_tag: $latest
          service_account_id: aje3932acd**********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
          dead_letter_queue:
            queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmk**********:dlq
            service-account-id: aje3932a**********
    status: ACTIVE
    ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы создать триггер для {{ cloud-logging-name }}:

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

     ```
     resource "yandex_function_trigger" "my_trigger" {
       name        = "<имя_триггера>"
       description = "<описание_триггера>"
       function {
          id                 = "<идентификатор_функции>"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
          retry_attempts     = "<количество_повторных_вызовов>"
          retry_interval     = "<интервал_между_повторными_вызовами>"
       }
       logging {
          group_id       = "<идентификатор_лог-группы>"
          resource_types = [ "<тип_ресурса>" ]
          resource_ids   = [ "<идентификатор_ресурса>" ]
          stream_names   = [ "<поток_логирования>" ]
          levels         = [ "<уровень_логирования>", "<уровень_логирования>" ]
          batch_cutoff   = "<максимальное_время_ожидания>"
          batch_size     = "<размер_группы_сообщений>"
       }
       dlq {
         queue_id           = "<идентификатор_очереди_Dead_Letter_Queue>"
         service_account_id = "<идентификатор_сервисного_аккаунта>"
       }
     }
     ```

     Где:

     * `name` — имя триггера. Формат имени:
     
         * длина — от 3 до 63 символов;
         * может содержать строчные буквы латинского алфавита, цифры и дефисы;
         * первый символ — буква, последний — не дефис.
     
     * `description` — описание триггера.
     
     * `function` — параметры функции:
     
         * `id` — идентификатор функции.
         * `service_account_id` — идентификатор сервисного аккаунта с правами на вызов функции.
         * `retry_attempts` — количество повторных вызовов, которые будут сделаны, прежде чем триггер отправит сообщение в Dead Letter Queue. Необязательный параметр. Допустимые значения — от 1 до 5, значение по умолчанию — 1.
         * `retry_interval` — время, через которое будет сделан повторный вызов функции, если текущий завершился неуспешно. Необязательный параметр. Допустимые значения — от 10 до 60 секунд, значение по умолчанию — 10 секунд.

     * `logging` — параметры триггера:

        * `group_id` — идентификатор лог-группы, при добавлении записей в которую будет вызываться функция.
        * `resource_types` — типы ресурсов, например функции {{ sf-name }} `resource_types = [ "serverless.function" ]`. Можно указать сразу несколько типов. 
        * `resource_ids` — идентификаторы ваших ресурсов или ресурсов {{ yandex-cloud }}, например функций `resource_ids = [ "<идентификатор_функции>" ]`. Вы можете указать несколько идентификаторов.
        * `stream_names` — потоки логирования. Необязательный параметр.
        * `levels` — уровни логирования. Например, `levels = [ "INFO", "ERROR"]`.

          Триггер срабатывает, когда в указанную лог-группу добавляют записи, которые соответствуют всем следующим параметрам: `resource-ids`, `resource-types`, `stream-names` и `levels`. Если параметр не задан, триггер срабатывает при любом его значении.

        * `batch_cutoff` — максимальное время ожидания. Допустимые значения от 0 до 60 секунд. Триггер группирует сообщения не дольше указанного времени ожидания и отправляет их в функцию. Число сообщений при этом не превышает указанный размер группы `batch-size`.
        * `batch_size` — размер группы сообщений. Допустимые значения от 1 до 10.

     * `dlq` — параметры очереди сообщений Dead Letter Queue:
         * `queue_id` — идентификатор очереди Dead Letter Queue.
         * `service_account_id` — идентификатор сервисного аккаунта с правами на запись в очередь Dead Letter Queue.

     Более подробную информацию о параметрах ресурса `yandex_function_trigger` см. в [документации провайдера]({{ tf-provider-resources-link }}/function_trigger).

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
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```bash
     yc serverless trigger list
     ```

- API {#api}

  Чтобы создать триггер для {{ cloud-logging-name }}, воспользуйтесь методом REST API [create](../../triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../../triggers/api-ref/grpc/Trigger/create.md).

{% endlist %}

## Проверить результат {#check-result}

Проверьте, что триггер работает корректно. Для этого посмотрите [логи функции](../function/function-logs.md), в них отображается информация о вызовах.

## См. также {#see-also}

* [{#T}](../../../serverless-containers/operations/cloud-logging-trigger-create.md)
* [{#T}](../../../api-gateway/operations/trigger/cloud-logging-trigger-create.md)