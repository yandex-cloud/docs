---
title: Создать топик в {{ cns-full-name }}
description: Следуя этой инструкции, вы сможете создать топик.
---

# Создать топик

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [topic-create-ui](../../../_includes/notifications/topic-create-ui.md) %}

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../../storage/tools/aws-cli.md).
  1. Выполните команду:

     {% include [topic-create-cli](../../../_includes/notifications/topic-create-cli.md) %}

- AWS SDK для Python {#python}

  1. Если у вас еще нет AWS SDK для Python (boto3), [установите и настройте его](../../tools/sdk-python.md#aws-sdk).
  1. Чтобы создать топик, используйте следующий код:

     {% include [topic-create-python](../../../_includes/notifications/topic-create-python.md) %}

{% endlist %}

После создания топика изменить его имя невозможно. Для добавления в топик эндпоинтов [создайте подписки](subscription-create.md).