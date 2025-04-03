---
title: Управлять эндпоинтом в {{ cns-full-name }}
description: Следуя этой инструкции, вы сможете изменить или удалить эндпоинт.
---

# Управлять эндпоинтом

## Изменить параметры эндпоинта {#endpoint-update}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится эндпоинт.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Выберите канал push-уведомлений в браузере.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.cns.label_endpoints }}**.
  1. Напротив нужного эндпоинта нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Измените **{{ ui-key.yacloud.cns.field_web-push-endpoint_params }}** и **{{ ui-key.yacloud.cns.field_endpoint-user-data }}**.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../../storage/tools/aws-cli.md).
  1. Выполните команду:

      ```bash
      aws sns set-endpoint-attributes \
        --endpoint-arn <ARN_эндпоинта> \
        --attributes Token=<pushSubscription_JSON>,CustomUserData=<произвольные_данные>
      ```

      Где:

      * `--endpoint-arn` — идентификатор (ARN) эндпоинта.
      * `--attributes` — параметры эндпоинта, которые вы хотите изменить, через запятую:
        * `Token` — объект [PushSubscription](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription) в формате [JSON](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription/toJSON), который получен в браузере пользователя.
        * `CustomUserData` – дополнительная информация.

      Подробнее о команде `aws sns set-endpoint-attributes` см. в [документации AWS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/set-endpoint-attributes.html).

- AWS SDK для Python {#python}

      ```python
      response = client.set_endpoint_attributes(
          EndpointArn="<ARN_эндпоинта>",
          Attributes={
              Token: "<pushSubscription_JSON>",
              CustomUserData: "<произвольные_данные>"
          }
      )
      print("Endpoint attributes updated successfully.")
      ```

      Где:

      * `EndpointArn` — идентификатор (ARN) эндпоинта.
      * `Attributes` — параметры, которые вы хотите изменить, через запятую:
        * `Token` — объект [PushSubscription](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription) в формате [JSON](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription/toJSON), который получен в браузере пользователя.
        * `CustomUserData` – дополнительная информация.

- AWS SDK для PHP {#php}

      ```php
      $response = $client->setEndpointAttributes([
          'EndpointArn' => '<ARN_эндпоинта>',
          'Attributes' => [
              Token => '<pushSubscription_JSON>',
              CustomUserData => '<произвольные_данные>'
          ],
      ]);

      echo "Endpoint attributes updated successfully.\n";
      ```

      * `EndpointArn` — идентификатор (ARN) эндпоинта.
      * `Attributes` — параметры, которые вы хотите изменить, через запятую:
        * `Token` — объект [PushSubscription](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription) в формате [JSON](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription/toJSON), который получен в браузере пользователя.
        * `CustomUserData` – дополнительная информация.

- API {#api}

  Воспользуйтесь методом HTTP API [setAttributes](../../api-ref/set-endpoint-attributes.md) для ресурса Endpoint сервиса {{ cns-full-name }}.

{% endlist %}

Изменение эндпоинта может занять некоторое время.

## Удалить эндпоинт {#endpoint-delete}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится эндпоинт.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Выберите канал push-уведомлений в браузере.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.cns.label_endpoints }}**.
  1. Напротив нужного эндпоинта нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Нажмите **{{ ui-key.yacloud.common.delete }}**.

- AWS CLI {#aws-cli}

      ```bash
      aws sns delete-endpoint \
        --endpoint-arn <ARN_эндпоинта>
      ```

      Где `--endpoint-arn` — идентификатор (ARN) эндпоинта.

      Подробнее о команде `aws sns delete-endpoint` см. в [документации AWS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/delete-endpoint.html).

- AWS SDK для Python {#python}

      ```python
      response = client.delete_endpoint(
          EndpointArn="<ARN_эндпоинта>"
      )
      print("Endpoint deleted successfully.")
      ```

- AWS SDK для PHP {#php}

      ```php
      $response = $client->deleteEndpoint([
          'EndpointArn' => '<ARN_эндпоинта>',
      ]);

      echo "Endpoint deleted successfully.\n";
      ```

- API {#api}

  Воспользуйтесь методом HTTP API [delete](../../api-ref/delete-endpoint.md) для ресурса Endpoint сервиса {{ cns-full-name }}.

{% endlist %}