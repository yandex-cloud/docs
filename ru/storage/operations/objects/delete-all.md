---
title: Удаление всех объектов из бакета в {{ objstorage-full-name }}
description: Следуя данной инструкции, вы сможете удалить все объекты из бакета в {{ objstorage-name }}.
---

# Удаление всех объектов из бакета

{% include [restore-only-versioning](../../../_includes/storage/restore-only-versioning.md) %}

{% include [auto-delete-all-multipart](../../../_includes/storage/auto-delete-all-multipart.md) %}

Чтобы очистить бакет и не [платить](../../pricing.md) за хранение:

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления объектов:

      ```bash
      yc storage s3api delete-objects --help
      ```

  1. {% include [bucket-list-cli](../../../_includes/storage/bucket-list-cli.md) %}
  1. Подготовьте файл JSON со списком объектов для удаления. Пример наполнения:

      ```json
      {
          "Objects": [
              {
                  "Key": "<ключ_объекта>"
              },
              {
                  "Key": "<ключ_объекта>"
              },
              ...
          ]          
      }
      ```

      Где:

      * `Objects` — массив объектов для удаления.
      * `Key` — [ключ](../../concepts/object.md#key) объекта. 

  1. Выполните команду:

      ```bash
      yc storage s3api delete-objects \
        --bucket <имя_бакета> \
        --delete <путь_к_файлу_json>
      ```

      Где:

      * `--bucket` — имя вашего бакета.
      * `--delete` — путь к файлу JSON со списком объектов для удаления.

      Результат:

      ```bash
      deleted:
        - key: file-1
          version_id: "null"
        - key: file-2
          version_id: "null"
      request_id: 4c35e7d4********
      ```

      Альтернативная команда:

      ```bash
      yc storage s3 rm \
        s3://<имя_бакета>/ \
        --recursive
      ```

      Где `--recursive` — параметр для удаления всех объектов.

      Результат:

      ```text
      delete: s3://my-bucket/object-1.txt
      delete: s3://my-bucket/object-2.txt
      ...
      delete: s3://my-bucket/object-n.txt
      ```

- AWS CLI {#aws-cli}

  Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  {% note info %}

  Команды в этом разделе используют синтаксис [Bash](https://ru.wikipedia.org/wiki/Bash). Если вы работаете в Windows, [ознакомьтесь](../../../overview/concepts/console-syntax-guide.md) с особенностями работы с Bash в Microsoft Windows и используйте [Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/ru-ru/windows/wsl/install), [Git Bash](https://git-scm.com/install/windows) или другой bash-совместимый терминал.

  {% endnote %}

  1. Создайте переменную с именем бакета:

     ```bash
     BUCKET_NAME=<имя_бакета>
     ```

  1. Удалите все версии объектов из бакета:

     ```bash
     aws s3api delete-objects \
       --endpoint-url https://{{ s3-storage-host }} \
       --bucket $BUCKET_NAME \
       --delete \
         "$(aws s3api list-object-versions \
           --endpoint-url https://{{ s3-storage-host }} \
           --bucket $BUCKET_NAME \
           --query '{Objects: Versions[].{Key: Key, VersionId: VersionId}}' \
           --max-items 1000)"
     ```

     Параметр `--max-items` задает количество версий объектов, которые команда передает за один запрос. Значение не может превышать `1000`, потому что `delete-objects` принимает не более 1000 ключей за один раз.

     Если параметр `--max-items` вызывает ошибку, можно использовать `--max-keys`. Оба параметра приводят к одинаковому результату, но `--max-items` работает на стороне клиента, а `--max-keys` — на стороне сервера.

     Если нужно удалить больше 1000 версий объектов, повторите команду несколько раз.

     Результат:

     ```json
     {
         "Deleted": [
             {
                 "Key": "object_000",
                 "VersionId": "0005CDD3********"
             },
             {
                 "Key": "object_001",
                 "VersionId": "0005CDD3********"
             },
             ...
         ]
     }
     ```

  1. Если для бакета включено [версионирование](../../concepts/versioning.md), удалите все delete-маркеры:

     ```bash
     aws s3api delete-objects \
       --endpoint-url https://{{ s3-storage-host }} \
       --bucket $BUCKET_NAME \
       --delete \
         "$(aws s3api list-object-versions \
           --endpoint-url https://{{ s3-storage-host }} \
           --bucket $BUCKET_NAME \
           --query '{Objects: DeleteMarkers[].{Key: Key, VersionId: VersionId}}' \
           --max-items 1000)"
     ```

     Параметр `--max-items` задает количество delete-маркеров, которые команда передает за один запрос. Значение не может превышать `1000`, потому что `delete-objects` принимает не более 1000 ключей за один раз.

     Если параметр `--max-items` вызывает ошибку, можно использовать `--max-keys`. Оба параметра приводят к одинаковому результату, но `--max-items` работает на стороне клиента, а `--max-keys` — на стороне сервера.

     Если нужно удалить больше 1000 delete-маркеров, повторите команду несколько раз.

     Результат:

     ```json
     {
         "Deleted": [
             {
                 "Key": "object_034",
                 "DeleteMarker": true,
                 "DeleteMarkerVersionId": "0005CDD3********"
             },
             {
                 "Key": "object_057",
                 "DeleteMarker": true,
                 "DeleteMarkerVersionId": "0005CDD3********"
             },
             ...
         ]
     }
     ```

  1. Удалите частично загруженные объекты:

     ```bash
     aws s3api list-multipart-uploads \
       --endpoint-url https://{{ s3-storage-host }} \
       --bucket $BUCKET_NAME \
     | jq -r '.Uploads[] | "--key \"\(.Key)\" --upload-id \(.UploadId)"' \
     | while read -r line; do
       eval 
         "aws s3api abort-multipart-upload \
           --endpoint-url https://{{ s3-storage-host }} \
           --bucket $BUCKET_NAME \
           $line";
     done
     ```

  1. Получите список частей объектов, оставшихся в бакете:

     ```bash
     aws s3api list-multipart-uploads \
       --endpoint-url https://{{ s3-storage-host }} \
       --bucket $BUCKET_NAME \
     | jq -r '.Uploads[] | "--key \"\(.Key)\" --upload-id \(.UploadId)"' \
     | while read -r line; do
       eval 
         "aws s3api list-parts \
           --endpoint-url https://{{ s3-storage-host }} \
           --bucket $BUCKET_NAME \
           $line";
     done
     ```

     В списке могут оказаться части объектов, загрузка которых началась до выполнения предыдущего шага и закончилась после него. Если список не пуст, повторите шаги 4–5.

- Python (boto3) {#boto3}

  Выполните следующий код:

  ```python
  import boto3

  bucket_name = '<имя_бакета>'
  s3 = boto3.resource('s3',
      endpoint_url='https://{{ s3-storage-host }}',
      aws_access_key_id='<идентификатор_ключа>',
      aws_secret_access_key='<секретный_ключ>')
  bucket = s3.Bucket(bucket_name)

  # Deleting all versions (works for non-versioned buckets too).
  bucket.object_versions.delete()

  # Aborting all multipart uploads, which also deletes all parts.
  for multipart_upload in bucket.multipart_uploads.iterator():
      # Part uploads that are currently in progress may or may not succeed,
      # so it might be necessary to abort a multipart upload multiple times.
      while len(list(multipart_upload.parts.all())) > 0:
          multipart_upload.abort()
  ```

- API {#api}

  Воспользуйтесь методом S3 API [deleteMultipleObjects](../../s3/api-ref/object/deletemultipleobjects.md).

{% endlist %}

В консоли управления информация о количестве объектов в бакете и занятом месте обновляется с задержкой в несколько минут.
