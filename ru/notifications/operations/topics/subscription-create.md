---
title: Создать подписку в {{ cns-full-name }}
description: Следуя этой инструкции, вы сможете подписать эндпоинт на уведомления в топике.
---

# Создать подписку

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится топик.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Слева выберите раздел **{{ ui-key.yacloud.cns.local.label_topics_vhBR3 }}**.
  
  {% include [subscribe-ui](../../../_includes/notifications/subscribe-ui.md) %}

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../../storage/tools/aws-cli.md).
  1. Выполните команду:

     {% include [subscribe-cli](../../../_includes/notifications/subscribe-cli.md) %}

- AWS SDK для Python {#python}

  1. Если у вас еще нет AWS SDK для Python (boto3), [установите и настройте его](../../tools/sdk-python.md#aws-sdk).
  1. Чтобы подписать эндпоинт на уведомления в топике, используйте следующий код:
     
     {% include [subscribe-python](../../../_includes/notifications/subscribe-python.md) %}

{% endlist %}