---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}:updateExternalDictionary
    method: post
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the ClickHouse cluster to update the external dictionary for.
            To get the cluster ID, use a [List](/docs/managed-clickhouse/api-ref/Backup/list#List) request.
            The maximum string length in characters is 50.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        externalDictionary:
          description: |-
            **[ExternalDictionary](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary)**
            Configuration of the external dictionary.
          $ref: '#/definitions/ExternalDictionary'
        updateMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
      additionalProperties: false
    definitions:
      Id:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name of the numeric key.
            type: string
        required:
          - name
      Attribute:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name of the column.
            type: string
          type:
            description: |-
              **string**
              Required field. Type of the column.
            type: string
          nullValue:
            description: |-
              **string**
              Default value for an element without data (for example, an empty string).
            type: string
          expression:
            description: |-
              **string**
              Expression, describing the attribute, if applicable.
            type: string
          hierarchical:
            description: |-
              **boolean**
              Indication of hierarchy support.
              Default value: **false**.
            default: false
            type: boolean
          injective:
            description: |-
              **boolean**
              Indication of injective mapping "id -> attribute".
              Default value: **false**.
            default: false
            type: boolean
        required:
          - name
          - type
      Key:
        type: object
        properties:
          attributes:
            description: |-
              **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**
              Attributes of a complex key.
              The number of elements must be greater than 0.
            type: array
            items:
              $ref: '#/definitions/Attribute'
      Structure:
        type: object
        properties:
          id:
            description: |-
              **[Id](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Id)**
              Single numeric key column for the dictionary.
            $ref: '#/definitions/Id'
          key:
            description: |-
              **[Key](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Key)**
              Composite key for the dictionary, containing of one or more key columns.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key).
            $ref: '#/definitions/Key'
          rangeMin:
            description: |-
              **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**
              Field holding the beginning of the range for dictionaries with **RANGE_HASHED** layout.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed).
            $ref: '#/definitions/Attribute'
          rangeMax:
            description: |-
              **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**
              Field holding the end of the range for dictionaries with **RANGE_HASHED** layout.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed).
            $ref: '#/definitions/Attribute'
          attributes:
            description: |-
              **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**
              Description of the fields available for database queries.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes).
              The number of elements must be greater than 0.
            type: array
            items:
              $ref: '#/definitions/Attribute'
      Layout:
        type: object
        properties:
          type:
            description: |-
              **enum** (Type)
              Required field. Layout type.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#ways-to-store-dictionaries-in-memory).
              - `CLICKHOUSE`: ClickHouse host.
              - `ZOOKEEPER`: ZooKeeper host.
              - `KEEPER`: ClickHouse Keeper host.
            type: string
            enum:
              - TYPE_UNSPECIFIED
              - CLICKHOUSE
              - ZOOKEEPER
              - KEEPER
          sizeInCells:
            description: |-
              **string** (int64)
              Number of cells in the cache. Rounded up to a power of two.
              Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.
              Default value: **1000000000**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache).
            type: string
            format: int64
          allowReadExpiredKeys:
            description: |-
              **boolean**
              Allows to read expired keys.
              Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache).
            type: boolean
          maxUpdateQueueSize:
            description: |-
              **string** (int64)
              Max size of update queue.
              Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.
              Default value: **100000**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache).
            type: string
            format: int64
          updateQueuePushTimeoutMilliseconds:
            description: |-
              **string** (int64)
              Max timeout in milliseconds for push update task into queue.
              Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.
              Default value: **10**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache).
            type: string
            format: int64
          queryWaitTimeoutMilliseconds:
            description: |-
              **string** (int64)
              Max wait timeout in milliseconds for update task to complete.
              Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.
              Default value: **60000** (1 minute).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache).
            type: string
            format: int64
          maxThreadsForUpdates:
            description: |-
              **string** (int64)
              Max threads for cache dictionary update.
              Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.
              Default value: **4**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache).
            type: string
            format: int64
          initialArraySize:
            description: |-
              **string** (int64)
              Initial dictionary key size.
              Applicable only for **FLAT** layout type.
              Default value: **1024**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#flat).
            type: string
            format: int64
          maxArraySize:
            description: |-
              **string** (int64)
              Maximum dictionary key size.
              Applicable only for **FLAT** layout type.
              Default value: **500000**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#flat).
            type: string
            format: int64
          accessToKeyFromAttributes:
            description: |-
              **boolean**
              Allows to retrieve key attribute using **dictGetString** function.
              Enabling this option increases memory usage.
              Applicable only for **IP_TRIE** layout type.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#ip_trie).
            type: boolean
        required:
          - type
      Range:
        type: object
        properties:
          min:
            description: |-
              **string** (int64)
              Minimum dictionary lifetime.
            type: string
            format: int64
          max:
            description: |-
              **string** (int64)
              Maximum dictionary lifetime.
            type: string
            format: int64
      Header:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Header name.
            type: string
          value:
            description: |-
              **string**
              Required field. Header value.
            type: string
        required:
          - name
          - value
      HttpSource:
        type: object
        properties:
          url:
            description: |-
              **string**
              Required field. URL of the source dictionary available over HTTP.
            type: string
          format:
            description: |-
              **string**
              Required field. The data format. Valid values are all formats [supported by ClickHouse SQL dialect](https://clickhouse.com/docs/en/interfaces/formats/).
            type: string
          headers:
            description: |-
              **[Header](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource.Header)**
              HTTP headers.
            type: array
            items:
              $ref: '#/definitions/Header'
        required:
          - url
          - format
      Replica:
        type: object
        properties:
          host:
            description: |-
              **string**
              Name (FQDN) or IP address of the external replica host.
            type: string
          port:
            description: |-
              **string** (int64)
              Port to connect to the external replica. If not specified, the default ClickHouse port is used.
            type: string
            format: int64
          secure:
            description: |-
              **boolean**
              Whether to use a secure (SSL/TLS) connection when connecting to the external replica.
            type: boolean
          user:
            description: |-
              **string**
              Name of the user to authenticate with on the external replica.
            type: string
          password:
            description: |-
              **string**
              Password of the user to authenticate with on the external replica.
            type: string
          priority:
            description: |-
              **string** (int64)
              Priority of the external replica for load balancing.
              The replica with the lowest priority value is preferred when establishing a connection.
            type: string
            format: int64
      MysqlSource:
        type: object
        properties:
          db:
            description: |-
              **string**
              Required field. Database name.
            type: string
          table:
            description: |-
              **string**
              Required field. Table name.
            type: string
          port:
            description: |-
              **string** (int64)
              Port to use when connecting to a replica of the dictionary source.
            type: string
            format: int64
          user:
            description: |-
              **string**
              Required field. Name of the user for replicas of the dictionary source.
            type: string
          password:
            description: |-
              **string**
              Password of the user for replicas of the dictionary source.
            type: string
          replicas:
            description: |-
              **[Replica](/docs/managed-clickhouse/api-ref/Cluster/getShardGroup#yandex.cloud.mdb.clickhouse.v1.ExternalShard.Replica)**
              List of MySQL replicas of the database used as dictionary source.
            type: array
            items:
              $ref: '#/definitions/Replica'
          where:
            description: |-
              **string**
              Selection criteria for the data in the specified MySQL table.
            type: string
          invalidateQuery:
            description: |-
              **string**
              Query for checking the dictionary status, to pull only updated data.
            type: string
          closeConnection:
            description: |-
              **boolean**
              Should a connection be closed after each request.
            type: boolean
          shareConnection:
            description: |-
              **boolean**
              Should a connection be shared for some requests.
            type: boolean
        required:
          - db
          - table
          - user
      ClickhouseSource:
        type: object
        properties:
          db:
            description: |-
              **string**
              Required field. Database name.
            type: string
          table:
            description: |-
              **string**
              Required field. Table name.
            type: string
          host:
            description: |-
              **string**
              ClickHouse host.
              The maximum string length in characters is 253.
            type: string
          port:
            description: |-
              **string** (int64)
              Port to use when connecting to the host.
            type: string
            format: int64
          user:
            description: |-
              **string**
              Required field. Name of the ClickHouse database user.
            type: string
          password:
            description: |-
              **string**
              Password of the ClickHouse database user.
            type: string
          where:
            description: |-
              **string**
              Selection criteria for the data in the specified ClickHouse table.
            type: string
          secure:
            description: |-
              **boolean**
              Determines whether to use TLS for connection.
            type: boolean
        required:
          - db
          - table
          - user
      MongodbSource:
        type: object
        properties:
          db:
            description: |-
              **string**
              Required field. Database name.
            type: string
          collection:
            description: |-
              **string**
              Required field. Collection name.
            type: string
          host:
            description: |-
              **string**
              Required field. MongoDB host.
              The maximum string length in characters is 253.
            type: string
          port:
            description: |-
              **string** (int64)
              Port to use when connecting to the host.
            type: string
            format: int64
          user:
            description: |-
              **string**
              Required field. Name of the MongoDB database user.
            type: string
          password:
            description: |-
              **string**
              Password of the MongoDB database user.
            type: string
          options:
            description: |-
              **string**
              Dictionary source options.
            type: string
        required:
          - db
          - collection
          - host
          - user
      PostgresqlSource:
        type: object
        properties:
          db:
            description: |-
              **string**
              Required field. Database name.
            type: string
          table:
            description: |-
              **string**
              Required field. Table name.
            type: string
          hosts:
            description: |-
              **string**
              PostgreSQL hosts.
            type: array
            items:
              type: string
          port:
            description: |-
              **string** (int64)
              Port to use when connecting to the PostgreSQL hosts.
            type: string
            format: int64
          user:
            description: |-
              **string**
              Required field. Name of the PostrgreSQL database user.
            type: string
          password:
            description: |-
              **string**
              Password of the PostrgreSQL database user.
            type: string
          invalidateQuery:
            description: |-
              **string**
              Query for checking the dictionary status, to pull only updated data.
            type: string
          sslMode:
            description: |-
              **enum** (SslMode)
              Mode of SSL TCP/IP connection to the PostgreSQL host.
              - `DISABLE`: Only try a non-SSL connection.
              - `ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.
              - `PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.
              - `VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).
              - `VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.
            type: string
            enum:
              - SSL_MODE_UNSPECIFIED
              - DISABLE
              - ALLOW
              - PREFER
              - VERIFY_CA
              - VERIFY_FULL
        required:
          - db
          - table
          - user
      ExternalDictionary:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name of the external dictionary.
            type: string
          structure:
            description: |-
              **[Structure](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure)**
              Required field. Structure of the external dictionary.
            $ref: '#/definitions/Structure'
          layout:
            description: |-
              **[Layout](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Layout)**
              Required field. Layout determining how to store the dictionary in memory.
              For details, see https://clickhouse.com/docs/sql-reference/dictionaries#ways-to-store-dictionaries-in-memory.
            $ref: '#/definitions/Layout'
          fixedLifetime:
            description: |-
              **string** (int64)
              Fixed interval between dictionary updates.
              Includes only one of the fields `fixedLifetime`, `lifetimeRange`.
            type: string
            format: int64
          lifetimeRange:
            description: |-
              **[Range](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Range)**
              Range of intervals between dictionary updates for ClickHouse to choose from.
              Includes only one of the fields `fixedLifetime`, `lifetimeRange`.
            $ref: '#/definitions/Range'
          httpSource:
            description: |-
              **[HttpSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource)**
              HTTP source for the dictionary.
              Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`.
            $ref: '#/definitions/HttpSource'
          mysqlSource:
            description: |-
              **[MysqlSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource)**
              MySQL source for the dictionary.
              Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`.
            $ref: '#/definitions/MysqlSource'
          clickhouseSource:
            description: |-
              **[ClickhouseSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.ClickhouseSource)**
              ClickHouse source for the dictionary.
              Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`.
            $ref: '#/definitions/ClickhouseSource'
          mongodbSource:
            description: |-
              **[MongodbSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MongodbSource)**
              MongoDB source for the dictionary.
              Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`.
            $ref: '#/definitions/MongodbSource'
          postgresqlSource:
            description: |-
              **[PostgresqlSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.PostgresqlSource)**
              PostgreSQL source for the dictionary.
              Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`.
            $ref: '#/definitions/PostgresqlSource'
        required:
          - name
          - structure
          - layout
        allOf:
          - oneOf:
              - required:
                  - fixedLifetime
              - required:
                  - lifetimeRange
          - oneOf:
              - required:
                  - httpSource
              - required:
                  - mysqlSource
              - required:
                  - clickhouseSource
              - required:
                  - mongodbSource
              - required:
                  - postgresqlSource
---

# Managed Service for ClickHouse API, REST: Cluster.UpdateExternalDictionary

Updates an external dictionary for the specified ClickHouse cluster.
(-- api-linter: yc::1705::http-method-mapping=disabled --)

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}:updateExternalDictionary
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the ClickHouse cluster to update the external dictionary for.
To get the cluster ID, use a [List](/docs/managed-clickhouse/api-ref/Backup/list#List) request.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.mdb.clickhouse.v1.UpdateClusterExternalDictionaryRequest}

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
            "hierarchical": "boolean",
            "injective": "boolean"
          }
        ]
      },
      "rangeMin": {
        "name": "string",
        "type": "string",
        "nullValue": "string",
        "expression": "string",
        "hierarchical": "boolean",
        "injective": "boolean"
      },
      "rangeMax": {
        "name": "string",
        "type": "string",
        "nullValue": "string",
        "expression": "string",
        "hierarchical": "boolean",
        "injective": "boolean"
      },
      "attributes": [
        {
          "name": "string",
          "type": "string",
          "nullValue": "string",
          "expression": "string",
          "hierarchical": "boolean",
          "injective": "boolean"
        }
      ]
    },
    "layout": {
      "type": "string",
      "sizeInCells": "string",
      "allowReadExpiredKeys": "boolean",
      "maxUpdateQueueSize": "string",
      "updateQueuePushTimeoutMilliseconds": "string",
      "queryWaitTimeoutMilliseconds": "string",
      "maxThreadsForUpdates": "string",
      "initialArraySize": "string",
      "maxArraySize": "string",
      "accessToKeyFromAttributes": "boolean"
    },
    // Includes only one of the fields `fixedLifetime`, `lifetimeRange`
    "fixedLifetime": "string",
    "lifetimeRange": {
      "min": "string",
      "max": "string"
    },
    // end of the list of possible fields
    // Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`
    "httpSource": {
      "url": "string",
      "format": "string",
      "headers": [
        {
          "name": "string",
          "value": "string"
        }
      ]
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
      "invalidateQuery": "string",
      "closeConnection": "boolean",
      "shareConnection": "boolean"
    },
    "clickhouseSource": {
      "db": "string",
      "table": "string",
      "host": "string",
      "port": "string",
      "user": "string",
      "password": "string",
      "where": "string",
      "secure": "boolean"
    },
    "mongodbSource": {
      "db": "string",
      "collection": "string",
      "host": "string",
      "port": "string",
      "user": "string",
      "password": "string",
      "options": "string"
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
    // end of the list of possible fields
  },
  "updateMask": "string"
}
```

#|
||Field | Description ||
|| externalDictionary | **[ExternalDictionary](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary)**

Configuration of the external dictionary. ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|#

## ExternalDictionary {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary}

External dictionary configuration.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the external dictionary. ||
|| structure | **[Structure](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure)**

Required field. Structure of the external dictionary. ||
|| layout | **[Layout](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Layout)**

Required field. Layout determining how to store the dictionary in memory.

For details, see https://clickhouse.com/docs/sql-reference/dictionaries#ways-to-store-dictionaries-in-memory. ||
|| fixedLifetime | **string** (int64)

Fixed interval between dictionary updates.

Includes only one of the fields `fixedLifetime`, `lifetimeRange`. ||
|| lifetimeRange | **[Range](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Range)**

Range of intervals between dictionary updates for ClickHouse to choose from.

Includes only one of the fields `fixedLifetime`, `lifetimeRange`. ||
|| httpSource | **[HttpSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource)**

HTTP source for the dictionary.

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`. ||
|| mysqlSource | **[MysqlSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource)**

MySQL source for the dictionary.

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`. ||
|| clickhouseSource | **[ClickhouseSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.ClickhouseSource)**

ClickHouse source for the dictionary.

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`. ||
|| mongodbSource | **[MongodbSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MongodbSource)**

MongoDB source for the dictionary.

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`. ||
|| postgresqlSource | **[PostgresqlSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.PostgresqlSource)**

PostgreSQL source for the dictionary.

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`. ||
|#

## Structure {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure}

Configuration of external dictionary structure.

#|
||Field | Description ||
|| id | **[Id](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Id)**

Single numeric key column for the dictionary. ||
|| key | **[Key](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Key)**

Composite key for the dictionary, containing of one or more key columns.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). ||
|| rangeMin | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**

Field holding the beginning of the range for dictionaries with **RANGE_HASHED** layout.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). ||
|| rangeMax | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**

Field holding the end of the range for dictionaries with **RANGE_HASHED** layout.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). ||
|| attributes[] | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**

Description of the fields available for database queries.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes).

The number of elements must be greater than 0. ||
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

Attributes of a complex key.

The number of elements must be greater than 0. ||
|#

## Attribute {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the column. ||
|| type | **string**

Required field. Type of the column. ||
|| nullValue | **string**

Default value for an element without data (for example, an empty string). ||
|| expression | **string**

Expression, describing the attribute, if applicable. ||
|| hierarchical | **boolean**

Indication of hierarchy support.

Default value: **false**. ||
|| injective | **boolean**

Indication of injective mapping "id -> attribute".

Default value: **false**. ||
|#

## Layout {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Layout}

#|
||Field | Description ||
|| type | **enum** (Type)

Required field. Layout type.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#ways-to-store-dictionaries-in-memory).

- `FLAT`: The dictionary is completely stored in memory in the form of flat arrays.
Applicable only for dictionaries with numeric keys of the UInt64 type.
- `HASHED`: The dictionary is completely stored in memory in the form of a hash table.
Applicable only for dictionaries with numeric keys of the UInt64 type.
- `COMPLEX_KEY_HASHED`: The dictionary is completely stored in memory in the form of a hash table.
Applicable for dictionaries with composite keys of arbitrary type.
- `RANGE_HASHED`: The dictionary is stored in memory in the form of a hash table with an ordered array of ranges and their corresponding values.
Applicable only for dictionaries with numeric keys of the UInt64 type.
- `CACHE`: The dictionary is stored in a cache that has a fixed number of cells. These cells contain frequently used elements.
Applicable only for dictionaries with numeric keys of the UInt64 type.
- `COMPLEX_KEY_CACHE`: The dictionary is stored in a cache that has a fixed number of cells. These cells contain frequently used elements.
Applicable for dictionaries with composite keys of arbitrary type.
- `SPARSE_HASHED`: The dictionary is completely stored in memory in the form of a hash table.
It's similar to HASHED layout type but uses less memory in favor of more CPU usage.
Applicable only for dictionaries with numeric keys of the UInt64 type.
- `COMPLEX_KEY_SPARSE_HASHED`: The dictionary is completely stored in memory in the form of a hash table.
It's similar to COMPLEX_KEY_HASHED layout type but uses less memory in favor of more CPU usage.
Applicable for dictionaries with composite keys of arbitrary type.
- `COMPLEX_KEY_RANGE_HASHED`: The dictionary is stored in memory in the form of a hash table with an ordered array of ranges and their corresponding values.
Applicable for dictionaries with composite keys of arbitrary type.
- `DIRECT`: The dictionary is not stored in memory and directly goes to the source during the processing of a request.
Applicable only for dictionaries with numeric keys of the UInt64 type.
- `COMPLEX_KEY_DIRECT`: The dictionary is not stored in memory and directly goes to the source during the processing of a request.
Applicable for dictionaries with composite keys of arbitrary type.
- `IP_TRIE`: The specialized layout type for mapping network prefixes (IP addresses) to metadata such as ASN. ||
|| sizeInCells | **string** (int64)

Number of cells in the cache. Rounded up to a power of two.
Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.

Default value: **1000000000**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache). ||
|| allowReadExpiredKeys | **boolean**

Allows to read expired keys.
Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache). ||
|| maxUpdateQueueSize | **string** (int64)

Max size of update queue.
Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.

Default value: **100000**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache). ||
|| updateQueuePushTimeoutMilliseconds | **string** (int64)

Max timeout in milliseconds for push update task into queue.
Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.

Default value: **10**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache). ||
|| queryWaitTimeoutMilliseconds | **string** (int64)

Max wait timeout in milliseconds for update task to complete.
Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.

Default value: **60000** (1 minute).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache). ||
|| maxThreadsForUpdates | **string** (int64)

Max threads for cache dictionary update.
Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.

Default value: **4**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache). ||
|| initialArraySize | **string** (int64)

Initial dictionary key size.
Applicable only for **FLAT** layout type.

Default value: **1024**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#flat). ||
|| maxArraySize | **string** (int64)

Maximum dictionary key size.
Applicable only for **FLAT** layout type.

Default value: **500000**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#flat). ||
|| accessToKeyFromAttributes | **boolean**

Allows to retrieve key attribute using **dictGetString** function.
Enabling this option increases memory usage.
Applicable only for **IP_TRIE** layout type.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#ip_trie). ||
|#

## Range {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Range}

#|
||Field | Description ||
|| min | **string** (int64)

Minimum dictionary lifetime. ||
|| max | **string** (int64)

Maximum dictionary lifetime. ||
|#

## HttpSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource}

#|
||Field | Description ||
|| url | **string**

Required field. URL of the source dictionary available over HTTP. ||
|| format | **string**

Required field. The data format. Valid values are all formats [supported by ClickHouse SQL dialect](https://clickhouse.com/docs/en/interfaces/formats/). ||
|| headers[] | **[Header](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource.Header)**

HTTP headers. ||
|#

## Header {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource.Header}

#|
||Field | Description ||
|| name | **string**

Required field. Header name. ||
|| value | **string**

Required field. Header value. ||
|#

## MysqlSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource}

#|
||Field | Description ||
|| db | **string**

Required field. Database name. ||
|| table | **string**

Required field. Table name. ||
|| port | **string** (int64)

Port to use when connecting to a replica of the dictionary source. ||
|| user | **string**

Required field. Name of the user for replicas of the dictionary source. ||
|| password | **string**

Password of the user for replicas of the dictionary source. ||
|| replicas[] | **[Replica](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource.Replica)**

List of MySQL replicas of the database used as dictionary source. ||
|| where | **string**

Selection criteria for the data in the specified MySQL table. ||
|| invalidateQuery | **string**

Query for checking the dictionary status, to pull only updated data. ||
|| closeConnection | **boolean**

Should a connection be closed after each request. ||
|| shareConnection | **boolean**

Should a connection be shared for some requests. ||
|#

## Replica {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource.Replica}

#|
||Field | Description ||
|| host | **string**

Required field. MySQL host of the replica.

The maximum string length in characters is 253. ||
|| priority | **string** (int64)

The priority of the replica that ClickHouse takes into account when connecting.
Replica with the highest priority should have this field set to the lowest number. ||
|| port | **string** (int64)

Port to use when connecting to the replica.
If a port is not specified for a replica, ClickHouse uses the port specified for the source. ||
|| user | **string**

Name of the MySQL database user.
If a user is not specified for a replica, ClickHouse uses the user specified for the source. ||
|| password | **string**

Password of the MySQL database user.
If a password is not specified for a replica, ClickHouse uses the password specified for the source. ||
|#

## ClickhouseSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.ClickhouseSource}

#|
||Field | Description ||
|| db | **string**

Required field. Database name. ||
|| table | **string**

Required field. Table name. ||
|| host | **string**

ClickHouse host.

The maximum string length in characters is 253. ||
|| port | **string** (int64)

Port to use when connecting to the host. ||
|| user | **string**

Required field. Name of the ClickHouse database user. ||
|| password | **string**

Password of the ClickHouse database user. ||
|| where | **string**

Selection criteria for the data in the specified ClickHouse table. ||
|| secure | **boolean**

Determines whether to use TLS for connection. ||
|#

## MongodbSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MongodbSource}

#|
||Field | Description ||
|| db | **string**

Required field. Database name. ||
|| collection | **string**

Required field. Collection name. ||
|| host | **string**

Required field. MongoDB host.

The maximum string length in characters is 253. ||
|| port | **string** (int64)

Port to use when connecting to the host. ||
|| user | **string**

Required field. Name of the MongoDB database user. ||
|| password | **string**

Password of the MongoDB database user. ||
|| options | **string**

Dictionary source options. ||
|#

## PostgresqlSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.PostgresqlSource}

#|
||Field | Description ||
|| db | **string**

Required field. Database name. ||
|| table | **string**

Required field. Table name. ||
|| hosts[] | **string**

PostgreSQL hosts. ||
|| port | **string** (int64)

Port to use when connecting to the PostgreSQL hosts. ||
|| user | **string**

Required field. Name of the PostrgreSQL database user. ||
|| password | **string**

Password of the PostrgreSQL database user. ||
|| invalidateQuery | **string**

Query for checking the dictionary status, to pull only updated data. ||
|| sslMode | **enum** (SslMode)

Mode of SSL TCP/IP connection to the PostgreSQL host.

- `DISABLE`: Only try a non-SSL connection.
- `ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.
- `PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.
- `VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).
- `VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **object**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **object**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#