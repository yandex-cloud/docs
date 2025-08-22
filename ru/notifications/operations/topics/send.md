---
title: Создать топик в {{ cns-full-name }}
description: Следуя этой инструкции, вы сможете отправить уведомление всем эндпоинтам, подписанным на топик.
---

# Отправить уведомление в топик

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [publish-ui](../../../_includes/notifications/publish-ui.md) %}

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../../storage/tools/aws-cli.md).
  1. Выполните команду:

     {% include [publish-cli](../../../_includes/notifications/publish-cli.md) %}

- AWS SDK для Python {#python}

  1. Если у вас еще нет AWS SDK для Python (boto3), [установите и настройте его](../../tools/sdk-python.md#aws-sdk).
  1. Чтобы создать канал push-уведомлений, используйте следующий код:

     {% include [publish-python](../../../_includes/notifications/publish-python.md) %}

{% endlist %}