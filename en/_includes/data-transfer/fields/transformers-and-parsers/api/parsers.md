`parser`: Conversion rules which depend on the selected parser:

* `auditTrailsV1Parser`: [{{ at-name }}](../../../../../audit-trails/) log parser.

* `cloudLoggingParser`: [{{ cloud-logging-short-name }}](../../../../../logging/) log parser.

* `jsonParser` or `tskvParser`: JSON and TSKV parsers, respectively.

   Both parsers share the same parameter fields:

   * `dataSchema`: Data schema represented either as a JSON object with a schema description or as a list of fields:

      * `fields`: Schema represented as a JSON object. The object contains an array of JSON objects that describe individual columns.

      * `jsonFields`: Schema represented as a list of fields.

   * `nullKeysAllowed`: Set to `true` to allow the `null` value in key columns.

   * `addRestColumn`: Set to `true` to add the fields missing in the schema to the `_rest` column.

   * `unescapeStringValues`: Set to `true` to remove quotation marks from string variables. Otherwise, the string field values will remain unchanged.
