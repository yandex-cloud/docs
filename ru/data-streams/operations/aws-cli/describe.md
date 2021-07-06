# Получение описания потока

Чтобы получить описание созданного [потока данных](../../concepts/glossary.md#stream-concepts), выполните команду:

{% list tabs %}

- CLI

  ```bash
  aws kinesis describe-stream \
    --endpoint <эндпоинт> \
    --stream-name <идентификатор_потока>
  ```

  * `--endpoint` — [эндпоинт](../aws-stream-full.md) для Amazon Kinesis.
  * `--stream-name` — [идентификатор потока](../aws-stream-full.md) для AWS Kinesis.

  Пример команды:

  ```bash
  aws kinesis describe-stream \
    --endpoint https://yds.serverless.yandexcloud.net \
    --stream-name /ru-central1/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/aws_stream
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