---
title: Начало работы с S3 API в {{ objstorage-full-name }}
description: Из этой статьи вы узнаете, как выполнять базовые операции в {{ objstorage-full-name }} при помощи AWS S3 API.
---

# Начало работы с AWS S3 API в {{ objstorage-full-name }}

[AWS S3 API](https://docs.aws.amazon.com/AmazonS3/latest/API/Type_API_Reference.html) — это интерфейс взаимодействия с сервисами AWS, совместимый с {{ objstorage-full-name }}.

С помощью AWS S3 API вы создадите бакет, загрузите в него объект, получите список объектов в бакете, скачаете объект из бакета, удалите объект и удалите бакет.

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Создайте сервисный аккаунт и подготовьте данные для аутентификации {#create-static-key}

{% include [s3-api-auth-intro](../../_includes/storage/s3-api-auth-intro.md) %}

{% list tabs group=auth_keys %}

- Аутентификация с помощью IAM-токена {#iam-token}

  {% include [s3-api-auth-intro-iam-token](../../_includes/storage/s3-api-auth-intro-iam-token.md) %}

  1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md).
  1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../security/index.md#storage-editor) `storage.editor` на каталог. Это позволит работать от имени этого сервисного аккаунта со всеми бакетами в каталоге.
  1. Получите IAM-токен для созданного сервисного аккаунта. Подробнее читайте в инструкции [{#T}](../../iam/operations/iam-token/create-for-sa.md).

      {% include [s3-api-auth-sa-impersonation-tip](../../_includes/storage/s3-api-auth-sa-impersonation-tip.md) %}


- Аутентификация с помощью статического ключа {#static-key}

  Статический ключ доступа выпускается только для [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), и все действия с использованием статического ключа выполняются от имени этого сервисного аккаунта.

  {% note info %}

  {% include [s3-api-auth-requires-signature-notice](../../_includes/storage/s3-api-auth-requires-signature-notice.md) %}

  {% endnote %}

  1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md).
  1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../security/index.md#storage-editor) `storage.editor` на каталог. Это позволит работать от имени этого сервисного аккаунта со всеми бакетами в каталоге.
  1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key).

      {% include [get-static-key-info](../../_includes/storage/get-static-key-result.md) %}
  1. Установите утилиту [curl](https://curl.se/).

      Начиная с версии [8.3.0](https://curl.se/changes.html) утилита `curl` при работе с AWS S3 API поддерживает автоматическое формирование [строки для подписи](./signing-requests.md#string-to-sign-gen), [подпись запроса](./signing-requests.md#signing) и подстановку необходимых заголовков.

      При использовании более ранних версий утилиты `curl` вы можете формировать необходимые заголовки и подписывать запросы вручную.

{% endlist %}

## Создайте бакет {#create-bucket}

{% list tabs group=auth_keys %}

- Аутентификация с помощью IAM-токена {#iam-token}

  1. Задайте переменные, содержащие необходимые данные:

      ```bash
      IAM_TOKEN="<содержимое_IAM-токена>"
      BUCKET_NAME="<имя_бакета>"
      ```

      Где:

      * `IAM_TOKEN` — тело [полученного ранее](#create-static-key) IAM-токена сервисного аккаунта.
      * `BUCKET_NAME` — [имя](../concepts/bucket.md#naming) создаваемого бакета.

  1. Выполните HTTP-запрос:

      ```bash
      curl \
        --request PUT \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --verbose \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}"
      ```

      Результат:

      ```text
      ...
      < HTTP/2 200
      < server: nginx
      < date: Wed, 14 Jan 2026 08:37:55 GMT
      < content-type: application/octet-stream
      < location: /my-sample-bucket
      < x-amz-request-id: cd6bd702********
      <
      * Connection #0 to host {{ s3-storage-host }} left intact
      ```

- Аутентификация с помощью статического ключа {#static-key}

  1. Задайте переменные, содержащие необходимые данные:

      {% cut "Версия curl 8.3.0 и выше" %}

      ```bash
      AWS_KEY_ID="<идентификатор_статического_ключа>"
      AWS_SECRET_KEY="<секретный_ключ>"
      BUCKET_NAME="<имя_бакета>"
      ```

      Где:

      {% include [s3-api-quickstart-acc-keys-descs](../../_includes/storage/s3-api-quickstart-acc-keys-descs.md) %}

      * `BUCKET_NAME` — [имя](../concepts/bucket.md#naming) создаваемого бакета.

      {% endcut %}

      {% cut "Версия curl 8.2.1 и ниже" %}

      ```bash
      AWS_KEY_ID="<идентификатор_статического_ключа>"
      AWS_SECRET_KEY="<секретный_ключ>"
      BUCKET_NAME="<имя_бакета>"
      DATE_VALUE=`date -R`
      STRING_TO_SIGN="PUT\n\n${CONTENT_TYPE}\n${DATE_VALUE}\n/${BUCKET_NAME}"
      SIGNATURE=`echo -en ${STRING_TO_SIGN} | openssl sha1 -hmac ${AWS_SECRET_KEY} -binary | base64`
      ```

      Где:

      {% include [s3-api-quickstart-acc-keys-descs](../../_includes/storage/s3-api-quickstart-acc-keys-descs.md) %}

      * `BUCKET_NAME` — [имя](../concepts/bucket.md#naming) создаваемого бакета.

      {% endcut %}

  1. Выполните HTTP-запрос:

      {% cut "Версия curl 8.3.0 и выше" %}

      ```bash
      curl \
        --request PUT \
        --user "${AWS_KEY_ID}:${AWS_SECRET_KEY}" \
        --aws-sigv4 "aws:amz:{{ region-id }}:s3" \
        --verbose \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}"
      ```

      Результат:

      ```text
      ...
      < HTTP/2 200
      < server: nginx
      < date: Wed, 14 May 2025 20:00:04 GMT
      < content-type: application/octet-stream
      < location: /my-sample-bucket
      < x-amz-request-id: a5cf0b8d********
      <
      * Connection #0 to host {{ s3-storage-host }} left intact
      ```

      {% endcut %}

      {% cut "Версия curl 8.2.1 и ниже" %}

      ```bash
      curl \
        --request PUT \
        --verbose \
        --header "Host: {{ s3-storage-host }}" \
        --header "Date: ${DATE_VALUE}" \
        --header "Authorization: AWS ${AWS_KEY_ID}:${SIGNATURE}" \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}"
      ```

      Результат:

      ```text
      ...
      < HTTP/2 200
      < server: nginx
      < date: Thu, 15 May 2025 07:06:22 GMT
      < content-type: application/octet-stream
      < location: /my-sample-bucket
      < x-amz-request-id: b8c1bd45********
      <
      * Connection #0 to host {{ s3-storage-host }} left intact
      ```

      {% endcut %}

{% endlist %}


## Загрузите объект в бакет {#upload-object}

{% list tabs group=auth_keys %}

- Аутентификация с помощью IAM-токена {#iam-token}

  1. Задайте переменные, содержащие необходимые данные:

      ```bash
      IAM_TOKEN="<содержимое_IAM-токена>"
      BUCKET_NAME="<имя_бакета>"
      LOCAL_FILE="<путь_к_локальному_файлу>"
      OBJECT_PATH="<ключ_объекта>"
      ```

      Где:

      * `IAM_TOKEN` — тело [полученного ранее](#create-static-key) IAM-токена сервисного аккаунта.
      * `BUCKET_NAME` — [имя бакета](../concepts/bucket.md#naming), в который загружается файл.
      * `LOCAL_FILE` — путь к локальному файлу, который вы хотите загрузить в бакет. Например: `./sample.txt`.
      * `OBJECT_PATH` — [ключ](../concepts/object.md#key), который будет присвоен объекту в бакете. Например: `new-prefix/sample-object.txt`.

  1. Выполните HTTP-запрос:

      ```bash
      curl \
        --request PUT \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --upload-file "${LOCAL_FILE}" \
        --verbose \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}/${OBJECT_PATH}"
      ```

      Результат:

      ```text
      ...
      < HTTP/2 200
      < server: nginx
      < date: Wed, 14 Jan 2026 10:42:41 GMT
      < content-type: text/plain
      < etag: "65a8e27d8879283831b664bd********"
      < x-amz-request-id: 646150ef********
      <
      * Connection #0 to host {{ s3-storage-host }} left intact
      ```

- Аутентификация с помощью статического ключа {#static-key}

  1. Задайте переменные, содержащие необходимые данные:

      {% cut "Версия curl 8.3.0 и выше" %}

      ```bash
      AWS_KEY_ID="<идентификатор_статического_ключа>"
      AWS_SECRET_KEY="<секретный_ключ>"
      LOCAL_FILE="<путь_к_локальному_файлу>"
      BUCKET_NAME="<имя_бакета>"
      OBJECT_PATH="<ключ_объекта>"
      ```

      Где:

      {% include [s3-api-quickstart-acc-keys-descs](../../_includes/storage/s3-api-quickstart-acc-keys-descs.md) %}

      * `LOCAL_FILE` — путь к локальному файлу, который вы хотите загрузить в бакет. Например: `./sample.txt`.
      * `BUCKET_NAME` — [имя бакета](../concepts/bucket.md#naming), в который загружается файл.
      * `OBJECT_PATH` — [ключ](../concepts/object.md#key), который будет присвоен объекту в бакете. Например: `new-prefix/sample-object.txt`.

      {% endcut %}

      {% cut "Версия curl 8.2.1 и ниже" %}

      ```bash
      AWS_KEY_ID="<идентификатор_статического_ключа>"
      AWS_SECRET_KEY="<секретный_ключ>"
      LOCAL_FILE="<путь_к_локальному_файлу>"
      BUCKET_NAME="<имя_бакета>"
      OBJECT_PATH="<ключ_объекта>"
      DATE_VALUE=`date -R`
      STRING_TO_SIGN="PUT\n\n${CONTENT_TYPE}\n${DATE_VALUE}\n/${BUCKET_NAME}/${OBJECT_PATH}"
      SIGNATURE=`echo -en ${STRING_TO_SIGN} | openssl sha1 -hmac ${AWS_SECRET_KEY} -binary | base64`
      ```

      Где:

      {% include [s3-api-quickstart-acc-keys-descs](../../_includes/storage/s3-api-quickstart-acc-keys-descs.md) %}

      * `LOCAL_FILE` — путь к локальному файлу, который вы хотите загрузить в бакет. Например: `./sample.txt`.
      * `BUCKET_NAME` — [имя бакета](../concepts/bucket.md#naming), в который загружается файл.
      * `OBJECT_PATH` — [ключ](../concepts/object.md#key), который будет присвоен объекту в бакете. Например: `new-prefix/sample-object.txt`.

      {% endcut %}

  1. Выполните HTTP-запрос:

      {% cut "Версия curl 8.3.0 и выше" %}

      ```bash
      curl \
        --request PUT \
        --user "${AWS_KEY_ID}:${AWS_SECRET_KEY}" \
        --aws-sigv4 "aws:amz:{{ region-id }}:s3" \
        --upload-file "${LOCAL_FILE}" \
        --verbose \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}/${OBJECT_PATH}"
      ```

      Результат:

      ```text
      ...
      < HTTP/2 200
      < server: nginx
      < date: Thu, 15 May 2025 07:17:46 GMT
      < content-type: text/plain
      < etag: "f75a361db63aa4722fb8e083********"
      < x-amz-request-id: 40afeceb********
      <
      * Connection #0 to host {{ s3-storage-host }} left intact
      ```

      {% endcut %}

      {% cut "Версия curl 8.2.1 и ниже" %}

      ```
      curl \
        --request PUT \
        --upload-file "${LOCAL_FILE}" \
        --verbose \
        --header "Host: {{ s3-storage-host }}" \
        --header "Date: ${DATE_VALUE}" \
        --header "Authorization: AWS ${AWS_KEY_ID}:${SIGNATURE}" \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}/${OBJECT_PATH}"
      ```

      Результат:

      ```text
      ...
      < HTTP/2 200
      < server: nginx
      < date: Thu, 15 May 2025 07:23:08 GMT
      < content-type: text/plain
      < etag: "f75a361db63aa4722fb8e083********"
      < x-amz-request-id: 67ccce91********
      <
      * Connection #0 to host {{ s3-storage-host }} left intact
      ```

      {% endcut %}

{% endlist %}


## Получите список объектов в бакете {#list-bucket-objects}

{% list tabs group=auth_keys %}

- Аутентификация с помощью IAM-токена {#iam-token}

  1. Задайте переменные, содержащие необходимые данные:

      ```bash
      IAM_TOKEN="<содержимое_IAM-токена>"
      BUCKET_NAME="<имя_бакета>"
      ```

      Где:

      * `IAM_TOKEN` — тело [полученного ранее](#create-static-key) IAM-токена сервисного аккаунта.
      * `BUCKET_NAME` — [имя](../concepts/bucket.md#naming) бакета, список объектов которого требуется получить.

  1. Выполните HTTP-запрос:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --verbose \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}?list-type=2"
      ```

      Результат:

      ```text
      ...
      < HTTP/2 200
      < server: nginx
      < date: Wed, 14 Jan 2026 11:15:43 GMT
      < content-type: application/xml; charset=UTF-8
      < content-length: 583
      < x-amz-request-id: 91e2b09f05f16f54
      <
      <?xml version="1.0" encoding="UTF-8"?>
      * Connection #0 to host {{ s3-storage-host }} left intact
      <ListBucketResult
          xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
          <KeyCount>1</KeyCount>
          <Name>my-sample-bucket</Name>
          <Prefix></Prefix>
          <MaxKeys>1000</MaxKeys>
          <IsTruncated>false</IsTruncated>
          <Contents>
              <Key>new-prefix/sample-object.txt</Key>
              <LastModified>2026-01-14T10:42:41.040Z</LastModified>
              <Owner>
                  <ID>ajeg2b2et02f********</ID>
                  <DisplayName>ajeg2b2et02f********</DisplayName>
              </Owner>
              <ETag>&#34;65a8e27d8879283831b664bd********&#34;</ETag>
              <Size>13</Size>
              <StorageClass>STANDARD</StorageClass>
              <TagSet></TagSet>
          </Contents>
      </ListBucketResult>
      ```

- Аутентификация с помощью статического ключа {#static-key}

  1. Задайте переменные, содержащие необходимые данные:

      {% cut "Версия curl 8.3.0 и выше" %}

      ```bash
      AWS_KEY_ID="<идентификатор_статического_ключа>"
      AWS_SECRET_KEY="<секретный_ключ>"
      BUCKET_NAME="<имя_бакета>"
      ```

      Где:

      {% include [s3-api-quickstart-acc-keys-descs](../../_includes/storage/s3-api-quickstart-acc-keys-descs.md) %}

      * `BUCKET_NAME` — [имя](../concepts/bucket.md#naming) бакета, список объектов которого требуется получить.

      {% endcut %}

      {% cut "Версия curl 8.2.1 и ниже" %}

      ```bash
      AWS_KEY_ID="<идентификатор_статического_ключа>"
      AWS_SECRET_KEY="<секретный_ключ>"
      BUCKET_NAME="<имя_бакета>"
      DATE_VALUE=`date -R`
      STRING_TO_SIGN="GET\n\n${CONTENT_TYPE}\n${DATE_VALUE}\n/${BUCKET_NAME}"
      SIGNATURE=`echo -en ${STRING_TO_SIGN} | openssl sha1 -hmac ${AWS_SECRET_KEY} -binary | base64`
      ```

      Где:

      {% include [s3-api-quickstart-acc-keys-descs](../../_includes/storage/s3-api-quickstart-acc-keys-descs.md) %}

      * `BUCKET_NAME` — [имя](../concepts/bucket.md#naming) бакета, список объектов которого требуется получить.

      {% endcut %}

  1. Выполните HTTP-запрос:

      {% cut "Версия curl 8.3.0 и выше" %}

      ```bash
      curl \
        --request GET \
        --user "${AWS_KEY_ID}:${AWS_SECRET_KEY}" \
        --aws-sigv4 "aws:amz:{{ region-id }}:s3" \
        --verbose \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}?list-type=2"
      ```

      Результат:

      ```xml
      ...
      < HTTP/2 200
      < server: nginx
      < date: Thu, 15 May 2025 07:44:41 GMT
      < content-type: application/xml; charset=UTF-8
      < content-length: 569
      < x-amz-request-id: cab0999d********
      <
      <?xml version="1.0" encoding="UTF-8"?>
      * Connection #0 to host {{ s3-storage-host }} left intact
      <ListBucketResult
          xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
          <KeyCount>1</KeyCount>
          <Name>my-sample-bucket</Name>
          <Prefix></Prefix>
          <MaxKeys>1000</MaxKeys>
          <IsTruncated>false</IsTruncated>
          <Contents>
              <Key>text.txt</Key>
              <LastModified>2025-05-15T07:23:08.030Z</LastModified>
              <Owner>
                  <ID>ajegtlf2q28a********</ID>
                  <DisplayName>ajegtlf2q28a********</DisplayName>
              </Owner>
              <ETag>&#34;f75a361db63aa4722fb8e083********&#34;</ETag>
              <Size>103</Size>
              <StorageClass>STANDARD</StorageClass>
              <TagSet></TagSet>
          </Contents>
      </ListBucketResult>
      ```

      {% endcut %}

      {% cut "Версия curl 8.2.1 и ниже" %}

      ```
      curl \
        --request GET \
        --verbose \
        --header "Host: {{ s3-storage-host }}" \
        --header "Date: ${DATE_VALUE}" \
        --header "Authorization: AWS ${AWS_KEY_ID}:${SIGNATURE}" \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}?list-type=2"
      ```

      Результат:

      ```xml
      ...
      < HTTP/2 200
      < server: nginx
      < date: Thu, 15 May 2025 08:29:36 GMT
      < content-type: application/xml; charset=UTF-8
      < content-length: 569
      < x-amz-request-id: cb4b9a3d********
      <
      <?xml version="1.0" encoding="UTF-8"?>
      * Connection #0 to host {{ s3-storage-host }} left intact
      <ListBucketResult
          xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
          <KeyCount>1</KeyCount>
          <Name>my-sample-bucket</Name>
          <Prefix></Prefix>
          <MaxKeys>1000</MaxKeys>
          <IsTruncated>false</IsTruncated>
          <Contents>
              <Key>text.txt</Key>
              <LastModified>2025-05-15T07:23:08.030Z</LastModified>
              <Owner>
                  <ID>ajegtlf2q28a********</ID>
                  <DisplayName>ajegtlf2q28a********</DisplayName>
              </Owner>
              <ETag>&#34;f75a361db63aa4722fb8e083********&#34;</ETag>
              <Size>103</Size>
              <StorageClass>STANDARD</StorageClass>
              <TagSet></TagSet>
          </Contents>
      </ListBucketResult>
      ```

      {% endcut %}

{% endlist %}


## Скачайте объект из бакета {#download-object}

{% list tabs group=auth_keys %}

- Аутентификация с помощью IAM-токена {#iam-token}

  1. Задайте переменные, содержащие необходимые данные:

      ```bash
      IAM_TOKEN="<содержимое_IAM-токена>"
      BUCKET_NAME="<имя_бакета>"
      OBJECT_PATH="<ключ_объекта>"
      LOCAL_FILE="<путь_к_локальному_файлу>"
      ```

      Где:

      * `IAM_TOKEN` — тело [полученного ранее](#create-static-key) IAM-токена сервисного аккаунта.
      * `BUCKET_NAME` — [имя бакета](../concepts/bucket.md#naming), в котором находится скачиваемый объект.
      * `OBJECT_PATH` — [ключ](../concepts/object.md#key) скачиваемого объекта в бакете. Например: `new-prefix/sample-object.txt`.
      * `LOCAL_FILE` — путь к локальному файлу, в который вы хотите сохранить скачанный объект. Например: `./sample.txt`.

  1. Выполните HTTP-запрос:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --verbose \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}/${OBJECT_PATH}" \
        > ${LOCAL_FILE}
      ```

      Результат:

      ```text
      ...
      < HTTP/2 200
      < server: nginx
      < date: Wed, 14 Jan 2026 11:22:01 GMT
      < content-type: application/octet-stream
      < content-length: 13
      < accept-ranges: bytes
      < etag: "65a8e27d8879283831b664bd********"
      < last-modified: Wed, 14 Jan 2026 10:42:41 GMT
      < x-amz-request-id: 93c9edaf********
      <
      { [13 bytes data]
      100    13  100    13    0     0     69      0 --:--:-- --:--:-- --:--:--    69
      * Connection #0 to host {{ s3-storage-host }} left intact
      ```

- Аутентификация с помощью статического ключа {#static-key}

  1. Задайте переменные, содержащие необходимые данные:

      {% cut "Версия curl 8.3.0 и выше" %}

      ```bash
      AWS_KEY_ID="<идентификатор_статического_ключа>"
      AWS_SECRET_KEY="<секретный_ключ>"
      BUCKET_NAME="<имя_бакета>"
      OBJECT_PATH="<ключ_объекта>"
      LOCAL_FILE="<путь_к_локальному_файлу>"
      ```

      Где:

      {% include [s3-api-quickstart-acc-keys-descs](../../_includes/storage/s3-api-quickstart-acc-keys-descs.md) %}

      * `BUCKET_NAME` — [имя бакета](../concepts/bucket.md#naming), в котором находится скачиваемый объект.
      * `OBJECT_PATH` — [ключ](../concepts/object.md#key) скачиваемого объекта в бакете. Например: `new-prefix/sample-object.txt`.
      * `LOCAL_FILE` — путь к локальному файлу, в который вы хотите сохранить скачанный объект. Например: `./sample.txt`.

      {% endcut %}

      {% cut "Версия curl 8.2.1 и ниже" %}

      ```bash
      AWS_KEY_ID="<идентификатор_статического_ключа>"
      AWS_SECRET_KEY="<секретный_ключ>"
      BUCKET_NAME="<имя_бакета>"
      OBJECT_PATH="<ключ_объекта>"
      LOCAL_FILE="<путь_к_локальному_файлу>"
      DATE_VALUE=`date -R`
      STRING_TO_SIGN="GET\n\n${CONTENT_TYPE}\n${DATE_VALUE}\n/${BUCKET_NAME}/${OBJECT_PATH}"
      SIGNATURE=`echo -en ${STRING_TO_SIGN} | openssl sha1 -hmac ${AWS_SECRET_KEY} -binary | base64`
      ```

      Где:

      {% include [s3-api-quickstart-acc-keys-descs](../../_includes/storage/s3-api-quickstart-acc-keys-descs.md) %}

      * `BUCKET_NAME` — [имя бакета](../concepts/bucket.md#naming), в котором находится скачиваемый объект.
      * `OBJECT_PATH` — [ключ](../concepts/object.md#key) скачиваемого объекта в бакете. Например: `new-prefix/sample-object.txt`.
      * `LOCAL_FILE` — путь к локальному файлу, в который вы хотите сохранить скачанный объект. Например: `./sample.txt`.

      {% endcut %}

  1. Выполните HTTP-запрос:

      {% cut "Версия curl 8.3.0 и выше" %}

      ```bash
      curl \
        --request GET \
        --user "${AWS_KEY_ID}:${AWS_SECRET_KEY}" \
        --aws-sigv4 "aws:amz:{{ region-id }}:s3" \
        --verbose \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}/${OBJECT_PATH}" \
        > ${LOCAL_FILE}
      ```

      Результат:

      ```text
      ...
      < HTTP/2 200
      < server: nginx
      < date: Thu, 15 May 2025 08:55:19 GMT
      < content-type: text/plain
      < content-length: 103
      < accept-ranges: bytes
      < etag: "f75a361db63aa4722fb8e083********"
      < last-modified: Thu, 15 May 2025 07:23:08 GMT
      < x-amz-request-id: 1afc3ec9********
      <
      { [103 bytes data]
      100   103  100   103    0     0   1925      0 --:--:-- --:--:-- --:--:--  1943
      * Connection #0 to host {{ s3-storage-host }} left intact
      ```

      {% endcut %}

      {% cut "Версия curl 8.2.1 и ниже" %}

      ```bash
      curl \
        --request GET \
        --verbose \
        --header "Host: {{ s3-storage-host }}" \
        --header "Date: ${DATE_VALUE}" \
        --header "Authorization: AWS ${AWS_KEY_ID}:${SIGNATURE}" \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}/${OBJECT_PATH}" \
        > ${LOCAL_FILE}
      ```

      Результат:

      ```text
      ...
      < HTTP/2 200
      < server: nginx
      < date: Thu, 15 May 2025 09:11:12 GMT
      < content-type: text/plain
      < content-length: 103
      < accept-ranges: bytes
      < etag: "f75a361db63aa4722fb8e083********"
      < last-modified: Thu, 15 May 2025 07:23:08 GMT
      < x-amz-request-id: e86c7119********
      <
      { [103 bytes data]
      100   103  100   103    0     0   3433      0 --:--:-- --:--:-- --:--:--  3433
      * Connection #0 to host {{ s3-storage-host }} left intact
      ```

      {% endcut %}

{% endlist %}

Скачанный объект сохранен в файл, путь к которому задан в переменной `LOCAL_FILE`.


## Удалите объект в бакете {#delete-object}

{% list tabs group=auth_keys %}

- Аутентификация с помощью IAM-токена {#iam-token}

  1. Задайте переменные, содержащие необходимые данные:

      ```bash
      IAM_TOKEN="<содержимое_IAM-токена>"
      BUCKET_NAME="<имя_бакета>"
      OBJECT_PATH="<ключ_объекта>"
      ```

      Где:

      * `IAM_TOKEN` — тело [полученного ранее](#create-static-key) IAM-токена сервисного аккаунта.
      * `BUCKET_NAME` — [имя бакета](../concepts/bucket.md#naming), из которого удаляется объект.
      * `OBJECT_PATH` — [ключ](../concepts/object.md#key) удаляемого объекта в бакете. Например: `new-prefix/sample-object.txt`.

  1. Выполните HTTP-запрос:

      ```bash
      curl \
        --request DELETE \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --verbose \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}/${OBJECT_PATH}"
      ```

      Результат:

      ```text
      ...
      < HTTP/2 204
      < server: nginx
      < date: Wed, 14 Jan 2026 11:26:02 GMT
      < x-amz-request-id: dba1c5e2********
      <
      * Connection #0 to host {{ s3-storage-host }} left intact
      ```

- Аутентификация с помощью статического ключа {#static-key}

  1. Задайте переменные, содержащие необходимые данные:

      {% cut "Версия curl 8.3.0 и выше" %}

      ```bash
      AWS_KEY_ID="<идентификатор_статического_ключа>"
      AWS_SECRET_KEY="<секретный_ключ>"
      BUCKET_NAME="<имя_бакета>"
      OBJECT_PATH="<ключ_объекта>"
      ```

      Где:

      {% include [s3-api-quickstart-acc-keys-descs](../../_includes/storage/s3-api-quickstart-acc-keys-descs.md) %}

      * `BUCKET_NAME` — [имя бакета](../concepts/bucket.md#naming), из которого удаляется объект.
      * `OBJECT_PATH` — [ключ](../concepts/object.md#key) удаляемого объекта в бакете. Например: `new-prefix/sample-object.txt`.

      {% endcut %}

      {% cut "Версия curl 8.2.1 и ниже" %}

      ```bash
      AWS_KEY_ID="<идентификатор_статического_ключа>"
      AWS_SECRET_KEY="<секретный_ключ>"
      BUCKET_NAME="<имя_бакета>"
      OBJECT_PATH="<ключ_объекта>"
      DATE_VALUE=`date -R`
      STRING_TO_SIGN="DELETE\n\n${CONTENT_TYPE}\n${DATE_VALUE}\n/${BUCKET_NAME}/${OBJECT_PATH}"
      SIGNATURE=`echo -en ${STRING_TO_SIGN} | openssl sha1 -hmac ${AWS_SECRET_KEY} -binary | base64`
      ```

      Где:

      {% include [s3-api-quickstart-acc-keys-descs](../../_includes/storage/s3-api-quickstart-acc-keys-descs.md) %}

      * `BUCKET_NAME` — [имя бакета](../concepts/bucket.md#naming), из которого удаляется объект.
      * `OBJECT_PATH` — [ключ](../concepts/object.md#key) удаляемого объекта в бакете. Например: `new-prefix/sample-object.txt`.

      {% endcut %}

  1. Выполните HTTP-запрос:

      {% cut "Версия curl 8.3.0 и выше" %}

      ```bash
      curl \
        --request DELETE \
        --user "${AWS_KEY_ID}:${AWS_SECRET_KEY}" \
        --aws-sigv4 "aws:amz:{{ region-id }}:s3" \
        --verbose \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}/${OBJECT_PATH}"
      ```

      Результат:

      ```text
      ...
      < HTTP/2 204
      < server: nginx
      < date: Thu, 15 May 2025 14:24:01 GMT
      < x-amz-request-id: 7d2f023c********
      <
      * Connection #0 to host {{ s3-storage-host }} left intact
      ```

      {% endcut %}

      {% cut "Версия curl 8.2.1 и ниже" %}

      ```
      curl \
        --request DELETE \
        --verbose \
        --header "Host: {{ s3-storage-host }}" \
        --header "Date: ${DATE_VALUE}" \
        --header "Authorization: AWS ${AWS_KEY_ID}:${SIGNATURE}" \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}/${OBJECT_PATH}"
      ```

      Результат:

      ```text
      ...
      < HTTP/2 204
      < server: nginx
      < date: Thu, 15 May 2025 14:30:28 GMT
      < x-amz-request-id: 7dc0c426********
      <
      * Connection #0 to host {{ s3-storage-host }} left intact
      ```

      {% endcut %}

{% endlist %}


## Удалите бакет {#delete-bucket}

{% list tabs group=auth_keys %}

- Аутентификация с помощью IAM-токена {#iam-token}

  1. Задайте переменные, содержащие необходимые данные:

      ```bash
      IAM_TOKEN="<содержимое_IAM-токена>"
      BUCKET_NAME="<имя_бакета>"
      ```

      Где:

      * `IAM_TOKEN` — тело [полученного ранее](#create-static-key) IAM-токена сервисного аккаунта.
      * `BUCKET_NAME` — [имя](../concepts/bucket.md#naming) удаляемого бакета. Удаляемый бакет не должен содержать объектов.

  1. Выполните HTTP-запрос:

      ```bash
      curl \
        --request DELETE \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --verbose \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}"
      ```

      Результат:

      ```text
      ...
      < HTTP/2 204
      < server: nginx
      < date: Wed, 14 Jan 2026 11:27:40 GMT
      < x-amz-request-id: 2f8de94e********
      <
      * Connection #0 to host {{ s3-storage-host }} left intact
      ```

- Аутентификация с помощью статического ключа {#static-key}

  1. Задайте переменные, содержащие необходимые данные:

      {% cut "Версия curl 8.3.0 и выше" %}

      ```bash
      AWS_KEY_ID="<идентификатор_статического_ключа>"
      AWS_SECRET_KEY="<секретный_ключ>"
      BUCKET_NAME="<имя_бакета>"
      ```

      Где:

      {% include [s3-api-quickstart-acc-keys-descs](../../_includes/storage/s3-api-quickstart-acc-keys-descs.md) %}

      * `BUCKET_NAME` — [имя](../concepts/bucket.md#naming) удаляемого бакета. Удаляемый бакет не должен содержать объектов.

      {% endcut %}

      {% cut "Версия curl 8.2.1 и ниже" %}

      ```bash
      AWS_KEY_ID="<идентификатор_статического_ключа>"
      AWS_SECRET_KEY="<секретный_ключ>"
      BUCKET_NAME="<имя_бакета>"
      DATE_VALUE=`date -R`
      STRING_TO_SIGN="DELETE\n\n${CONTENT_TYPE}\n${DATE_VALUE}\n/${BUCKET_NAME}"
      SIGNATURE=`echo -en ${STRING_TO_SIGN} | openssl sha1 -hmac ${AWS_SECRET_KEY} -binary | base64`
      ```

      Где:

      {% include [s3-api-quickstart-acc-keys-descs](../../_includes/storage/s3-api-quickstart-acc-keys-descs.md) %}

      * `BUCKET_NAME` — [имя](../concepts/bucket.md#naming) удаляемого бакета. Удаляемый бакет не должен содержать объектов.

      {% endcut %}

  1. Выполните HTTP-запрос:

      {% cut "Версия curl 8.3.0 и выше" %}

      ```bash
      curl \
        --request DELETE \
        --user "${AWS_KEY_ID}:${AWS_SECRET_KEY}" \
        --aws-sigv4 "aws:amz:{{ region-id }}:s3" \
        --verbose \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}"
      ```

      Результат:

      ```text
      ...
      < HTTP/2 204
      < server: nginx
      < date: Thu, 15 May 2025 14:35:57 GMT
      < x-amz-request-id: 6a13b7ae********
      <
      * Connection #0 to host {{ s3-storage-host }} left intact
      ```

      {% endcut %}

      {% cut "Версия curl 8.2.1 и ниже" %}

      ```
      curl \
        --request DELETE \
        --verbose \
        --header "Host: {{ s3-storage-host }}" \
        --header "Date: ${DATE_VALUE}" \
        --header "Authorization: AWS ${AWS_KEY_ID}:${SIGNATURE}" \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}"
      ```

      Результат:

      ```text
      ...
      < HTTP/2 204
      < server: nginx
      < date: Thu, 15 May 2025 14:39:15 GMT
      < x-amz-request-id: 331b2dc4********
      <
      * Connection #0 to host {{ s3-storage-host }} left intact
      ```

      {% endcut %}

{% endlist %}

#### См. также {#see-also}

* [{#T}](./index.md)
* [{#T}](../api-ref/authentication.md)
* [{#T}](./signing-requests.md)