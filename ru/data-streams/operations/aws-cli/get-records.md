---
title: Чтение данных из потока в AWS CLI
description: Следуя данной инструкции, вы сможете получить данные из потока в AWS CLI.
---

# Чтение данных из потока в AWS CLI

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы получить данные из [потока](../../concepts/glossary.md#stream-concepts) из _первого_ сегмента, выполните команду:

  ```bash
  SHARD_ITERATOR=$(aws kinesis get-shard-iterator \
    --endpoint <эндпоинт> \
    --shard-id shard-000001 \
    --shard-iterator-type LATEST \
    --stream-name <идентификатор_потока> \
    --query 'ShardIterator'| tr -d \")
  aws kinesis get-records \
    --endpoint <эндпоинт> \
    --shard-iterator $SHARD_ITERATOR
  ```

  Где:

  * `--endpoint` — для чтения данных из потока по протоколу AWS Kinesis Data Streams укажите эндпоинт `https://yds.serverless.yandexcloud.net`.
  * `--stream-name` — состоит из зоны доступности, идентификатора каталога, идентификатора базы данных {{ ydb-full-name }} и имени потока.

     >Например, укажите идентификатор потока `/{{ region-id }}/aoeu1kuk2dht********/cc8029jgtuab********/aws_stream`, если:
     >* `aws_stream` — имя потока;
     >* `{{ region-id }}` — регион;
     >* `aoeu1kuk2dht********` — идентификатор каталога;
     >* `cc8029jgtuab********` — идентификатор базы данных {{ ydb-short-name }}.

  Пример команды:

  ```bash
  SHARD_ITERATOR=$(aws kinesis get-shard-iterator \
    --endpoint https://yds.serverless.yandexcloud.net \
    --shard-id shard-000001 \
    --shard-iterator-type LATEST \
    --stream-name /{{ region-id }}/aoeu1kuk2dht********/cc8029jgtuab********/aws_stream 
    --query 'ShardIterator'| tr -d \")
  aws kinesis get-records \
    --endpoint https://yds.serverless.yandexcloud.net \
    --shard-iterator $SHARD_ITERATOR
  ```

  Пример результата:
  ```json
  {
    "Records": [
        {
            "SequenceNumber": "0",
            "Data": "eyJ1c2VyX2lkIjoidXNlcjEiLCJzY29yZSI6MTAwfQ==",
            "PartitionKey": "1"
        },
        {
            "SequenceNumber": "1",
            "Data": "eyJ1c2VyX2lkIjoidXNlcjEiLCJzY29yZSI6MTAwfQ==",
            "PartitionKey": "1"
        },
    ...
  }
  ```
  В примере выше данные в поле `Data` выводятся закодированными в кодировке BASE64, если данные декодировать, то будет выведена строка:

  ```json
    {"user_id":"user1","score":100}
  ```

{% endlist %}
