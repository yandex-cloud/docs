---
title: "Удаление потока данных в AWS CLI"
description: "Следуя данной инструкции, вы сможете удалить поток данных в AWS CLI."
---

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
  * `--stream-name` — состоит из зоны доступности, идентификатора каталога, идентификатора базы данных {{ ydb-full-name }} и имени потока.

     >Например, укажите идентификатор потока `/{{ region-id }}/aoeu1kuk2dht********/cc8029jgtuab********/aws_stream`, если:
     >* `aws_stream` — имя потока;
     >* `{{ region-id }}` — регион;
     >* `aoeu1kuk2dht********` — идентификатор каталога;
     >* `cc8029jgtuab********` — идентификатор базы данных {{ ydb-short-name }}.

  Пример команды:

  ```bash
  aws kinesis delete-stream \
    --endpoint https://yds.serverless.yandexcloud.net \
    --stream-name /{{ region-id }}/aoeu1kuk2dht********/cc8029jgtuab********/aws_stream
  ```

{% endlist %}
