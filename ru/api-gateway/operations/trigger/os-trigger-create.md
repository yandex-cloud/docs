# Создать триггер для {{ objstorage-name }}, который отправляет сообщения в WebSocket-соединения

Создайте [триггер для {{ objstorage-name }}](../../concepts/trigger/os-trigger.md), который будет отправлять сообщения в [WebSocket-соединения](../../concepts/extensions/websocket.md) при создании, перемещении или удалении [объекта](../../../storage/concepts/object.md) в бакете.

## Перед началом работы {#before-begin}

{% include [trigger-before-you-begin](../../../_includes/api-gateway/trigger-before-you-begin.md) %}

* [Бакет](../../../storage/concepts/bucket.md), при событиях с объектами в котором триггер будет запускаться. Если у вас нет бакета, [создайте его](../../../storage/operations/buckets/create.md) с ограниченным доступом.

## Создать триггер {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. Откройте сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.

    1. На панели слева выберите ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Введите имя и описание триггера.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_storage }}`.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_gateway-broadcast }}`.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_storage }}**:

        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_bucket }}** выберите бакет, для событий с объектами которого хотите создать триггер.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_event-types }}** выберите события, после наступления которых триггер будет запускаться.
        * (Опционально) В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_prefix }}** введите префикс для фильтрации.
        * (Опционально) В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_suffix }}** введите суффикс для фильтрации.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}** укажите:

        * размер группы сообщений. Допустимые значения от 1 до 1000, значение по умолчанию — 1.
        * максимальное время ожидания. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда.

       Триггер группирует события не дольше указанного времени ожидания и отправляет их в WebSocket-соединения. Число событий при этом не превышает указанный размер группы.

    1. {% include [api-gateway-settings](../../../_includes/api-gateway/api-gateway-settings.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать триггер, который отправляет сообщения в WebSocket-соединения, выполните команду:
    
  ```bash
    yc serverless trigger create object-storage \
      --name <имя_триггера> \
      --bucket-id <идентификатор_бакета> \
      --prefix '<префикс_ключа_объекта>' \
      --suffix '<суффикс_ключа_объекта>' \
      --events 'create-object','delete-object','update-object' \
      --batch-size <размер_группы> \
      --batch-cutoff <максимальное_время_ожидания> \
      --gateway-id <идентификатор_API-шлюза> \
      --gateway-websocket-broadcast-path <путь> \
      --gateway-websocket-broadcast-service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где:

    * `--name` — имя триггера.
    * `--bucket-id` — идентификатор бакета.
    * `--prefix` — [префикс](../../concepts/trigger/os-trigger.md#filter) ключа объекта в бакете. Необязательный параметр. Используется для фильтрации.
    * `--suffix` — [суффикс](../../concepts/trigger/os-trigger.md#filter) ключа объекта в бакете. Необязательный параметр. Используется для фильтрации.
    * `--events` — [события](../../concepts/trigger/os-trigger.md#event), после наступления которых триггер запускается.

    {% include [batch-settings-events](../../../_includes/api-gateway/batch-settings-events.md) %}

    {% include [trigger-cli-param](../../../_includes/api-gateway/trigger-cli-param.md) %}

    Результат:

    ```text
    id: a1s5msktijh2********
    folder_id: b1gmit33hgh2********
    created_at: "2023-08-24T15:19:15.353909857Z"
    name: os-trigger
    rule:
      object_storage:
        event_type:
        - OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT
        - OBJECT_STORAGE_EVENT_TYPE_DELETE_OBJECT
        - OBJECT_STORAGE_EVENT_TYPE_UPDATE_OBJECT
        bucket_id: s3-for-trigger
        prefix: dev
        suffix: 12.jpg
        batch_settings:
          size: "3"
          cutoff: 20s
        gateway_websocket_broadcast:
          gateway_id: d4eofc7n0mh2********
          path: /
          service_account_id: aje3932acdh2********
    status: ACTIVE
    ```

- API {#api}

  Чтобы создать триггер для {{ objstorage-name }}, воспользуйтесь методом REST API [create](../../triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../../triggers/api-ref/grpc/Trigger/create.md).

{% endlist %}

## Проверить результат {#check-result}

{% include [check-result](../../../_includes/api-gateway/check-result.md) %}

## См. также {#see-also}

* [Триггер для {{ objstorage-name }}, который вызывает функцию {{ sf-name }}](../../../functions/operations/trigger/os-trigger-create.md)
* [Триггер для {{ objstorage-name }}, который вызывает контейнер {{ serverless-containers-name }}](../../../serverless-containers/operations/os-trigger-create.md)
