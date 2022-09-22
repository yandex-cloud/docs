# Работа с API-шлюзом по протоколу WebSocket

Чтобы установить соединение с API-шлюзом по протоколу WebSocket:

1. [Создайте API-шлюз](#create).
1. [Установите соединение](#connect).
1. [Проверьте работу соединения](#check).

Если созданные ресурсы больше не нужны, [удалите](#clear-out) их.

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость ресурсов входит плата за количество запросов к API-шлюзу и исходящий трафик (см. [тарифы {{ api-gw-full-name }}](../pricing.md)).

## Создайте API-шлюз {#create}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором необходимо создать API-шлюз.
    1. В списке сервисов выберите **{{ api-gw-name }}**.
    1. Нажмите кнопку **Создать API-шлюз**.
    1. В поле **Имя** введите `websocket`.
    1. (опционально) В поле **Описание** введите описание.
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
1. Установите соединение с API-шлюзом. Вместо `<идентификатор_API-шлюза>` укажите идентификатор API-шлюза.
    ```bash
    wscat -c wss://<идентификатор_API-шлюза>.apigw.yandexcloud.net/connections
    Connected (press CTRL+C to quit)
    ```
1. Введите любое сообщение и нажмите `Enter`.

Сообщение отправится через установленное соединение в API-шлюз. API-шлюз вызовет интеграцию и отправит ответ — вы увидите его на экране. В ответе будет идентификатор установленного соединения:
```bash
> Hello!
< {"connection_id":"<идентификатор соединения>"}
```
## Проверьте работу соединения {#check}

Откройте новое окно в терминале и проверьте работу соединения, используя полученный идентификатор соединения.

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Получите информацию об установленном соединении:
        ```bash
        yc serverless api-gateway websocket get <идентификатор_соединения>
        ```
    1. Отправьте сообщение на клиентскую сторону:
        ```bash
        yc serverless api-gateway websocket send <идентификатор соединения> --data Hello!
        ```
    1. Закройте соединение:
        ```bash
        yc serverless api-gateway websocket disconnect <идентификатор соединения>
        ```
    1. Перейдите в окно терминала с установленным соединением. Там должна отобразиться следующая информация:
        ```bash
        wscat -c wss://<идентификатор API-шлюза>.apigw.yandexcloud.net/connections
        Connected (press CTRL+C to quit)
        > Hello!
        < {"connection_id":"<идентификатор соединения>"}
        < Hello!
        Disconnected (code: 1000, reason: "")
        ```

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, [удалите API-шлюз](../operations/api-gw-delete.md).
