# Передача данных из эндпоинта-источника {{ yds-full-name }}


С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные из очереди {{ yds-name }} и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Подготовьте базу данных {{ yds-name }}](#prepare) к трансферу.
1. [Настройте эндпоинт-источник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Настройте один из поддерживаемых приемников данных](#supported-targets).
1. [Cоздайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с базой и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](#troubleshooting) по их устранению.

## Сценарии передачи данных из {{ yds-name }} {#scenarios}

1. Миграция — перенос данных из одного хранилища в другое. Часто это перенос базы из устаревших локальных баз в управляемые облачные.

   Отдельной задачей миграции является зеркалирование данных между очередями {{ yds-name }}.

1. Поставка данных — процесс доставки произвольных данных в целевые хранилища. Процесс поставки включает извлечение данных из очереди и их десериализацию с последующей трансформацией данных в формат целевого хранилища.

    * [{{ DS }} в {{ CH }}](../../../tutorials/yds-to-clickhouse.md);
    * [{{ DS }} в {{ objstorage-name }}](../../../tutorials/yds-to-objstorage.md);
    * [{{ DS }} в {{ ydb-name }}](../../../tutorials/yds-to-ydb.md);
    * [{{ DS }} в {{ mkf-name }}](../../../tutorials/yds-to-kafka.md).

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} читайте в разделе [Практические руководства](../../../tutorials/index.md).

## Подготовка базы данных источника {#prepare}

1. [Создайте сервисный аккаунт](../../../../iam/operations/sa/create.md) с ролью `yds.editor`.
1. [Создайте поток данных](../../../../data-streams/operations/manage-streams.md#create-data-stream).
1. (Опционально) [Создайте функцию обработки](../../../../functions/operations/function/function-create.md).

   {% cut "Пример функции обработки" %}

    ```javascript
    const yc = require("yandex-cloud");
    const { Parser } = require("@robojones/nginx-log-parser");
    module.exports.handler = async function (event, context) {
        const schema =
            '$remote_addr - $remote_user [$time_local] "$request" $status $bytes_sent "$http_referer" "$http_user_agent"';
        const parser = new Parser(schema);
        return {
            Records: event.Records.map((record) => {
                const decodedData = new Buffer(record.kinesis.data, "base64")
                    .toString("ascii")
                    .trim();
                try {
                    const result = parser.parseLine(decodedData);
                    if (result.request == "") {
                        // empty request - drop message
                        return {
                            eventID: record.eventID,
                            invokeIdentityArn: record.invokeIdentityArn,
                            eventVersion: record.eventVersion,
                            eventName: record.eventName,
                            eventSourceARN: record.eventSourceARN,
                            result: "Dropped"
                        };
                    }
                    return {
                        // successfully parsed message
                        eventID: record.eventID,
                        invokeIdentityArn: record.invokeIdentityArn,
                        eventVersion: record.eventVersion,
                        eventName: record.eventName,
                        eventSourceARN: record.eventSourceARN,
                        kinesis: {
                            data: new Buffer(JSON.stringify(result)).toString(
                                "base64"
                            ),
                        },
                        result: "Ok"
                    };
                } catch (err) {
                    // error - fail message
                    return {
                        eventID: record.eventID,
                        invokeIdentityArn: record.invokeIdentityArn,
                        eventVersion: record.eventVersion,
                        eventName: record.eventName,
                        eventSourceARN: record.eventSourceARN,
                        result: "ProcessingFailed",
                    };
                }
            })
        };
    };
    ```

   {% endcut %}

1. (Опционально) Подготовьте файл схемы данных в формате JSON.

   Пример файла со схемой данных:

    ```json
    [
        {
            "name": "<имя_поля>",
            "type": "<тип>"
        },
        ...
        {
            "name": "<имя_поля>",
            "type": "<тип>"
        }
    ]
    ```

   Список допустимых типов:
  
  * `any`
  * `boolean`
  * `datetime`
  * `double`
  * `int8`
  * `int16`
  * `int32`
  * `int64`
  * `string`
  * `uint8`
  * `uint16`
  * `uint32`
  * `uint64`
  * `utf8`

## Настройка эндпоинта-источника {{ yds-name }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* [Настройки подключения](#managed-service) к потоку данных в [{{ yds-full-name }}](#managed-service). Это обязательные параметры.
* [Расширенные настройки](#additional-settings).

### Основные настройки {#managed-service}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.database.title }}** — выберите базу данных {{ ydb-full-name }}, зарегистрированную в [{{ yds-full-name }}](../../../../data-streams/index.md) в качестве источника.
    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.stream.title }}** — укажите имя потока, ассоциированного с базой данных.
    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.service_account_id.title }}** — выберите или [создайте](../../../../iam/operations/sa/create.md) [сервисный аккаунт](../../../../iam/concepts/users/service-accounts.md) с ролью `yds.editor`, от имени которого сервис {{ data-transfer-name }} будет подключаться к источнику данных.
    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.security_groups.title }}** — выберите облачную сеть, в которой будет размещен эндпоинт. Управлять сетями можно в сервисе [{{ vpc-name }}](../../../../vpc/index.md).

{% endlist %}

### Расширенные настройки {#additional-settings}

В расширенных настройках вы можете задать правила трансформации и правила конвертации. Данные обрабатываются в следующем порядке:

1. **Трансформация**. Данные в формате JSON передаются функции [{{ sf-full-name }}](../../../../functions/index.md). В теле функции содержатся метаинформация и необработанные данные, которые переданы в очередь. С помощью функции данные обрабатываются и возвращаются в {{ data-transfer-name }}.

1. **Конвертация**. Выполняется парсинг, с помощью которого данные подготавливаются для передачи приемнику.

Если не заданы правила трансформации, то парсинг применяется к необработанным данным из очереди. Если не заданы правила конвертации, то данные сразу передаются в приемник.

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.transformer.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.cloud_function.title }}** — выберите одну из функций, созданных в сервисе {{ sf-name }}.

            
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.service_account_id.title }}** — выберите или [создайте](../../../../iam/operations/sa/create.md) сервисный аккаунт, от имени которого будет запускаться функция обработки.


        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.number_of_retries.title }}** — укажите количество попыток вызова функции обработки.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.buffer_size.title }}** — укажите размер буфера (в байтах), при заполнении которого данные будут переданы функции обработки.

            Максимальный размер буфера — 3,5 МБ. Подробнее об ограничениях, действующих при работе с функциями в сервисе {{ sf-name }}, читайте в [соответствующем разделе](../../../../functions/concepts/limits.md).

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.buffer_flush_interval.title }}** — укажите длительность интервала (в секундах), по истечении которого данные из потока должны быть переданы функции обработки.

            {% note info %}

            Если буфер заполнится или истечет интервал отправки, данные будут переданы функции обработки.

            {% endnote %}

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.invocation_timeout.title }}** — укажите допустимое время ожидания ответа от функции обработки (в секундах).

        {% note warning %}

        Значения в полях **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.buffer_flush_interval.title }}** и **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.invocation_timeout.title }}** указываются с постфиксом `s`, например, `10s`.

        {% endnote %}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.converter.title }}**:

       * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.converter.title }}**:
         
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.format.title }}** — выберите один из доступных форматов:
                * `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_JSON.title }}` — формат JSON. Для оптимизации пропускной способности поддерживается обработка сообщений JSON, записанных одной строкой — без символов перевода строки `\n`. Пример: `{"attr": "value"}`
                * `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_config_audit_trails_v1.title }}` — формат логов сервиса [{{ at-name }}](../../../../audit-trails/index.md).
                * `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_config_common_cloud_logging.title }}` — формат логов сервиса [{{ cloud-logging-short-name }}](../../../../logging/index.md).
                * `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_config_common_debezium_cdc.title }}` — Debezium CDC. Позволяет указать настройки подключения к Schema Registry: `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.title }}` для [Confluent Schema Registry](https://docs.confluent.io/platform/current/schema-registry/index.html), идентификатор [пространства имен](../../../../metadata-hub/operations/list-name-space.md) для `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.yandex_sr.title }}`.
                * `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_raw_to_table.title }}` — позволяет сохранять сообщения целиком «как есть» в отдельную таблицу приемника.
         
                   Для формата **JSON** укажите:
         
                    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.data_schema.title }}** — задайте схему в виде списка полей или загрузите файл с описанием схемы в формате JSON.
                     
                    {% cut "Пример задания схемы данных" %}
                    ```json
                    [
                        {
                            "name": "request",
                            "type": "string"
                          }
                    ]
                    ```
                    {% endcut %}
             
                    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.GenericParser.null_keys_allowed.title }}** — выберите эту опцию, чтобы разрешить значение `null` в ключевых колонках.
                    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.add_rest_column.title }}** — выберите эту опцию, чтобы поля, отсутствующие в схеме, попадали в колонку `_rest`.
                    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.parsers.GenericParserCommon.unescape_string_values.title }}** — выберите эту опцию, чтобы убрать кавычки из строковых переменных (если этого не сделать, значения строковых полей останутся без изменений).
         
                  Для **Debezium CDC** укажите:
                    * Для `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.title }}` — URL для Schema Registry, способ аутентификации (с указанием логина и пароля пользователя в случае использования аутентификации) и CA-сертификат.
                    * Для `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.yandex_sr.title }}` — идентификатор [пространства имен](../../../../metadata-hub/operations/list-name-space.md) реестра схем.
         
                  Для **Raw-to-table** укажите:
                    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_raw_to_table.table_name.title }}** — имя таблицы, в которую сохраняются сообщения. По умолчанию совпадает с именем топика.
                    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_raw_to_table.is_key_enabled.title }}** — выберите эту опцию, чтобы записывать ключ сообщения в отдельный столбец.
                    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_raw_to_table.key_type.title }}** — выберите подходящий формат для записи ключа в таблицу.
                    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_raw_to_table.value_type.title }}** — выберите подходящий формат для записи значения в таблицу.
                    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_raw_to_table.advanced.title }}**:
                      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_raw_to_table.is_timestamp_enabled.title }}** — выберите опцию, чтобы сохранять время записи сообщения в отдельном столбце.
                      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_raw_to_table.is_headers_enabled.title }}** — выберите опцию, чтобы сохранять заголовки сообщения в отдельном столбце.
                      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_raw_to_table.dlq_suffix.title }}** — укажите суффикс, который будет использоваться для именования отдельной таблицы с недоставленными сообщениями по схеме `<имя_таблицы_сообщений>_<суффикс>`. По умолчанию применяется суффикс `_dlq`.    

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.supported_codecs.title }}** — укажите требуемый формат сжатия данных: `{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YdsSupportedCodecs.gzip.title }}`, `{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YdsSupportedCodecs.zstd.title }}` или `{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YdsSupportedCodecs.raw.title }}`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.allow_ttl_rewind.title }}** — включите настройку, чтобы разрешить трансферу начать или продолжить чтение из топика, даже если часть данных в нем была удалена в связи с превышением периода хранения. Если настройка выключена, при превышении периода хранения и удалении данных из топика трансфер остановится с ошибкой. Обычно это происходит в случае, когда трансфер не успевает переносить все данные и отставание чтения превышает период хранения.
    
        {% note warning %}   

        Если вы впервые настраиваете поставку данных из топика, в который данные уже давно пишутся, либо включаете ее после длительного простоя и сталкиваетесь с ошибкой вида `Found rewind`, вы можете временно включить эту настройку, активировать трансфер, затем, после считывания всех данных и сокращения отставания, выключить настройку. 

        {% endnote %}

{% endlist %}


## Настройка приемника данных {#supported-targets}

Настройте один из поддерживаемых приемников данных:

* [{{ PG }}](../target/postgresql.md);
* [{{ MY }}](../target/mysql.md);
* [{{ MG }}](../target/mongodb.md)
* [{{ CH }}](../target/clickhouse.md);
* [{{ GP }}](../target/greenplum.md);
* [{{ ydb-full-name }}](../target/yandex-database.md);
* [{{ objstorage-full-name }}](../target/object-storage.md);
* [{{ KF }}](../target/kafka.md);
* [{{ DS }}](../target/data-streams.md);
* [{{ OS }}](../target/opensearch.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} читайте в разделе [Доступные трансферы](../../../transfer-matrix.md).

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

## Решение проблем, возникающих при переносе данных {#troubleshooting}

* [Прерывание трансфера с ошибкой](#overloaded)
* [Редиректы {{ sf-short-name }}](#redirects)

См. полный список рекомендаций в разделе [Решение проблем](../../../troubleshooting/index.md).

### Прерывание трансфера с ошибкой {#overloaded}

Трансфер типа _{{ dt-type-repl }}_ или _{{ dt-type-copy-repl }}_ прерывается с ошибкой.

Текст ошибки:

```text
/Ydb.PersQueue.V1.PersQueueService/AddReadRule failed: OVERLOADED
```

Трансфер прерывается из-за ограничения облачной [квоты]({{ link-console-quotas }}) на количество операций с {{ ydb-name }}.

**Решение:**

1. Увеличьте в [квотах {{ ydb-name }}](../../../../ydb/concepts/limits.md) на облако с нужной базой данных значение характеристики **Количество схемных операций в минуту** и [активируйте](../../transfer.md#activate) трансфер повторно.

### Редиректы {{ sf-short-name }} {#redirects}

В трансферах из {{ yds-short-name }} или {{ KF }} в редких случаях может возникнуть ошибка:

```text
redirect to SOME_URL is requested but no redirects are allowed.
```

Возможная причина:

На источнике настроено использование функции {{ sf-short-name }}, которая возвращает не данные, а редирект на другой URL. 

**Решение:**

По соображениям безопасности такие редиректы запрещены. Воздержитесь от использования редиректов в {{ sf-short-name }} в трансферах.