[Документация Yandex Cloud](../../../index.md) > [Yandex Data Streams](../../index.md) > [Пошаговые инструкции](../index.md) > Работа с AWS CLI > Получение информации о потоке

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
  * `--stream-name` — состоит из зоны доступности, идентификатора облака, идентификатора базы данных Yandex Managed Service for YDB и имени потока.

    >Например, укажите идентификатор потока `/ru-central1/b1gvlrnlei4l********/etn780rpm7e5********/default`, если:
     >* `ru-central1` — регион;
     >* `b1gvlrnlei4l********` — идентификатор облака;
     >* `etn780rpm7e5********` — идентификатор базы данных YDB;
     >* `default` — имя потока.

  Пример команды:

  ```bash
  aws kinesis describe-stream \
    --endpoint https://yds.serverless.yandexcloud.net \
    --stream-name /ru-central1/b1gvlrnlei4l********/etn780rpm7e5********/default
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