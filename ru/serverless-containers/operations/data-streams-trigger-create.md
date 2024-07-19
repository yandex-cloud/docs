# Создать триггер для {{ yds-name }}, который вызывает контейнер {{ serverless-containers-name }}

 Создайте [триггер для {{ yds-name }}](../concepts/trigger/data-streams-trigger.md), который будет вызывать [контейнер](../concepts/container.md) {{ serverless-containers-name }} при отправке данных в [поток](../../data-streams/concepts/glossary.md#stream-concepts). 

## Перед началом работы {#before-you-begin}

Для создания триггера вам понадобятся:

* Контейнер, который триггер будет вызывать. Если у вас нет контейнера:

    * [Создайте контейнер](create.md).
    * [Создайте ревизию контейнера](manage-revision.md#create).

* (Опционально) Очередь [Dead Letter Queue](../concepts/dlq.md), куда будут перенаправляться сообщения, которые не смог обработать контейнер. Если у вас нет очереди, [создайте ее](../../message-queue/operations/message-queue-new-queue.md).

* [Сервисные аккаунты](../../iam/concepts/users/service-accounts.md) с правами:

    * на вызов контейнера;
    * на чтение из потока, при отправке данных в который триггер будет запускаться;
    * (опционально) на запись в очередь Dead Letter Queue.

    Вы можете использовать один и тот же сервисный аккаунт или разные. Если у вас нет сервисного аккаунта, [создайте его](../../iam/operations/sa/create.md).

* Поток, при отправке данных в который триггер будет запускаться.  Если у вас нет потока, [создайте его](../../data-streams/quickstart/create-stream.md). 

## Создать триггер {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. Откройте сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.

    1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Введите имя и описание триггера.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_data-streams }}`.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_container }}`.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_data-streams }}** выберите поток данных и сервисный аккаунт с правами на чтение из потока данных и запись в него.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}** укажите:

        * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cutoff }}**. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда.
        * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_stream-size }}**. Допустимые значения от 1 Б до 64 КБ, значение по умолчанию — 1 Б.

        Триггер группирует сообщения не дольше указанного времени ожидания и отправляет их в контейнер. Суммарный объем данных, которые передаются в контейнер, может превышать указанный размер группы, если данные передаются в одном сообщении. Во всех остальных случаях объем данных не превышает размер группы.

    1. {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

        {% include [repeat-request](../../_includes/serverless-containers/repeat-request.md) %}

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** выберите очередь Dead Letter Queue и сервисный аккаунт с правами на запись в нее.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать триггер, который вызывает контейнер, выполните команду:

    ```bash
    yc serverless trigger create yds \
      --name <имя_триггера> \
      --database <размещение_базы_данных> \
      --stream <имя_потока_данных> \
      --batch-size 1b \
      --batch-cutoff 1s \
      --stream-service-account-id <идентификатор_сервисного_аккаунта> \
      --invoke-container-id <идентификатор_контейнера> \
      --invoke-container-service-account-id <идентификатор_сервисного_аккаунта> \
      --retry-attempts 1 \
      --retry-interval 10s \
      --dlq-queue-id <идентификатор_очереди_Dead_Letter_Queue> \
      --dlq-service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где:

    * `--name` — имя триггера.
    * `--database` — размещение базы данных {{ ydb-short-name }}, к которой привязан поток {{ yds-name }}.

      Чтобы узнать, где размещена база данных, выполните команду `yc ydb database list`. Размещение базы данных указано в столбце `ENDPOINT`, в параметре `database`, например `/{{ region-id }}/b1gia87mbah2********/etn7hehf6gh3********`.

    * `--stream` — имя потока данных.
    * `--batch-size` — размер группы сообщений. Необязательный параметр. Допустимые значения от 1 Б до 64 КБ, значение по умолчанию — 1 Б.
    * `--batch-cutoff` — максимальное время ожидания. Необязательный параметр. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда. Триггер группирует сообщения не дольше `batch-cutoff` и отправляет их в контейнер. Суммарный объем данных, которые передаются в контейнер, может превышать `batch-size`, если данные передаются в одном сообщении. Во всех остальных случаях объем данных не превышает `batch-size`.
    * `--stream-service-account-id` — идентификатор сервисного аккаунта, у которого есть права на чтение из потока данных и запись в него.
    
    {% include [trigger-cli-param](../../_includes/serverless-containers/trigger-cli-param.md) %}

    Результат:

    ```text
    id: a1s5msktijh2********
    folder_id: b1gmit33hgh2********
    created_at: "2022-10-24T14:07:04.693126923Z"
    name: data-streams-trigger
    rule:
      data_stream:
        database: /{{ region-id }}/b1gia87mbah2********/etn7hehh2********
        stream: streams-name
        service_account_id: ajep8qm0kh2********
        batch_settings:
          size: "1"
          cutoff: 1s
        invoke_container:
          container_id: bba5jb38o8h2********
          service_account_id: aje03adgd2h2********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
          dead_letter_queue:
            queue-id: yrn:yc:ymq:{{ region-id }}:b1gmit33ngh2********:dlq
            service-account-id: aje3lebfemh2********
    status: ACTIVE
    ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы создать триггер для {{ yds-name }}:

  1. Опишите в конфигурационном файле параметры триггера:

     ```
     resource "yandex_function_trigger" "my_trigger" {
       name = "<имя_триггера>"
       container {
         id                 = "<идентификатор_контейнера>"
         service_account_id = "<идентификатор_сервисного_аккаунта>"
         retry_attempts     = "<количество_повторных_вызовов>"
         retry_interval     = "<интервал_между_повторными_вызовами>"
       }
       data_streams {
         stream_name        = "<имя_потока_данных>"
         database           = "<размещение_базы_данных>"
         service_account_id = "<идентификатор_сервисного_аккаунта>"
         batch_cutoff       = "<время_ожидания>"
         batch_size         = "<размер_группы_событий>"
       }
       dlq {
         queue_id           = "<идентификатор_очереди>"
         service_account_id = "<идентификатор_сервисного_аккаунта>"
       }
     }
     ```

     Где:

     * `name` — имя триггера. Формат имени:

          {% include [name-format](../../_includes/name-format.md) %}

     * `container` — параметры контейнера:

         {% include [tf-container-params](../../_includes/serverless-containers/tf-container-params.md) %}

         {% include [tf-retry-params](../../_includes/serverless-containers/tf-retry-params.md) %}
     
     * `data_streams` — параметры триггера:

         * `stream_name` — имя потока данных.
         * `database` — размещение базы данных {{ ydb-short-name }}, к которой привязан поток {{ yds-name }}.

             Чтобы узнать, где размещена база данных, выполните команду `yc ydb database list`. Размещение базы данных указано в столбце `ENDPOINT`, в параметре `database`, например `/ru-central1/b1gia87mba**********/etn7hehf6g*******`.

         * `service_account_id` — сервисный аккаунт с правами на чтение из потока {{ yds-name }}  и запись в него.

         {% include [tf-batch-msg-params](../../_includes/serverless-containers/tf-batch-msg-params.md) %}

     {% include [tf-dlq-params](../../_includes/serverless-containers/tf-dlq-params.md) %}

     Более подробную информацию о параметрах ресурса `yandex_function_trigger` см. в [документации провайдера]({{ tf-provider-resources-link }}/function_trigger).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

        ```bash
        yc serverless trigger list
        ```

- API {#api}

  Чтобы создать триггер для {{ yds-name }}, воспользуйтесь методом REST API [create](../triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../triggers/api-ref/grpc/trigger_service.md#Create).

{% endlist %}

## Проверить результат {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## См. также {#see-also}

* [Триггер для {{ yds-name }}, который вызывает функцию {{ sf-name }}](../../functions/operations/trigger/data-streams-trigger-create.md).
