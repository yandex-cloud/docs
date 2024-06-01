---
title: "Получение информации о потоке"
description: "Следуя данной инструкции, вы сможете получить информацию о потоке."
---

# Получение информации о потоке

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы получить описание созданного [потока данных](../../concepts/glossary.md#stream-concepts), выполните команду:

  ```bash
  aws kinesis describe-stream \
    --endpoint <эндпоинт> \
    --stream-name <идентификатор_потока>
  ```

  * `--endpoint` — для получения информации о потоке, данные в который поставляются по протоколу AWS Kinesis Data Streams, укажите эндпоинт `https://yds.serverless.yandexcloud.net`.
  * `--stream-name` — состоит из зоны доступности, идентификатора облака, идентификатора базы данных {{ ydb-full-name }} и имени потока.

    {% include [stream-name-example](../../../_includes/data-streams/stream-name-example.md) %}

  Пример команды:

  ```bash
  aws kinesis describe-stream \
    --endpoint https://yds.serverless.yandexcloud.net \
    --stream-name /{{ region-id }}/b1gvlrnlei4l********/etn780rpm7e5********/default
  ```

  Результат:

  ```json
  {
    "StreamDescription": {
      "Shards": [
      {
        "ShardId": "shard-000000",
        "ParentShardId": "",
        "AdjacentParentShardId": "",
        "HashKeyRange": {
          "StartingHashKey": "0",
          "EndingHashKey": "113427455640312821154458202477256070484"
        },
        "SequenceNumberRange": {
          "StartingSequenceNumber": "0",
          "EndingSequenceNumber": ""
        }
      }],
      "StreamARN": null,
      "StreamName": "aws_stream",
      "StreamStatus": "ACTIVE",
      "RetentionPeriodHours": 24,
      "EnhancedMonitoring": null,
      "EncryptionType": "ENCRYPTION_UNDEFINED",
      "KeyId": "",
      "StreamCreationTimestamp": ""
    }
  }
  ```

{% endlist %}
