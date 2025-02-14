---
title: Создать канал push-уведомлений в {{ cns-full-name }}
description: Следуя этой инструкции, вы сможете создать канал push-уведомлений.
---

# Создать канал push-уведомлений

В {{ cns-name }} сообщения конечным пользователям отправляются через [каналы уведомлений](../../concepts/index.md#channels).

Чтобы создать канал:

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [push-channel-create](../../../_includes/notifications/push-channel-create.md) %}

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../../storage/tools/aws-cli.md).
  1. Выполните команду:

      {% include [push-channel-create-aws](../../../_includes/notifications/push-channel-create-aws.md) %}

- AWS SDK для Python (boto3) {#python}

  1. Если у вас еще нет AWS SDK для Python (boto3), [установите и настройте его](../../tools/sdk-python.md#aws-sdk).
  1. Чтобы создать канал push-уведомлений, используйте следующий код:

      {% include [push-channel-create-python](../../../_includes/notifications/push-channel-create-python.md) %}

- AWS SDK для PHP {#php}

  1. Если у вас еще нет AWS SDK для PHP, [установите и настройте его](../../tools/sdk-php.md#aws-sdk).
  1. Чтобы создать канал push-уведомлений, используйте следующий код:

      {% include [push-channel-create-php](../../../_includes/notifications/push-channel-create-php.md) %}

- API {#api}

  Воспользуйтесь методом HTTP API [create](../../api-ref/create-platform-application.md) для ресурса PlatformApplications сервиса {{ cns-full-name }}.

{% endlist %}

Создание канала уведомлений может занять некоторое время.