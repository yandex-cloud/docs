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
  * `--stream-name` — состоит из зоны доступности, идентификатора облака, идентификатора базы данных {{ ydb-full-name }} и имени потока.

     >Например, укажите идентификатор потока `/{{ region-id }}/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/aws_stream`, если:
     >* `aws_stream` — имя потока;
     >* `{{ region-id }}` — регион;
     >* `aoeu1kuk2dhtaupdb1es` — идентификатор облака;
     >* `cc8029jgtuabequtgtbv` — идентификатор базы данных {{ ydb-short-name }}.

  Пример команды:

  ```bash
  aws kinesis delete-stream \
    --endpoint https://yds.serverless.yandexcloud.net \
    --stream-name /{{ region-id }}/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/aws_stream
  ```

{% endlist %}
