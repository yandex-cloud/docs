# Создать триггер для {{ message-queue-name }}, который передает сообщения в функцию {{ sf-name }}

Создайте [триггер](../../concepts/trigger/ymq-trigger.md) для [очереди сообщений](../../../message-queue/concepts/queue.md) сервиса {{ message-queue-short-name }} и обрабатывайте их с помощью [функции](../../concepts/function.md) {{ sf-name }}.

{% include [ymq-trigger-note.md](../../../_includes/functions/ymq-trigger-note.md) %}

## Перед началом работы {#before-begin}

Для создания триггера вам понадобятся: 

* Функция, которую триггер будет вызывать. Если у вас нет функции:

    * [Создайте функцию](../function/function-create.md).
    * [Создайте версию функции](../function/version-manage.md).

* [Сервисные аккаунты](../../../iam/concepts/users/service-accounts.md) с правами:

    * на вызов функции;
    * на чтение из очереди, из которой триггер будет принимать сообщения.

    Вы можете использовать один и тот же сервисный аккаунт или разные. Если у вас нет сервисного аккаунта, [создайте его](../../../iam/operations/sa/create.md).

* Очередь сообщений, из которой триггер будет принимать сообщения. Если у вас нет очереди, [создайте ее](../../../message-queue/operations/message-queue-new-queue.md).

## Создать триггер {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

    1. На панели слева выберите ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Введите имя и описание триггера.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите **{{ ui-key.yacloud.serverless-functions.triggers.form.label_ymq }}**.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите **{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}**.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_ymq }}** выберите очередь сообщений и сервисный аккаунт с правами на чтение из нее.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}** укажите:

        * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_ymq-cutoff }}**. Допустимые значения от 0 до 20 секунд, значение по умолчанию — 10 секунд.
        * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_size }}**. Допустимые значения от 1 до 1000, значение по умолчанию — 1.

        {% include [batch-messages](../../../_includes/functions/batch-messages.md) %}

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}** выберите функцию и укажите:

        {% include [function-settings](../../../_includes/functions/function-settings.md) %}

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
      --batch-size 1 \
      --batch-cutoff 10s
    ```

    Где:

    * `--name` — имя триггера.
    * `--queue` — идентификатор очереди.

        Чтобы узнать идентификатор очереди:

        1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится очередь.
        1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
        1. Выберите очередь.
        1. Идентификатор очереди будет в блоке **{{ ui-key.yacloud.ymq.queue.overview.section_base }}**, в поле **{{ ui-key.yacloud.ymq.queue.overview.label_queue-arn }}**.

    * `--invoke-function-id` — идентификатор функции.
    * `--queue-service-account-name` — сервисный аккаунт с правами на чтение из очереди сообщений.
    * `--invoke-function-service-account-id` — сервисный аккаунт с правами на вызов функции.
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
         batch_size         = "<время_ожидания>"
         batch_cutoff       = "<размер_группы_событий>"
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
           1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
           1. Выберите очередь.
           1. Идентификатор очереди будет в блоке **{{ ui-key.yacloud.ymq.queue.overview.section_base }}**, в поле **{{ ui-key.yacloud.ymq.queue.overview.label_queue-arn }}**.

       * `service_account_id` — идентификатор сервисного аккаунта с правами на чтение из очереди сообщений.
       * `batch_size` — размер группы сообщений. Необязательный параметр. Допустимые значения от 1 до 10, значение по умолчанию — 1.
       * `batch_cutoff` — максимальное время ожидания. Необязательный параметр. Допустимые значения от 0 до 20 секунд, значение по умолчанию — 10 секунд. Триггер группирует сообщения не дольше `batch-cutoff` и отправляет их в функцию. Число сообщений при этом не превышает `batch-size`.

     Более подробную информацию о параметрах ресурса `yandex_function_trigger` см. в [документации провайдера]({{ tf-provider-resources-link }}/function_trigger).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```bash
     yc serverless trigger get <идентификатор_триггера>
     ```

- API {#api}

  Чтобы создать триггер для {{ message-queue-full-name }}, воспользуйтесь методом REST API [create](../../triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../../triggers/api-ref/grpc/trigger_service.md#Create).

{% endlist %}

## Проверить результат {#check-result}

{% list tabs %}

- {{ sf-name }}

    {% include [check-result](../../../_includes/functions/check-result.md) %}

- {{ message-queue-name }}

    Проверьте, что количество сообщений в очереди уменьшается. Для этого посмотрите статистику очереди:

    1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
    1. Выберите очередь, для которой создали триггер.
    1. Перейдите в раздел **{{ ui-key.yacloud.common.monitoring }}**. Посмотрите график **{{ ui-key.yacloud.ymq.queue.overview.label_msg-count }}**.

{% endlist %}

## См. также {#see-also}

* [{#T}](../../../serverless-containers/operations/ymq-trigger-create.md)
* [{#T}](../../../api-gateway/operations/trigger/ymq-trigger-create.md)
