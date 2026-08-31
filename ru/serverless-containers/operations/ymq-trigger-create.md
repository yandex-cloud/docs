# Создать триггер для {{ message-queue-name }}, который передает сообщения в контейнер {{ serverless-containers-name }}

Создайте [триггер для очереди сообщений](../concepts/trigger/ymq-trigger.md) сервиса {{ message-queue-short-name }} и обрабатывайте их с помощью [контейнера](../concepts/container.md) {{ serverless-containers-name }}.

{% include [ymq-trigger-note.md](../../_includes/functions/ymq-trigger-note.md) %}

## Перед началом работы {#before-begin}

Для создания триггера вам понадобятся:

* Контейнер, который триггер будет вызывать. Если у вас нет контейнера:

    * [Создайте контейнер](create.md).
    * [Создайте ревизию контейнера](manage-revision.md#create).

* [Сервисные аккаунты](../../iam/concepts/users/service-accounts.md) с правами:

    * на вызов контейнера;
    * на чтение из очереди, из которой триггер будет принимать сообщения.

    Вы можете использовать один и тот же сервисный аккаунт или разные. Если у вас нет сервисного аккаунта, [создайте его](../../iam/operations/sa/create.md).

* Очередь сообщений, из которой триггер будет принимать сообщения. Если у вас нет очереди, [создайте ее](../../message-queue/operations/message-queue-new-queue.md).

## Создать триггер {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. [Перейдите]({{ link-console-main }}/link/serverless-containers) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.

    1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Введите имя и описание триггера.

        * {% include [triggers-labels-step](../../_includes/functions/triggers-labels-step.md) %}

        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_ymq }}`.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_ymq }}** выберите очередь сообщений и сервисный аккаунт с правами на чтение из нее.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}** укажите:

        * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_ymq-cutoff }}**. Допустимые значения от 0 до 20 секунд, значение по умолчанию — 10 секунд.
        * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_size }}**. Допустимые значения от 1 до 1000, значение по умолчанию — 1.

        {% include [batch-messages](../../_includes/serverless-containers/batch-messages.md) %}

    1. В блоке **Приёмники**:

        1. В поле **Тип приёмника** выберите `Контейнер`.

        1. {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

        1. {% include [trigger-console-filter](../../_includes/functions/trigger-console-filter.md) %}

        1. {% include [trigger-console-template](../../_includes/functions/trigger-console-template.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать триггер, который вызывает контейнер, выполните команду:

    ```bash
    yc serverless trigger create message-queue \
      --name <имя_триггера> \
      --queue <идентификатор_очереди> \
      --queue-service-account-id <идентификатор_сервисного_аккаунта> \
      --invoke-container-id <идентификатор_контейнера> \
      --invoke-container-service-account-id <идентификатор_сервисного_аккаунта> \
      --batch-size <размер_группы_сообщений> \
      --batch-cutoff <максимальное_время_ожидания>
    ```

    Где:

    * `--name` — имя триггера.
    * `--queue` — идентификатор очереди.

        {% include [ymq-id](../../_includes/serverless-containers/ymq-id.md) %}

    * `--invoke-container-id` — идентификатор контейнера.
    * `--queue-service-account-id` — идентификатор сервисного аккаунта с правами на чтение из очереди сообщений.
    * `--invoke-container-service-account-id` — идентификатор сервисного аккаунта с правами на вызов контейнера.
    * `--batch-size` — размер группы сообщений. Необязательный параметр. Допустимые значения от 1 до 1000, значение по умолчанию — 1.
    * `--batch-cutoff` — максимальное время ожидания. Необязательный параметр. Допустимые значения от 0 до 20 секунд, значение по умолчанию — 10 секунд. Триггер группирует сообщения не дольше `batch-cutoff` и отправляет их в контейнер. Число сообщений при этом не превышает `batch-size`.

    Результат:

    ```text
    id: a1s5msktijh2********
    folder_id: b1gmit33hgh2********
    created_at: "2022-10-24T15:19:15.353909857Z"
    name: ymq-trigger
    rule:
      message_queue:
        queue_id: yrn:yc:ymq:{{ region-id }}:b1gmit33ngh2********:my-mq
        service_account_id: bfbqqeo6jkh2********
        batch_settings:
          size: "1"
          cutoff: 10s
        invoke_container:
          container_id: bba5jb38o8h2********
          service_account_id: bfbqqeo6jkh2********
    status: ACTIVE
    ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы создать триггер для {{ message-queue-name }}:

  1. Опишите в конфигурационном файле параметры триггера:

     ```hcl
     resource "yandex_serverless_triggers" "my_trigger" {
       name = "<имя_триггера>"
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
         invoke_container {
           container_id       = "<идентификатор_контейнера>"
           path               = "<HTTP-путь>"
           service_account_id = "<идентификатор_сервисного_аккаунта>"
         }
       }
     }
     ```

     Где:

     {% include [tf-triggers-common-params](../../_includes/tf-triggers-common-params.md) %}

     * `source` — параметры источника событий:

       * `ymq` — параметры очереди сообщений:

         * `queue_arn` — ARN очереди.

             {% include [ymq-id](../../_includes/serverless-containers/ymq-id.md) %}

         * `service_account_id` — идентификатор сервисного аккаунта с правами на чтение из очереди сообщений.
         * `visibility_timeout` — [таймаут видимости](../../message-queue/concepts/visibility-timeout.md) сообщений, который переопределяет значение, заданное в очереди. Необязательный параметр.

         {% include [tf-triggers-batch-settings](../../_includes/tf-triggers-batch-settings.md) %}

     * `action` — параметры приемника. Блок можно указать несколько раз, чтобы триггер вызывал несколько ресурсов, в том числе разных типов. Максимальное количество ресурсов ограничено [лимитами](../concepts/limits.md#serverless-containers-limits).

         * `invoke_container` — параметры контейнера:

             * `container_id` — идентификатор контейнера.
             * `path` — HTTP-путь, по которому будет вызван контейнер. Необязательный параметр.
             * `service_account_id` — идентификатор сервисного аккаунта с правами на вызов контейнера.

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

     ```hcl
     resource "yandex_function_trigger" "my_trigger" {
       name = "<имя_триггера>"
       container {
         id                 = "<идентификатор_контейнера>"
         service_account_id = "<идентификатор_сервисного_аккаунта>"
       }
       message_queue {
         queue_id           = "<идентификатор_очереди>"
         service_account_id = "<идентификатор_сервисного_аккаунта>"
         batch_cutoff       = "<максимальное_время_ожидания>"
         batch_size         = "<размер_группы_сообщений>"
       }
     }
     ```

     Где:

     * `name` — имя триггера. Формат имени:

          {% include [name-format](../../_includes/name-format.md) %}

     * `container` — параметры контейнера:

         {% include [tf-container-params](../../_includes/serverless-containers/tf-container-params.md) %}

     * `message_queue` — параметры триггера:

         * `queue_id` — идентификатор очереди.

             {% include [ymq-id](../../_includes/serverless-containers/ymq-id.md) %}

         * `service_account_id` — идентификатор сервисного аккаунта с правами на чтение из очереди сообщений.

         * `batch_cutoff` — максимальное время ожидания. Необязательный параметр. Допустимые значения от 0 до 20 секунд, значение по умолчанию — 10 секунд. Триггер группирует сообщения не дольше `batch-cutoff` и отправляет их в контейнер. Число сообщений при этом не превышает `batch-size`.
         * `batch_size` — размер группы сообщений. Необязательный параметр. Допустимые значения от 1 до 1000, значение по умолчанию — 1.

     Подробнее о параметрах ресурса `yandex_function_trigger` в [документации провайдера]({{ tf-provider-resources-link }}/function_trigger).

     {% endcut %}

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {% include [terraform-check-result](../../_tutorials/_tutorials_includes/terraform-check-result.md) %}

     ```bash
     yc serverless trigger list
     ```

- API {#api}

  Чтобы создать триггер для {{ message-queue-name }}, воспользуйтесь методом REST API [create](../triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../triggers/api-ref/grpc/Trigger/create.md).

{% endlist %}

## Проверить результат {#check-result}

{% list tabs %}

- {{ serverless-containers-name }}

    {% include [check-result](../../_includes/serverless-containers/check-result.md) %}

- {{ message-queue-name }}

    Проверьте, что количество сообщений в очереди уменьшается. Для этого посмотрите статистику очереди:

   1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором создали триггер.
   1. [Перейдите]({{ link-console-main }}/link/message-queue) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_ymq }}**.
   1. Выберите очередь, для которой создали триггер.
   1. Перейдите в раздел **{{ ui-key.yacloud.common.monitoring }}**. Посмотрите график **{{ ui-key.yacloud.ymq.queue.overview.label_msg-count }}**.

{% endlist %}


#### Полезные ссылки {#see-also}

* [{#T}](../../functions/operations/trigger/ymq-trigger-create.md)
* [{#T}](../../api-gateway/operations/trigger/ymq-trigger-create.md)
