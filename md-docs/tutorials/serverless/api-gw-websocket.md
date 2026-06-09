# Работа с API-шлюзом по протоколу WebSocket


Чтобы установить соединение с API-шлюзом по протоколу WebSocket:

1. [Создайте API-шлюз](#create).
1. [Установите соединение](#connect).
1. [Проверьте работу соединения](#check).

Если созданные ресурсы больше не нужны, [удалите](#clear-out) их.

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость ресурсов входит плата за количество запросов к API-шлюзу и исходящий трафик (см. [тарифы Yandex API Gateway](../../api-gateway/pricing.md)).

## Создайте API-шлюз {#create}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором необходимо создать API-шлюз.
    1. Перейдите в сервис **API Gateway**.
    1. Нажмите кнопку **Создать API-шлюз**.
    1. В поле **Имя** введите `websocket`.
    1. (Опционально) В поле **Описание** введите описание.
    1. В блок **Спецификация** добавьте спецификацию:

        ```yaml
        openapi: 3.0.0
        info:
          title: Test API
          version: 1.0.0
        paths:
          /connections:
            x-yc-apigateway-websocket-message:
              summary: Get connection identifier
              operationId: getConnectionID
              parameters:
                - name: X-Yc-Apigateway-Websocket-Connection-Id
                  in: header
                  description: Websocket connection identifier
                  required: true
                  schema:
                    type: string
              responses:
                '200':
                  description: Connection identifier
                  content:
                    text/plain:
                      schema:
                        type: string
              x-yc-apigateway-integration:
                type: dummy
                http_code: 200
                http_headers:
                  Content-Type: application/json
                content:
                  text/plain: '{"connection_id":"{X-Yc-Apigateway-Websocket-Connection-Id}"}'
        ```

    1. Нажмите кнопку **Создать**.

{% endlist %}

## Установите соединение {#connect}

1. Откройте терминал и установите утилиту [wscat](https://www.npmjs.com/package/wscat):

    ```bash
    npm install -g wscat
    ```

1. Установите соединение с API-шлюзом. Вместо `<домен_API-шлюза>` укажите домен API-шлюза вида `d5dm1lba80md********.i9******.apigw.yandexcloud.net`:

    ```bash
    wscat -c wss://<домен_API-шлюза>/connections
    Connected (press CTRL+C to quit)
    ```

1. Введите любое сообщение и нажмите `Enter`.

Сообщение отправится через установленное соединение в API-шлюз. API-шлюз вызовет интеграцию и отправит ответ — вы увидите его на экране. В ответе будет идентификатор установленного соединения:

```bash
> Hello!
< {"connection_id":"<идентификатор_соединения>"}
```

## Проверьте работу соединения {#check}

Откройте новое окно в терминале и проверьте работу соединения, используя полученный идентификатор соединения.

{% list tabs group=instructions %}

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    1. Получите информацию об установленном соединении:

        ```bash
        yc serverless api-gateway websocket get <идентификатор_соединения>
        ```

    1. Отправьте сообщение на клиентскую сторону:

        ```bash
        yc serverless api-gateway websocket send <идентификатор_соединения> --data Hello!
        ```

    1. Закройте соединение:

        ```bash
        yc serverless api-gateway websocket disconnect <идентификатор_соединения>
        ```

    1. Перейдите в окно терминала с установленным соединением. Там должна отобразиться следующая информация:

        ```bash
        wscat -c wss://<домен_API-шлюза>/connections
        Connected (press CTRL+C to quit)
        > Hello!
        < {"connection_id":"<идентификатор_соединения>"}
        < Hello!
        Disconnected (code: 1000, reason: "")
        ```

        Где `домен_API-шлюза` — строка вида `d5dm1lba80md********.i9******.apigw.yandexcloud.net`.

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, [удалите API-шлюз](../../api-gateway/operations/api-gw-delete.md).