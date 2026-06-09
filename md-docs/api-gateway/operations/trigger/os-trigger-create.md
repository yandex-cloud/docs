# Создать триггер для {{ objstorage-name }}, который отправляет сообщения в WebSocket-соединения

Создайте [триггер для {{ objstorage-name }}](../../concepts/trigger/os-trigger.md), который будет отправлять сообщения в [WebSocket-соединения](../../concepts/extensions/websocket.md) при создании, перемещении или удалении [объекта](../../../storage/concepts/object.md) в бакете.

## Перед началом работы {#before-begin}

Для создания триггера вам понадобятся:

* API-шлюз. Сообщения будут отправляться в WebSocket-соединения, подключенные к API-шлюзу по пути, указанному в настройках триггера. Если у вас нет API-шлюза, [создайте его](../api-gw-create.md).

    {% note info %}

    Триггер не вызывает API-шлюз при отправке сообщений в WebSocket-соединения.

    {% endnote %}

* [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) с ролью `api-gateway.websocketBroadcaster`. Если у вас нет сервисного аккаунта, [создайте его](../../../iam/operations/sa/create.md).

* [Бакет](../../../storage/concepts/bucket.md), при событиях с объектами в котором триггер будет запускаться. Если у вас нет бакета, [создайте его](../../../storage/operations/buckets/create.md) с ограниченным доступом.

## Создать триггер {#trigger-create}

{% note info %}

Триггер начинает работать в течение 5 минут после создания.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.

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

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_gateway-broadcast }}**:
       * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_api-gateway }}** выберите API-шлюз.
       * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_gateway-path }}** укажите путь в OpenAPI-спецификации. Через WebSocket-соединения, которые установлены по этому пути, будут отправляться сообщения.
       * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function_service-account }}** выберите [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), от имени которого в WebSocket-соединения будут отправляться сообщения.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

    * `--batch-size` — размер группы событий. Необязательный параметр. Допустимые значения от 1 до 1000, значение по умолчанию — 1.
    * `--batch-cutoff` — максимальное время ожидания. Необязательный параметр. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда. Триггер группирует события не дольше `batch-cutoff` и отправляет их в WebSocket-соединения. Число событий при этом не превышает `batch-size`.

    * `--gateway-id` — идентификатор API-шлюза.
    * `--gateway-websocket-broadcast-path` — путь в OpenAPI-спецификации. Через WebSocket-соединения, которые установлены по этому пути, будут отправляться сообщения.
    * `--gateway-websocket-broadcast-account-id` — идентификатор сервисного аккаунта с правами на отправку сообщений в WebSocket-соединения.

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

Проверьте, что триггер работает корректно. Для этого посмотрите [логи API-шлюза](../api-gw-logs.md), в них отображается информация об обращениях к нему.

## См. также {#see-also}

* [Триггер для {{ objstorage-name }}, который вызывает функцию {{ sf-name }}](../../../functions/operations/trigger/os-trigger-create.md)
* [Триггер для {{ objstorage-name }}, который вызывает контейнер {{ serverless-containers-name }}](../../../serverless-containers/operations/os-trigger-create.md)