---
title: Удалить эндпоинт в {{ cns-full-name }}
description: Следуя этой инструкции, вы сможете удалить эндпоинт.
---

# Удалить эндпоинт

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится эндпоинт.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Выберите канал push-уведомлений.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.cns.label_endpoints }}**.
  1. Напротив нужного эндпоинта нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите **{{ ui-key.yacloud.common.delete }}**.

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../../storage/tools/aws-cli.md).
  1. Выполните команду:

      ```bash
      aws sns delete-endpoint \
        --endpoint-arn <ARN_эндпоинта>
      ```

      Где `--endpoint-arn` — идентификатор (ARN) эндпоинта.

      Подробнее о команде `aws sns delete-endpoint` см. в [документации AWS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/delete-endpoint.html).

- AWS SDK для Python {#python}

  1. Если у вас еще нет AWS SDK для Python (boto3), [установите и настройте его](../../tools/sdk-python.md#aws-sdk).
  1. Чтобы изменить эндпоинт, используйте следующий код:

      ```python
      response = client.delete_endpoint(
          EndpointArn="<ARN_эндпоинта>"
      )
      print("Endpoint deleted successfully.")
      ```

      Где `EndpointArn` — идентификатор (ARN) эндпоинта.

- AWS SDK для PHP {#php}

  1. Если у вас еще нет AWS SDK для PHP, [установите и настройте его](../../tools/sdk-php.md#aws-sdk).
  1. Чтобы удалить эндпоинт, используйте следующий код:

      ```php
      $response = $client->deleteEndpoint([
          'EndpointArn' => '<ARN_эндпоинта>',
      ]);

      echo "Endpoint deleted successfully.\n";
      ```

      Где `EndpointArn` — идентификатор (ARN) эндпоинта.


- API {#api}

  Воспользуйтесь методом HTTP API [delete](../../api-ref/delete-endpoint.md) для ресурса Endpoint сервиса {{ cns-full-name }}.

{% endlist %}