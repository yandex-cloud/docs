# Создать триггер для почты, который отправляет сообщения в WebSocket-соединения

Создайте [триггер для почты](../../concepts/trigger/mail-trigger.md), который будет отправлять сообщения в [WebSocket-соединения](../../concepts/extensions/websocket.md) {{ api-gw-full-name }}, когда на электронную почту приходит письмо. Адрес электронной почты генерируется сервисом автоматически во время создания триггера.

## Перед началом работы {#before-you-begin}

{% include [trigger-before-you-begin](../../../_includes/api-gateway/trigger-before-you-begin.md) %}

* (Опционально) [Бакет](../../../storage/concepts/bucket.md), в который будут сохраняться вложения из писем. Если у вас нет бакета, [создайте его](../../../storage/operations/buckets/create.md) с ограниченным доступом.

## Создать триггер {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. Откройте сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.

    1. На панели слева выберите ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * (Опционально) Введите имя и описание триггера.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_mail }}`.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_gateway-broadcast }}`.
    
    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_mail-attachments }}**:
      
        {% include [mail-trigger-attachements](../../../_includes/functions/mail-trigger-attachements.md) %}

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}** укажите:

        * размер группы сообщений. Допустимые значения от 1 до 1000, значение по умолчанию — 1.
        * максимальное время ожидания. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда.

       Триггер группирует сообщения не дольше указанного времени ожидания и отправляет их в WebSocket-соединения. Число сообщений при этом не превышает указанный размер группы.

    1. {% include [api-gateway-settings](../../../_includes/api-gateway/api-gateway-settings.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

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

    {% include [batch-settings-messages](../../../_includes/api-gateway/batch-settings-messages.md) %}

    * `--attachements-bucket` — имя бакета, в который будут сохраняться вложения из писем. Необязательный параметр.
    
    * `--attachements-service-account-id` — идентификатор сервисного аккаунта, у которого есть права на загрузку объектов в бакет Object Storage. Необязательный параметр.

    {% include [trigger-cli-param](../../../_includes/api-gateway/trigger-cli-param.md) %}

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

{% include [check-result](../../../_includes/api-gateway/check-result.md) %}

## См. также {#see-also}

* [Триггер для почты, который вызывает функцию {{ sf-name }}](../../../functions/operations/trigger/mail-trigger-create.md)
* [Триггер для почты, который вызывает контейнер {{ serverless-containers-name }}](../../../serverless-containers/operations/mail-trigger-create.md)
