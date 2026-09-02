---
title: Проверка шифрования бакета и объектов в {{ objstorage-full-name }}
description: Следуя данной инструкции, вы сможете узнать текущие настройки шифрования бакета, определить, каким ключом зашифрован объект, и найти в бакете незашифрованные объекты.
---

# Проверка шифрования бакета и объектов

[Шифрование бакета](encrypt.md) применяется только к новым объектам: загруженные ранее остаются без изменений. Поэтому в одном бакете могут одновременно лежать незашифрованные объекты и объекты, зашифрованные разными [ключами {{ kms-short-name }}](../../../kms/concepts/key.md) — например, если ключ бакета меняли.

Из этой инструкции вы узнаете, как:

* посмотреть текущие настройки шифрования бакета;
* определить, зашифрован ли конкретный объект и каким ключом;
* найти в бакете незашифрованные объекты.

{% include [encryption-roles](../../../_includes/storage/encryption-roles.md) %}

## Посмотреть настройки шифрования бакета {#bucket}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/storage) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Выберите нужный бакет.
  1. На панели слева выберите ![image](../../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}**.
  1. Выберите вкладку **{{ ui-key.yacloud.storage.bucket.switch_encryption }}**.

  В поле **{{ ui-key.yacloud.storage.bucket.encryption.field_key }}** отображается ключ, которым шифруются новые объекты. Если выбрано значение **{{ ui-key.yacloud.component.symmetric-key-select.label_no-symmetric-key }}**, шифрование по умолчанию для бакета не задано.

- AWS CLI {#aws-cli}

  Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  Выполните команду:

  ```bash
  aws s3api get-bucket-encryption \
    --bucket <имя_бакета> \
    --endpoint-url=https://{{ s3-storage-host }}
  ```

  Где:

  * `--bucket` — имя бакета.
  * `--endpoint-url` — эндпоинт {{ objstorage-name }}.

  Результат:

  ```json
  {
      "ServerSideEncryptionConfiguration": {
          "Rules": [
              {
                  "ApplyServerSideEncryptionByDefault": {
                      "SSEAlgorithm": "aws:kms",
                      "KMSMasterKeyID": "abjbeb2bgg4l********"
                  }
              }
          ]
      }
  }
  ```

  Если шифрование для бакета не настроено, конфигурация не будет найдена и команда завершится ошибкой. Перечень возможных ответов метода приведен в разделе [{#T}](../../s3/api-ref/response-codes.md).

- API {#api}

  Чтобы получить настройки шифрования бакета, воспользуйтесь методом S3 API [getBucketEncryption](../../s3/api-ref/bucket/getbucketencryption.md).

  Идентификатор ключа возвращается в элементе `KMSMasterKeyID`.

{% endlist %}

## Узнать, зашифрован ли объект {#object}

Метаданные объекта содержат сведения о шифровании, только если объект зашифрован. Если объект был загружен до включения шифрования, полей о шифровании в ответе не будет.

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. {% include [bucket-list-cli](../../../_includes/storage/bucket-list-cli.md) %}
  1. Получите метаданные объекта:

     ```bash
     yc storage s3api head-object \
       --bucket <имя_бакета> \
       --key <ключ_объекта>
     ```

     Где:

     * `--bucket` — имя бакета.
     * `--key` — [ключ](../../concepts/object.md#key) объекта.

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

     Где:

     * `server_side_encryption` — алгоритм, которым зашифрован объект.
     * `sse_kms_key_id` — идентификатор ключа {{ kms-short-name }}, которым зашифрован объект.

- AWS CLI {#aws-cli}

  Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  Выполните команду:

  ```bash
  aws s3api head-object \
    --bucket <имя_бакета> \
    --key <ключ_объекта> \
    --endpoint-url=https://{{ s3-storage-host }}
  ```

  В ответе шифрованию соответствуют поля `ServerSideEncryption` и `SSEKMSKeyId`.

- API {#api}

  Чтобы получить метаданные объекта, воспользуйтесь методом S3 API [getObjectMeta](../../s3/api-ref/object/getobjectmeta.md) или [getObject](../../s3/api-ref/object/get.md).

  В ответе возвращаются заголовки `X-Amz-Server-Side-Encryption` и `X-Amz-Server-Side-Encryption-Aws-Kms-Key-Id`. Если объект не зашифрован, этих заголовков не будет.

{% endlist %}

## Найти незашифрованные объекты в бакете {#find-unencrypted}

Проверка по одному объекту неудобна, если объектов много. Скрипт ниже перебирает объекты бакета и выводит ключи тех из них, у которых в метаданных нет сведений о шифровании.

Для работы скрипта потребуются [AWS CLI](../../tools/aws-cli.md) и утилита [jq](https://stedolan.github.io/jq/).

1. Задайте имя бакета:

   ```bash
   BUCKET_NAME=<имя_бакета>
   ```

1. Выполните команду:

   ```bash
   # Перебираем все объекты бакета
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

     # Если поля ServerSideEncryption нет, объект не зашифрован
     if ! echo "$metadata" | jq -e 'has("ServerSideEncryption")' > /dev/null; then
       echo "Не зашифрован: $key"
     fi
   done
   ```

   Результат:

   ```text
   Не зашифрован: photos/********.jpg
   Не зашифрован: logs/2024-10-08.log
   ```

   Если вывод пуст, все объекты бакета зашифрованы.

Чтобы зашифровать найденные объекты, загрузите их заново — при загрузке к ним применится [шифрование по умолчанию](encrypt.md#add), заданное в настройках бакета, либо укажите ключ явно в заголовках запроса [upload](../../s3/api-ref/object/upload.md).

#### Полезные ссылки {#see-also}

* [{#T}](encrypt.md)
* [{#T}](../../concepts/encryption.md)
* [{#T}](../objects/info.md)
