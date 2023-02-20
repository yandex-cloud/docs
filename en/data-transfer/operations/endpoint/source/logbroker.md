# Configuring a Logbroker source endpoint

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, configure connection settings to Logbroker.

## Settings {#settings}

{% list tabs %}

- Management console

   * **Connection type**: Select **Cluster** or **Instance**, then select the name of the YT source cluster or instance from the list, for example, HAHN, ARNOLD, or FREUD.

   * **Consumer**: Specify the Logbroker consumer name.

   * **Topic**: Specify the name of the topic the data will be coming from.

   * **Parsing rules**: Select the data processing type and set the parsing parameters.

      * **Universal parser:**

         * **Data format**: Select the format, `JSON` or `TSKV`.

         * **Data schema**: Set the schema as a list of fields by using a JSON file or one of the available Logfeller schemas.

            {% include notitle[schema-sample](../../../../_includes/data-transfer/fields/common/ui/json-schema-sample.md) %}

         * **Custom key columns**: Enable this option to exclude Logbroker deduplication keys from the list of custom key columns.

         * **Date and time column**: Specify the name of the column that sets the date parsing rule in [Golang format](https://pkg.go.dev/time#Parse).

         * **NULL values in key columns**: Enable this option to allow using `NULL` values in key columns.

         * **Adding Logbroker system columns**: Defines whether to add the `СreateTime` (`_lb_ctime`) and `WriteTime` (`_lb_wtime`) columns, as well as all `ExtraFields` columns with the `_lb_extra_` prefix.

      * **YQL parsing**

         * **YQL script**: Add your custom [YQL](https://ydb.tech/ru/docs/yql/reference/) code to read and process data from the Logbroker message queue.

            {% cut "Sample script for post processing" %}

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

         * **Data schema**: Set a schema as a list of fields (using a JSON specification file) or specify the ID of the descriptor file of the [Logfeller schema from the proto file](https://a.yandex-team.ru/arc/trunk/arcadia/logfeller/configs/parsers).

            {% include notitle[schema-sample](../../../../_includes/data-transfer/fields/common/ui/json-schema-sample.md) %}

            You can access the schema from your script using `FileContent()`.

         * **Key result columns**: Add one or more columns to be used as primary keys in the result entry.

         * **Synthetic keys**: Enable this setting if the data has no fields that can serve as primary keys or these fields are not enough to ensure row uniqueness. Adds the `_partition`, `_offset`, and `_idx` columns, that ensure row uniqueness, to the key.

      * **Logfeller parsing**

         * **Parser name**: Specify the Logfeller parser name.

         * **Data schema**: Set the schema as a list of fields by using a JSON file or one of the available Logfeller schemas.

            {% include notitle[schema-sample](../../../../_includes/data-transfer/fields/common/ui/json-schema-sample.md) %}

         * **Adding Logbroker system columns**: Defines whether to add the `СreateTime` (`_lb_ctime`) and `WriteTime` (`_lb_wtime`) columns, as well as all `ExtraFields` columns with the `_lb_extra_` prefix.

   * **Read settings**

      * **Maximum data delay**: Specify the value in seconds before data consumption starts. The default value is `0 s`, which means consuming all data.

      * **Read buffer size**: Specify the maximum amount of data that will be read before being added. The default value is 52 MB.

      * **Continue operation when TTL is exceeded**: Enable this option so that, when TTL is exceeded, the transfer continues with data loss. If this option is disabled, the transfer will be stopped with an error.

      * **Mask secrets**: Enable this option to replace `AQAD-...`-like secrets with `XXXXX`.

   * **Divide into subtables**: Specify one or more columns, the values of which will be used to break the input stream down into subtables. The order in which the columns are specified is important.

{% endlist %}
