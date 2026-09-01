# Создать триггер для {{ message-queue-name }}, который передает сообщения в функцию {{ sf-name }}

Создайте [триггер](../../concepts/trigger/ymq-trigger.md) для [очереди сообщений](../../../message-queue/concepts/queue.md) сервиса {{ message-queue-short-name }} и обрабатывайте их с помощью [функции](../../concepts/function.md) {{ sf-name }}.

{% include [ymq-trigger-note.md](../../../_includes/functions/ymq-trigger-note.md) %}

## Перед началом работы {#before-begin}

Для создания триггера вам понадобятся: 

* Функция, которую триггер будет вызывать. Если у вас нет функции:

    * [Создайте функцию](../function/function-create.md).
    * [Создайте версию функции](../function/version-manage.md).

* [Сервисные аккаунты](../../../iam/concepts/users/service-accounts.md) с правами:

    * на вызов функции, например [{{ roles-functions-invoker }}](../../security/index.md#functions-functionInvoker);
    * на чтение из очереди, из которой триггер будет принимать сообщения, например [ymq.reader](../../../message-queue/security/index.md#ymq-reader).

    Вы можете использовать один и тот же сервисный аккаунт или разные. Если у вас нет сервисного аккаунта, [создайте его](../../../iam/operations/sa/create.md).

* Очередь сообщений, из которой триггер будет принимать сообщения. Если у вас нет очереди, [создайте ее](../../../message-queue/operations/message-queue-new-queue.md).

## Создать триггер {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. [Перейдите]({{ link-console-main }}/link/functions) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

    1. На панели слева выберите ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Введите имя и описание триггера.

        * {% include [triggers-labels-step](../../../_includes/functions/triggers-labels-step.md) %}

        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_ymq }}`.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_ymq }}** выберите очередь сообщений и сервисный аккаунт с правами на чтение из нее.

    1. {% include [batch-settings-ymq](../../../_includes/functions/batch-settings-ymq.md) %}

    1. В блоке **Приёмники**:

        1. В поле **Тип приёмника** выберите `Функция`.

        1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}** выберите функцию и укажите:

            {% include [function-settings](../../../_includes/functions/function-settings.md) %}

        1. {% include [trigger-console-filter](../../../_includes/functions/trigger-console-filter.md) %}

        1. {% include [trigger-console-template](../../../_includes/functions/trigger-console-template.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать триггер, который вызывает функцию, выполните команду:

    ```bash
    yc serverless trigger create message-queue \
      --name <имя_триггера> \
      --queue <идентификатор_очереди> \
      --queue-service-account-id <идентификатор_сервисного_аккаунта> \
      --invoke-function-id <идентификатор_функции> \
      --invoke-function-service-account-id <идентификатор_сервисного_аккаунта> \
      --batch-size <размер_группы_сообщений> \
      --batch-cutoff <максимальное_время_ожидания>
    ```

    Где:

    * `--name` — имя триггера.
    * `--queue` — идентификатор очереди.

        Чтобы узнать идентификатор очереди:

        1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится очередь.
        1. [Перейдите]({{ link-console-main }}/link/message-queue) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
        1. Выберите очередь.
        1. Идентификатор очереди будет в блоке **{{ ui-key.yacloud.ymq.queue.overview.section_base }}**, в поле **{{ ui-key.yacloud.ymq.queue.overview.label_queue-arn }}**.

    * `--invoke-function-id` — идентификатор функции.
    * `--queue-service-account-name` — идентификатор сервисного аккаунта с правами на чтение из очереди сообщений.
    * `--invoke-function-service-account-id` — идентификатор сервисного аккаунта с правами на вызов функции.
    * `--batch-size` — размер группы сообщений. Необязательный параметр. Допустимые значения от 1 до 1000, значение по умолчанию — 1.
    * `--batch-cutoff` — максимальное время ожидания. Необязательный параметр. Допустимые значения от 0 до 20 секунд, значение по умолчанию — 10 секунд. Триггер группирует сообщения не дольше `batch-cutoff` и отправляет их в функцию. Число сообщений при этом не превышает `batch-size`.

    Результат:

    ```text
    id: dd0cspdch6**********
    folder_id: aoek49ghmk**********
    created_at: "2019-08-28T12:14:45.762915Z"
    name: ymq-trigger
    rule:
      message_queue:
        queue_id: yrn:yc:ymq:{{ region-id }}:aoek49ghmk**********:my-mq
        service_account_id: bfbqqeo6jk**********
        batch_settings:
          size: "1"
          cutoff: 10s
        invoke_function:
          function_id: b09e5lu91t**********
          function_tag: $latest
          service_account_id: bfbqqeo6j**********
    status: ACTIVE
    ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы создать триггер для {{ message-queue-name }}:

  1. Опишите в конфигурационном файле параметры триггера:

     ```hcl
     resource "yandex_serverless_triggers" "my_trigger" {
       name        = "<имя_триггера>"
       description = "<описание_триггера>"
       source {
         ymq {
           queue_arn          = "<ARN_очереди>"
           service_account_id = "<идентификатор_сервисного_аккаунта>"
           visibility_timeout = "<таймаут_видимости_сообщений>"
           batch_settings {
             max_count = "<максимальное_число_сообщений>"
             max_bytes = "<максимальный_размер_группы_в_байтах>"
             cutoff    = "<максимальное_время_ожидания>"
           }
         }
       }
       action {
         invoke_function {
           function_id        = "<идентификатор_функции>"
           service_account_id = "<идентификатор_сервисного_аккаунта>"
         }
       }
     }
     ```

     Где:

     {% include [tf-triggers-common-params](../../../_includes/tf-triggers-common-params.md) %}

     * `source` — параметры источника событий:

       * `ymq` — параметры очереди сообщений:

         * `queue_arn` — ARN очереди сообщений.

             Чтобы узнать ARN очереди:

             1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится очередь.
             1. [Перейдите]({{ link-console-main }}/link/message-queue) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
             1. Выберите очередь.
             1. ARN очереди будет в блоке **{{ ui-key.yacloud.ymq.queue.overview.section_base }}**, в поле **{{ ui-key.yacloud.ymq.queue.overview.label_queue-arn }}**.

         * `service_account_id` — идентификатор сервисного аккаунта с правами на чтение из очереди сообщений.
         * `visibility_timeout` — [таймаут видимости](../../../message-queue/concepts/visibility-timeout.md) сообщений, который переопределяет значение, заданное в очереди. Необязательный параметр.

         {% include [tf-triggers-batch-settings](../../../_includes/tf-triggers-batch-settings.md) %}

     * `action` — параметры приемника. Блок можно указать несколько раз, чтобы триггер вызывал несколько ресурсов, в том числе разных типов. Максимальное количество ресурсов ограничено [лимитами](../../concepts/limits.md#functions-limits).

         * `invoke_function` — параметры функции:

             * `function_id` — идентификатор функции.
             * `function_tag` — тег версии функции. Необязательный параметр. Если параметр не указан, вызывается последняя версия функции.
             * `service_account_id` — идентификатор сервисного аккаунта с правами на вызов функции.

         * `filter` — фильтрация событий перед отправкой в приемник. Необязательный блок.

             * `jq` — [jq-шаблон](https://jqlang.github.io/jq/manual/) для фильтрации событий, передаваемых в приемник. Если не указан, в приемник передаются все события.

         * `transformer` — преобразование событий перед отправкой в приемник. Необязательный блок.

             * `jq` — jq-шаблон для преобразования событий перед отправкой в приемник. Если не указан, события не преобразуются.

         * `dead_letter` — параметры очереди сообщений Dead Letter Queue. Необязательный блок.

             * `dead_letter_queue` — параметры очереди:

                 * `queue_arn` — ARN очереди.
                 * `service_account_id` — идентификатор сервисного аккаунта с правами на запись в очередь.
                 * `message_attributes` — атрибуты, которые будут добавлены к каждому сообщению в очереди, в формате `ключ:значение`. Необязательный параметр.

     Подробнее о параметрах ресурса `yandex_serverless_triggers` в [документации провайдера]({{ tf-provider-resources-link }}/serverless_triggers).

     {% cut "Конфигурация для ресурса yandex_function_trigger" %}

     ```
     resource "yandex_function_trigger" "my_trigger" {
       name        = "<имя_триггера>"
       description = "<описание_триггера>"
       function {
         id                 = "<идентификатор_функции>"
         service_account_id = "<идентификатор_сервисного_аккаунта>"
       }
       message_queue {
         queue_id           = "<идентификатор_очереди>"
         service_account_id = "<идентификатор_сервисного_аккаунта>"
         batch_size         = "<размер_группы_сообщений>"
         batch_cutoff       = "<максимальное_время_ожидания>"
     }
     ```

     Где:

     * `name` — имя триггера. Формат имени:

        {% include [name-format](../../../_includes/name-format.md) %}

     * `description` — описание триггера.

     * `function` — параметры функции:

       * `id` — идентификатор функции.
       * `service_account_id` — идентификатор сервисного аккаунта с правами на вызов функции.

     * `message_queue` — параметры триггера:

       * `queue_id` — идентификатор очереди сообщений.

           Чтобы узнать идентификатор очереди:

           1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится очередь.
           1. [Перейдите]({{ link-console-main }}/link/message-queue) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
           1. Выберите очередь.
           1. Идентификатор очереди будет в блоке **{{ ui-key.yacloud.ymq.queue.overview.section_base }}**, в поле **{{ ui-key.yacloud.ymq.queue.overview.label_queue-arn }}**.

       * `service_account_id` — идентификатор сервисного аккаунта с правами на чтение из очереди сообщений.
       * `batch_size` — размер группы сообщений. Необязательный параметр. Допустимые значения от 1 до 1000, значение по умолчанию — 1.
       * `batch_cutoff` — максимальное время ожидания. Необязательный параметр. Допустимые значения от 0 до 20 секунд, значение по умолчанию — 10 секунд. Триггер группирует сообщения не дольше `batch-cutoff` и отправляет их в функцию. Число сообщений при этом не превышает `batch-size`.

     Подробнее о параметрах ресурса `yandex_function_trigger` в [документации провайдера]({{ tf-provider-resources-link }}/function_trigger).

     {% endcut %}

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {% include [terraform-check-result](../../../_tutorials/_tutorials_includes/terraform-check-result.md) %}

     ```bash
     yc serverless trigger list
     ```

- API {#api}

  Чтобы создать триггер для {{ message-queue-full-name }}, воспользуйтесь методом REST API [create](../../triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../../triggers/api-ref/grpc/Trigger/create.md).

{% endlist %}

## Проверить результат {#check-result}

{% list tabs %}

- {{ sf-name }}

    {% include [check-result](../../../_includes/functions/check-result.md) %}

- {{ message-queue-name }}

    Проверьте, что количество сообщений в очереди уменьшается. Для этого посмотрите статистику очереди:

    1. [Перейдите]({{ link-console-main }}/link/message-queue) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
    1. Выберите очередь, для которой создали триггер.
    1. Перейдите в раздел **{{ ui-key.yacloud.common.monitoring }}**. Посмотрите график **{{ ui-key.yacloud.ymq.queue.overview.label_msg-count }}**.

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](../../../serverless-containers/operations/ymq-trigger-create.md)
* [{#T}](../../../api-gateway/operations/trigger/ymq-trigger-create.md)
