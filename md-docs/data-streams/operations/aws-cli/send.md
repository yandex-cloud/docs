# Отправка данных в поток в AWS CLI

{% note info %}

Вы можете создать триггер, который будет запускать [функцию](../../../functions/concepts/function.md) Cloud Functions или [контейнер](../../../serverless-containers/concepts/container.md) Serverless Containers при отправке данных в поток. Подробнее о [триггере для Data Streams](../../../functions/operations/trigger/data-streams-trigger-create.md).

{% endnote %}

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
  * `--stream-name` — состоит из зоны доступности, идентификатора каталога, идентификатора базы данных Yandex Managed Service for YDB и имени потока.

     >Например, укажите идентификатор потока `/ru-central1/aoeu1kuk2dht********/cc8029jgtuab********/aws_stream`, если:
     >* `aws_stream` — имя потока;
     >* `ru-central1` — регион;
     >* `aoeu1kuk2dht********` — идентификатор каталога;
     >* `cc8029jgtuab********` — идентификатор базы данных YDB.
  * `--cli-binary-format` — формат бинарных объектов.
  * `--data` — передаваемые данные.
  * `--partition-key` — [сегмент](../../concepts/glossary.md#shard) в потоке, в который будут переданы данные.

  Пример команды:

  ```bash
  aws kinesis put-record \
    --endpoint https://yds.serverless.yandexcloud.net \
    --stream-name /ru-central1/aoeu1kuk2dht********/cc8029jgtuab********/aws_stream \
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