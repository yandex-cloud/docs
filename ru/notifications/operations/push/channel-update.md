---
title: Изменить канал push-уведомлений в {{ cns-full-name }}
description: Следуя этой инструкции, вы сможете изменить канал push-уведомлений.
---

# Изменить канал push-уведомлений

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится канал уведомлений.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Напротив нужного канала push-уведомлений нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. На вкладке **{{ ui-key.yacloud.cns.type_mobile }}** в зависимости от платформы измените параметры аутентификации:

      {% include [push-channel-platforms-params.md](../../../_includes/notifications/push-channel-platforms-params.md) %}

  1. Нажмите ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.cns.button_add-description }}** и введите описание для канала уведомлений.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../../storage/tools/aws-cli.md).
  1. Выполните команду:

      ```bash
      aws sns set-platform-application-attributes \
        --platform-application-arn <ARN_канала_уведомлений> \
        --attributes <параметр1>=<новое_значение1>, ... <параметрN>=<новое_значениеN>
      ```

      Где:

      * `--platform-application-arn` — идентификатор (ARN) канала уведомлений.
      * `--attributes` — параметры канала уведомлений, которые вы хотите изменить, через запятую в формате `<параметр1>=<новое_значение1>`.

      Подробнее о команде `aws sns set-platform-application-attributes` см. в [документации AWS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/set-platform-application-attributes.html).

- AWS SDK для Python (boto3) {#python}

  1. Если у вас еще нет AWS SDK для Python (boto3), [установите и настройте его](../../tools/sdk-python.md#aws-sdk).
  1. Чтобы изменить канал push-уведомлений, используйте следующий код:

      ```python
      response = client.set_platform_application_attributes(
          PlatformApplicationArn="<ARN_канала_уведомлений>",
          Attributes={
              "<параметр1>": "<новое_значение1>",
              ...
              "<параметрN>": "<новое_значениеN>"
          }
      )
      print("Attributes updated successfully.")
      ```

      Где:

      * `PlatformApplicationArn` — идентификатор (ARN) канала уведомлений.
      * `Attributes` —  параметры, которые вы хотите изменить, через запятую в формате `"<параметрN>": "<новое_значениеN>"`.

- AWS SDK для PHP {#php}

  1. Если у вас еще нет AWS SDK для PHP, [установите и настройте его](../../tools/sdk-php.md#aws-sdk).
  1. Чтобы изменить канал push-уведомлений, используйте следующий код:

      ```php
      $response = $client->setPlatformApplicationAttributes([
          'PlatformApplicationArn' => '<ARN_канала_уведомлений>',
          'Attributes' => [
              '<параметр1>' => '<новое_значение1>',
              ...
              '<параметрN>' => '<новое_значениеN>'
          ],
      ]);

      echo "Platform application attributes updated successfully.\n";
      ```

      Где:

      * `PlatformApplicationArn` — идентификатор (ARN) канала уведомлений.
      * `Attributes` —  параметры, которые вы хотите изменить, через запятую в формате `'<параметр>' => '<новое_значение>'`.


- API {#api}

  Воспользуйтесь методом HTTP API [setAttributes](../../api-ref/set-platform-application-attributes.md) для ресурса PlatformApplications сервиса {{ cns-full-name }}.

{% endlist %}

Изменение канала уведомлений может занять некоторое время.
