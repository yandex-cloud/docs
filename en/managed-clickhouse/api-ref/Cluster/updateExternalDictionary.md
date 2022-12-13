---
editable: false
sourcePath: en/_api-ref/mdb/clickhouse/api-ref/Cluster/updateExternalDictionary.md
---

# Managed Service for ClickHouse API, REST: Cluster.updateExternalDictionary
Updates an external dictionary for the specified ClickHouse cluster.
 

 
## HTTP request {#https-request}
```
POST https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}:updateExternalDictionary
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the ClickHouse cluster to update the external dictionary for. To get the cluster ID, use a [List] request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "externalDictionary": {
    "name": "string",
    "structure": {
      "id": {
        "name": "string"
      },
      "key": {
        "attributes": [
          {
            "name": "string",
            "type": "string",
            "nullValue": "string",
            "expression": "string",
            "hierarchical": true,
            "injective": true
          }
        ]
      },
      "rangeMin": {
        "name": "string",
        "type": "string",
        "nullValue": "string",
        "expression": "string",
        "hierarchical": true,
        "injective": true
      },
      "rangeMax": {
        "name": "string",
        "type": "string",
        "nullValue": "string",
        "expression": "string",
        "hierarchical": true,
        "injective": true
      },
      "attributes": [
        {
          "name": "string",
          "type": "string",
          "nullValue": "string",
          "expression": "string",
          "hierarchical": true,
          "injective": true
        }
      ]
    },
    "layout": {
      "type": "string",
      "sizeInCells": "string"
    },

    // `externalDictionary` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`
    "fixedLifetime": "string",
    "lifetimeRange": {
      "min": "string",
      "max": "string"
    },
    // end of the list of possible fields`externalDictionary`

    "httpSource": {
      "url": "string",
      "format": "string"
    },
    "mysqlSource": {
      "db": "string",
      "table": "string",
      "port": "string",
      "user": "string",
      "password": "string",
      "replicas": [
        {
          "host": "string",
          "priority": "string",
          "port": "string",
          "user": "string",
          "password": "string"
        }
      ],
      "where": "string",
      "invalidateQuery": "string"
    },
    "clickhouseSource": {
      "db": "string",
      "table": "string",
      "host": "string",
      "port": "string",
      "user": "string",
      "password": "string",
      "where": "string"
    },
    "mongodbSource": {
      "db": "string",
      "collection": "string",
      "host": "string",
      "port": "string",
      "user": "string",
      "password": "string"
    },
    "postgresqlSource": {
      "db": "string",
      "table": "string",
      "hosts": [
        "string"
      ],
      "port": "string",
      "user": "string",
      "password": "string",
      "invalidateQuery": "string",
      "sslMode": "string"
    }
  },
  "updateMask": "string"
}
```

 
Field | Description
--- | ---
externalDictionary | **object**<br><p>Configuration of the external dictionary.</p> 
externalDictionary.<br>name | **string**<br><p>Required. Name of the external dictionary.</p> 
externalDictionary.<br>structure | **object**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/).
externalDictionary.<br>structure.<br>id | **object**<br><p>Single numeric key column for the dictionary.</p> <p>Numeric key.</p> 
externalDictionary.<br>structure.<br>id.<br>name | **string**<br><p>Required. Name of the numeric key.</p> 
externalDictionary.<br>structure.<br>key | **object**<br><p>Composite key for the dictionary, containing of one or more key columns. For details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key">ClickHouse documentation</a>.</p> <p>Complex key.</p> 
externalDictionary.<br>structure.<br>key.<br>attributes[] | **object**<br><p>Required. Attributes of a complex key.</p> <p>Must contain at least one element.</p> 
externalDictionary.<br>structure.<br>key.<br>attributes[].<br>name | **string**<br><p>Required. Name of the column.</p> 
externalDictionary.<br>structure.<br>key.<br>attributes[].<br>type | **string**<br><p>Required. Type of the column.</p> 
externalDictionary.<br>structure.<br>key.<br>attributes[].<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
externalDictionary.<br>structure.<br>key.<br>attributes[].<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
externalDictionary.<br>structure.<br>key.<br>attributes[].<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: ``false``.</p> 
externalDictionary.<br>structure.<br>key.<br>attributes[].<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping "id -&gt; attribute". Default value: ``false``.</p> 
externalDictionary.<br>structure.<br>rangeMin | **object**<br><p>Field holding the beginning of the range for dictionaries with ``RANGE_HASHED`` layout. For details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed">ClickHouse documentation</a>.</p> 
externalDictionary.<br>structure.<br>rangeMin.<br>name | **string**<br><p>Required. Name of the column.</p> 
externalDictionary.<br>structure.<br>rangeMin.<br>type | **string**<br><p>Required. Type of the column.</p> 
externalDictionary.<br>structure.<br>rangeMin.<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
externalDictionary.<br>structure.<br>rangeMin.<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
externalDictionary.<br>structure.<br>rangeMin.<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: ``false``.</p> 
externalDictionary.<br>structure.<br>rangeMin.<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping "id -&gt; attribute". Default value: ``false``.</p> 
externalDictionary.<br>structure.<br>rangeMax | **object**<br><p>Field holding the end of the range for dictionaries with ``RANGE_HASHED`` layout. For details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed">ClickHouse documentation</a>.</p> 
externalDictionary.<br>structure.<br>rangeMax.<br>name | **string**<br><p>Required. Name of the column.</p> 
externalDictionary.<br>structure.<br>rangeMax.<br>type | **string**<br><p>Required. Type of the column.</p> 
externalDictionary.<br>structure.<br>rangeMax.<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
externalDictionary.<br>structure.<br>rangeMax.<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
externalDictionary.<br>structure.<br>rangeMax.<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: ``false``.</p> 
externalDictionary.<br>structure.<br>rangeMax.<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping "id -&gt; attribute". Default value: ``false``.</p> 
externalDictionary.<br>structure.<br>attributes[] | **object**<br><p>Required. Description of the fields available for database queries. For details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes">ClickHouse documentation</a>.</p> <p>Must contain at least one element.</p> 
externalDictionary.<br>structure.<br>attributes[].<br>name | **string**<br><p>Required. Name of the column.</p> 
externalDictionary.<br>structure.<br>attributes[].<br>type | **string**<br><p>Required. Type of the column.</p> 
externalDictionary.<br>structure.<br>attributes[].<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
externalDictionary.<br>structure.<br>attributes[].<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
externalDictionary.<br>structure.<br>attributes[].<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: ``false``.</p> 
externalDictionary.<br>structure.<br>attributes[].<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping "id -&gt; attribute". Default value: ``false``.</p> 
externalDictionary.<br>layout | **object**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/).
externalDictionary.<br>layout.<br>type | **string**<br><p>Required. Layout type for an external dictionary.</p> <ul> <li>FLAT: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li> <li>HASHED: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li> <li>COMPLEX_KEY_HASHED: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li> <li>RANGE_HASHED: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li> <li>CACHE: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li> <li>COMPLEX_KEY_CACHE: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li> </ul> 
externalDictionary.<br>layout.<br>sizeInCells | **string** (int64)<br><p>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types.</p> 
externalDictionary.<br>fixedLifetime | **string** (int64) <br>`externalDictionary` includes only one of the fields `fixedLifetime`, `lifetimeRange`<br><br><p>Fixed interval between dictionary updates.</p> 
externalDictionary.<br>lifetimeRange | **object**<br>Range of intervals between dictionary updates for ClickHouse to choose from. <br>`externalDictionary` includes only one of the fields `fixedLifetime`, `lifetimeRange`<br>
externalDictionary.<br>lifetimeRange.<br>min | **string** (int64)<br><p>Minimum dictionary lifetime.</p> 
externalDictionary.<br>lifetimeRange.<br>max | **string** (int64)<br><p>Maximum dictionary lifetime.</p> 
externalDictionary.<br>httpSource | **object**<br>HTTP source for the dictionary. <br>`externalDictionary` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
externalDictionary.<br>httpSource.<br>url | **string**<br><p>Required. URL of the source dictionary available over HTTP.</p> 
externalDictionary.<br>httpSource.<br>format | **string**<br><p>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect.</p> 
externalDictionary.<br>mysqlSource | **object**<br>MySQL source for the dictionary. <br>`externalDictionary` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
externalDictionary.<br>mysqlSource.<br>db | **string**<br><p>Required. Name of the MySQL database to connect to.</p> 
externalDictionary.<br>mysqlSource.<br>table | **string**<br><p>Required. Name of the database table to use as a ClickHouse dictionary.</p> 
externalDictionary.<br>mysqlSource.<br>port | **string** (int64)<br><p>Default port to use when connecting to a replica of the dictionary source.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
externalDictionary.<br>mysqlSource.<br>user | **string**<br><p>Name of the default user for replicas of the dictionary source.</p> 
externalDictionary.<br>mysqlSource.<br>password | **string**<br><p>Password of the default user for replicas of the dictionary source.</p> 
externalDictionary.<br>mysqlSource.<br>replicas[] | **object**<br><p>Required. List of MySQL replicas of the database used as dictionary source.</p> <p>Must contain at least one element.</p> 
externalDictionary.<br>mysqlSource.<br>replicas[].<br>host | **string**<br><p>Required. MySQL host of the replica.</p> <p>The maximum string length in characters is 253.</p> 
externalDictionary.<br>mysqlSource.<br>replicas[].<br>priority | **string** (int64)<br><p>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number.</p> <p>Value must be greater than 0.</p> 
externalDictionary.<br>mysqlSource.<br>replicas[].<br>port | **string** (int64)<br><p>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
externalDictionary.<br>mysqlSource.<br>replicas[].<br>user | **string**<br><p>Name of the MySQL database user.</p> 
externalDictionary.<br>mysqlSource.<br>replicas[].<br>password | **string**<br><p>Password of the MySQL database user.</p> 
externalDictionary.<br>mysqlSource.<br>where | **string**<br><p>Selection criteria for the data in the specified MySQL table.</p> 
externalDictionary.<br>mysqlSource.<br>invalidateQuery | **string**<br><p>Query for checking the dictionary status, to pull only updated data. For more details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/">ClickHouse documentation on dictionaries</a>.</p> 
externalDictionary.<br>clickhouseSource | **object**<br>ClickHouse source for the dictionary. <br>`externalDictionary` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
externalDictionary.<br>clickhouseSource.<br>db | **string**<br><p>Required. Name of the ClickHouse database.</p> 
externalDictionary.<br>clickhouseSource.<br>table | **string**<br><p>Required. Name of the table in the specified database to be used as the dictionary source.</p> 
externalDictionary.<br>clickhouseSource.<br>host | **string**<br><p>Required. ClickHouse host of the specified database.</p> <p>The maximum string length in characters is 253.</p> 
externalDictionary.<br>clickhouseSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
externalDictionary.<br>clickhouseSource.<br>user | **string**<br><p>Required. Name of the ClickHouse database user.</p> 
externalDictionary.<br>clickhouseSource.<br>password | **string**<br><p>Password of the ClickHouse database user.</p> 
externalDictionary.<br>clickhouseSource.<br>where | **string**<br><p>Selection criteria for the data in the specified ClickHouse table.</p> 
externalDictionary.<br>mongodbSource | **object**<br>MongoDB source for the dictionary. <br>`externalDictionary` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
externalDictionary.<br>mongodbSource.<br>db | **string**<br><p>Required. Name of the MongoDB database.</p> 
externalDictionary.<br>mongodbSource.<br>collection | **string**<br><p>Required. Name of the collection in the specified database to be used as the dictionary source.</p> 
externalDictionary.<br>mongodbSource.<br>host | **string**<br><p>Required. MongoDB host of the specified database.</p> <p>The maximum string length in characters is 253.</p> 
externalDictionary.<br>mongodbSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
externalDictionary.<br>mongodbSource.<br>user | **string**<br><p>Required. Name of the MongoDB database user.</p> 
externalDictionary.<br>mongodbSource.<br>password | **string**<br><p>Password of the MongoDB database user.</p> 
externalDictionary.<br>postgresqlSource | **object**<br>PostgreSQL source for the dictionary. <br>`externalDictionary` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
externalDictionary.<br>postgresqlSource.<br>db | **string**<br><p>Required. Name of the PostrgreSQL database.</p> 
externalDictionary.<br>postgresqlSource.<br>table | **string**<br><p>Required. Name of the table in the specified database to be used as the dictionary source.</p> 
externalDictionary.<br>postgresqlSource.<br>hosts[] | **string**<br><p>Required. Name of the PostrgreSQL host</p> <p>Must contain at least one element.</p> 
externalDictionary.<br>postgresqlSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
externalDictionary.<br>postgresqlSource.<br>user | **string**<br><p>Required. Name of the PostrgreSQL database user.</p> 
externalDictionary.<br>postgresqlSource.<br>password | **string**<br><p>Password of the PostrgreSQL database user.</p> 
externalDictionary.<br>postgresqlSource.<br>invalidateQuery | **string**<br><p>Query for checking the dictionary status, to pull only updated data. For more details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/">ClickHouse documentation on dictionaries</a>.</p> 
externalDictionary.<br>postgresqlSource.<br>sslMode | **string**<br><p>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see <a href="https://www.postgresql.org/docs/current/libpq-ssl.html">PostgreSQL documentation</a>.</p> <ul> <li>DISABLE: Only try a non-SSL connection.</li> <li>ALLOW: First try a non-SSL connection; if that fails, try an SSL connection.</li> <li>PREFER: First try an SSL connection; if that fails, try a non-SSL connection.</li> <li>VERIFY_CA: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li> <li>VERIFY_FULL: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li> </ul> 
updateMask | **string**<br><p>Field mask that specifies which fields of the External Dictionary should be updated.</p> <p>A comma-separated names off ALL fields to be updated. Only the specified fields will be changed. The others will be left untouched. If the field is specified in ``updateMask`` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If ``updateMask`` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 