---
title: "Как настроить эндпоинт-источник {{ objstorage-name }}"
description: "Следуя данной инструкции, вы сможете настроить эндпоинт-источник {{ objstorage-name }}."
---
# Передача данных из эндпоинта-источника {{ objstorage-name }}

С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные из хранилища {{ objstorage-full-name }} в управляемые базы данных {{ yandex-cloud }} и реализовывать различные сценарии обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Настройте эндпоинт-источник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Настройте один из поддерживаемых приемников данных](#supported-targets).
1. [Cоздайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с хранилищем и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](../../../../data-transfer/troubleshooting/index.md) по их устранению.

## Сценарии передачи данных из {{ objstorage-name }} {#scenarios}

Вы можете реализовывать сценарии миграции и поставки данных из хранилища {{ objstorage-name }} в управляемые базы данных для дальнейшего хранения в облаке, обработки и загрузки в витрины данных с целью последующей визуализации.

{% include [data-mart](../../../../_includes/data-transfer/scenario-captions/data-mart.md) %}

* [Загрузка данных из {{ objstorage-name }} в {{ PG }}](../../../tutorials/object-storage-to-postgresql.md);
* [Загрузка данных из {{ objstorage-name }} в {{ CH }}](../../../tutorials/object-storage-to-clickhouse.md).

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} см. в разделе [Практические руководства](../../../tutorials/index.md).

## Настройка эндпоинта-источника {{ objstorage-name }} {#endpoint-settings}

{% include [note-preview](../../../../_includes/preview-pp.md) %}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта задайте настройки доступа к S3-совместимому хранилищу.

### Настройки {#settings}

#### Параметры настройки конфигурации бакета {#bucket-config}

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.bucket.title }}** — имя бакета.
  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.aws_access_key_id.title }}** и **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.aws_secret_access_key.title }}** — [идентификатор и содержимое ключа AWS](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys) для доступа к частному бакету.
  * (Опционально) **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.path_prefix.title }}** — префикс для каталогов и файлов, которые можно использовать для поиска по бакету.
  * (Опционально) **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.endpoint.title }}** — эндпоинт для службы, совместимой с Amazon S3. Оставьте поле пустым для использования Amazon.
  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.region.title }}** — регион для отправки запросов.
  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.use_ssl.title }}** — выберите, если удаленный сервер использует безопасное соединение SSL/TLS.
  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.verify_ssl_cert.title }}** — разрешить самоподписанные сертификаты.
    
**{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.path_pattern.title }}** — укажите шаблон пути. Если в бакете размещаются только файлы, используйте значение `**`.

#### Конфигурация очереди событий {#event-queue-config}

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.queue_name.title }}** — имя очереди, настроенной в бакете S3, для получения событий `s3:ObjectCreated`.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.owner_id.title }}** — идентификатор аккаунта AWS для аккаунта, создавшего очередь. Оставьте поле пустым, если бакет S3 и очередь созданы в одном и том же аккаунте.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.aws_access_key_id.title }}** — идентификатор ключа AWS, используемый как часть учетных данных для чтения из очереди SQS. Оставьте поле пустым, если можно использовать те же учетные данные, что и для бакета S3.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.aws_secret_access_key.title }}** — cекрет AWS, используемый как часть учетных данных для чтения из очереди SQS. Оставьте пустым, если можно использовать те же учетные данные, что и для бакета S3.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.endpoint.title }}** — эндпоинт для S3-совместимого сервиса. Оставьте поле пустым, чтобы использовать AWS.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.region.title }}** — регион AWS для отправки запросов. Оставьте поле пустым, если он совпадает с регионом бакета.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.use_ssl.title }}** — выберите, если удаленный сервер использует безопасное соединение SSL/TLS.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.verify_ssl_cert.title }}** — разрешить самоподписанные сертификаты.

#### Формат данных {#data-format}
   
{% list tabs %}

- {{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.csv.title }} 

     * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Csv.delimiter.title }}** — символ-разделитель.
     * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Csv.quote_char.title }}** — символ для обозначения начала и конца строки.
     * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Csv.escape_char.title }}** — Еscape-символ, используемый для экранирования специальных символов.
     * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Csv.encoding.title }}** — [кодировка](https://docs.python.org/3/library/codecs.html#standard-encodings).
     * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Csv.double_quote.title }}** — выберите, чтобы заменять двойные кавычки на одинарные.
     * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Csv.newlines_in_values.title }}** — выберите, если значения текстовых данных могут содержать символы переноса строки.
     * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Csv.block_size.title }}** — максимальная длина части файла, размещаемой в памяти во время чтения.
     * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.advanced_settings.title }}** — необходимые CSV [ConvertOptions](https://arrow.apache.org/docs/python/generated/pyarrow.csv.ConvertOptions.html#pyarrow.csv.ConvertOptions) для редактирования. Указываются в виде JSON-строки.
     * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Csv.additional_options.title }}** — необходимые CSV [ReadOptions](https://arrow.apache.org/docs/python/generated/pyarrow.csv.ReadOptions.html#pyarrow.csv.ReadOptions) для редактирования. Указываются в виде JSON-строки.

- {{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.parquet.title }}  

- {{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.jsonl.title }}
  
     * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Jsonl.newlines_in_values.title }}** — разрешить использовать символы новой строки в значениях JSON. Использование этого параметра может повлиять на производительность. Оставьте пустым, чтобы по умолчанию было установлено значение `FALSE`.
     * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Jsonl.unexpected_field_behavior.title }}** — метод обработки полей JSON за пределами `explicit_schema` (если указано). См. [документацию PyArrow](https://arrow.apache.org/docs/python/generated/pyarrow.json.ParseOptions.html).
     * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Jsonl.block_size.title }}** — размер фрагмента в байтах для одновременной обработки в памяти каждого файла. Если объем данных большой, и не удается обнаружить схему, увеличение этого значения должно решить проблему. Слишком большое значение может привести к ошибкам OOM.

- proto

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigProto.proto_desc.title }}** — загрузите файл-дескриптор.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigProto.msg_package_type.title }}** — укажите способ упаковки сообщений: 
        * `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ProtoMessagePackageType.PROTOSEQ.title }}` — последовательность целевых сообщений с разделителем;
        * `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ProtoMessagePackageType.REPEATED.title }}` — целевое сообщение находится в поле `repeated` единственного сообщения-обертки;
        * `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ProtoMessagePackageType.SINGLE_MESSAGE.title }}` — единственное целевое сообщение;
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigProto.msg_name.title }}** — если тип упаковки `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ProtoMessagePackageType.REPEATED.title }}`, указывается имя сообщения, содержащего единственное поле `repeated` целевым сообщением (иначе указывается имя целевого сообщения).
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigProto.primary_keys.title }}** — перечислите поля, чтобы они добавились в результат как первичные ключи.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigProto.included_fields.title }}** — перечислите поля сообщения для передачи. Если не задано, выводятся все поля сообщения.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ProtoParser.null_keys_allowed.title }}** — выберите эту опцию, чтобы разрешить значение `null` в ключевых колонках.

{% endlist %}

#### Датасет {#dataset}

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.SchemaTableFilterEntry.schema.title }}** — укажите схему служебной таблицы, которая будет использоваться для подключения.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.SchemaTableFilterEntry.table.title }}** — укажите имя служебной таблицы, которое будет использоваться для подключения.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageResultTable.add_system_cols.title }}** — добавить в схему результатов системные колонки `__file_name` и `__row_index`. `__file_name` соответствует имени объекта S3, из которого поступают данные. `__row_index` соответствует счетчику строк, в котором находятся данные, в объекте S3. 

  {% note warning %}

  Отключение этой опции может иметь нежелательные эффекты для приемников, которым требуется первичный ключ, при условии, что схема результатов может стать обязательной в таких случаях.
 
  {% endnote %}

**{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.result_schema.title }}** — укажите JSON-схему в формате `{"<столбец>": "<тип_данных>"}` или перечислите поля для схемы результирующей таблицы. Если вы выберете `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageDataSchema.infer.title }}`, то схема определится автоматически.

Дополнительно, вы можете определить, как следует обрабатывать строки, не прошедшие проверку типов: продолжать передачу данных, повторить попытку определить тип, не продолжать.

## Настройка приемника данных {#supported-targets}

Настройте один из поддерживаемых приемников данных:

* [{{ PG }}](../target/postgresql.md);
* [{{ MY }}](../target/mysql.md);
* [{{ CH }}](../target/clickhouse.md);
* [{{ GP }}](../target/greenplum.md);
* [{{ ydb-full-name }}](../target/yandex-database.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} см. в разделе [Доступные трансферы](../../../transfer-matrix.md).

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).