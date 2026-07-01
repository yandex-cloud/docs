---
title: Передача данных в эндпоинт-приемник {{ objstorage-full-name }}
description: Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-приемника {{ objstorage-name }}.
---

# Передача данных в эндпоинт-приемник {{ objstorage-full-name }}

С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные в хранилище {{ objstorage-full-name }} и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Настройте один из поддерживаемых источников данных](#supported-sources).
1. [Настройте эндпоинт-приемник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Cоздайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с хранилищем и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](../../../../data-transfer/troubleshooting/index.md) по их устранению.

## Сценарии передачи данных в {{ objstorage-full-name }} {#scenarios}

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/queue.md) %}
    
    * [Поставка данных из {{ DS }} в {{ objstorage-name }}](../../../tutorials/yds-to-objstorage.md).   

1. {% include [data-mart](../../../../_includes/data-transfer/scenario-captions/storage.md) %}
    
    * [Загрузка данных из {{ MY }} в {{ objstorage-name }}](../../../tutorials/mmy-objs-migration.md);
    * [Загрузка данных из {{ PG }} в {{ objstorage-name }}](../../../tutorials/mpg-to-objstorage.md);
    * [Загрузка данных из {{ OS }} в {{ objstorage-name }}](../../../tutorials/opensearch-to-object-storage.md);
    * [Загрузка данных из {{ ydb-name }} в {{ objstorage-name }}](../../../tutorials/ydb-to-object-storage.md).

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} читайте в разделе [Практические руководства](../../../tutorials/index.md).

## Настройка источника данных {#supported-sources}

Настройте один из поддерживаемых источников данных:

* [{{ PG }}](../source/postgresql.md);
* [{{ MY }}](../source/mysql.md);
* [{{ MG }}](../source/mongodb.md);
* [{{ KF }}](../source/kafka.md);
* [{{ AB }}](../../../transfer-matrix.md#airbyte);
* [{{ DS }}](../source/data-streams.md);
* [Oracle](../source/oracle.md);
* [{{ ydb-name }}](../source/ydb.md);
* [{{ OS }}](../source/opensearch.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} читайте в разделе [Доступные трансферы](../../../transfer-matrix.md).

{% note warning %}

{{ objstorage-name }} поддерживает только вставку новых данных, но не поддерживает их обновление. Если в источнике происходит обновление данных, он не должен использоваться для поставки данных в {{ objstorage-name }}, иначе трансфер завершится с [ошибкой](#update-not-supported).

{% endnote %}

## Настройка эндпоинта-приемника {{ objstorage-name }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* [Настройки подключения](#bucket-config) для бакета {{ objstorage-full-name }} или пользовательского S3-совместимого хранилища.
* [Дополнительные параметры](#additional-settings).

### Настройки подключения {#bucket-config}

{% list tabs group=bucket %}

- Бакет {{ objstorage-full-name }} {#obj-storage}

    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.bucket.title }}** — имя [бакета](../../../../storage/concepts/bucket.md), в который будут загружаться данные из источника.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.service_account_id.title }}** — [сервисный аккаунт](../../../../iam/concepts/users/service-accounts.md) с ролью `storage.uploader`, от имени которого сервис {{ data-transfer-name }} будет подключаться к бакету.


- Пользовательское S3-совместимое хранилище {#s3-storage}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.bucket.title }}** — имя бакета, в который будут загружаться данные из источника.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.region.title }}** — регион, в котором хранятся данные.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.endpoint.title }}** — эндпоинт для сервиса, совместимого с Amazon S3.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.aws_access_key_id.title }}** и **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.aws_secret_access_key.title }}** — [идентификатор и содержимое ключа AWS](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys) для доступа к бакету.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.use_ssl.title }}** — выберите, если удаленный сервер использует безопасное соединение SSL/TLS.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.verify_ssl_cert.title }}** — запретить самоподписанные сертификаты.

{% endlist %}

Если создаваемый эндпоинт и бакет {{ objstorage-name }} лежат в разных каталогах, то при создании в настройках соединения нужно выбрать ручную настройку и указать следующие значения:

  * регион: `ru-central1`;
  * эндпоинт: {{ s3-storage-host }};
  * включить обе настройки, связанные с использованием SSL.

### Дополнительные настройки {#additional-settings}

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageV1Endpoint.path_prefix.title }}** — путь в бакете, по которому будут выгружаться данные.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageV1SerializerConfig.title }}** — формат, в котором данные будут записаны в бакет: `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_JSON.title }}`, `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_CSV.title }}` или `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_PARQUET.title }}`. Подробнее читайте в разделе [{#T}](../../../concepts/serializer.md#serializer-s3).

    {% list tabs group=bucket-data-format %}

    - {{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_JSON.title }} {#json}

         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageV1SerializerConfig.compression_codec.title }}** — алгоритм сжатия выходных данных: `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageCodecUI.GZIP.title }}` или `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageCodecUI.UNCOMPRESSED.title }}`.
  
    - {{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_CSV.title }} {#csv}

         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageV1SerializerConfig.compression_codec.title }}** — алгоритм сжатия выходных данных: `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageCodecUI.GZIP.title }}` или `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageCodecUI.UNCOMPRESSED.title }}`.

    - {{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_PARQUET.title }} {#parquet}

         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageV1SerializerConfig.Parquet.column_compression_codec.title }}** — алгоритм сжатия блоков данных: `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageCodecUI.GZIP.title }}`, `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageParquetCompressionCodecUI.SNAPPY.title }}` или `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageParquetCompressionCodecUI.ZSTD.title }}`.
  
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.Parquet.row_group.title }}** — параметры разбиения данных на группы. Можно указать максимальное количество строк в группе или максимальный размер группы в байтах. При совместном использовании настроек новая группа будет создаваться, когда хотя бы одно из ограничений будет нарушено.

    {% endlist %}

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageV1AdvancedWriterSettings.title }}** — дополнительные настройки записи выходных файлов:

    {% list tabs group=writer-settings %}

    - {{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageV1WriterSettings.SnapshotWriter.title }} {#snapshot}

      *  **Максимальное число записей в одном файле** — если оставить поле пустым, то данные запишутся в один файл.
      *  **Максимальное число байтов в одном файле** — если оставить поле пустым, то данные запишутся в один файл.

    - {{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageV1WriterSettings.ReplicationWriter.title }} {#replication}

      * **Интервал ротации** — значение в секундах, по истечении которого новый файл будет записан. Данные о времени берутся из параметров получаемых сообщений. Значение по умолчанию — 1 час.

    {% endlist %}

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

## Решение проблем, возникающих при переносе данных {#troubleshooting}

Смотрите полный список рекомендаций в разделе [Решение проблем](../../../troubleshooting/index.md).

{% include [update-not-supported](../../../../_includes/data-transfer/troubles/object-storage/update-not-supported.md) %}
