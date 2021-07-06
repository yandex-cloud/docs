# Удаление потока данных

Чтобы удалить [поток данных](../../concepts/glossary.md#stream-concepts), выполните команду:

{% list tabs %}

- CLI

  ```bash
  aws kinesis delete-stream \
    --endpoint <эндпоинт> \
    --stream-name <идентификатор_потока>
  ```

  * `--endpoint` — [эндпоинт](../aws-stream-full.md) для Amazon Kinesis.
  * `--stream-name` — [идентификатор потока](../aws-stream-full.md) для AWS Kinesis.

  Пример команды:

  ```bash
  aws kinesis delete-stream \
    --endpoint https://yds.serverless.yandexcloud.net \
    --stream-name /ru-central1/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/aws_stream
  ```

{% endlist %}