# Сериализация

Сериализация — процесс преобразования объекта данных в битовую последовательность во время передачи в приемники, которые работают с <q>сырыми</q> данными. К таким приемникам относятся:

* [Object Storage](#serializer-s3)
* [Очереди сообщений Apache Kafka® и Yandex Data Streams](#serializer-message-queue)

Сериализацию можно настроить во время [создания](../operations/endpoint/index.md#create) или [изменения](../operations/endpoint/index.md#update) эндпоинта-приемника.

## Сериализация при поставке в Object Storage {#serializer-s3}

При поставке в Object Storage вы можете выбрать **Выходной формат**: `JSON`, `CSV`, `PARQUET` или `Сырые данные`. Для `JSON` доступна настройка **Преобразовать комплексные значения в строки**.

Выходной формат данных зависит не только от выбора настройки **Выходной формат**, но и от типа и настроек правил конвертации эндпоинта-источника.

Ниже представлены различия выходных данных при отсутствии правил конвертации для эндпоинта-источника.

{% note info %}

Примеры выходных данных для формата `PARQUET` не приводятся, так как это бинарный формат.

{% endnote %}

### Yandex Data Streams {#yds}

Входные данные — два сообщения:

```text
Text string
{"device_id":"iv9,"speed":"5"}
```

Выходные данные:

{% list tabs %}

- JSON

    ```text
    {"data":"Text string","partition":<ключ_сегмента>,"seq_no":<порядковый_номер_сообщения>,"topic":"<имя_потока>","write_time":"<дата_и_время_записи_данных>"}
    {"data":"{\"device_id\":\"iv9\",\"speed\":5}","partition":<ключ_сегмента>,"seq_no":<порядковый_номер_сообщения>,"topic":"<имя_потока>","write_time":"<дата_и_время_записи_данных>"}
    ```

- CSV

    ```text
    <имя_потока>,<ключ_сегмента>,<порядковый_номер_сообщения>,<дата_и_время_записи_данных>,Text string
    <имя_потока>,<ключ_сегмента>,<порядковый_номер_сообщения>,<дата_и_время_записи_данных>,"{""device_id"":""iv9"",""speed"":5}"
    ```

- Сырые данные

    ```text
    Text string
    {"device_id":"iv9,"speed":"5"}
    ```

{% endlist %}

### Managed Service for PostgreSQL {#pg}

Входные данные — таблица:

| device_id | speed |
| --------- | ----- |
| iv9       | 5     |
| rhi       | 10    |

Выходные данные:

{% list tabs %}

- JSON

    ```text
    {"device_id":"iv9","speed":5}
    {"device_id":"rhi","speed":10}
    ```

- CSV

    ```text
    iv9,5,
    rhi,10,
    ````

- Сырые данные

    Не поддерживается.

{% endlist %}

## Сериализация при поставке в очереди сообщений {#serializer-message-queue}

При поставке в очередь сообщений вы можете использовать сериализацию двух типов:

* [Auto](#auto)
* [Debezium](#debezium)

### Auto {#auto}

Автоматический выбор настроек сериализации в зависимости от типа источника.

### Debezium {#debezium}

Сериализация [Debezium](https://debezium.io/) с возможностью настройки ее параметров:

* **dt.add.original.type.info** — определяет, добавлять ли информацию об исходных типах данных, чтобы восстановить их тип после переноса.

    Исключение — типы данных даты и времени PostgreSQL `with time zone`. Информацию о часовом поясе восстановить невозможно.

    Значение по умолчанию — `false`.

* **dt.batching.max.size** — максимальный размер пакета сообщений в байтах.

    Значение по умолчанию — `0` байт (пакетирование отключено). Рекомендуемое значение — `1048576` байт (1 МБ). Ненулевое значение включает пакетирование.

    Настройка актуальна, если используется JSON-сериализация со Schema Registry (смотрите параметры **key.converter** и **value.converter**). При использовании Schema Registry сообщения, приходящие в очередь, могут стать очень маленькими. Пакетирование в таком случае позволяет увеличить пропускную способность очередей.

    При включенном пакетировании в одно сообщение очереди помещаются последовательно несколько логических сообщений в формате [Confluent wire format](https://docs.confluent.io/cloud/current/sr/fundamentals/serdes-develop/index.html#wire-format). Данные, сериализованные таким образом, можно однозначно декодировать.

    При включенном пакетировании сообщения накапливаются в буфере. Если новое сообщение увеличивает размер пакета сверх установленного значения `dt.batching.max.size`, то текущий буфер сохраняется, а новое сообщение добавляется в пустой буфер. Если одно логическое сообщение из источника превышает значение `dt.batching.max.size`, то будет сформирован пакет из одного такого сообщения. Пакетирование происходит до компрессии в клиенте очереди.

    Включать пакетирование может быть полезно, чтобы оптимизировать тяжелую поставку в очередь, из которой сообщения считываются трансфером.

    {% note warning %}

    Пакетированные сообщения могут быть декодированы только трансфером.

    {% endnote %}

* **dt.mysql.timezone** — часовой пояс для типов данных даты и времени MySQL® в формате [IANA](https://www.iana.org/time-zones).

    Значение по умолчанию — `UTC`.

* **dt.unknown.types.policy** — политика поведения при обработке пользовательских типов данных.

    Возможные значения:

    * `skip` — не прерывать трансфер и игнорировать пользовательские типы данных.
    * `to_string` — не прерывать трансфер и преобразовать пользовательские типы данных в текст.
    * `fail` — прерывать трансфер с ошибкой.

    Значение по умолчанию — `skip`.

* **decimal.handling.mode** — режим обработки действительных чисел.

    Возможные значения:

    * `precise` — точное преобразование с помощью метода `java.math.BigDecimal`.
    * `double` — преобразование в тип данных `double`. Может привести к потере точности.
    * `string` — преобразование в текст.

    Значение по умолчанию — `precise`.

* **interval.handling.mode** — режим обработки временных интервалов.

    Возможные значения:

    * `numeric` — приблизительное преобразование в микросекунды.
    * `string` — точное преобразование с использованием строкового шаблона `P<years>Y<months>M<days>DT<hours>H<minutes>M<seconds>S`.

    Значение по умолчанию — `numeric`.

* **key.converter** и **value.converter** — конвертеры для ключей и значений.

    Возможные значения:

    * `org.apache.kafka.connect.json.JsonConverter` — JSON, стандартный для [Debezium](https://debezium.io/documentation/reference/index.html).
    * `io.confluent.connect.json.JsonSchemaConverter` — [Confluent Schema Registry](https://docs.confluent.io/platform/current/schema-registry/index.html).

    Значение по умолчанию — `org.apache.kafka.connect.json.JsonConverter`.

* **key.converter.schemas.enable** и **value.converter.schemas.enable** — определяют, добавлять ли описание схемы в каждое сообщение для ключей и значений при использовании конвертера `org.apache.kafka.connect.json.JsonConverter`.

    Значение по умолчанию — `true`.

* **key.converter.schema.registry.url** и **value.converter.schema.registry.url** — определяют, добавлять ли описание схемы в каждое сообщение для ключей и значений при использовании конвертера `io.confluent.connect.json.JsonSchemaConverter`.

    Возможные значения: 

    * пустая строка (значение по умолчанию) — не добавлять описание схемы;
    * строковое значение URL, определяющее путь к сервису реестра схем. 

* **key.converter.dt.json.generate.closed.content.schema** и **value.converter.dt.json.generate.closed.content.schema** — определяют, будет ли схема производителя данных для ключа и значения генерироваться в закрытой контентной модели. Это нужно для проверки совместимости через конвертацию открытой модели потребителя в закрытую и поиск аналогичной схемы среди зарегистрированных для производителя схем. 

    Значение по умолчанию — `false`.

    Чтобы сохранять полную транзитивную совместимость при добавлении и удалении опциональных полей в схеме ключа:

    1. Выберите в пространстве имен Schema Registry политику проверки совместимости `Optional-friendly`.
    1. В настройках сериализации эндпоинта-приемника Managed Service for Apache Kafka® [задайте настройку](../operations/endpoint/target/kafka.md#serializer) **key.converter.dt.json.generate.closed.content.schema** — `true`.

    Чтобы сохранять полную транзитивную совместимость при добавлении и удалении опциональных полей в схеме значения:

    1. Выберите в пространстве имен Schema Registry политику проверки совместимости `Optional-friendly`.
    1. В настройках сериализации эндпоинта-приемника [задайте настройку](../operations/endpoint/target/kafka.md#serializer) **value.converter.dt.json.generate.closed.content.schema** — `true`.    

* **key.converter.basic.auth.user.info** и **value.converter.basic.auth.user.info** — имя пользователя и пароль для аутентификации в Confluent Schema Registry для ключей и значений при использовании конвертера `io.confluent.connect.json.JsonSchemaConverter`.

    Формат значения: `<имя_пользователя>:<пароль>`.

* **key.converter.ssl.ca** и **value.converter.ssl.ca** — содержимое SSL-сертификата Confluent Schema Registry для ключей и значений при использовании конвертера `io.confluent.connect.json.JsonSchemaConverter`.

    Если значение настройки не указано, SSL-сертификат не проверяется.

* **tombstones.on.delete** — определяет, будет ли Debezium генерировать tombstone-маркеры удаления для топиков Apache Kafka®.

    Tombstone-маркеры записываются в лог кластера-источника Apache Kafka® во время удаления сообщений из топика. Они указывают на записи в логе, которые хранят предыдущие значения удаленных сообщений.

    Если [политика очистки лога](../../managed-kafka/concepts/settings-list.md#settings-topic-cleanup-policy) в кластере-источнике установлена в режим `Compact` или `CompactAndDelete`, во время сжатия лога будут удалены все записи, на которые указывают tombstone-маркеры.

    Значение по умолчанию — `true`.

    Подробнее о настройке в [документации Debezium](https://debezium.io/documentation/reference/stable/transformations/applying-transformations-selectively.html#ignoring-tombstone-events).

* **unavailable.value.placeholder** — значение, которое устанавливается вместо данных, если их тип не поддерживается.

    Значение по умолчанию — `__debezium_unavailable_value`.

## Примеры использования {#examples}

* [Поставка данных из очереди Apache Kafka® в ClickHouse®](../tutorials/mkf-to-mch.md)
* [Поставка данных из очереди Apache Kafka® в PostgreSQL](../tutorials/mkf-to-mpg.md)
* [Поставка данных из очереди YDS в ClickHouse®](../tutorials/yds-to-clickhouse.md)
* [Поставка данных из очереди в Yandex Object Storage с помощью Yandex Data Transfer](../tutorials/yds-to-objstorage.md)
* [Ввод данных в системы хранения](../tutorials/data-ingestion.md)