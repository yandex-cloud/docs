---
title: Создать триггер для {{ yds-full-name }}, который вызывает функцию {{ sf-full-name }}
description: Следуя данной инструкции, вы сможете создать триггер для {{ yds-name }}, который вызывает функцию {{ sf-name }}.
---

# Создать триггер для {{ yds-name }}, который вызывает функцию {{ sf-name }}

Создайте [триггер для {{ yds-name }}](../../concepts/trigger/data-streams-trigger.md), который будет вызывать [функцию](../../concepts/function.md) {{ sf-name }} при отправке данных в [поток](../../../data-streams/concepts/glossary.md#stream-concepts).

## Перед началом работы {#before-you-begin}

Для создания триггера вам понадобятся:

* Функция, которую триггер будет вызывать. Если у вас нет функции:

    * [Создайте функцию](../function/function-create.md).
    * [Создайте версию функции](../function/version-manage.md).

* (Опционально) Очередь [Dead Letter Queue](../../concepts/dlq.md), куда будут перенаправляться сообщения, которые не смогла обработать функция. Если у вас нет очереди, [создайте ее](../../../message-queue/operations/message-queue-new-queue.md).

* [Сервисные аккаунты](../../../iam/concepts/users/service-accounts.md) с правами:

    * на вызов функции;
    * на чтение из потока, при отправке данных в который триггер будет запускаться;
    * (опционально) на запись в очередь Dead Letter Queue.

    Вы можете использовать один и тот же сервисный аккаунт или разные. Если у вас нет сервисного аккаунта, [создайте его](../../../iam/operations/sa/create.md).

* Поток, при отправке данных в который триггер будет запускаться.  Если у вас нет потока, [создайте его](../../../data-streams/quickstart/create-stream.md). 

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
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите **{{ ui-key.yacloud.serverless-functions.triggers.form.label_data-streams }}**.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите **{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}**.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_data-streams }}** выберите поток данных и сервисный аккаунт с правами на чтение из потока данных и запись в него.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}** укажите:

        * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cutoff }}**. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда.
        * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_stream-size }}**. Допустимые значения от 1 Б до 64 КБ, значение по умолчанию — 1 Б.

        Триггер группирует сообщения не дольше указанного времени ожидания и отправляет их в функцию. Суммарный объем данных, которые передаются в функцию, может превышать указанный размер группы, если данные передаются в одном сообщении. Во всех остальных случаях объем данных не превышает размер группы.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}** выберите функцию и укажите:

        {% include [function-settings](../../../_includes/functions/function-settings.md) %}

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

        {% include [repeat-request.md](../../../_includes/functions/repeat-request.md) %}

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** выберите очередь Dead Letter Queue и сервисный аккаунт с правами на запись в нее.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать триггер, который вызывает функцию, выполните команду:

    ```bash
    yc serverless trigger create yds \
      --name <имя_триггера> \
      --database <размещение_базы_данных> \
      --stream <имя_потока_данных> \
      --batch-size <размер_группы_сообщений> \
      --batch-cutoff <максимальное_время_ожидания> \
      --stream-service-account-id <идентификатор_сервисного_аккаунта> \
      --invoke-function-id <идентификатор_функции> \
      --invoke-function-service-account-id <идентификатор_сервисного_аккаунта> \
      --retry-attempts <количество_повторных_вызовов> \
      --retry-interval <интервал_между_повторными_вызовами> \
      --dlq-queue-id <идентификатор_очереди_Dead_Letter_Queue> \
      --dlq-service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где:

    * `--name` — имя триггера.
    * `--database` — размещение базы данных {{ ydb-short-name }}, к которой привязан поток {{ yds-name }}.

      Чтобы узнать, где размещена база данных, выполните команду `yc ydb database list`. Размещение базы данных указано в столбце `ENDPOINT`, в параметре `database`, например `/{{ region-id }}/b1gia87mba**********/etn7hehf6g*******`.

    * `--stream` — имя потока данных {{ yds-name }}.
    * `--batch-size` — размер группы сообщений. Необязательный параметр. Допустимые значения от 1 Б до 64 КБ, значение по умолчанию — 1 Б.
    * `--batch-cutoff` — максимальное время ожидания. Необязательный параметр. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда. Триггер группирует сообщения не дольше `batch-cutoff` и отправляет их в функцию. Суммарный объем данных, которые передаются в функцию, может превышать `batch-size`, если данные передаются в одном сообщении. Во всех остальных случаях объем данных не превышает `batch-size`.
    * `--stream-service-account-id` — идентификатор сервисного аккаунта, у которого есть права на чтение из потока данных и запись в него.
    
    {% include [trigger-cli-param](../../../_includes/functions/trigger-cli-param.md) %}

    Результат:

    ```text
    id: a1smnfisr5**********
    folder_id: b1gc1t4cb6**********
    created_at: "2022-10-31T10:57:08.234586266Z"
    name: data-streams-trigger
    rule:
      data_stream:
        database: /{{ region-id }}/b1gvlrnlei**********/etn3ege6nj**********
        stream: yds-stream
        service_account_id: aje07l4q4v**********
        batch_settings:
          size: "1"
          cutoff: 1s
        invoke_function:
          function_id: d4e155orh3**********
          function_tag: $latest
          service_account_id: aje07l4q4v**********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
          dead_letter_queue:
            queue_id: yrn:yc:ymq:{{ region-id }}:b1gc1t4cb6**********:queue_dead
            service_account_id: aje07l4q4v**********
    status: ACTIVE
    ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы создать триггер для {{ yds-name }}:

  1. Опишите в конфигурационном файле параметры триггера:

     ```hcl
     resource "yandex_function_trigger" "my_trigger" {
       name = "<имя_триггера>"
       function {
         id                 = "<идентификатор_функции>"
         service_account_id = "<идентификатор_сервисного_аккаунта>"
         retry_attempts     = "<количество_повторных_вызовов>"
         retry_interval     = "<интервал_между_повторными_вызовами>"
       }
       data_streams {
         stream_name        = "<имя_потока_данных>"
         database           = "<размещение_базы_данных>"
         service_account_id = "<идентификатор_сервисного_аккаунта>"
         batch_cutoff       = "<максимальное_время_ожидания>"
         batch_size         = "<размер_группы_сообщений>"
       }
       dlq {
         queue_id           = "<идентификатор_очереди_Dead_Letter_Queue>"
         service_account_id = "<идентификатор_сервисного_аккаунта>"
       }
     }
     ```

     Где:

     {% include [tf-function-params](../../../_includes/functions/tf-function-params.md) %}
     
     * `data_streams` — параметры триггера:

         * `stream_name` — имя потока данных {{ yds-name }}.
         * `database` — размещение базы данных {{ ydb-short-name }}, к которой привязан поток {{ yds-name }}.

             Чтобы узнать, где размещена база данных, выполните команду `yc ydb database list`. Размещение базы данных указано в столбце `ENDPOINT`, в параметре `database`, например `/ru-central1/b1gia87mba**********/etn7hehf6g*******`.

         * `service_account_id` — сервисный аккаунт с правами на чтение из потока {{ yds-name }} и запись в него.

         * `batch_cutoff` — максимальное время ожидания. Необязательный параметр. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда. Триггер группирует сообщения не дольше `batch-cutoff` и отправляет их в функцию. Суммарный объем данных, которые передаются в функцию, может превышать `batch-size`, если данные передаются в одном сообщении. Во всех остальных случаях объем данных не превышает `batch-size`.
         * `batch_size` — размер группы сообщений. Необязательный параметр. Допустимые значения от 1 Б до 64 КБ, значение по умолчанию — 1 Б.

     {% include [tf-dlq-params](../../../_includes/serverless-containers/tf-dlq-params.md) %}

     Более подробную информацию о параметрах ресурса `yandex_function_trigger` см. в [документации провайдера]({{ tf-provider-resources-link }}/function_trigger).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {% include [terraform-check-result](../../../_tutorials/_tutorials_includes/terraform-check-result.md) %}

     ```bash
     yc serverless trigger list
     ```

- API {#api}

  Чтобы создать триггер для {{ yds-name }}, воспользуйтесь методом REST API [create](../../triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../../triggers/api-ref/grpc/Trigger/create.md).

{% endlist %}

## Проверить результат {#check-result}

{% include [check-result](../../../_includes/functions/check-result.md) %}

## См. также {#see-also}

* [{#T}](../../../serverless-containers/operations/data-streams-trigger-create.md)
* [{#T}](../../../api-gateway/operations/trigger/data-streams-trigger-create.md)
