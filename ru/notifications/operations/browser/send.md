---
title: Отправить push-уведомление в {{ cns-full-name }}
description: Следуя этой инструкции, вы сможете отправить push-уведомление.
---

# Отправить push-уведомление

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится эндпоинт.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Выберите канал push-уведомлений в браузере.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.cns.label_endpoints }}**.
  1. Выберите нужный эндпоинт.
  1. Введите текст уведомления и нажмите **{{ ui-key.yacloud.cns.action_send-msg }}**.

  Каждому отправленному уведомлению присваивается уникальный идентификатор. Чтобы сохранить его, нажмите **{{ ui-key.yacloud.cns.action_copy-msg-id }}**.

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../../storage/tools/aws-cli.md).

  1. Выполните команду:

      ```bash
      aws sns publish \
        --target-arn "<ARN_эндпоинта>" \
        --message-structure json \
        --message '{"default": "<текст_уведомления>", "WEB": "<текст_уведомления>"}'
      ```

  Где:

  * `--target-arn` — идентификатор (ARN) эндпоинта.
  * `--message-structure` — формат сообщения.
  * `--message` — сообщение.

- AWS SDK для Python {#python}

  1. Если у вас еще нет AWS SDK для Python (boto3), [установите и настройте его](../../tools/sdk-python.md#aws-sdk).
  1. Чтобы отправить уведомление, используйте следующий код:

      ```python
      try:
        response = client.publish(
            TargetArn="<ARN_эндпоинта>",
            Message=json.dumps({
                "default": "<текст_уведомления>",
                "WEB": "<текст_уведомления>",
            }),
            MessageStructure="json",
        )
        print(f'Message ID: {response["MessageId"]}')

      except botocore.exceptions.ClientError as error:
        print(f"Error: {error}")
      ```

- AWS SDK для PHP {#php}

  1. Если у вас еще нет AWS SDK для PHP, [установите и настройте его](../../tools/sdk-php.md#aws-sdk).
  1. Чтобы отправить уведомление, используйте следующий код:

      ```php
      $response = $client->publish(
        [
            'TargetArn' => '<ARN_эндпоинта>',
            'Message' => json_encode([
                'default' => '<текст_уведомления>',
                'WEB' => '<текст_уведомления>',
            ]),
            'MessageStructure' => 'json',
        ]
      );
      print('Message ID: ' . $response->get('MessageId'));
      ```

- AWS SDK для JavaScript {#javascript}

   1. Если у вас еще нет AWS SDK для JavaScript, [установите и настройте его](../../tools/sdk-javascript.md).
   1. Чтобы отправить уведомление в браузер, используйте следующий код:
   
       ```javascript
       try {
        const response = await client.send(
            new AWS.PublishCommand({
                Message: JSON.stringify({
                    "default": "<текст_уведомления>",
                    "WEB": "<текст_уведомления>",
                }),
                MessageStructure: "json",
                TargetArn: "<ARN_эндпоинта>",
            }),
        );
        console.log("Message ID:", response["MessageId"]);
      } catch (e) {
        console.log("Error:", e)
      }
      ```

- API {#api}

  Воспользуйтесь методом HTTP API [publish](../../api-ref/publish.md) для ресурса Publish сервиса {{ cns-full-name }}.

{% endlist %}
