**{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.converter.title }}**:

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.format.title }}**: Select one of the available formats:
       * `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_JSON.title }}`: JSON format.
       * `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_config_audit_trails_v1.title }}`: [{{ at-name }}](../../../../../audit-trails/) log format.
       * `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_config_common_cloud_logging.title }}`: [{{ cloud-logging-short-name }}](../../../../../logging/) log format.
       * `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_config_common_debezium_cdc.title }}`: Debezium CDC. It allows specifying [Confluent Schema Registry](https://docs.confluent.io/platform/current/schema-registry/index.html) in the settings. 
        
          For **JSON**, specify: 

           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.data_schema.title }}**: Specify the schema as a list of fields or upload a file with the description of the schema in JSON format.
            
           {% include notitle [json-schema-sample](../../common/ui/json-schema-sample.md) %}
    
           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.GenericParser.null_keys_allowed.title }}**: Select this option to allow the `null` value in key columns.
           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.add_rest_column.title }}**: Select this option to add the fields missing in the schema to the `_rest` column.
           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.parsers.GenericParserCommon.unescape_string_values.title }}**: Select this option to remove quotation marks from string variables. Otherwise, the string field values will remain unchanged.
           
         For **Debezium CDC**, specify the following: Schema Registry URL, authentication method (including the username and user password if authentication is used), and CA certificate. 