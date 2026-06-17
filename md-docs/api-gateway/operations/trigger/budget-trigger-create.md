# Создать триггер для бюджетов, который отправляет сообщения в WebSocket-соединения

Создайте [триггер для бюджетов](../../concepts/trigger/budget-trigger.md), который будет отправлять сообщения в [WebSocket-соединения](../../concepts/extensions/websocket.md) при превышении пороговых значений.

## Перед началом работы {#before-you-begin}

Для создания триггера вам понадобятся:

* API-шлюз. Сообщения будут отправляться в WebSocket-соединения, подключенные к API-шлюзу по пути, указанному в настройках триггера. Если у вас нет API-шлюза, [создайте его](../api-gw-create.md).

    {% note info %}

    Триггер не вызывает API-шлюз при отправке сообщений в WebSocket-соединения.

    {% endnote %}

* [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) с ролью `api-gateway.websocketBroadcaster`. Если у вас нет сервисного аккаунта, [создайте его](../../../iam/operations/sa/create.md).

* Бюджет, при превышении порога которого триггер будет запускаться. Если у вас нет бюджета, [создайте его](../../../billing/operations/budgets.md).

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
       * В поле **Тип** выберите `Бюджет`.
       * В поле **Запускаемый ресурс** выберите `API-шлюз`.

    1. В блоке **Настройки бюджета** выберите платежный аккаунт и бюджет. Можно выбрать **Все бюджеты**.

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
    yc serverless trigger create billing-budget \
      --name <имя_триггера> \
      --billing-account-id <идентификатор_платежного_аккаунта> \
      --budget-id <идентификатор_бюджета> \
      --gateway-id <идентификатор_API-шлюза> \
      --gateway-websocket-broadcast-path <путь> \
      --gateway-websocket-broadcast-service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где:

    * `--name` — имя триггера.
    * `--billing-account-id` — идентификатор платежного аккаунта.
    * `--budget-id` — идентификатор бюджета.

    * `--gateway-id` — идентификатор API-шлюза.
    * `--gateway-websocket-broadcast-path` — путь в OpenAPI-спецификации. Через WebSocket-соединения, которые установлены по этому пути, будут отправляться сообщения.
    * `--gateway-websocket-broadcast-account-id` — идентификатор сервисного аккаунта с правами на отправку сообщений в WebSocket-соединения.

    Результат:

    ```text
    id: a1sfe084v4h2********
    folder_id: b1g88tflruh2********
    created_at: "2019-12-04T08:45:31.131391Z"
    name: budget-trigger
    rule:
      billing-budget:
        billing-account-id: dn2char50jh2********
        budget-id: dn2jnshmdlh2********
        gateway_websocket_broadcast:
          gateway_id: d4eofc7n0mh2********
          path: /
          service_account_id: aje3932acdh2********
    status: ACTIVE
    ```

- API {#api}

  Чтобы создать триггер для бюджетов, воспользуйтесь методом REST API [create](../../triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../../triggers/api-ref/grpc/Trigger/create.md).

{% endlist %}

## Проверить результат {#check-result}

Проверьте, что триггер работает корректно. Для этого посмотрите [логи API-шлюза](../api-gw-logs.md), в них отображается информация об обращениях к нему.

## Полезные ссылки {#see-also}

* [Триггер для бюджетов, который вызывает функцию Cloud Functions](../../../functions/operations/trigger/budget-trigger-create.md)
* [Создать триггер для бюджетов, который вызывает контейнер Serverless Containers](../../../serverless-containers/operations/budget-trigger-create.md)