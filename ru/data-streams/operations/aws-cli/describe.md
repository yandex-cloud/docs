---
title: "Получение информации о потоке"
description: "Следуя данной инструкции, вы сможете получить информацию о потоке."
---

# Получение информации о потоке

{% list tabs %}

- CLI

  Чтобы получить описание созданного [потока данных](../../concepts/glossary.md#stream-concepts), выполните команду:

  ```bash
  aws kinesis describe-stream \
    --endpoint <эндпоинт> \
    --stream-name <идентификатор_потока>
  ```

  * `--endpoint` — для получения информации о потоке, данные в который поставляются по протоколу AWS Kinesis Data Streams, укажите эндпоинт `https://yds.serverless.yandexcloud.net`.
  * `--stream-name` — состоит из зоны доступности, идентификатора каталога, идентификатора базы данных {{ ydb-full-name }} и имени потока.

     >Например, укажите идентификатор потока `/{{ region-id }}/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/aws_stream`, если:
     >* `aws_stream` — имя потока;
     >* `{{ region-id }}` — регион;
     >* `aoeu1kuk2dhtaupdb1es` — идентификатор каталога;
     >* `cc8029jgtuabequtgtbv` — идентификатор базы данных {{ ydb-short-name }}.

  Пример команды:

  ```bash
  aws kinesis describe-stream \
    --endpoint https://yds.serverless.yandexcloud.net \
    --stream-name /{{ region-id }}/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/aws_stream
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
