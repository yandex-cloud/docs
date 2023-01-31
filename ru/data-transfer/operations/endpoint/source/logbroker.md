# Настройка эндпоинта-источника Logbroker

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта задайте настройки подключения к Logbroker.

## Настройки {#settings}

{% list tabs %}

- Консоль управления

    * **Тип подключения** — выберите **Кластер** или **Инстанс**, затем выберите из списка имя кластера или инстанса источника YT, например, "HAHN", "ARNOLD" или "FREUD".
  
    * **Консьюмер** — укажите имя Logbroker-консьюмера.

    * **Топик** — укажите имя топика, из которого будут поступать данные.

    * **Правила парсинга** — выберите тип обработки данных и задайте параметры парсинга.
  
      * **Универсальный парсер:**

        * **Формат данных** — выберите формат: `JSON` или `TSKV`.

        * **Схема данных** — задайте схему в виде списка полей, с помощью JSON-файла или одной из доступных схем Logfeller.

          {% include notitle[Пример схемы](../../../../_includes/data-transfer/fields/common/ui/json-schema-sample.md) %}

        * **Пользовательские ключевые столбцы** — включите настройку, чтобы исключить ключи дедупликации Logbroker из перечня пользовательских ключевых столбцов.

        * **Столбец, содержащий дату-время** — укажите имя столбца, по которому определяется правило парсинга даты в [формате Golang](https://pkg.go.dev/time#Parse).

        * **Значения NULL в ключевых столбцах** — включите настройку, чтобы разрешить использовать значения `NULL` в ключевых столбцах.

        * **Добавление системных столбцов Logbroker** — включите настройку, чтобы добавить столбцы `СreateTime` (`_lb_ctime`), `WriteTime` (`_lb_wtime`) и все столбцы `ExtraFields` с префиксом `_lb_extra_`.

      * **YQL-парсинг**

        * **YQL-скрипт** — добавьте пользовательский код на [языке YQL](https://ydb.tech/ru/docs/yql/reference/), который читает и обрабатывает данные из очереди сообщений Logbroker.

           {% cut "Пример скрипта для пост-обработки" %}

           ```sql
           $custom_config = AsStruct(
             "schema" as descriptor_file,
             "DatacampMessage" as message_type,
             false as framed_events,
             false as use_defaults,
             false as compressed_binary,
             AsDict(AsTuple(
               "schem\", FileContent("schema"))) as resources);
           $dumped_config = Unwrap(ToBytes(Yson::SerializeText(Yson::From($custom_config))));
           $parse_raw = YQL::Udf(AsAtom(\"LogFellerParsers.ParseProto\"), YQL::Void(), YQL::Void(), AsAtom($dumped_config));

           $parsed =
            SELECT 
              ParsedRecord, _partition, _offset, _seqno 
            FROM(
              SELECT 
                $parse_raw(Data) as parsed_records, 
                Data as raw_record, 
                Partition as _partition, 
                Offset as _offset, 
                SeqNo as _seqno
              FROM Input )
            FLATTEN COLUMNS;

           $rows = 
             SELECT * FROM (
               SELECT ParsedRecord, _partition, _offset, _seqno 
               FROM $parsed)
             FLATTEN COLUMNS;

           SELECT * FROM (
             SELECT * FROM $rows
             FLATTEN LIST BY (Yson::ConvertToList(market_skus.msku) as market_skus_msku)
           ) FLATTEN COLUMNS;
           ```

           {% endcut %}

        * **Схема данных** — задайте схему в виде списка полей, с помощью файла JSON-спецификации или укажите ID файла-дескриптора [схемы Logfeller из proto-файла](https://a.yandex-team.ru/arc/trunk/arcadia/logfeller/configs/parsers).

            {% include notitle[Пример схемы](../../../../_includes/data-transfer/fields/common/ui/json-schema-sample.md) %}

            В скрипте к заданной схеме можно обратиться через `FileContent()`.

        * **Ключевые столбцы результаты** — добавьте один или несколько столбцов для использования в качестве первичных ключей записи результата.

        * **Синтетические ключи** — включите настройку, если в данных нет подходящих для первичного ключа полей или их недостаточно для уникальности строк. Добавляет в ключ служебные столбцы `_partition`, `_offset` и `_idx`, которые гарантируют уникальность строк.

      * **Парсинг Logfeller**

        * **Имя парсера** — укажите имя парсера Logfeller.

        * **Схема данных** — задайте схему в виде списка полей, с помощью JSON-файла или одной из доступных схем Logfeller.

          {% include notitle[Пример схемы](../../../../_includes/data-transfer/fields/common/ui/json-schema-sample.md) %}

        * **Добавление системных столбцов Logbroker** — включите настройку, чтобы добавить столбцы `СreateTime` (`_lb_ctime`), `WriteTime` (`_lb_wtime`) и все столбцы `ExtraFields` с префиксом `_lb_extra_`.

    * **Настройки чтения**

      * **Максимальная задержка данных** — укажите значение в секундах до начала потребления данных. Значение по умолчанию: `0 с` - потреблять все данные.

      * **Размер буфера чтения** — укажите максимальное количество прочитанных данных перед добавлением. Значение по умолчанию: 52 МБ.

      * **Продолжать работу при превышении по TTL** — включите настройку, чтобы при превышении по TTL продолжить трансфер с потерей данных. Если настройка выключена, трансфер будет остановлен с ошибкой.

      * **Маскировать секреты** — включите настройку, чтобы заменить секреты вида `AQAD-...` на символы `XXXXX`.

    * **Делить на подтаблицы** — укажите один или несколько столбцов, по значению которых входной поток будет разбиваться на подтаблицы. Порядок указания столбцов важен.

{% endlist %}
