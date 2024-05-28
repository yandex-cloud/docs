`parser`: Conversion rules which depend on the selected parser:

* `audit_trails_v1_parser`: [{{ at-name }}](../../../../../audit-trails/) log parser.
* `cloud_logging_parser`: [{{ cloud-logging-short-name }}](../../../../../logging/) log parser.
* `json_parser` or `tskv_parser`: JSON and TSKV parsers, respectively.

   Both parsers use the same attributes to define parameters:

   * `data_schema`: Data schema represented either as a JSON object with a schema description or as a list of fields:

      * `fields`: Schema represented as a JSON object. The object contains an array of JSON objects that describe individual columns.
      * `json_fields`: Schema represented as a list of fields.

   * `null_keys_allowed`: Set to `true` to allow the `null` value in key columns.
   * `add_rest_column`: Set to `true` to add the fields missing in the schema to the `_rest` column.
   * `unescape_string_values`: Set to `true` to remove quotation marks from string variables. Otherwise, the string field values will remain unchanged.
