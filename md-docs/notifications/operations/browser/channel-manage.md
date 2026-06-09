# Управлять каналом push-уведомлений в браузере

## Изменить параметры канала {#channel-update}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится канал уведомлений.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Напротив нужного канала нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Измените описание канала.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../../storage/tools/aws-cli.md).
  1. Выполните команду:

      ```bash
      aws sns set-platform-application-attributes \
        --platform-application-arn <ARN_канала_уведомлений> \
        --attributes <параметр1>=<новое_значение1>
      ```

      Где:

      * `--platform-application-arn` — идентификатор (ARN) канала уведомлений.
      * `--attributes` — параметры канала уведомлений.

      Подробнее о команде `aws sns set-platform-application-attributes` см. в [документации AWS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/set-platform-application-attributes.html).

- API {#api}

  Воспользуйтесь методом HTTP API [setAttributes](../../api-ref/set-platform-application-attributes.md) для ресурса PlatformApplications сервиса {{ cns-full-name }}.

{% endlist %}

Изменение канала уведомлений может занять некоторое время.

## Удалить канал {#channel-delete}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится канал уведомлений.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Напротив нужного канала уведомлений нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите **{{ ui-key.yacloud.common.delete }}**.

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../../storage/tools/aws-cli.md).
  1. Выполните команду:

      ```bash
      aws sns delete-platform-application \
        --platform-application-arn <ARN_канала_уведомлений>
      ```

      Где `--platform-application-arn` — идентификатор (ARN) канала уведомлений.

      Подробнее о команде `aws sns delete-platform-application` см. в [документации AWS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/delete-platform-application.html).

- API {#api}

  Воспользуйтесь методом HTTP API [delete](../../api-ref/delete-platform-application.md) для ресурса PlatformApplications сервиса {{ cns-full-name }}.

{% endlist %}