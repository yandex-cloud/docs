---
title: Создать эндпоинт для уведомлений в браузере
description: Следуя этой инструкции, вы сможете создать эндпоинт для Push-уведомлений в браузере.
---

# Создать эндпоинт

Для каждого канала надо создать набор [эндпоинтов](../../concepts/browser.md), через которые будут отправляться уведомления в браузеры конкретных пользователей.

Чтобы создать эндпоинт:

1. Из браузера пользователя с помощью [Service Worker](https://developer.mozilla.org/ru/docs/Web/API/Service_Worker_API/Using_Service_Workers) вызовите метод JavaScript [subscribe](https://developer.mozilla.org/en-US/docs/Web/API/PushManager/subscribe#applications).

    В ответ вернется объект [PushSubscription](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription).

1. Преобразуйте полученный объект в JSON, вызвав метод [toJSON](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription/toJSON).

Формат ответа в JSON:

```json
{
  "endpoint": <string>,
  "expirationTime": <DOMHighResTimeStamp,null>,
  "keys": {
    "p256dh": <string>,
    "auth": <string>
  }
}
```
Где:
* `endpoint` — URL-адрес, на который будет отправляться push-уведомление. Обычно это адрес сервера push-уведомлений, например, Firebase Cloud Messaging (FCM).
* `expirationTime` — время жизни уведомления в миллисекундах. Если значение равно `null`, то время жизни не ограничено.
* `keys` — данные для защиты уведомления:
    * `p256dh` — публичный ключ пользователя, который используется для шифрования данных уведомления.
    * `auth` — ключ аутентификации для подтверждения подлинности отправителя.

{% cut "Пример ответа в JSON" %}

   ```json
   {
    "endpoint": "https://fcm.googleapis.com/fcm/send/abcdef123456",
    "expirationTime": 1704093740000,
    "keys": {
      "p256dh": "BOrLkr7sEt8tERyAv6c8ZG5UC********",
      "auth": "aBcDeFg12345"
    }
   }
   ```
{% endcut %}
   
Получив данные для отправки уведомлений пользователю, создайте эндпоинт:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится канал уведомлений.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Выберите вкладку **{{ ui-key.yacloud.cns.type_web }}**.
  1. Выберите канал уведомлений.
  1. Выберите вкладку ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.cns.label_endpoints }}**.
  1. Нажмите **{{ ui-key.yacloud.cns.action_create-endpoint }}**.
  1. Введите **{{ ui-key.yacloud.cns.field_web-push-endpoint_params }}**, которые были получены при подписке пользователя.
  1. (опционально) Введите **{{ ui-key.yacloud.cns.field_endpoint-user-data }}** — текст длиной до 2048 символов в кодировке [UTF-8](https://ru.wikipedia.org/wiki/UTF-8).
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../../storage/tools/aws-cli.md).
  1. Выполните команду:

     ```bash
     aws sns create-platform-endpoint \
     --platform-application-arn <ARN_канала> \
     --token <pushSubscription_JSON>
     ```

     Где:

     * `--platform-application-arn` — идентификатор (ARN) канала уведомлений.
     * `--token` — объект [PushSubscription](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription) в формате [JSON](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription/toJSON), который получен в браузере пользователя.

     Подробнее о команде `aws sns create-platform-endpoint` см. в [документации AWS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/create-platform-endpoint.html).

- AWS SDK для Python {#python}

  1. Если у вас еще нет AWS SDK для Python (boto3), [установите и настройте его](../../tools/sdk-python.md#aws-sdk).
  1. Чтобы создать эндпоинт, используйте следующий код:

     ```python
     try:
      response = client.create_platform_endpoint(
        PlatformApplicationArn="<ARN_канала>",
        Token="<pushSubscription_JSON>",
      )
      print(f'Endpoint ARN: {response["EndpointArn"]}')

     except botocore.exceptions.ClientError as error:
      print(f"Error: {error}")
     ```

- AWS SDK для PHP {#php}

  1. Если у вас еще нет AWS SDK для PHP, [установите и настройте его](../../tools/sdk-php.md#aws-sdk).
  1. Чтобы создать эндпоинт, используйте следующий код:

      ```php
      $response = $client->createPlatformApplication(
        [
          'PlatformApplicationArn' => '<ARN_канала>',
          'Token' => '<pushSubscription_JSON>',
        ]
      );
      print('Endpoint ARN: ' . $response->get('EndpointArn'));
      ```

- AWS SDK для JavaScript {#javascript}

   1. Если у вас еще нет AWS SDK для JavaScript, [установите и настройте его](../../tools/sdk-javascript.md).
   1. Чтобы создать эндпоинт, используйте следующий код:

      ```javascript
      try {
        const response = await client.send(
          new AWS.CreatePlatformEndpointCommand({
            PlatformApplicationArn: "<ARN_канала>",
            Token: "<pushSubscription_JSON>",
          }),
        );
        console.log("Endpoint ARN:", response["EndpointArn"]);
      } catch (e) {
        console.log("Error:", e)
      }
      ```

- API {#api}

  Воспользуйтесь методом HTTP API [create](../../api-ref/create-platform-endpoint.md) для ресурса Endpoint сервиса {{ cns-full-name }}.

{% endlist %}

Создание эндпоинта может занять некоторое время.