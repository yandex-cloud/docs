# Передача данных в эндпоинт-приемник {{ objstorage-name }}

С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные в хранилище {{ objstorage-name }} и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Настройте один из поддерживаемых источников данных](#supported-sources).
1. [Настройте эндпоинт-приемник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Cоздайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с хранилищем и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](../../../../data-transfer/troubleshooting/index.md) по их устранению.

## Сценарии передачи данных в {{ objstorage-name }} {#scenarios}

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/queue.md) %}
    
    * [Поставка данных из {{ DS }} в {{ objstorage-name }}](../../../tutorials/yds-to-objstorage.md).   

1. {% include [data-mart](../../../../_includes/data-transfer/scenario-captions/storage.md) %}
    
    * [Загрузка данных из {{ MY }} в {{ objstorage-name }}](../../../tutorials/mmy-objs-migration.md);
    * [Загрузка данных из {{ PG }} в {{ objstorage-name }}](../../../tutorials/mpg-to-objstorage.md).

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} см. в разделе [Практические руководства](../../../tutorials/index.md).

## Настройка источника данных {#supported-sources}

Настройте один из поддерживаемых источников данных:

* [{{ PG }}](../source/postgresql.md);
* [{{ MY }}](../source/mysql.md);
* [{{ MG }}](../source/mongodb.md);
* [{{ KF }}](../source/kafka.md);
* [Aibyte](../../../transfer-matrix.md#airbyte);
* [{{ DS }}](../source/data-streams.md);
* [{{ ydb-name }}](../source/ydb.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} см. в разделе [Доступные трансферы](../../../transfer-matrix.md).

## Настройка эндпоинта-приемника {{ objstorage-name }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать настройки доступа к бакету {{ objstorage-full-name }}.


* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.bucket.title }}** — имя [бакета](../../../../storage/concepts/bucket.md), в который будут загружаться данные из источника.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.service_account_id.title }}** — [сервисный аккаунт](../../../../iam/concepts/users/service-accounts.md) с ролью `storage.uploader`, под которым будет осуществляться доступ к [{{ yds-full-name }}](../../../../data-streams/).


* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_format.title }}** — формат, в котором данные будут записаны в бакет, `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_JSON.title }}`, `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_CSV.title }}`, `PARQUET` или `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_RAW.title }}`. Подробнее см. в разделе [{#T}](../../../concepts/serializer.md#serializer-s3).

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.any_as_string.title }}** — преобразование комплексных значений в строки для выходного формата `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_JSON.title }}`.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_encoding.title }}** — сжатие выходных данных, `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageCodecUI.GZIP.title }}` или `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageCodecUI.UNCOMPRESSED.title }}`.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.bucket_layout.title }}** — имя папки для размещения файлов. Поддерживает шаблон раскладки данных по дате, например `2006/01/02/<имя_каталога>`.

### Расширенные настройки {#additional-settings}

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageAdvancedSettings.buffer_size.title }}** — размер файлов, на которые разделены данные.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageAdvancedSettings.buffer_interval.title }}** — интервал, спустя который файл будет записан, вне зависимости от его размера.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageAdvancedSettings.bucket_layout_timezone.title }}** — часовой пояс, по времени которого раскладываются файлы. Влияет только на раскладывание файлов по папкам в бакете, но не влияет на данные внутри файлов.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageAdvancedSettings.bucket_layout_column.title }}** — имя колонки для указания логического времени для данных. Значение по умолчанию — системное время записи. Время при записи данных в приемник преобразуется в UTC. Это поведение нельзя изменить.

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).