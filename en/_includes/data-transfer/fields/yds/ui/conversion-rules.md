**{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.converter.title }}**:

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.format.title }}**: Select one of the available formats:
       * `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_JSON.title }}`: JSON. To optimize throughput, the system supports single-line JSON messages, i.e., those without line breaks introduced with `\n`. Example: `{"attr": "value"}`.
       * `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_config_audit_trails_v1.title }}`: [{{ at-name }}](../../../../../audit-trails/) log format.
       * `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_config_common_cloud_logging.title }}`: [{{ cloud-logging-short-name }}](../../../../../logging/) log format.
       * `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_config_common_debezium_cdc.title }}`: Debezium CDC. It allows you to specify settings for connection to Schema Registry: `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.title }}` for [Confluent Schema Registry](https://docs.confluent.io/platform/current/schema-registry/index.html), [namespace](../../../../../metadata-hub/operations/list-name-space.md) ID for `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.yandex_sr.title }}`.
       * `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_raw_to_table.title }}` allows saving whole messages "as is" to a separate table on the target.

          For **JSON**, specify:

           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.data_schema.title }}**: Specify the schema as a list of fields or upload a file with the description of the schema in JSON format.
            
           {% include notitle [json-schema-sample](../../common/ui/json-schema-sample.md) %}
    
           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.GenericParser.null_keys_allowed.title }}**: Select this option to allow the `null` value in key columns.
           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.add_rest_column.title }}**: Select this option to add the fields missing in the schema to the `_rest` column.
           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.parsers.GenericParserCommon.unescape_string_values.title }}**: Select this option to remove quotation marks from string variables. Otherwise, the string field values will remain unchanged.

         For **Debezium CDC**, specify the following:
           * For `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.title }}`: Schema Registry URL, authentication method (including username and password if authentication is used), and CA certificate.
           * For `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.yandex_sr.title }}`: Schema registry [namespace](../../../../../metadata-hub/operations/list-name-space.md) ID.

         For **Raw-to-table**, specify:
           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_raw_to_table.table_name.title }}**: Name of the table the messages are saved to. By default, matches the the topic name.
           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_raw_to_table.is_key_enabled.title }}**: Select this option to write the message key to a separate column.
           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_raw_to_table.key_type.title }}**: Select suitable format to write the key to the table.
           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_raw_to_table.key_type.title }}**: Select suitable format to write the value to the table.
           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_raw_to_table.advanced.title }}**:
             * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_raw_to_table.is_timestamp_enabled.title }}**: Select this option to save message write time in a separate column.
             * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_raw_to_table.is_headers_enabled.title }}**: Select this option to save message headers in a separate column.
             * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_raw_to_table.dlq_suffix.title }}**: Specify a suffix to append to the name of the separate undelivered message table according to the `<message_table_name>_<suffix>` pattern. The default suffix is `_dlq`.
