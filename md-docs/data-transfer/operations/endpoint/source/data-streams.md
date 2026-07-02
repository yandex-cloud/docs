[Документация Yandex Cloud](../../../../index.md) > [Yandex Data Transfer](../../../index.md) > [Пошаговые инструкции](../../index.md) > [Настройка эндпоинтов](../index.md) > Yandex Data Streams > Источник

# Передача данных из эндпоинта-источника Yandex Data Streams


С помощью сервиса Yandex Data Transfer вы можете переносить данные из очереди Data Streams и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Подготовьте базу данных Data Streams](#prepare) к трансферу.
1. [Настройте эндпоинт-источник](#endpoint-settings) в Yandex Data Transfer.
1. [Настройте один из поддерживаемых приемников данных](#supported-targets).
1. [Cоздайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с базой и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](#troubleshooting) по их устранению.

## Сценарии передачи данных из Data Streams {#scenarios}

1. Миграция — перенос данных из одного хранилища в другое. Часто это перенос базы из устаревших локальных баз в управляемые облачные.

   Отдельной задачей миграции является зеркалирование данных между очередями Data Streams.

1. Поставка данных — процесс доставки произвольных данных в целевые хранилища. Процесс поставки включает извлечение данных из очереди и их десериализацию с последующей трансформацией данных в формат целевого хранилища.

    * [YDS в ClickHouse®](../../../tutorials/yds-to-clickhouse.md);
    * [YDS в Object Storage](../../../tutorials/yds-to-objstorage.md);
    * [YDS в Managed Service for YDB](../../../tutorials/yds-to-ydb.md);
    * [YDS в Managed Service for Apache Kafka®](../../../tutorials/yds-to-kafka.md).

Подробное описание возможных сценариев передачи данных в Yandex Data Transfer читайте в разделе [Практические руководства](../../../tutorials/index.md).

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

## Настройка эндпоинта-источника Data Streams {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* [Настройки подключения](#managed-service) к потоку данных в [Yandex Data Streams](#managed-service). Это обязательные параметры.
* [Расширенные настройки](#additional-settings).

### Основные настройки {#managed-service}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **База данных** — выберите базу данных Yandex Managed Service for YDB, зарегистрированную в [Yandex Data Streams](../../../../data-streams/index.md) в качестве источника.
    
    * **Поток** — укажите имя потока, ассоциированного с базой данных.
    
    * **Сервисный аккаунт** — выберите или [создайте](../../../../iam/operations/sa/create.md) [сервисный аккаунт](../../../../iam/concepts/users/service-accounts.md) с ролью `yds.editor`, от имени которого сервис Data Transfer будет подключаться к источнику данных.
    
    * **Группы безопасности** — выберите облачную сеть, в которой будет размещен эндпоинт. Управлять сетями можно в сервисе [Virtual Private Cloud](../../../../vpc/index.md).

{% endlist %}

### Расширенные настройки {#additional-settings}

В расширенных настройках вы можете задать правила трансформации и правила конвертации. Данные обрабатываются в следующем порядке:

1. **Трансформация**. Данные в формате JSON передаются функции [Yandex Cloud Functions](../../../../functions/index.md). В теле функции содержатся метаинформация и необработанные данные, которые переданы в очередь. С помощью функции данные обрабатываются и возвращаются в Data Transfer.

1. **Конвертация**. Выполняется парсинг, с помощью которого данные подготавливаются для передачи приемнику.

Если не заданы правила трансформации, то парсинг применяется к необработанным данным из очереди. Если не заданы правила конвертации, то данные сразу передаются в приемник.

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **Правила трансформации**:

        * **Функция обработки** — выберите одну из функций, созданных в сервисе Cloud Functions.

            
            * **Сервисный аккаунт** — выберите или [создайте](../../../../iam/operations/sa/create.md) сервисный аккаунт, от имени которого будет запускаться функция обработки.


        * **Количество попыток** — укажите количество попыток вызова функции обработки.
        * **Размер буфера для отправки** — укажите размер буфера (в байтах), при заполнении которого данные будут переданы функции обработки.

            Максимальный размер буфера — 3,5 МБ. Подробнее об ограничениях, действующих при работе с функциями в сервисе Cloud Functions, читайте в [соответствующем разделе](../../../../functions/concepts/limits.md).

        * **Интервал отправки** — укажите длительность интервала (в секундах), по истечении которого данные из потока должны быть переданы функции обработки.

            {% note info %}

            Если буфер заполнится или истечет интервал отправки, данные будут переданы функции обработки.

            {% endnote %}

        * **Таймаут вызова** — укажите допустимое время ожидания ответа от функции обработки (в секундах).

        {% note warning %}

        Значения в полях **Интервал отправки** и **Таймаут вызова** указываются с постфиксом `s`, например, `10s`.

        {% endnote %}

    * **Правила конвертации**:

       * **Правила конвертации**:
         
            * **Формат данных** — выберите один из доступных форматов:
                * `JSON` — формат JSON. Для оптимизации пропускной способности поддерживается обработка сообщений JSON, записанных одной строкой — без символов перевода строки `\n`. Пример: `{"attr": "value"}`
                * `Парсер AuditTrails.v1` — формат логов сервиса [Audit Trails](../../../../audit-trails/index.md).
                * `Парсер CloudLogging` — формат логов сервиса [Cloud Logging](../../../../logging/index.md).
                * `Парсер Debezium CDC` — Debezium CDC. Позволяет указать настройки подключения к Schema Registry: `On Premise Schema Registry` для [Confluent Schema Registry](https://docs.confluent.io/platform/current/schema-registry/index.html), идентификатор [пространства имен](../../../../metadata-hub/operations/list-name-space.md) для `Yandex Schema Registry`.
                * `Парсер Raw-to-table` — позволяет сохранять сообщения целиком «как есть» в отдельную таблицу приемника.
         
                   Для формата **JSON** укажите:
         
                    * **Схема данных** — задайте схему в виде списка полей или загрузите файл с описанием схемы в формате JSON.
                     
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
             
                    * **Использовать значение NULL в ключевых столбцах** — выберите эту опцию, чтобы разрешить значение `null` в ключевых колонках.
                    * **Добавить неразмеченные столбцы** — выберите эту опцию, чтобы поля, отсутствующие в схеме, попадали в колонку `_rest`.
                    * **Разэкранировать значения строк** — выберите эту опцию, чтобы убрать кавычки из строковых переменных (если этого не сделать, значения строковых полей останутся без изменений).
         
                  Для **Debezium CDC** укажите:
                    * Для `On Premise Schema Registry` — URL для Schema Registry, способ аутентификации (с указанием логина и пароля пользователя в случае использования аутентификации) и CA-сертификат.
                    * Для `Yandex Schema Registry` — идентификатор [пространства имен](../../../../metadata-hub/operations/list-name-space.md) реестра схем.
         
                  Для **Raw-to-table** укажите:
                    * **Имя целевой таблицы** — имя таблицы, в которую сохраняются сообщения. По умолчанию совпадает с именем топика.
                    * **Сохранять ключ сообщения** — выберите эту опцию, чтобы записывать ключ сообщения в отдельный столбец.
                    * **Тип ключа** — выберите подходящий формат для записи ключа в таблицу.
                    * **Тип значения** — выберите подходящий формат для записи значения в таблицу.
                    * **Дополнительные параметры**:
                      * **Сохранять время записи** — выберите опцию, чтобы сохранять время записи сообщения в отдельном столбце.
                      * **Сохранять заголовки сообщения** — выберите опцию, чтобы сохранять заголовки сообщения в отдельном столбце.
                      * **Суффикс имени таблицы DLQ** — укажите суффикс, который будет использоваться для именования отдельной таблицы с недоставленными сообщениями по схеме `<имя_таблицы_сообщений>_<суффикс>`. По умолчанию применяется суффикс `_dlq`.    

    * **Кодеки сжатия** — укажите требуемый формат сжатия данных: `GZIP`, `ZSTD` или `Без сжатия`.

    * **Продолжать работу при превышении по TTL топика** — включите настройку, чтобы разрешить трансферу начать или продолжить чтение из топика, даже если часть данных в нем была удалена в связи с превышением периода хранения. Если настройка выключена, при превышении периода хранения и удалении данных из топика трансфер остановится с ошибкой. Обычно это происходит в случае, когда трансфер не успевает переносить все данные и отставание чтения превышает период хранения.
    
        {% note warning %}   

        Если вы впервые настраиваете поставку данных из топика, в который данные уже давно пишутся, либо включаете ее после длительного простоя и сталкиваетесь с ошибкой вида `Found rewind`, вы можете временно включить эту настройку, активировать трансфер, затем, после считывания всех данных и сокращения отставания, выключить настройку. 

        {% endnote %}

{% endlist %}


## Настройка приемника данных {#supported-targets}

Настройте один из поддерживаемых приемников данных:

* [PostgreSQL](../target/postgresql.md);
* [MySQL®](../target/mysql.md);
* [MongoDB](../target/mongodb.md)
* [ClickHouse®](../target/clickhouse.md);
* [Greenplum®](../target/greenplum.md);
* [Yandex Managed Service for YDB](../target/yandex-database.md);
* [Yandex Object Storage](../target/object-storage.md);
* [Apache Kafka®](../target/kafka.md);
* [YDS](../target/data-streams.md);
* [OpenSearch](../target/opensearch.md).

Полный список поддерживаемых источников и приемников в Yandex Data Transfer читайте в разделе [Доступные трансферы](../../../transfer-matrix.md).

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

## Решение проблем, возникающих при переносе данных {#troubleshooting}

* [Прерывание трансфера с ошибкой](#overloaded)
* [Редиректы Cloud Functions](#redirects)

Смотрите полный список рекомендаций в разделе [Решение проблем](../../../troubleshooting/index.md).

### Прерывание трансфера с ошибкой {#overloaded}

Трансфер типа _**Репликация**_ или _**Копирование и репликация**_ прерывается с ошибкой.

Текст ошибки:

```text
/Ydb.PersQueue.V1.PersQueueService/AddReadRule failed: OVERLOADED
```

Трансфер прерывается из-за ограничения облачной [квоты](https://console.yandex.cloud/cloud?section=quotas) на количество операций с Managed Service for YDB.

**Решение:**

1. Увеличьте в [квотах Managed Service for YDB](../../../../ydb/concepts/limits.md) на облако с нужной базой данных значение характеристики **Количество схемных операций в минуту** и [активируйте](../../transfer.md#activate) трансфер повторно.

### Редиректы Cloud Functions {#redirects}

В трансферах из Data Streams или Apache Kafka® в редких случаях может возникнуть ошибка:

```text
redirect to SOME_URL is requested but no redirects are allowed.
```

Возможная причина:

На источнике настроено использование функции Cloud Functions, которая возвращает не данные, а редирект на другой URL. 

**Решение:**

По соображениям безопасности такие редиректы запрещены. Воздержитесь от использования редиректов в Cloud Functions в трансферах.