# Configuring a Logfeller source endpoint

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, configure access to Logfeller.

## Settings {#settings}

{% list tabs %}

- Management console

   * **Logbroker topic**: The topic that data will come from.

   * **YT delivery**: Configuring [YT delivery](https://logbroker.yandex-team.ru/docs/how_to/configuration#configuring-yt-delivery) for a topic. Configure YT delivery for a topic yourself.

   * **YT operations settings for indexing**:

      * **Pool**: The pool where operations in YT will be run to process the log data.

      * **Specification**: [Specifications of YT operations in JSON format](https://yt.yandex-team.ru/docs/description/mr/operations_options#obshie-opcii-dlya-vseh-tipov-operacij). Enables you to redefine the settings.

   * **Parsing settings**:

      * **Splitting rule**: The rule for splitting data into strings in a Logbroker chunk. Select a value from the list.

      * **Parser**: Select a parser type: **External parser** or **Embedded parser**.

         * **External parser**: Specify a parser from [Logfeller config](https://a.yandex-team.ru/arc/trunk/arcadia/logfeller/configs/parsers/parsers.auto.json).

         * **Embedded parser**:

            * **Basic options**:

               * **Event time**: Taken into account at the indexing stage to tabulate the analyzed data by time. Select a value from the list.

               * **TimeZone field**: Used if the time zone in the data is written as a separate field and in `TZMode=PARSE` format.

               * **Time field value format**: Specify the time in Unixtime seconds or a formatted string specifying the time format value and time zone.

               * **Additional time format**: An alternative time format. Specify the time in Unixtime seconds or a formatted string specifying the time format value and time zone.

               * **Enable PUID column hashing**: Select to activate hashing of the PUID column.

               * **List of precomputers**: [Precomputers](https://a.yandex-team.ru/svn/trunk/arcadia/logfeller/lib/parsing/precompute/README.md#dostupnye-prekomptery) add calculated columns. For a complete list of available precomputers, see the [documentation](https://a.yandex-team.ru/arc/trunk/arcadia/logfeller/configs/parsers/precomputers.json).

            * **Raw format description**: Description of JSON or TSKV formats before processing:

               * **JSON**: Use it to delete extracted fields, add the `_rest` field to log all fields not specified in the schema, process integer values from the string, and validate UTF-8 strings.

               * **TSKV**: Use the options to skip fields not specified in the schema and to prohibit the use of fields not specified in the schema.

               * **Data schema**: Can be specified by a list of fields, in a JSON configuration file, or using an external schema by specifying its ID.

                  {% include notitle[Пример схемы](../../../../_includes/data-transfer/fields/common/ui/json-schema-sample.md) %}

   * **Additional resources**: Use to connect specific resources stored in Cypress by a user parser or precomputer.

   * **Secure YT environment variables**: Use if secure environment variables need to be set in the parsing process: `key` is the variable name, `value` is the secret ID in `vault-api.passport.yandex.net`.

{% endlist %}
