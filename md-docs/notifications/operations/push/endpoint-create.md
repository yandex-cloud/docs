# Создать эндпоинт

Каждый канал имеет свою базу [эндпоинтов](../../concepts/index.md#mobile-endpoints) для отправки уведомлений напрямую в приложение на устройства пользователей.

Чтобы создать эндпоинт:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится эндпоинт.
  1. Перейдите в сервис **Cloud Notification Service**.
  1. Выберите канал push-уведомлений.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **Эндпоинты**.
  1. Нажмите **Создать эндпоинт**.
  1. Введите **Токен устройства** — уникальный токен на устройстве пользователя, созданный сервисом уведомлений для приложения.
  1. (опционально) Введите **Данные пользователя** — текст длиной до 2048 символов в кодировке [UTF-8](https://ru.wikipedia.org/wiki/UTF-8).
  1. Нажмите **Создать**.

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../../storage/tools/aws-cli.md).
  1. Выполните команду:

      ```bash
      aws sns create-platform-endpoint \
        --platform-application-arn <ARN_канала_уведомлений> \
        --token <Push-токен>
      ```
      
      Где:
      
      * `--platform-application-arn` — идентификатор (ARN) канала уведомлений.
      * `--token` — уникальный Push-токен приложения на устройстве пользователя.
      
      В результате вы получите идентификатор (ARN) мобильного эндпоинта. Сохраните его для дальнейшего использования.
      
      Подробнее о команде `aws sns create-platform-endpoint` смотрите в [документации AWS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/create-platform-endpoint.html).

- AWS SDK для Python {#python}

  1. Если у вас еще нет AWS SDK для Python (boto3), [установите и настройте его](../../tools/sdk-python.md#aws-sdk).
  1. Чтобы создать эндпоинт, используйте следующий код:

      ```python
      response = client.create_platform_endpoint(
          PlatformApplicationArn="<ARN_канала_уведомлений>",
          Token="<Push-токен>",
      )
      print ("Endpoint ARN:", response["EndpointArn"])
      ```
      
      Где:
      
      * `PlatformApplicationArn` — идентификатор (ARN) канала уведомлений.
      * `Token` — уникальный Push-токен приложения на устройстве пользователя.
      
      В результате вы получите идентификатор (ARN) мобильного эндпоинта.

- AWS SDK для PHP {#php}

  1. Если у вас еще нет AWS SDK для PHP, [установите и настройте его](../../tools/sdk-php.md#aws-sdk).
  1. Чтобы создать эндпоинт, используйте следующий код:

      ```php
      $response = $client->createPlatformEndpoint(
          [
              'PlatformApplicationArn' => '<ARN_канала_уведомлений>',
              'Token' => '<Push-токен>',
          ]
      );
      
      print($response->get('EndpointArn'));
      ```
      
      Где:
      
      * `PlatformApplicationArn` — идентификатор (ARN) канала уведомлений.
      * `Token` — уникальный Push-токен приложения на устройстве пользователя.
      
      В результате вы получите идентификатор (ARN) мобильного эндпоинта.


- API {#api}

  Воспользуйтесь методом HTTP API [create](../../api-ref/create-platform-endpoint.md) для ресурса Endpoint сервиса Yandex Cloud Notification Service.

{% endlist %}

Создание эндпоинта может занять некоторое время.