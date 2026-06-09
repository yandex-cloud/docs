# Создать триггер для почты, который отправляет сообщения в WebSocket-соединения

Создайте [триггер для почты](../../concepts/trigger/mail-trigger.md), который будет отправлять сообщения в [WebSocket-соединения](../../concepts/extensions/websocket.md) {{ api-gw-full-name }}, когда на электронную почту приходит письмо. Адрес электронной почты генерируется сервисом автоматически во время создания триггера.

## Перед началом работы {#before-you-begin}

Для создания триггера вам понадобятся:

* API-шлюз. Сообщения будут отправляться в WebSocket-соединения, подключенные к API-шлюзу по пути, указанному в настройках триггера. Если у вас нет API-шлюза, [создайте его](../api-gw-create.md).

    {% note info %}

    Триггер не вызывает API-шлюз при отправке сообщений в WebSocket-соединения.

    {% endnote %}

* [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) с ролью `api-gateway.websocketBroadcaster`. Если у вас нет сервисного аккаунта, [создайте его](../../../iam/operations/sa/create.md).

* (Опционально) [Бакет](../../../storage/concepts/bucket.md), в который будут сохраняться вложения из писем. Если у вас нет бакета, [создайте его](../../../storage/operations/buckets/create.md) с ограниченным доступом.

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

        * (Опционально) Введите имя и описание триггера.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_mail }}`.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_gateway-broadcast }}`.
    
    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_mail-attachments }}**:
      
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_bucket }}** выберите бакет, в который будут сохраняться вложения из писем.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_service-account }}** укажите сервисный аккаунт, у которого есть права на загрузку объектов в бакет {{ objstorage-name }}.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}** укажите:

        * размер группы сообщений. Допустимые значения от 1 до 1000, значение по умолчанию — 1.
        * максимальное время ожидания. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда.

       Триггер группирует сообщения не дольше указанного времени ожидания и отправляет их в WebSocket-соединения. Число сообщений при этом не превышает указанный размер группы.

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
    yc serverless trigger create mail \
      --name <имя_триггера> \
      --batch-size <размер_группы> \
      --batch-cutoff <максимальное_время_ожидания> \
      --attachements-bucket <имя_бакета> \
      --attachements-service-account-id <идентификатор_сервисного_аккаунта> \
      --gateway-id <идентификатор_API-шлюза> \
      --gateway-websocket-broadcast-path <путь> \
      --gateway-websocket-broadcast-service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где:

    * `--name` — имя триггера.

    * `--batch-size` — размер группы сообщений. Необязательный параметр. Допустимые значения от 1 до 10, значение по умолчанию — 1.
    * `--batch-cutoff` — максимальное время ожидания. Необязательный параметр. Допустимые значения от 0 до 20 секунд, значение по умолчанию — 10 секунд. Триггер группирует сообщения не дольше `batch-cutoff` и отправляет их в WebSocket-соединения. Число сообщений при этом не превышает `batch-size`.

    * `--attachements-bucket` — имя бакета, в который будут сохраняться вложения из писем. Необязательный параметр.
    
    * `--attachements-service-account-id` — идентификатор сервисного аккаунта, у которого есть права на загрузку объектов в бакет Object Storage. Необязательный параметр.

    * `--gateway-id` — идентификатор API-шлюза.
    * `--gateway-websocket-broadcast-path` — путь в OpenAPI-спецификации. Через WebSocket-соединения, которые установлены по этому пути, будут отправляться сообщения.
    * `--gateway-websocket-broadcast-account-id` — идентификатор сервисного аккаунта с правами на отправку сообщений в WebSocket-соединения.

    Результат:

    ```text
    id: a1sfe084v4h2********
    folder_id: b1g88tflruh2********
    created_at: "2023-08-04T08:45:31.131391Z"
    name: mail-trigger
    rule:
      mail:
        email: a1s8h8avglh2********-cho1****@serverless.yandexcloud.net
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

  Чтобы создать триггер для почты, воспользуйтесь методом REST API [create](../../triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../../triggers/api-ref/grpc/Trigger/create.md).

{% endlist %}

{{ api-gw-full-name }} автоматически сгенерирует адрес электронной почты, при отправке писем на который будет запускаться триггер. Чтобы посмотреть его, [получите подробную информацию о триггере](trigger-list.md#trigger-get).

## Проверить результат {#check-result}

Проверьте, что триггер работает корректно. Для этого посмотрите [логи API-шлюза](../api-gw-logs.md), в них отображается информация об обращениях к нему.

## См. также {#see-also}

* [Триггер для почты, который вызывает функцию {{ sf-name }}](../../../functions/operations/trigger/mail-trigger-create.md)
* [Триггер для почты, который вызывает контейнер {{ serverless-containers-name }}](../../../serverless-containers/operations/mail-trigger-create.md)