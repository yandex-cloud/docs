---
title: Изменить эндпоинт в {{ cns-full-name }}
description: Следуя этой инструкции, вы сможете изменить эндпоинт.
---

# Изменить эндпоинт

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится эндпоинт.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Выберите канал push-уведомлений.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.cns.label_endpoints }}**.
  1. Напротив нужного эндпоинта нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Введите **{{ ui-key.yacloud.cns.field_token }}** — уникальный токен на устройстве пользователя, созданный сервисом уведомлений для приложения.
  1. (опционально) Введите **{{ ui-key.yacloud.cns.field_endpoint-user-data }}** — текст длиной до 2048 символов в кодировке [UTF-8](https://ru.wikipedia.org/wiki/UTF-8).
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../../storage/tools/aws-cli.md).
  1. Выполните команду:

      ```bash
      aws sns set-endpoint-attributes \
        --endpoint-arn <ARN_эндпоинта> \
        --attributes <параметр1>=<новое_значение1>, ... <параметрN>=<новое_значениеN>
      ```

      Где:

      * `--endpoint-arn` — идентификатор (ARN) эндпоинта.
      * `--attributes` — параметры эндпоинта, которые вы хотите изменить, через запятую в формате `<параметр>=<новое_значение>`.

      Подробнее о команде `aws sns set-endpoint-attributes` см. в [документации AWS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/set-endpoint-attributes.html).

- AWS SDK для Python {#python}

  1. Если у вас еще нет AWS SDK для Python (boto3), [установите и настройте его](../../tools/sdk-python.md#aws-sdk).
  1. Чтобы изменить эндпоинт, используйте следующий код:

      ```python
      response = client.set_endpoint_attributes(
          EndpointArn="<ARN_эндпоинта>",
          Attributes={
              "<параметр1>": "<новое_значение1>",
              ...
              "<параметрN>": "<новое_значениеN>"
          }
      )
      print("Endpoint attributes updated successfully.")
      ```

      Где:

      * `EndpointArn` — идентификатор (ARN) эндпоинта.
      * `Attributes` — параметры, которые вы хотите изменить, через запятую в формате `"<параметр>": "<новое_значение>"`.

- AWS SDK для PHP {#php}

  1. Если у вас еще нет AWS SDK для PHP, [установите и настройте его](../../tools/sdk-php.md#aws-sdk).
  1. Чтобы изменить эндпоинт, используйте следующий код:

      ```php
      $response = $client->setEndpointAttributes([
          'EndpointArn' => '<ARN_эндпоинта>',
          'Attributes' => [
              '<параметр1>' => '<новое_значение1>',
              ...
              '<параметрN>' => '<новое_значениеN>'
          ],
      ]);

      echo "Endpoint attributes updated successfully.\n";
      ```

      * `EndpointArn` — идентификатор (ARN) эндпоинта.
      * `Attributes` — параметры, которые вы хотите изменить, через запятую в формате `'<параметр>' => '<новое_значение>'`.


- API {#api}

  Воспользуйтесь методом HTTP API [setAttributes](../../api-ref/set-endpoint-attributes.md) для ресурса Endpoint сервиса {{ cns-full-name }}.

{% endlist %}

Изменение эндпоинта может занять некоторое время.