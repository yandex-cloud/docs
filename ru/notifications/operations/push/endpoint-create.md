---
title: Создать эндпоинт в {{ cns-full-name }}
description: Следуя этой инструкции, вы сможете создать эндпоинт.
---

# Создать эндпоинт

Каждый канал имеет свою базу [эндпоинтов](../../concepts/index.md#mobile-endpoints) для отправки уведомлений напрямую в приложение на устройства пользователей.

Чтобы создать эндпоинт:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится эндпоинт.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Выберите канал push-уведомлений.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.cns.label_endpoints }}**.
  1. Нажмите **{{ ui-key.yacloud.cns.action_create-endpoint }}**.
  1. Введите **{{ ui-key.yacloud.cns.field_token }}** — уникальный токен на устройстве пользователя, созданный сервисом уведомлений для приложения.
  1. (опционально) Введите **{{ ui-key.yacloud.cns.field_endpoint-user-data }}** — текст длиной до 2048 символов в кодировке [UTF-8](https://ru.wikipedia.org/wiki/UTF-8).
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../../storage/tools/aws-cli.md).
  1. Выполните команду:

      {% include [endpoint-create-aws](../../../_includes/notifications/endpoint-create-aws.md) %}

- AWS SDK для Python (boto3) {#python}

  1. Если у вас еще нет AWS SDK для Python (boto3), [установите и настройте его](../../tools/sdk-python.md#aws-sdk).
  1. Чтобы создать эндпоинт, используйте следующий код:

      {% include [endpoint-create-python](../../../_includes/notifications/endpoint-create-python.md) %}

- AWS SDK для PHP {#php}

  1. Если у вас еще нет AWS SDK для PHP, [установите и настройте его](../../tools/sdk-php.md#aws-sdk).
  1. Чтобы создать эндпоинт, используйте следующий код:

      {% include [endpoint-create-php](../../../_includes/notifications/endpoint-create-php.md) %}


- API {#api}

  Воспользуйтесь методом HTTP API [create](../../api-ref/create-platform-endpoint.md) для ресурса Endpoint сервиса {{ cns-full-name }}.

{% endlist %}

Создание эндпоинта может занять некоторое время.
