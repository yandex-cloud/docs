# Configuring source endpoints {{ yds-full-name }}

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* Stream [connection settings](#managed-service) in [{{ yds-full-name }}](#managed-service). These are required parameters.
* [Additional settings](#additional-settings).

## Basic settings {#managed-service}

{% list tabs %}

- Management console

   {% include [Data Streams UI](../../../../_includes/data-transfer/necessary-settings/ui/yandex-data-streams-source.md) %}

{% endlist %}

## Advanced settings {#additional-settings}

{% include [Note processing order](../../../../_includes/data-transfer/notes/kafka-yds-evhub-processing-order.md) %}

{% list tabs %}

- Management console

   
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.transformer.title }}**

      Rules for processing an incoming stream using a {{ sf-name }} function:

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.cloud_function.title }}**: Select one of the functions created in [{{ sf-full-name }}](../../../../functions/).

         
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.service_account_id.title }}**: Select or [create](../../../../iam/operations/sa/create.md) a service account that the processing function will start under.


      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.number_of_retries.title }}**: Set the number of attempts to invoke the processing function.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.buffer_size.title }}**: Set the size of the buffer (in bytes) which when full data will be transferred to the processing function.

         The maximum buffer size is 3.5 MB. For more information about restrictions that apply when working with functions in {{ sf-name }}, see the [corresponding section](../../../../functions/concepts/limits.md).

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.buffer_flush_interval.title }}**: Set the duration of the interval (in seconds) after the expiration of which the data from the stream should be transferred to the processing function.

         {% note info %}

         If the buffer becomes full or the sending interval expires, the data is transferred to the processing function.

         {% endnote %}

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.invocation_timeout.title }}**: Set the allowed timeout of the response from the processing function (in seconds).

      {% note warning %}

      Values in the **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.buffer_flush_interval.title }}** and **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.invocation_timeout.title }}** fields are specified with the `s` postfix, for example, `10s`.

      {% endnote %}


   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.converter.title }}**:

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.format.title }}**: Select one of the available formats:
         * `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_JSON.title }}`: JSON format.
         * `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_config_audit_trails_v1.title }}`: [{{ at-name }}](../../../../audit-trails/) log format.
         * `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_config_common_cloud_logging.title }}`: [{{ cloud-logging-short-name }}](../../../../logging) log format.

         For JSON, specify:

         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.data_schema.title }}**: Specify the schema as a list of fields or upload a file with a description of the schema in JSON format.

         {% include notitle [json-schema-sample](../../../../_includes/data-transfer/fields/common/ui/json-schema-sample.md) %}

         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.add_rest_column.title }}**: Select this option to have the fields missing in the schema appear in the `_rest` column.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.null_keys_allowed.title }}**: Select this option to allow the `null` value in key columns.

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.supported_codecs.title }}**: Set the required data compression format (`{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YdsSupportedCodecs.gzip.title }}`, `{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YdsSupportedCodecs.zstd.title }}`, or `{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YdsSupportedCodecs.raw.title }}`).

{% endlist %}
