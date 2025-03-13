---
title: Отправить push-уведомление в {{ cns-full-name }}
description: Следуя этой инструкции, вы сможете отправить push-уведомление.
---

# Отправить push-уведомление

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится эндпоинт.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Выберите канал push-уведомлений.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.cns.label_endpoints }}**.
  1. Выберите нужный эндпоинт.
  1. В блоке **{{ ui-key.yacloud.cns.section_message-sending }}** выберите формат уведомления: `Текст` или `JSON`.
  1. Введите текст уведомления или JSON-объект, содержащий данные уведомления.
  1. Нажмите **{{ ui-key.yacloud.cns.action_send-msg }}**.

  Каждому отправленному уведомлению присваивается уникальный идентификатор. Чтобы сохранить его, нажмите **{{ ui-key.yacloud.cns.action_copy-msg-id }}**.

  Вы можете сразу же отправить новое уведомление или повторить предыдущее.

- AWS CLI {#aws-cli}

  Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../../storage/tools/aws-cli.md).

  **Явные уведомления (Bright Push)**

  Чтобы отправить явное уведомление, выполните команду:

  * Apple iOS (APNs)

      ```bash
      aws sns publish \
        --target-arn "<ARN_эндпоинта>" \
        --message-structure json \
        --message '{"default": "<текст_уведомления>", "APNS": "{ \"aps\": { \"alert\": \"<текст_уведомления>\"} }" }'
      ```

  * Google Android (FCM)

      ```bash
      aws sns publish \
        --target-arn "<ARN_эндпоинта>" \
        --message-structure json \
        --message '{"default": "<текст_уведомления>", "GCM": "{ \"notification\": { \"body\": \"<текст_уведомления>\"} }" }'
      ```

  Где:

  * `--target-arn` — идентификатор (ARN) мобильного эндпоинта.
  * `--message-structure` — формат сообщения.
  * `--message` — сообщение.

  **Тихие уведомления (Silent Push)**

  Чтобы отправить тихое уведомление, выполните команду:

  ```bash
  aws sns publish \
    --target-arn <ARN_эндпоинта> \
    --message-structure json \
    --message '{"data": { "key": "value" } }'
  ```

  Где:

  * `--target-arn` — идентификатор (ARN) мобильного эндпоинта.
  * `--message-structure` — формат сообщения.
  * `--message` — сообщение.

- AWS SDK для Python (boto3) {#python}

  Если у вас еще нет AWS SDK для Python (boto3), [установите и настройте его](../../tools/sdk-python.md#aws-sdk).

  **Явные уведомления (Bright Push)**

  Чтобы отправить явное уведомление, используйте следующий код:

  * Apple iOS (APNs)

      ```json
      response = client.publish(
          TargetArn="<идентификатор_эндпоинта>",
          Message=json.dumps({
              "default": "<текст_уведомления>",
              "APNS": json.dumps({
                  "aps": {
                      "alert": "<текст_уведомления>"
                  }
              })
          }),
          MessageStructure="json"
      )
      print ("Message id:", response["MessageId"])
      ```

  * Google Android (FCM)

      ```python
      response = client.publish(
          TargetArn="<идентификатор_эндпоинта>",
          Message=json.dumps({
              "default": "<текст_уведомления>",
              "GCM": json.dumps({
                  "notification": {
                      "body": "<текст_уведомления>"
                  }
              })
          }),
          MessageStructure="json"
      )
      print ("Message id:", response["MessageId"])
      ```

  * RuStore Android

      ```python
      response = client.publish(
          TargetArn="<идентификатор_эндпоинта>",
          Message=json.dumps({
              "default": "<текст_уведомления_по_умолчанию>",
              "RUSTORE": json.dumps({
                  "notification": {
                      "title": "<заголовок уведомления>",
                      "body": "<текст_уведомления>",
                  }
              })
          }),
          MessageStructure="json"
      )
      message_id = response["MessageId"]
      print(f"Message id is: {message_id}")
      ```

  Где:

  * `TargetArn` — идентификатор (ARN) мобильного эндпоинта.
  * `MessageStructure` — формат сообщения.
  * `Message` — сообщение.

  **Тихие уведомления (Silent Push)**

  Чтобы отправить тихое уведомление, используйте следующий код:

  ```python
  response = client.publish(
      TargetArn="<endpoint ARN>",
      Message='{"data": { "key": "value" } }')
  print ("Message id:", response["MessageId"])
  ```

  Где:

  * `TargetArn` — идентификатор (ARN) мобильного эндпоинта.
  * `Message` — сообщение.

- AWS SDK для PHP {#php}

  Если у вас еще нет AWS SDK для PHP, [установите и настройте его](../../tools/sdk-php.md#aws-sdk).

  **Явные уведомления (Bright Push)**

  Чтобы отправить явное уведомление, используйте следующий код:

  * Apple iOS (APNs)

      ```php
      $response = $client->publish(
        [
            'TargetArn' => '<идентификатор_эндпоинта>',
            'Message' => json_encode([
                'default' => '<текст_уведомления>',
                'APNS' => json_encode([
                    'aps' => [
                        'alert' => '<текст_уведомления>',
                    ],
                ])
            ]),
            'MessageStructure' => 'json',
        ]
      );

      print($response->get('MessageId'));
      ```

  * Google Android (FCM)

      ```php
      $response = $client->publish(
        [
            'TargetArn' => '<идентификатор_эндпоинта>',
            'Message' => json_encode([
                'default' => '<текст_уведомления>',
                'GCM' => json_encode([
                    'notification' => [
                        'title' => '<заголовок_уведомления>',
                        'body' => '<текст_уведомления>',
                    ],
                ])
            ]),
            'MessageStructure' => 'json',
        ]
      );

      print($response->get('MessageId'));
      ```

  Где:

  * `TargetArn` — идентификатор (ARN) мобильного эндпоинта.
  * `MessageStructure` — формат сообщения.
  * `Message` — сообщение.

  **Тихие уведомления (Silent Push)**

  Чтобы отправить тихое уведомление, используйте следующий код:

  * Google Android (FCM)

      ```php
      $response = $client->publish(
        [
            'TargetArn' => '<идентификатор_эндпоинта>',
            'Message' => json_encode([
                'default' => '<текст_уведомления>',
                'GCM' => json_encode([
                    'data' => ['<ключ>' => '<значение>'],
                ])
            ]),
            'MessageStructure' => 'json',
        ]
      );

      print($response->get('MessageId'));
      ```

      Где:

      * `TargetArn` — идентификатор (ARN) мобильного эндпоинта.
      * `MessageStructure` — формат сообщения.
      * `Message` — сообщение.


- API {#api}

  Воспользуйтесь методом HTTP API [publish](../../api-ref/publish.md) для ресурса Publish сервиса {{ cns-full-name }}.

{% endlist %}
