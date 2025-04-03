---
title: Удалить канал push-уведомлений в {{ cns-full-name }}
description: Следуя этой инструкции, вы сможете удалить канал push-уведомлений.
---

# Удалить канал push-уведомлений

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [channel-delete](../../../_includes/notifications/channel-delete-console.md) %}

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../../storage/tools/aws-cli.md).
  1. Выполните команду:

      ```bash
      aws sns delete-platform-application \
        --platform-application-arn <ARN_канала_уведомлений>
      ```

      Где `--platform-application-arn` — идентификатор (ARN) канала уведомлений.

      Подробнее о команде `aws sns delete-platform-application` см. в [документации AWS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/delete-platform-application.html).

- AWS SDK для Python {#python}

  1. Если у вас еще нет AWS SDK для Python (boto3), [установите и настройте его](../../tools/sdk-python.md#aws-sdk).
  1. Чтобы удалить канал push-уведомлений, используйте следующий код:

      ```python
      response = client.delete_platform_application(
          PlatformApplicationArn="<ARN_канала_уведомлений>"
      )
      print("Platform application deleted successfully.")
      ```

      Где `PlatformApplicationArn` — идентификатор (ARN) канала уведомлений.

- AWS SDK для PHP {#php}

  1. Если у вас еще нет AWS SDK для PHP, [установите и настройте его](../../tools/sdk-php.md#aws-sdk).
  1. Чтобы удалить канал push-уведомлений, используйте следующий код:

      ```php
      $response = $client->deletePlatformApplication([
          'PlatformApplicationArn' => '<ARN_канала_уведомлений>',
      ]);

      echo "Platform application deleted successfully.\n";
      ```

      Где `PlatformApplicationArn` — идентификатор (ARN) канала уведомлений.


- API {#api}

  Воспользуйтесь методом HTTP API [delete](../../api-ref/delete-platform-application.md) для ресурса PlatformApplications сервиса {{ cns-full-name }}.

{% endlist %}
