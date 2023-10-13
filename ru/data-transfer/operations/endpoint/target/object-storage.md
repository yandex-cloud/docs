# Настройка эндпоинта-приемника {{ objstorage-name }}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать настройки доступа к бакету {{ objstorage-full-name }}.

## Настройки {{ objstorage-full-name }} {#settings}


* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.bucket.title }}** — имя [бакета](../../../../storage/concepts/bucket.md), в который будут загружаться данные из источника.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.service_account_id.title }}** — [сервисный аккаунт](../../../../iam/concepts/users/service-accounts.md) с ролью `storage.uploader`, под которым будет осуществляться доступ к [{{ yds-full-name }}](../../../../data-streams/).


* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_format.title }}** — формат, в котором данные будут записаны в бакет, `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_JSON.title }}`, `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_CSV.title }}`, `PARQUET` или `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_RAW.title }}`. Подробнее см. в разделе [{#T}](../../../concepts/serializer.md#serializer-s3).

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.any_as_string.title }}** — преобразование комплексных значений в строки для выходного формата `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_JSON.title }}`.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_encoding.title }}** — сжатие выходных данных, `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageCodecUI.GZIP.title }}` или `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageCodecUI.UNCOMPRESSED.title }}`.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.bucket_layout.title }}** — имя папки для размещения файлов. Поддерживает шаблон раскладки данных по дате, например `2006/01/02/<имя_каталога>`.

## Расширенные настройки {#additional-settings}

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageAdvancedSettings.buffer_size.title }}** — размер файлов, на которые разделены данные.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageAdvancedSettings.buffer_interval.title }}** — интервал, спустя который файл будет записан, вне зависимости от его размера.
