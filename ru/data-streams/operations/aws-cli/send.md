# Отправка данных в поток

Чтобы отправить данные в [поток](../../concepts/glossary.md#stream-concepts), выполните команду:

{% list tabs %}

- CLI

  ```bash
  aws kinesis put-record \
    --endpoint <эндпоинт> \
    --stream-name <идентификатор_потока_данных> \
    --cli-binary-format <бинарный_формат> \
    --data <сообщение> \
    --partition-key <ключ_сегмента>
  ```

  * `--endpoint` — [эндпоинт](../aws-stream-full.md) для Amazon Kinesis.
  * `--stream-name` — [идентификатор потока](../aws-stream-full.md) для AWS Kinesis.
  * `--cli-binary-format` — формат бинарных объектов.
  * `--data` — передаваемые данные.
  * `--partition-key` — [сегмент](../../concepts/glossary.md#shard) в потоке, в который будут переданы данные.

  Пример команды:

  ```bash
  aws kinesis put-record \
    --endpoint https://yds.serverless.yandexcloud.net \
    --stream-name /ru-central1/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/aws_stream \
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