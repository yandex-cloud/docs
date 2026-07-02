[Документация Yandex Cloud](../../../index.md) > [Yandex Data Streams](../../index.md) > [Пошаговые инструкции](../index.md) > Работа с AWS CLI > Удаление потока данных

# Удаление потока данных в AWS CLI

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы удалить [поток данных](../../concepts/glossary.md#stream-concepts), выполните команду:

  ```bash
  aws kinesis delete-stream \
    --endpoint <эндпоинт> \
    --stream-name <идентификатор_потока>
  ```

  * `--endpoint` — для удаления потока, данные в который поставляются по протоколу AWS Kinesis Data Streams, укажите эндпоинт `https://yds.serverless.yandexcloud.net`.
  * `--stream-name` — состоит из зоны доступности, идентификатора каталога, идентификатора базы данных Yandex Managed Service for YDB и имени потока.

     >Например, укажите идентификатор потока `/ru-central1/aoeu1kuk2dht********/cc8029jgtuab********/aws_stream`, если:
     >* `aws_stream` — имя потока;
     >* `ru-central1` — регион;
     >* `aoeu1kuk2dht********` — идентификатор каталога;
     >* `cc8029jgtuab********` — идентификатор базы данных YDB.

  Пример команды:

  ```bash
  aws kinesis delete-stream \
    --endpoint https://yds.serverless.yandexcloud.net \
    --stream-name /ru-central1/aoeu1kuk2dht********/cc8029jgtuab********/aws_stream
  ```

{% endlist %}