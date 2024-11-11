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

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} см. в разделе [Практические руководства](../../../tutorials/index.md).

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
* [{{ ES }}](../source/elasticsearch.md);
* [{{ OS }}](../source/opensearch.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} см. в разделе [Доступные трансферы](../../../transfer-matrix.md).

{% note warning %}

{{ objstorage-name }} поддерживает только вставку новых данных, но не поддерживает их обновление. Если в источнике происходит обновление данных, он не должен использоваться для поставки данных в {{ objstorage-name }}, иначе трансфер завершится с [ошибкой](#update-not-supported).

{% endnote %}

## Настройка эндпоинта-приемника {{ objstorage-name }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* [Настройки конфигурации](#bucket-config) для бакета {{ objstorage-full-name }} или пользовательского S3-совместимого хранилища.
* [Дополнительные параметры](#additional-settings).

### Настройки конфигурации бакета {#bucket-config}

{% list tabs group=instructions %}

- Бакет {{ objstorage-full-name }} {#obj-storage}


    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.bucket.title }}** — имя [бакета](../../../../storage/concepts/bucket.md), в который будут загружаться данные из источника.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.service_account_id.title }}** — [сервисный аккаунт](../../../../iam/concepts/users/service-accounts.md) с ролью `storage.uploader`, под которым будет осуществляться доступ к [{{ yds-full-name }}](../../../../data-streams/).


- Пользовательское S3-совместимое хранилище {#s3-storage}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.bucket.title }}** — имя бакета.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.aws_access_key_id.title }}** и **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.aws_secret_access_key.title }}** — [идентификатор и содержимое ключа AWS](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys) для доступа к частному бакету.
    * (Опционально) **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.endpoint.title }}** — эндпоинт для службы, совместимой с Amazon S3. Оставьте поле пустым для использования Amazon.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.region.title }}** — регион для отправки запросов.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.use_ssl.title }}** — выберите, если удаленный сервер использует безопасное соединение SSL/TLS.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.verify_ssl_cert.title }}** — разрешить самоподписанные сертификаты.

{% endlist %}

### Дополнительные настройки {#additional-settings}

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_format.title }}** — формат, в котором данные будут записаны в бакет, `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_JSON.title }}`, `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_CSV.title }}`, `PARQUET` или `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_RAW.title }}`. Подробнее см. в разделе [{#T}](../../../concepts/serializer.md#serializer-s3).

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.any_as_string.title }}** — преобразование комплексных значений в строки для выходного формата `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_JSON.title }}`.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_encoding.title }}** — сжатие выходных данных, `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageCodecUI.GZIP.title }}` или `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageCodecUI.UNCOMPRESSED.title }}`.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageAdvancedSettings.buffer_size.title }}** — размер файлов, на которые разделены данные.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageAdvancedSettings.buffer_interval.title }}** — интервал, спустя который файл будет записан, вне зависимости от его размера.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageAdvancedSettings.bucket_layout.title }}** — имя папки объекта. Поддерживает шаблон раскладки данных по дате. Пример: `2006/01/02/<имя_папки>`.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageAdvancedSettings.bucket_layout_timezone.title }}** — часовой пояс, по времени которого раскладываются файлы. Влияет только на раскладывание файлов по папкам в бакете, но не влияет на данные внутри файлов.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageAdvancedSettings.bucket_layout_column.title }}** — имя колонки для указания логического времени для данных. Значение по умолчанию — системное время записи. Время при записи данных в приемник преобразуется в UTC. Это поведение нельзя изменить.

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

## Решение проблем, возникающих при переносе данных {#troubleshooting}

См. полный список рекомендаций в разделе [Решение проблем](../../../troubleshooting/index.md).

{% include [update-not-supported](../../../../_includes/data-transfer/troubles/object-storage/update-not-supported.md) %}
