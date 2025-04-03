---
title: Создать канал push-уведомлений в браузере в {{ cns-full-name }}
description: Следуя этой инструкции, вы сможете создать канал push-уведомлений в браузере.
---

# Создать канал push-уведомлений в браузере

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать канал уведомлений.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Нажмите **{{ ui-key.yacloud.cns.action_create-channel }}**.
  1. Выберите вкладку **{{ ui-key.yacloud.cns.type_web }}**.
  1. (Опционально) В разделе **{{ ui-key.yacloud.cns.section_logging }}** включите **{{ ui-key.yacloud.cns.field_logging }}**.
     1. В списке **{{ ui-key.yacloud.cns.field_logging-folder }}** выберите каталог, в котором будет расположена [лог-группа](../../../logging/concepts/log-group.md).
     1. В поле **{{ ui-key.yacloud.cns.field_log-group }}** выберите существующую лог-группу или создайте новую.
  1. Введите имя канала уведомления. Имя канала должно быть уникальным в {{ cns-name }}.
  1. (Опционально) Нажмите ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.cns.button_add-description }}** и введите описание для канала уведомлений.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../../storage/tools/aws-cli.md).
  1. Выполните команду:

     ```bash
     aws sns create-platform-application \
     --name <имя_канала> \
     --platform "WEB" \
     --attributes "{}"
     ```

     Где `--name` — имя канала уведомлений, задается пользователем.

     Подробнее о команде `aws sns create-platform-application` см. в [документации AWS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/create-platform-application.html).

- AWS SDK для Python {#python}

  1. Если у вас еще нет AWS SDK для Python (boto3), [установите и настройте его](../../tools/sdk-python.md#aws-sdk).
  1. Чтобы создать канал push-уведомлений, используйте следующий код:

     ```python
     try:
      response = client.create_platform_application(
        Name="<имя_канала>",
        Platform="WEB",
        Attributes={},
      )
      print(f'PlatformApplication ARN: {response["PlatformApplicationArn"]}')

     except botocore.exceptions.ClientError as error:
      print(f"Error: {error}")
     ```

- AWS SDK для PHP {#php}

  1. Если у вас еще нет AWS SDK для PHP, [установите и настройте его](../../tools/sdk-php.md#aws-sdk).
  1. Чтобы создать канал push-уведомлений, используйте следующий код:

      ```php
      $response = $client->createPlatformApplication(
        [
          'Name' => '<имя_канала>',
          'Platform' => 'WEB',
          'Attributes' => [],
        ]
      );
      print('PlatformApplication ARN: ' . $response->get('PlatformApplicationArn'));
      ```

- AWS SDK для JavaScript {#javascript}

   1. Если у вас еще нет AWS SDK для JavaScript, [установите и настройте его](../../tools/sdk-javascript.md).
   1. Чтобы создать канал push-уведомлений, используйте следующий код:

      ```javascript
      try {
        const response = await client.send(
          new AWS.CreatePlatformApplicationCommand({
            Name: "<имя_канала>",
            Platform: "WEB",
          }),
        );
        console.log("PlatformApplication ARN:", response["PlatformApplicationArn"]);
      } catch (e) {
        console.log("Error:", e)
      }
      ```

- API {#api}

  Воспользуйтесь методом HTTP API [create](../../api-ref/create-platform-application.md) для ресурса PlatformApplications сервиса {{ cns-full-name }}.

{% endlist %}

Создание канала уведомлений может занять некоторое время. После создания канала [создайте эндпоинт](endpoint-create.md).