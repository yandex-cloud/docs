---
title: Создать топик в {{ cns-full-name }}
description: Следуя этой инструкции, вы сможете отправить уведомление всем эндпоинтам, подписанным на топик.
---

# Отправить уведомление в топик

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится топик.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Слева выберите раздел **{{ ui-key.yacloud.cns.local.label_topics_vhBR3 }}**.
  
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