# Управление пользовательскими метаданными объекта

При загрузке объекта в {{ objstorage-name }} вместе с ним вы можете передавать набор [пользовательских метаданных](../../concepts/object.md#user-meta) в виде пар `ключ-значение`.

## Загрузить объект с метаданными {#load-object-with-meta}

{% list tabs group=instructions %}

- AWS CLI {#cli}

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

- AWS CLI {#cli}

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

- AWS CLI {#cli}

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