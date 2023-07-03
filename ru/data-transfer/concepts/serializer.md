# Сериализация

Сериализация — процесс преобразования объекта данных в битовую последовательность во время передачи в приемники, которые работают с <q>сырыми</q> данными.

К таким приемникам относится [{{ objstorage-name }}](#serializer-s3), а также приемники, которые используют [очереди сообщений](#serializer-message-queue):

* {{ KF }}
* {{ yds-full-name }}

Сериализацию можно настроить во время [создания](../operations/endpoint/index.md#create) или [изменения](../operations/endpoint/index.md#update) эндпоинта-приемника.

## Сериализация {{ objstorage-name }} {#serializer-s3}

При сериализации {{ objstorage-name }} вы можете выбрать **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_format.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_JSON.title }}`, `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_CSV.title }}` или `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_RAW.title }}`. Для `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_JSON.title }}` можно преобразовать комплексные значения в строки.

## Сериализация при поставке в очереди сообщений {#serializer-message-queue}

При поставке в очередь сообщений вы можете использовать сериализацию двух типов:

* [{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_auto.title }}](#auto)
* [{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_debezium.title }}](#debezium)

### {{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_auto.title }} {#auto}

Автоматический выбор настроек сериализации в зависимости от типа источника.

### {{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_debezium.title }} {#debezium}

Сериализация [Debezium](https://debezium.io/) с возможностью настройки ее параметров:

* **dt.add.original.type.info** — определяет, добавлять ли информацию об исходных типах данных, чтобы восстановить их тип после переноса.

    Исключение — типы данных даты и времени {{ PG }} `with time zone`. Информацию о часовом поясе восстановить невозможно.

    Значение по умолчанию — `false`.

* **dt.mysql.timezone** — часовой пояс для типов данных даты и времени {{ MY }} в формате [IANA](https://www.iana.org/time-zones).

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

    Значение по умолчанию — `true`.

* **key.converter.basic.auth.user.info** и **value.converter.basic.auth.user.info** — имя пользователя и пароль для авторизации в Confluent Schema Registry для ключей и значений при использовании конвертера `io.confluent.connect.json.JsonSchemaConverter`.

    Формат значения: `<имя пользователя>:<пароль>`.

* **key.converter.ssl.ca** и **value.converter.ssl.ca** — содержимое SSL-сертификата Confluent Schema Registry для ключей и значений при использовании конвертера `io.confluent.connect.json.JsonSchemaConverter`.

    Если значение настройки не указано, SSL-сертификат не проверяется.

* **unavailable.value.placeholder** — значение, которое устанавливается вместо данных, если их тип не поддерживается.

    Значение по умолчанию — `__debezium_unavailable_value`.
