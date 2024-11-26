---
editable: false
sourcePath: en/_api-ref-grpc/mdb/clickhouse/v1/api-ref/grpc/Cluster/listExternalDictionaries.md
---

# Managed Service for ClickHouse API, gRPC: ClusterService.ListExternalDictionaries

Retrieves a list of external dictionaries that belong to specified cluster.

## gRPC request

**rpc ListExternalDictionaries ([ListClusterExternalDictionariesRequest](#yandex.cloud.mdb.clickhouse.v1.ListClusterExternalDictionariesRequest)) returns ([ListClusterExternalDictionariesResponse](#yandex.cloud.mdb.clickhouse.v1.ListClusterExternalDictionariesResponse))**

## ListClusterExternalDictionariesRequest {#yandex.cloud.mdb.clickhouse.v1.ListClusterExternalDictionariesRequest}

```json
{
  "cluster_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the cluster that the external dictionaries belong to. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListClusterExternalDictionaryResponse.next_page_token]
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the [ListClusterExternalDictionaryResponse.next_page_token]
returned by a previous list request. ||
|#

## ListClusterExternalDictionariesResponse {#yandex.cloud.mdb.clickhouse.v1.ListClusterExternalDictionariesResponse}

```json
{
  "external_dictionaries": [
    {
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
              "null_value": "string",
              "expression": "string",
              "hierarchical": "bool",
              "injective": "bool"
            }
          ]
        },
        "range_min": {
          "name": "string",
          "type": "string",
          "null_value": "string",
          "expression": "string",
          "hierarchical": "bool",
          "injective": "bool"
        },
        "range_max": {
          "name": "string",
          "type": "string",
          "null_value": "string",
          "expression": "string",
          "hierarchical": "bool",
          "injective": "bool"
        },
        "attributes": [
          {
            "name": "string",
            "type": "string",
            "null_value": "string",
            "expression": "string",
            "hierarchical": "bool",
            "injective": "bool"
          }
        ]
      },
      "layout": {
        "type": "Type",
        "size_in_cells": "int64",
        "max_array_size": "int64"
      },
      // Includes only one of the fields `fixed_lifetime`, `lifetime_range`
      "fixed_lifetime": "int64",
      "lifetime_range": {
        "min": "int64",
        "max": "int64"
      },
      // end of the list of possible fields
      // Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`
      "http_source": {
        "url": "string",
        "format": "string",
        "headers": [
          {
            "name": "string",
            "value": "string"
          }
        ]
      },
      "mysql_source": {
        "db": "string",
        "table": "string",
        "port": "int64",
        "user": "string",
        "password": "string",
        "replicas": [
          {
            "host": "string",
            "priority": "int64",
            "port": "int64",
            "user": "string",
            "password": "string"
          }
        ],
        "where": "string",
        "invalidate_query": "string",
        "close_connection": "google.protobuf.BoolValue",
        "share_connection": "google.protobuf.BoolValue"
      },
      "clickhouse_source": {
        "db": "string",
        "table": "string",
        "host": "string",
        "port": "int64",
        "user": "string",
        "password": "string",
        "where": "string",
        "secure": "google.protobuf.BoolValue"
      },
      "mongodb_source": {
        "db": "string",
        "collection": "string",
        "host": "string",
        "port": "int64",
        "user": "string",
        "password": "string",
        "options": "string"
      },
      "postgresql_source": {
        "db": "string",
        "table": "string",
        "hosts": [
          "string"
        ],
        "port": "int64",
        "user": "string",
        "password": "string",
        "invalidate_query": "string",
        "ssl_mode": "SslMode"
      }
      // end of the list of possible fields
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| external_dictionaries[] | **[ExternalDictionary](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary)**

List of ClickHouse Cluster external dictionaries. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListClusterExternalDictionaryRequest.page_size], use the `next_page_token` as the value
for the [ListClusterExternalDictionaryRequest.page_token] parameter in the next list request. Each subsequent
list request will have its own `next_page_token` to continue paging through the results. ||
|#

## ExternalDictionary {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the external dictionary. ||
|| structure | **[Structure](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure)**

Required field. Set of attributes for the external dictionary.
For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/). ||
|| layout | **[Layout](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Layout)**

Required field. Layout for storing the dictionary in memory.
For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/). ||
|| fixed_lifetime | **int64**

Fixed interval between dictionary updates.

Includes only one of the fields `fixed_lifetime`, `lifetime_range`.

Setting for the period of time between dictionary updates.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). ||
|| lifetime_range | **[Range](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Range)**

Range of intervals between dictionary updates for ClickHouse to choose from.

Includes only one of the fields `fixed_lifetime`, `lifetime_range`.

Setting for the period of time between dictionary updates.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). ||
|| http_source | **[HttpSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource)**

HTTP source for the dictionary.

Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`.

Description of the source for the external dictionary. ||
|| mysql_source | **[MysqlSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource)**

MySQL source for the dictionary.

Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`.

Description of the source for the external dictionary. ||
|| clickhouse_source | **[ClickhouseSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.ClickhouseSource)**

ClickHouse source for the dictionary.

Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`.

Description of the source for the external dictionary. ||
|| mongodb_source | **[MongodbSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MongodbSource)**

MongoDB source for the dictionary.

Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`.

Description of the source for the external dictionary. ||
|| postgresql_source | **[PostgresqlSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.PostgresqlSource)**

PostgreSQL source for the dictionary.

Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`.

Description of the source for the external dictionary. ||
|#

## Structure {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure}

#|
||Field | Description ||
|| id | **[Id](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Id)**

Single numeric key column for the dictionary. ||
|| key | **[Key](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Key)**

Composite key for the dictionary, containing of one or more key columns.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). ||
|| range_min | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**

Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). ||
|| range_max | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**

Field holding the end of the range for dictionaries with `RANGE_HASHED` layout.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). ||
|| attributes[] | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**

Description of the fields available for database queries.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes). ||
|#

## Id {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Id}

Numeric key.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the numeric key. ||
|#

## Key {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Key}

Complex key.

#|
||Field | Description ||
|| attributes[] | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**

Attributes of a complex key. ||
|#

## Attribute {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the column. ||
|| type | **string**

Required field. Type of the column. ||
|| null_value | **string**

Default value for an element without data (for example, an empty string). ||
|| expression | **string**

Expression, describing the attribute, if applicable. ||
|| hierarchical | **bool**

Indication of hierarchy support.
Default value: `false`. ||
|| injective | **bool**

Indication of injective mapping "id -> attribute".
Default value: `false`. ||
|#

## Layout {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Layout}

Layout determining how to store the dictionary in memory.

#|
||Field | Description ||
|| type | enum **Type**

Required field. Layout type for an external dictionary.

- `TYPE_UNSPECIFIED`
- `FLAT`: The entire dictionary is stored in memory in the form of flat arrays.
Available for all dictionary sources.
- `HASHED`: The entire dictionary is stored in memory in the form of a hash table.
Available for all dictionary sources.
- `COMPLEX_KEY_HASHED`: Similar to HASHED, to be used with composite keys.
Available for all dictionary sources.
- `RANGE_HASHED`: The entire dictionary is stored in memory in the form of a hash table,
with an ordered array of ranges and their corresponding values.
Available for all dictionary sources.
- `CACHE`: The dictionary is stored in a cache with a set number of cells.
Available for MySQL, ClickHouse and HTTP dictionary sources.
- `COMPLEX_KEY_CACHE`: Similar to CACHE, to be used with composite keys.
Available for MySQL, ClickHouse and HTTP dictionary sources. ||
|| size_in_cells | **int64**

Number of cells in the cache. Rounded up to a power of two.
Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. ||
|| max_array_size | **int64**

Maximum dictionary key size.
Applicable only for FLAT layout type. ||
|#

## Range {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Range}

#|
||Field | Description ||
|| min | **int64**

Minimum dictionary lifetime. ||
|| max | **int64**

Maximum dictionary lifetime. ||
|#

## HttpSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource}

#|
||Field | Description ||
|| url | **string**

Required field. URL of the source dictionary available over HTTP. ||
|| format | **string**

Required field. The data format. Valid values are all formats supported by ClickHouse SQL dialect. ||
|| headers[] | **[Header](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource.Header)**

HTTP headers. ||
|#

## Header {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource.Header}

#|
||Field | Description ||
|| name | **string**

Required field.  ||
|| value | **string**

Required field.  ||
|#

## MysqlSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource}

#|
||Field | Description ||
|| db | **string**

Required field. Name of the MySQL database to connect to. ||
|| table | **string**

Required field. Name of the database table to use as a ClickHouse dictionary. ||
|| port | **int64**

Default port to use when connecting to a replica of the dictionary source. ||
|| user | **string**

Name of the default user for replicas of the dictionary source. ||
|| password | **string**

Password of the default user for replicas of the dictionary source. ||
|| replicas[] | **[Replica](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource.Replica)**

List of MySQL replicas of the database used as dictionary source. ||
|| where | **string**

Selection criteria for the data in the specified MySQL table. ||
|| invalidate_query | **string**

Query for checking the dictionary status, to pull only updated data.
For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). ||
|| close_connection | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Should the connection be closed after each request. ||
|| share_connection | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Should a connection be shared for some requests. ||
|#

## Replica {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource.Replica}

#|
||Field | Description ||
|| host | **string**

Required field. MySQL host of the replica. ||
|| priority | **int64**

Required field. The priority of the replica that ClickHouse takes into account when connecting.
Replica with the highest priority should have this field set to the lowest number. ||
|| port | **int64**

Port to use when connecting to the replica.
If a port is not specified for a replica, ClickHouse uses the port specified for the source. ||
|| user | **string**

Name of the MySQL database user. ||
|| password | **string**

Password of the MySQL database user. ||
|#

## ClickhouseSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.ClickhouseSource}

#|
||Field | Description ||
|| db | **string**

Required field. Name of the ClickHouse database. ||
|| table | **string**

Required field. Name of the table in the specified database to be used as the dictionary source. ||
|| host | **string**

ClickHouse host of the specified database. ||
|| port | **int64**

Port to use when connecting to the host. ||
|| user | **string**

Required field. Name of the ClickHouse database user. ||
|| password | **string**

Password of the ClickHouse database user. ||
|| where | **string**

Selection criteria for the data in the specified ClickHouse table. ||
|| secure | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Use ssl for connection. ||
|#

## MongodbSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MongodbSource}

#|
||Field | Description ||
|| db | **string**

Required field. Name of the MongoDB database. ||
|| collection | **string**

Required field. Name of the collection in the specified database to be used as the dictionary source. ||
|| host | **string**

MongoDB host of the specified database. ||
|| port | **int64**

Port to use when connecting to the host. ||
|| user | **string**

Required field. Name of the MongoDB database user. ||
|| password | **string**

Password of the MongoDB database user. ||
|| options | **string** ||
|#

## PostgresqlSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.PostgresqlSource}

#|
||Field | Description ||
|| db | **string**

Required field. Name of the PostrgreSQL database. ||
|| table | **string**

Required field. Name of the table in the specified database to be used as the dictionary source. ||
|| hosts[] | **string**

Name of the PostrgreSQL host ||
|| port | **int64**

Port to use when connecting to the host. ||
|| user | **string**

Required field. Name of the PostrgreSQL database user. ||
|| password | **string**

Password of the PostrgreSQL database user. ||
|| invalidate_query | **string**

Query for checking the dictionary status, to pull only updated data.
For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). ||
|| ssl_mode | enum **SslMode**

Mode of SSL TCP/IP connection to the PostgreSQL host.
For more details, see [PostgreSQL documentation](https://www.postgresql.org/docs/current/libpq-ssl.html).

- `SSL_MODE_UNSPECIFIED`
- `DISABLE`: Only try a non-SSL connection.
- `ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.
- `PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.
- `VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).
- `VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate. ||
|#