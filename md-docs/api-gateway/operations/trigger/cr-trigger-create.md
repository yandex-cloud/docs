# Создать триггер для Container Registry, который отправляет сообщения в WebSocket-соединения

Создайте [триггер для Container Registry](../../concepts/trigger/cr-trigger.md), который будет отправлять сообщения в [WebSocket-соединения](../../concepts/extensions/websocket.md) при создании и удалении [Docker-образов](../../../container-registry/concepts/docker-image.md) Container Registry или их тегов.

## Перед началом работы {#before-begin}

Для создания триггера вам понадобятся:

* API-шлюз. Сообщения будут отправляться в WebSocket-соединения, подключенные к API-шлюзу по пути, указанному в настройках триггера. Если у вас нет API-шлюза, [создайте его](../api-gw-create.md).

    {% note info %}

    Триггер не вызывает API-шлюз при отправке сообщений в WebSocket-соединения.

    {% endnote %}

* [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) с ролью `api-gateway.websocketBroadcaster`. Если у вас нет сервисного аккаунта, [создайте его](../../../iam/operations/sa/create.md).

* [Реестр](../../../container-registry/concepts/registry.md), при событиях с [Docker-образами](../../../container-registry/concepts/docker-image.md) в котором триггер будет запускаться. Если у вас нет реестра, [создайте его](../../../container-registry/operations/registry/registry-create.md).

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
        * В поле **Тип** выберите `Container Registry`.
        * В поле **Запускаемый ресурс** выберите `API-шлюз`.

    1. В блоке **Настройки Container Registry**:

        * В поле **Реестр** выберите реестр, для событий с образами в котором необходимо создать триггер.
        * В поле **Типы событий** выберите [события](../../concepts/trigger/cr-trigger.md#event), после наступления которых триггер будет запускаться.
        * (Опционально) В поле **Имя Docker-образа** введите имя образа для [фильтрации](../../concepts/trigger/cr-trigger.md#filter). Чтобы узнать имя Docker-образа, [получите список Docker-образов в реестре](../../../container-registry/operations/docker-image/docker-image-list.md).
        * (Опционально) В поле **Тег Docker-образа** введите тег образа для фильтрации.

    1. В блоке **Настройки группирования сообщений** укажите:

        * размер группы событий. Допустимые значения от 1 до 1000, значение по умолчанию — 1.
        * максимальное время ожидания. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда.

       Триггер группирует события не дольше указанного времени ожидания и отправляет их в WebSocket-соединения. Число событий при этом не превышает указанный размер группы.

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
    yc serverless trigger create container-registry \
      --name <имя_триггера> \
      --registry-id <идентификатор_реестра> \
      --events 'create-image','delete-image','create-image-tag','delete-image-tag' \
      --batch-size <размер_группы> \
      --batch-cutoff <максимальное_время_ожидания> \
      --gateway-id <идентификатор_API-шлюза> \
      --gateway-websocket-broadcast-path <путь> \
      --gateway-websocket-broadcast-service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где:

    * `--name` — имя триггера.
    * `--registry-id` — [идентификатор реестра](../../../container-registry/operations/registry/registry-list.md).
    * `--events` — [события](../../concepts/trigger/cr-trigger.md#event), после наступления которых триггер запускается.

    * `--batch-size` — размер группы событий. Необязательный параметр. Допустимые значения от 1 до 1000, значение по умолчанию — 1.
    * `--batch-cutoff` — максимальное время ожидания. Необязательный параметр. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда. Триггер группирует события не дольше `batch-cutoff` и отправляет их в WebSocket-соединения. Число событий при этом не превышает `batch-size`.

    * `--gateway-id` — идентификатор API-шлюза.
    * `--gateway-websocket-broadcast-path` — путь в OpenAPI-спецификации. Через WebSocket-соединения, которые установлены по этому пути, будут отправляться сообщения.
    * `--gateway-websocket-broadcast-account-id` — идентификатор сервисного аккаунта с правами на отправку сообщений в WebSocket-соединения.

    Результат:

    ```text
    id: a1s5msktijh2********
    folder_id: b1gmit33hgh2********
    created_at: "2023-08-04T15:19:15.353909857Z"
    name: registry-trigger
    rule:
      container_registry:
        event_type:
        - CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE
        - CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE
        - CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE_TAG
        - CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE_TAG
        registry_id: crtlds4tdfg12kil77h2********
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

  Чтобы создать триггер для Container Registry, воспользуйтесь методом REST API [create](../../triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../../triggers/api-ref/grpc/Trigger/create.md).

{% endlist %}

## Проверить результат {#check-result}

Проверьте, что триггер работает корректно. Для этого посмотрите [логи API-шлюза](../api-gw-logs.md), в них отображается информация об обращениях к нему.

## Полезные ссылки {#see-also}

* [Триггер для Container Registry, который вызывает функцию Cloud Functions](../../../functions/operations/trigger/cr-trigger-create.md)
* [Триггер для Container Registry, который вызывает контейнер Serverless Containers](../../../serverless-containers/operations/cr-trigger-create.md)