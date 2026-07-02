[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Notification Service](../../index.md) > [Пошаговые инструкции](../index.md) > Мобильные Push-уведомления > Изменить эндпоинт

# Изменить эндпоинт

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится эндпоинт.
  1. Перейдите в сервис **Cloud Notification Service**.
  1. Выберите канал push-уведомлений.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **Эндпоинты**.
  1. Напротив нужного эндпоинта нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
  1. Введите **Токен устройства** — уникальный токен на устройстве пользователя, созданный сервисом уведомлений для приложения.
  1. (опционально) Введите **Данные пользователя** — текст длиной до 2048 символов в кодировке [UTF-8](https://ru.wikipedia.org/wiki/UTF-8).
  1. Нажмите **Сохранить**.

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

      Подробнее о команде `aws sns set-endpoint-attributes` в [документации AWS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/set-endpoint-attributes.html).

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

  Воспользуйтесь методом HTTP API [setAttributes](../../api-ref/set-endpoint-attributes.md) для ресурса Endpoint сервиса Yandex Cloud Notification Service.

{% endlist %}

Изменение эндпоинта может занять некоторое время.