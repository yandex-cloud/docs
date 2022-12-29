# Configuring a Logbroker source endpoint

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, configure connection settings to Logbroker.

## Settings {#settings}

{% list tabs %}

- Management console

   * **Connection type**: Select **Cluster** or **Instance**, then select the name of the YT source cluster or instance from the list, for example, HAHN, ARNOLD, or FREUD.

   * **Consumer**: Logbroker consumer name.

   * **Topic**: Topic name.

   * **Parsing rules**: Data processing type. You can set parsing parameters for the `Universal parser`, `YQL parsing`, and `Logbroker parsing` types.

      * **Universal parser:**

         * **Data format**: `JSON` or `TSKV`.

         * **Data schema**: It can be specified by a list of fields, using a JSON file or one of the available Logfeller schemas.

            {% include notitle[schema-sample](../../../../_includes/data-transfer/fields/common/ui/json-schema-sample.md) %}

         * **Custom key columns**: The option enables you to exclude Logbroker deduplication keys from the list of custom key columns.

         * **Date-time column**: Defines the column name and date parsing rule in [Golang format](https://pkg.go.dev/time#Parse).

         * **NULL values in key columns**: Permits the use of NULL values in key columns.

         * **Adding Logbroker system columns**: Defines whether to add the `CreateTime` (`_lb_ctime`), `WriteTime` (`_lb_wtime`) columns, and all the `ExtraFields` columns with the `_lb_extra_` prefix.

      * **YQL parsing:**

         * **YQL script**: Parsing script.

         * **Data schema**: It can be specified by a list of fields, using a JSON file or one of the available Logfeller schemas.

            {% include notitle[schema-sample](../../../../_includes/data-transfer/fields/common/ui/json-schema-sample.md) %}

         * **Key result columns**: One or more key columns to record the result.

         * **Synthetic keys**: Adds the `_partition`, `_offset`, and `_idx` columns to the key.

      * **Logfeller parsing**

         * **Parser name**: Logfeller parser name.

         * **Data schema**: It can be specified by a list of fields, using a JSON file or one of the available Logfeller schemas.

            {% include notitle[schema-sample](../../../../_includes/data-transfer/fields/common/ui/json-schema-sample.md) %}

         * **Adding Logbroker system columns**: Defines whether to add the `CreateTime` (`_lb_ctime`), `WriteTime` (`_lb_wtime`) columns, and all the `ExtraFields` columns with the `_lb_extra_` prefix.

   * **Read settings**

      * **Maximum data delay**: Value in seconds before data consumption begins. The default value is `0 s`: Consume all data.

      * **Read buffer size**: The maximum amount of data read before being added. The default value is 52 MB.

      * **Continue operation when TTL is exceeded**: If the option is enabled, the transfer will continue with data loss. Otherwise, the transfer will be stopped with an error.

      * **Mask secrets**: If the option is used, the `AQAD-...` secrets will be replaced by `XXXXX`.

   * **Divide into subtables**: One or more columns by the value of which the input stream will be split into subtables. The order in which the columns are specified is important.

{% endlist %}
