---
title: Управление пользовательскими метаданными объекта в {{ objstorage-full-name }}
description: Следуя данной инструкции, вы сможете управлять пользовательскими метаданными объекта в бакете в {{ objstorage-name }}.
---

# Управление пользовательскими метаданными объекта

При загрузке объекта в {{ objstorage-name }} вместе с ним вы можете передавать набор [пользовательских метаданных](../../concepts/object.md#user-meta) в виде пар `ключ-значение`.


## Загрузить объект с метаданными {#load-object-with-meta}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для загрузки объекта:

      ```bash
      yc storage s3api put-object --help
      ```

  1. {% include [bucket-list-cli](../../../_includes/storage/bucket-list-cli.md) %}
  1. Выполните команду:

      ```bash
      yc storage s3api put-object \
        --bucket <имя_бакета> \
        --key <ключ_объекта> \
        --body <путь_к_локальному_файлу> \
        --metadata "<ключ_1>"="<значение_1>","<ключ_2>"="<значение_2>"
      ```

      Где:

      * `--bucket` — имя бакета, в который вы хотите загрузить объект.
      * `--key` — [ключ](../../concepts/object.md#key) объекта в бакете.
      * `--body` — путь к локальному файлу, который вы хотите загрузить в бакет.
      * `--metadata` — набор пользовательских метаданных в виде пар `ключ-значение`, указанных через запятую. Ключи должны состоять только из [ASCII-символов](https://{{ lang }}.wikipedia.org/wiki/ASCII). Размер значения не должен превышать 2 КБ.

      Результат:

      ```text
      etag: '"65187664ed291179f9244d61********"'
      request_id: 3eca0fd2********
      ```

- AWS CLI {#aws-cli}

  Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  В терминале выполните команду:

  ```bash
  aws s3api put-object \
    --bucket <имя_бакета> \
    --key <ключ_объекта> \
    --body <путь_к_локальному_файлу> \
    --metadata "<ключ_1>"="<значение_1>","<ключ_2>"="<значение_2>" \
    --endpoint-url=https://{{ s3-storage-host }}
  ```

  Где:

  * `--bucket` — имя бакета, в который вы хотите загрузить объект.
  * `--key` — [ключ](../../concepts/object.md#key) объекта в бакете.
  * `--body` — путь к локальному файлу, который вы хотите загрузить в бакет.
  * `--metadata` — набор пользовательских метаданных в виде пар `ключ-значение`, указанных через запятую. Ключи должны состоять только из [ASCII-символов](https://{{ lang }}.wikipedia.org/wiki/ASCII). Размер значения не должен превышать 2 КБ.
  * `--endpoint-url` — эндпоинт {{ objstorage-name }}.

  Результат:

  ```text
  {
    "ETag": "\"65187664ed291179f9244d61********\""
  }
```

- API {#api}

  Воспользуйтесь методом S3 API [upload](../../s3/api-ref/object/upload.md), например, с помощью утилиты `curl`.

  Используйте `curl` версии [8.3.0](https://curl.se/changes.html) и выше. Подробнее см. [Пример использования AWS S3 API](../../api-ref/authentication.md#s3-api-example).

  ```bash
  AWS_KEY_ID="<идентификатор_статического_ключа>"
  AWS_SECRET_KEY="<секретный_ключ>"
  LOCAL_FILE="<путь_к_локальному_файлу>"
  BUCKET_NAME="<имя_бакета>"
  OBJECT_PATH="<ключ_объекта>"
  META_KEY_1="<ключ_1>"
  META_VALUE_1="<значение_1>"
  META_KEY_2="<ключ_2>"
  META_VALUE_2="<значение_2>"

  curl \
    --request PUT \
    --user "${AWS_KEY_ID}:${AWS_SECRET_KEY}" \
    --aws-sigv4 "aws:amz:{{ region-id }}:s3" \
    --upload-file "${LOCAL_FILE}" \
    --header "X-Amz-Meta-${META_KEY_1}: ${META_VALUE_1}" \
    --header "X-Amz-Meta-${META_KEY_2}: ${META_VALUE_2}" \
    --verbose \
    "https://{{ s3-storage-host }}/${BUCKET_NAME}/${OBJECT_PATH}"
  ```

  Где:

  * `AWS_KEY_ID` — [идентификатор](../../../iam/concepts/authorization/access-key.md#key-id) статического ключа доступа.
  * `AWS_SECRET_KEY` — [секретный ключ](../../../iam/concepts/authorization/access-key.md#private-key).
  * `LOCAL_FILE` — путь к локальному файлу, который вы хотите загрузить в бакет.
  * `BUCKET_NAME` — имя бакета, в который вы хотите загрузить объект.
  * `OBJECT_PATH` — [ключ](../../concepts/object.md#key) объекта в бакете.
  * `META_KEY_1` и `META_KEY_1` — ключи пользовательских метаданных. Ключи должны состоять только из [ASCII-символов](https://{{ lang }}.wikipedia.org/wiki/ASCII).
  * `META_VALUE_1` и `META_VALUE_2` — значения пользовательских метаданных. Размер значения не должен превышать 2 КБ.

{% endlist %}


## Получить метаданные объекта {#get-object-meta}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения метаданных объекта:

      ```bash
      yc storage s3api head-object --help
      ```

  1. {% include [bucket-list-cli](../../../_includes/storage/bucket-list-cli.md) %}
  1. Получите список объектов в бакете:

      ```bash
      yc storage s3api list-objects \
        --bucket <имя_бакета>
      ```

      Результат:

      ```text
      contents:
        - key: object-1.txt
          last_modified: "2025-04-28T11:04:42.796Z"
          etag: '"e807f1fcf82d132f9bb018ca********"'
          size: "10"
          owner:
            id: aje9k8luj4qf********
            display_name: aje9k8luj4qf********
          storage_class: STANDARD
        ...
      name: first-bucket
      max_keys: "1000"
      key_count: "9"
      request_id: 8e85efa1********
      ```

  1. Выполните команду:

      ```bash
      yc storage s3api head-object \
        --bucket <имя_бакета> \
        --key <ключ_объекта>
      ```

      Где:

      * `--bucket` — имя бакета, в котором размещен объект.
      * `--key` — [ключ](../../concepts/object.md#key) объекта в бакете.

      Результат:

      ```bash
      etag: '"d41d8cd98f00b204e9800998********"'
      request_id: 6428ce25********
      accept_ranges: bytes
      content_type: application/octet-stream
      last_modified_at: "2024-10-08T12:36:36Z"
      server_side_encryption: aws:kms
      sse_kms_key_id: abj497vtg3h0********
      ```

- AWS CLI {#aws-cli}

  Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  В терминале выполните команду:

  ```bash
  aws s3api head-object \
    --bucket <имя_бакета> \
    --key <ключ_объекта> \
    --endpoint-url=https://{{ s3-storage-host }}
  ```

  Где:

  * `--bucket` — имя бакета, в котором размещен объект.
  * `--key` — [ключ](../../concepts/object.md#key) объекта в бакете.
  * `--endpoint-url` — эндпоинт {{ objstorage-name }}.

  Результат:

  ```text
  {
      "AcceptRanges": "bytes",
      "LastModified": "2025-04-28T11:47:10+00:00",
      "ContentLength": 812,
      "ETag": "\"65187664ed291179f9244d61********\"",
      "ContentType": "application/octet-stream",
      "Metadata": {
          "Key1": "val1",
          "Key2": "val2"
      }
  }
  ```

- API {#api}

  Воспользуйтесь методом S3 API [getObjectMeta](../../s3/api-ref/object/getobjectmeta.md), например, с помощью утилиты `curl`.

  Используйте `curl` версии [8.3.0](https://curl.se/changes.html) и выше. Подробнее см. [Пример использования AWS S3 API](../../api-ref/authentication.md#s3-api-example).

  ```bash
  AWS_KEY_ID="<идентификатор_статического_ключа>"
  AWS_SECRET_KEY="<секретный_ключ>"
  BUCKET_NAME="<имя_бакета>"
  OBJECT_PATH="<ключ_объекта>"

  curl \
    --head \
    --user "${AWS_KEY_ID}:${AWS_SECRET_KEY}" \
    --aws-sigv4 "aws:amz:{{ region-id }}:s3" \
    "https://{{ s3-storage-host }}/${BUCKET_NAME}/${OBJECT_PATH}"
  ```

  Где:

  * `AWS_KEY_ID` — [идентификатор](../../../iam/concepts/authorization/access-key.md#key-id) статического ключа доступа.
  * `AWS_SECRET_KEY` — [секретный ключ](../../../iam/concepts/authorization/access-key.md#private-key).
  * `BUCKET_NAME` — имя бакета, в котором размещен объект.
  * `OBJECT_PATH` — [ключ](../../concepts/object.md#key) объекта в бакете.

{% endlist %}


## Изменить метаданные объекта {#update-object-meta}

{% note warning %}

Существующий набор пользовательских метаданных будет полностью перезаписан новым.

{% endnote %}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для копирования объекта:

      ```bash
      yc storage s3api copy-object --help
      ```

  1. {% include [bucket-list-cli](../../../_includes/storage/bucket-list-cli.md) %}
  1. Получите список объектов в бакете:

      ```bash
      yc storage s3api list-objects \
        --bucket <имя_бакета>
      ```

      Результат:

      ```text
      contents:
        - key: object-1.txt
          last_modified: "2025-04-28T11:04:42.796Z"
          etag: '"e807f1fcf82d132f9bb018ca********"'
          size: "10"
          owner:
            id: aje9k8luj4qf********
            display_name: aje9k8luj4qf********
          storage_class: STANDARD
        ...
      name: first-bucket
      max_keys: "1000"
      key_count: "9"
      request_id: 8e85efa1********
      ```

  1. Выполните команду:

      ```bash
      yc storage s3api copy-object \
        --bucket <имя_бакета> \
        --key <ключ_объекта> \
        --copy-source <имя_бакета>/<ключ_объекта> \
        --metadata "<ключ_1>"="<значение_1>","<ключ_2>"="<значение_2>" \
        --metadata-directive REPLACE
      ```

      Где:

      * `--bucket` — имя бакета, в котором вы хотите изменить метаданные объекта.
      * `--key` — [ключ](../../concepts/object.md#key) объекта в бакете.
      * `--copy-source` — путь к объекту в формате `<имя_бакета>/<ключ_объекта>`.
      * `--metadata` — набор новых пользовательских метаданных в виде пар `ключ-значение`, указанных через запятую. Ключи должны состоять только из [ASCII-символов](https://{{ lang }}.wikipedia.org/wiki/ASCII). Размер значения не должен превышать 2 КБ.
      * `--metadata-directive` — параметр, который указывает, что нужно заменить метаданные объекта на новые.

      Результат:

      ```text
      copy_object_result:
        etag: '"65187664ed291179f9244d61********"'
        last_modified_at: "2025-04-28T11:47:10.351Z"
      request_id: 8b7e94df********
      copy_source_version_id: "null"
      ```

- AWS CLI {#aws-cli}

  Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  В терминале выполните команду:

  ```bash
  aws s3api copy-object \
    --bucket <имя_бакета> \
    --key <ключ_объекта> \
    --copy-source <имя_бакета>/<ключ_объекта> \
    --metadata "<ключ_1>"="<значение_1>","<ключ_2>"="<значение_2>" \
    --metadata-directive REPLACE \
    --endpoint-url=https://{{ s3-storage-host }}
  ```

  Где:

  * `--bucket` — имя бакета, в котором вы хотите изменить метаданные объекта.
  * `--key` — [ключ](../../concepts/object.md#key) объекта в бакете.
  * `--copy-source` — путь к объекту в формате `<имя_бакета>/<ключ_объекта>`.
  * `--metadata` — набор новых пользовательских метаданных в виде пар `ключ-значение`, указанных через запятую. Ключи должны состоять только из [ASCII-символов](https://{{ lang }}.wikipedia.org/wiki/ASCII). Размер значения не должен превышать 2 КБ.
  * `--metadata-directive` — параметр, который указывает, что нужно заменить метаданные объекта на новые.
  * `--endpoint-url` — эндпоинт {{ objstorage-name }}.

  Результат:

  ```text
  {
    "CopySourceVersionId": "null",
    "CopyObjectResult": {
        "ETag": "\"65187664ed291179f9244d61********\"",
        "LastModified": "2025-04-28T11:47:10.351000+00:00"
    }
  }
  ```

- API {#api}

  Воспользуйтесь методом S3 API [copy](../../s3/api-ref/object/copy.md), например, с помощью утилиты `curl`.

  Используйте `curl` версии [8.3.0](https://curl.se/changes.html) и выше. Подробнее см. [Пример использования AWS S3 API](../../api-ref/authentication.md#s3-api-example).

  ```bash
  AWS_KEY_ID="<идентификатор_статического_ключа>"
  AWS_SECRET_KEY="<секретный_ключ>"
  BUCKET_NAME="<имя_бакета>"
  OBJECT_PATH="<ключ_объекта>"
  META_KEY_1="<ключ_1>"
  META_VALUE_1="<значение_1>"
  META_KEY_2="<ключ_2>"
  META_VALUE_2="<значение_2>"

  curl \
    --request PUT \
    --user "${AWS_KEY_ID}:${AWS_SECRET_KEY}" \
    --aws-sigv4 "aws:amz:{{ region-id }}:s3" \
    --header "X-Amz-Copy-Source: /${BUCKET_NAME}/${OBJECT_PATH}" \
    --header "X-Amz-Metadata-Directive: REPLACE" \
    --header "X-Amz-Meta-${META_KEY_1}: ${META_VALUE_1}" \
    --header "X-Amz-Meta-${META_KEY_2}: ${META_VALUE_2}" \
    --verbose \
    "https://{{ s3-storage-host }}/${BUCKET_NAME}/${OBJECT_PATH}"
  ```

  Где:

  * `AWS_KEY_ID` — [идентификатор](../../../iam/concepts/authorization/access-key.md#key-id) статического ключа доступа.
  * `AWS_SECRET_KEY` — [секретный ключ](../../../iam/concepts/authorization/access-key.md#private-key).
  * `BUCKET_NAME` — имя бакета, в котором вы хотите изменить метаданные объекта.
  * `OBJECT_PATH` — [ключ](../../concepts/object.md#key) объекта в бакете.
  * `META_KEY_1` и `META_KEY_1` — новые ключи пользовательских метаданных. Ключи должны состоять только из [ASCII-символов](https://{{ lang }}.wikipedia.org/wiki/ASCII).
  * `META_VALUE_1` и `META_VALUE_2` — новые значения пользовательских метаданных. Размер значения не должен превышать 2 КБ.

{% endlist %}


## Поиск по метаданным {#tags-searching}

{% note info %}

Для поиска по метаданным используются операции `LIST` и `HEAD`. Эти операции [тарифицируются](../../pricing.md#prices-operations).

{% endnote %}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  {{ yandex-cloud }} CLI не предоставляет встроенную функцию для прямого поиска объектов по метаданным. Однако вы можете использовать bash-скрипт, который последовательно проверяет метаданные каждого объекта в бакете.

  1. Сохраните данные для поиска в переменные:

      ```bash
      BUCKET_NAME=<имя_бакета>
      METADATA_KEY=<ключ_метаданных>
      METADATA_VALUE=<значение_метаданных>
      ```

  1. Выполните команду:

      ```bash
      # Перебираем все объекты и проверяем их метаданные
      yc storage s3api list-objects \
        --bucket $BUCKET_NAME \
        --format json | jq -r '.contents[].key' | while read -r key; do

        # Получаем метаданные объекта
        metadata=$(yc storage s3api head-object --bucket $BUCKET_NAME --key "$key" --format json)

        # Проверяем наличие нужного ключа и значения метаданных
        if echo "$metadata" | jq -e ".metadata[\"$METADATA_KEY\"] == \"$METADATA_VALUE\"" > /dev/null; then
          echo "Найден объект с нужными метаданными: $key"
          echo "$metadata" | jq
          echo "----------------------------------------"
        fi
      done
      ```

      Результат:

      ```text
      Найден объект с нужными метаданными: ********.jpg
      {
        "etag": "\"d658ade1b7628f5fa824c60a********\"",
        "request_id": "8dcb3cfb********",
        "accept_ranges": "bytes",
        "content_length": "223840",
        "content_type": "application/octet-stream",
        "last_modified_at": "2025-04-23T10:54:16Z",
        "metadata": {
          "key1": "val1",
          "key2": "val2"
        }
      }
      ----------------------------------------
      ```

- AWS CLI {#aws-cli}

  {% include [aws-cli-install](../../../_includes/aws-cli-install.md) %}

  AWS CLI не предоставляет встроенную функцию для прямого поиска объектов по метаданным. Однако вы можете использовать bash-скрипт, который последовательно проверяет метаданные каждого объекта в бакете.

  1. Сохраните данные для поиска в переменные:

      ```bash
      BUCKET_NAME=<имя_бакета>
      METADATA_KEY=<ключ_метаданных>
      METADATA_VALUE=<значение_метаданных>
      ```

  1. Выполните команду:

      ```bash
      # Перебираем все объекты и проверяем их метаданные
      aws s3api list-objects \
        --bucket $BUCKET_NAME \
        --endpoint-url=https://{{ s3-storage-host }} \
        --query 'Contents[].Key' \
        --output text | tr '\t' '\n' | while read -r key; do

        # Получаем метаданные объекта
          metadata=$(aws s3api head-object \
            --bucket $BUCKET_NAME \
            --key "$key" \
            --endpoint-url=https://{{ s3-storage-host }})

        # Преобразуем METADATA_KEY в заглавные
        uppercase_threshold_key=$(echo "$METADATA_KEY" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')

        # Проверяем наличие нужного ключа и значения метаданных
        echo "$metadata" | jq -e --arg key "$uppercase_threshold_key" --arg value "$METADATA_VALUE" '.Metadata[$key] == $value' > /dev/null
        if [ $? -eq 0 ]; then
          echo "Найден объект с нужными метаданными: $key"
          echo "$metadata" | jq
          echo "----------------------------------------"
        fi
      done
      ```

      Результат:

      ```text
      Найден объект с нужными метаданными: ********.jpg
      {
        "AcceptRanges": "bytes",
        "LastModified": "Wed, 23 Apr 2025 10:54:16 GMT",
        "ContentLength": 223840,
        "ETag": "\"d658ade1b7628f5fa824c60a********\"",
        "ContentType": "application/octet-stream",
        "Metadata": {
          "Key1": "val1",
          "Key2": "val2"
        }
      }
      ----------------------------------------
      ```

- Python (boto3) {#boto3}

  Для поиска объектов по метаданным вы можете воспользоваться [boto3 для Python](../../tools/boto.md).

  1. Создайте файл `main.py` со следующим кодом:

      ```python
      import boto3
      import sys
      import json
      from datetime import datetime

      def format_response(response, obj_name):
          # Преобразуем дату в нужный формат
          last_modified = response['LastModified'].strftime("%a, %d %b %Y %H:%M:%S GMT")

          formatted_response = {
              "RequestId": response['ResponseMetadata']['RequestId'],
              "AcceptRanges": response['AcceptRanges'],
              "LastModified": last_modified,
              "ContentLength": response['ContentLength'],
              "ETag": response['ETag'],
              "ContentType": response['ContentType'],
              "Metadata": response['Metadata']
          }

          # Форматированный вывод с отступами
          formatted_output = json.dumps(formatted_response, indent=2, ensure_ascii=False)

          print(f"Найден объект с нужными метаданными: {obj_name}")
          print(formatted_output)
          print("----------------------------------------")

      def update_object_metadata(bucket_name, metadata_key, metadata_value):
          s3 = boto3.client('s3')

          obj_names = []
          try:
              # Получаем список объектов
              paginator = s3.get_paginator('list_objects_v2')
              for page in paginator.paginate(Bucket=bucket_name):
                  for obj in page.get('Contents', []):
                      obj_names.append(obj['Key'])

          except Exception as e:
              print(f"Ошибка при получении списка объектов: {e}")
              return

          found = False
          for obj_name in obj_names:
              try:
                  # Получаем текущие метаданные объекта
                  response = s3.head_object(Bucket=bucket_name, Key=obj_name)
                  current_metadata = response.get('Metadata', {})
                  # Приводим метаданных к нормализованному виду для сравнения
                  normalized_key = metadata_key.lower()
                  # Приводим метаданных к нижнему регистру
                  normalized_metadata = {key.lower(): value for key, value in current_metadata.items()}
                  # Проверяем на совпадение
                  if normalized_metadata.get(normalized_key) == metadata_value:
                      format_response(response, obj_name)
                      found = True

              except s3.exceptions.ClientError as e:
                  print(f"Ошибка при получении метаданных объекта {obj_name}: {e}")
                  continue

          if not found:
              print('В бакете нет объектов с указанными метаданными.')

      if __name__ == "__main__":
          if len(sys.argv) != 4:
              print("Использование: python main.py metadata_key metadata_value bucket_name")
              sys.exit(1)

          metadata_key = sys.argv[1]
          metadata_value = sys.argv[2]
          bucket_name = sys.argv[3]

          update_object_metadata(bucket_name, metadata_key, metadata_value)
      ```

  1. Запустите скрипт, указав свои значения:

      ```bash
      python main.py <ключ_метаданных> <значение_метаданных> <имя_бакета>
      ```

      Результат:

      ```text
      Найден объект с нужными метаданными: ********.jpg
      {
        "AcceptRanges": "bytes",
        "LastModified": "Wed, 23 Apr 2025 10:54:16 GMT",
        "ContentLength": 223840,
        "ETag": "\"d658ade1b7628f5fa824c60a********\"",
        "ContentType": "application/octet-stream",
        "Metadata": {
          "Key1": "val1",
          "Key2": "val2"
        }
      }
      ----------------------------------------
      ```

{% endlist %}

Если в бакете существует объект с указанными метаданными, в терминал будет выведена информация о нем.