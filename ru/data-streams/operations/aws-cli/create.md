---
title: "Создание потока данных в AWS CLI"
description: "Следуя данной инструкции, вы сможете создать поток данных в AWS CLI."
---

# Создание потока данных в AWS CLI

{% note warning %}

В данный момент отсутствует поддержка версий AWS CLI с протоколом JSON. Используйте [AWS CLI](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-json-faqs.html#json-protocol-getting-started) до версии `1.29.81`.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы создать [поток данных](../../concepts/glossary.md#stream-concepts), выполните команду:

  ```bash
  aws kinesis create-stream \
    --endpoint <эндпоинт> \
    --stream-name <идентификатор_потока> \
    --shard-count <количество_сегментов>
  ```

  * `--endpoint` — для создания потока, данные в который будут поставляться по протоколу AWS Kinesis Data Streams, укажите эндпоинт `https://yds.serverless.yandexcloud.net`.
  * `--stream-name` — состоит из зоны доступности, идентификатора каталога, идентификатора базы данных {{ ydb-full-name }} и имени потока.

     >Например, укажите идентификатор потока `/{{ region-id }}/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/aws_stream`, если:
     >* `aws_stream` — имя потока;
     >* `{{ region-id }}` — регион;
     >* `aoeu1kuk2dhtaupdb1es` — идентификатор каталога;
     >* `cc8029jgtuabequtgtbv` — идентификатор базы данных {{ ydb-short-name }}.
  * `--shard-count` — количество [сегментов потока данных](../../concepts/glossary.md#shard).

  {% note info %}

  В Amazon Kinesis нельзя указать скорость потока данных, поэтому для совместимости все потоки данных создаются с пропускной способностью сегмента 1 МБ/с и временем хранения 24 часа.

  {% endnote %}

  Пример команды:

  ```bash
  aws kinesis create-stream \
    --endpoint https://yds.serverless.yandexcloud.net \
    --stream-name /{{ region-id }}/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/aws_stream \
    --shard-count 1
  ```

{% endlist %}
