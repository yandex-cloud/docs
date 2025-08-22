---
title: Как начать работать с топиками в {{ cns-full-name }}
description: В {{ cns-name }} вы можете отправлять уведомления различным эндпоинтам, подписанным на топик.
---

# Как начать работать с топиками в {{ cns-full-name }}

{% include [preview-stage](../_includes/notifications/preview-stage.md) %}

{% include [ask-for-turning-on](../_includes/notifications/ask-for-turning-on.md) %}

{% include [about-service](../_includes/notifications/about-service.md) %}

Чтобы отправлять сообщения в разные эндпоинты одновременно, используйте топики. _Топик_ позволяет отправлять уведомления сразу всем подписанным на него эндпоинтам.

Чтобы начать работать с топиками:

1. [Подготовьте облако к работе](#before-you-begin)
1. Создайте каналы для уведомлений и эндпоинты: 
   
   * [Мобильные push-уведомления](quickstart-push.md)
   * [Push-уведомления в браузере](quickstart-browser.md)
   * [SMS](quickstart-sms.md) 
      Для SMS можно не добавлять телефонные номера в канале, а добавить их сразу в топике.

1. [Создайте топик](#create-topic)
1. [Подпишите эндпоинты на топик](#subscribe-endpoints)
1. [Отправьте уведомление в топик](#send-message)

# Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Создайте топик {#create-topic}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [topic-create-ui](../_includes/notifications/topic-create-ui.md) %}

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../storage/tools/aws-cli.md).
  1. Выполните команду:

     {% include [topic-create-cli](../_includes/notifications/topic-create-cli.md) %}

- AWS SDK для Python {#python}

  1. Если у вас еще нет AWS SDK для Python (boto3), [установите и настройте его](tools/sdk-python.md#aws-sdk).
  1. Чтобы создать канал push-уведомлений, используйте следующий код:

     {% include [topic-create-python](../_includes/notifications/topic-create-python.md) %}

{% endlist %}

## Подпишите эндпоинты на топик {#subscribe-endpoints}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [topic-create-ui](../_includes/notifications/subscribe-ui.md) %}

- AWS CLI {#aws-cli}

   Выполните команду:

   {% include [topic-create-cli](../_includes/notifications/subscribe-cli.md) %}

- AWS SDK для Python {#python}

  Используйте следующий код:

  {% include [topic-create-python](../_includes/notifications/subscribe-python.md) %}

{% endlist %}

## Отправьте уведомление в топик {#send-message}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [topic-create-ui](../_includes/notifications/publish-ui.md) %}

- AWS CLI {#aws-cli}

  Выполните команду:

  {% include [publish-cli](../_includes/notifications/publish-cli.md) %}

- AWS SDK для Python {#python}

  Используйте следующий код:

  {% include [topic-create-python](../_includes/notifications/publish-python.md) %}

{% endlist %}