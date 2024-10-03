---
title: Инструкция по отправке данных из {{ ydb-full-name }} в поток в AWS CLI
description: Из статьи вы узнаете, как отправить данные из {{ ydb-full-name }} в поток в AWS CLI.
---

# Отправка данных в поток в AWS CLI

{% include [trigger](../../../_includes/data-streams/trigger.md) %}

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы отправить данные в [поток](../../concepts/glossary.md#stream-concepts), выполните команду:

  ```bash
  aws kinesis put-record \
    --endpoint <эндпоинт> \
    --stream-name <идентификатор_потока> \
    --cli-binary-format <бинарный_формат> \
    --data <сообщение> \
    --partition-key <ключ_сегмента>
  ```

  Где:

  * `--endpoint` — для отправки данных в поток по протоколу AWS Kinesis Data Streams укажите эндпоинт `https://yds.serverless.yandexcloud.net`.
  * `--stream-name` — состоит из зоны доступности, идентификатора каталога, идентификатора базы данных {{ ydb-full-name }} и имени потока.

     >Например, укажите идентификатор потока `/{{ region-id }}/aoeu1kuk2dht********/cc8029jgtuab********/aws_stream`, если:
     >* `aws_stream` — имя потока;
     >* `{{ region-id }}` — регион;
     >* `aoeu1kuk2dht********` — идентификатор каталога;
     >* `cc8029jgtuab********` — идентификатор базы данных {{ ydb-short-name }}.
  * `--cli-binary-format` — формат бинарных объектов.
  * `--data` — передаваемые данные.
  * `--partition-key` — [сегмент](../../concepts/glossary.md#shard) в потоке, в который будут переданы данные.

  Пример команды:

  ```bash
  aws kinesis put-record \
    --endpoint https://yds.serverless.yandexcloud.net \
    --stream-name /{{ region-id }}/aoeu1kuk2dht********/cc8029jgtuab********/aws_stream \
    --cli-binary-format raw-in-base64-out \
    --data '{"user_id":"user1", "score": 100}' \
    --partition-key 1
  ```

  Пример результата:

  ```json
  {
    "ShardId": "shard-000001",
    "SequenceNumber": "5851",
    "EncryptionType": "NONE"
  }
  ```

{% endlist %}
