# Создать таймер, который отправляет сообщения в WebSocket-соединения

Создайте [таймер](../../concepts/trigger/timer.md) — триггер, который будет отправлять сообщения в [WebSocket-соединения](../../concepts/extensions/websocket.md) по расписанию.

## Перед началом работы {#before-you-begin}

{% include [trigger-before-you-begin](../../../_includes/api-gateway/trigger-before-you-begin.md) %}

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
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_timer }}`.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_gateway-broadcast }}`.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_timer }}**:

        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cron-expression }}** укажите расписание отправки сообщений в WebSocket-соединения в формате [cron-выражения](../../concepts/trigger/timer.md#cron-expression).
        * (Опционально) В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cron-payload }}** укажите сообщение, которое будет передаваться в WebSocket-соединения при срабатывании таймера в поле `payload`. Тип данных — строка, длина которой не более 4096 символов.

    1. {% include [api-gateway-settings](../../../_includes/api-gateway/api-gateway-settings.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

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

    {% include [trigger-cli-param](../../../_includes/api-gateway/trigger-cli-param.md) %}

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

  Чтобы создать таймер, воспользуйтесь методом REST API [create](../../triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../../triggers/api-ref/grpc/trigger_service.md#Create).

{% endlist %}

## Проверить результат {#check-result}

{% include [check-result](../../../_includes/api-gateway/check-result.md) %}

## См. также {#see-also}

* [Таймер, который вызывает функцию {{ sf-name }}](../../../functions/operations/trigger/timer-create.md)
* [Таймер, который вызывает контейнер {{ serverless-containers-name }}](../../../serverless-containers/operations/timer-create.md)
