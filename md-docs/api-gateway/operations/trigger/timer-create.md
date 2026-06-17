# Создать таймер, который отправляет сообщения в WebSocket-соединения

Создайте [таймер](../../concepts/trigger/timer.md) — триггер, который будет отправлять сообщения в [WebSocket-соединения](../../concepts/extensions/websocket.md) по расписанию.

## Перед началом работы {#before-you-begin}

Для создания триггера вам понадобятся:

* API-шлюз. Сообщения будут отправляться в WebSocket-соединения, подключенные к API-шлюзу по пути, указанному в настройках триггера. Если у вас нет API-шлюза, [создайте его](../api-gw-create.md).

    {% note info %}

    Триггер не вызывает API-шлюз при отправке сообщений в WebSocket-соединения.

    {% endnote %}

* [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) с ролью `api-gateway.websocketBroadcaster`. Если у вас нет сервисного аккаунта, [создайте его](../../../iam/operations/sa/create.md).

## Создать триггер {#trigger-create}

{% note info %}

Триггер начинает работать в течение 5 минут после создания.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите создать триггер.

    1. Перейдите в сервис **API Gateway**.

    1. На панели слева выберите ![image](../../../_assets/console-icons/gear-play.svg) **Триггеры**.

    1. Нажмите кнопку **Создать триггер**.

    1. В блоке **Базовые параметры**:

        * Введите имя и описание триггера.
        * В поле **Тип** выберите `Таймер`.
        * В поле **Запускаемый ресурс** выберите `API-шлюз`.

    1. В блоке **Настройки таймера**:

        * В поле **Cron-выражение** укажите расписание отправки сообщений в WebSocket-соединения в формате [cron-выражения](../../concepts/trigger/timer.md#cron-expression).
        * (Опционально) В поле **Данные** укажите сообщение, которое будет передаваться в WebSocket-соединения при срабатывании таймера в поле `payload`. Тип данных — строка, длина которой не более 4096 символов.

    1. В блоке **Настройки API-шлюза**:
       * В поле **API-шлюз** выберите API-шлюз.
       * В поле **Путь** укажите путь в OpenAPI-спецификации. Через WebSocket-соединения, которые установлены по этому пути, будут отправляться сообщения.
       * В поле **Сервисный аккаунт** выберите [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), от имени которого в WebSocket-соединения будут отправляться сообщения.

    1. Нажмите кнопку **Создать триггер**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы создать триггер, который отправляет сообщения в WebSocket-соединения, выполните команду:

    ```bash
    yc serverless trigger create timer \
      --name <имя_таймера> \
      --cron-expression '<cron_выражение>' \
      --payload <сообщение> \
      --gateway-id <идентификатор_API-шлюза> \
      --gateway-websocket-broadcast-path <путь> \
      --gateway-websocket-broadcast-service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где:

    * `--name` — имя таймера.
    * `--cron-expression` — расписание отправки сообщений в WebSocket-соединения в формате [cron-выражения](../../concepts/trigger/timer.md#cron-expression).
    * `--payload` — сообщение, которое будет передаваться в WebSocket-соединения при срабатывании таймера. Длина строки должна быть не более 4096 символов.

    * `--gateway-id` — идентификатор API-шлюза.
    * `--gateway-websocket-broadcast-path` — путь в OpenAPI-спецификации. Через WebSocket-соединения, которые установлены по этому пути, будут отправляться сообщения.
    * `--gateway-websocket-broadcast-account-id` — идентификатор сервисного аккаунта с правами на отправку сообщений в WebSocket-соединения.

    Результат:

    ```text
    id: a1s5msktijh2********
    folder_id: b1gmit33hgh2********
    created_at: "2023-08-04T15:19:15.353909857Z"
    name: timer
    rule:
      timer:
        cron_expression: 5 10 ? * * *
        payload: <сообщение>
        gateway_websocket_broadcast:
          gateway_id: d4eofc7n0mh2********
          path: /
          service_account_id: aje3932acdh2********
    status: ACTIVE
    ```

- API {#api}

  Чтобы создать таймер, воспользуйтесь методом REST API [create](../../triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../../triggers/api-ref/grpc/Trigger/create.md).

{% endlist %}

## Проверить результат {#check-result}

Проверьте, что триггер работает корректно. Для этого посмотрите [логи API-шлюза](../api-gw-logs.md), в них отображается информация об обращениях к нему.

## Полезные ссылки {#see-also}

* [Таймер, который вызывает функцию Cloud Functions](../../../functions/operations/trigger/timer-create.md)
* [Таймер, который вызывает контейнер Serverless Containers](../../../serverless-containers/operations/timer-create.md)