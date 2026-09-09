---
title: Аутентификация и соединение с БД по HTTP API, совместимому с Amazon SQS
description: Следуя данной инструкции, вы сможете аутентифицироваться и установить соединение с БД по HTTP API, совместимому с Amazon SQS.
---

# Аутентификация и соединение с БД по HTTP API, совместимому с Amazon SQS

## Эндпоинт {#endpoint}

Эндпоинт подключения отображается в [консоли управления]({{ link-console-main }}), на странице базы данных. Эндпоинт одинаковый для протоколов Amazon Kinesis Data Streams и Amazon Simple Queue Service (SQS).

## Предварительные требования {#requirements}

Для аутентификации требуется:

1. [Создать сервисный аккаунт](../../iam/operations/sa/create.md).
1. [Назначить сервисному аккаунту роли](../../iam/operations/sa/assign-role-for-sa.md):
   * Для чтения из потока данных: `ydb.viewer`.
   * Для записи в поток данных: `ydb.editor`.
   * Для создания и удаления очереди: `ydb.editor`.
1. [Создать статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key) для сервисного аккаунта. Надежно сохраните идентификатор и секретный ключ.

## Аутентификация {#auth}

В HTTP API, совместимом с Amazon SQS, аутентификация выполняется через [подпись запросов Signature Version 4](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-api-request-authentication.html), как в Amazon SQS.

Для этого необходимы:

* `<access_key_id>` — идентификатор [статического ключа доступа](../../iam/concepts/authorization/access-key.md).
* `<secret_access_key>` — секретная часть статического ключа доступа.

Настройте AWS CLI:

{% include [configure-aws-cli](../../_includes/message-queue/configure-aws-cli.md) %}

## Пример создания очереди {#create-queue}

В примере используются:

* `<sqs_api_endpoint>` — [эндпоинт](#endpoint).
* `<stream_name>` — имя создаваемого [потока данных](../concepts/glossary.md#stream-concepts).

1. Установите [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html), если он еще не установлен.

1. Создайте очередь:

   ```bash
   aws --endpoint "<sqs_api_endpoint>" sqs create-queue \
     --queue-name "<stream_name>"
   ```

   Будет создан поток данных с указанным именем и разделяемым (общим) читателем `ydb-sqs-consumer`.

   Для создания FIFO-очереди укажите атрибут `FifoQueue=true`. Имя такой очереди рекомендуется заканчивать на `.fifo`:

   ```bash
   aws --endpoint "<sqs_api_endpoint>" sqs create-queue \
     --queue-name "<stream_name>.fifo" \
     --attributes FifoQueue=true
   ```

## Пример записи и чтения сообщения {#example}

В примере используются:

* `<sqs_api_endpoint>` — [эндпоинт](#endpoint).
* `<stream_name>` — имя [потока данных](../concepts/glossary.md#stream-concepts).

1. Установите [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html), если он еще не установлен.

1. Получите `QueueUrl` потока:

   ```bash
   QUEUE_URL="$(aws --endpoint "<sqs_api_endpoint>" sqs get-queue-url \
     --queue-name "<stream_name>" \
     --query 'QueueUrl' --output text)"
   ```

1. Отправьте сообщение в поток:

   ```bash
   aws --endpoint "<sqs_api_endpoint>" sqs send-message \
     --queue-url "$QUEUE_URL" \
     --message-body "test message"
   ```

1. Прочитайте сообщение из потока:

   ```bash
   aws --endpoint "<sqs_api_endpoint>" sqs receive-message \
     --queue-url "$QUEUE_URL" \
     --wait-time-seconds 20 \
     --max-number-of-messages 1
   ```

Основную документацию по работе с {{ yds-name }} через HTTP API, совместимый с Amazon SQS, и больше примеров читайте в [документации YDB]({{ ydb.docs }}/reference/sqs-api/?version=v26.3).
