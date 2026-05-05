---
editable: false
---

# Managed Service for ClickHouse Audit Trails Events: DeleteClusterExternalDictionary

## Event JSON schema {#yandex.cloud.audit.mdb.clickhouse.DeleteClusterExternalDictionary2-schema}

```json
{
  "eventId": "string",
  "eventSource": "string",
  "eventType": "string",
  "eventTime": "string",
  "authentication": {
    "authenticated": "boolean",
    // Includes only one of the fields `subjectType`
    "subjectType": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectId`
    "subjectId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectName`
    "subjectName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationId`
    "federationId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationName`
    "federationName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationType`
    "federationType": "string",
    // end of the list of possible fields
    "tokenInfo": {
      "maskedIamToken": "string",
      // Includes only one of the fields `iamTokenId`
      "iamTokenId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorId`
      "impersonatorId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorType`
      "impersonatorType": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorName`
      "impersonatorName": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationId`
      "impersonatorFederationId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationName`
      "impersonatorFederationName": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationType`
      "impersonatorFederationType": "string"
      // end of the list of possible fields
    }
  },
  "authorization": {
    "authorized": "boolean"
  },
  "resourceMetadata": {
    "path": [
      {
        "resourceType": "string",
        "resourceId": "string",
        // Includes only one of the fields `resourceName`
        "resourceName": "string"
        // end of the list of possible fields
      }
    ]
  },
  "requestMetadata": {
    "remoteAddress": "string",
    "userAgent": "string",
    "requestId": "string",
    // Includes only one of the fields `remotePort`
    "remotePort": "string"
    // end of the list of possible fields
  },
  "eventStatus": "string",
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "details": {
    "clusterId": "string",
    "externalDictionaryName": "string",
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
    "clusterName": "string"
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.mdb.clickhouse.DeleteClusterExternalDictionary2}

#|
||Field | Description ||
|| eventId | **string** ||
|| eventSource | **string** ||
|| eventType | **string** ||
|| eventTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| authentication | **[IamAuthentication](#yandex.cloud.audit.IamAuthentication)** ||
|| authorization | **[Authorization](#yandex.cloud.audit.Authorization)** ||
|| resourceMetadata | **[ResourceMetadata](#yandex.cloud.audit.ResourceMetadata)** ||
|| requestMetadata | **[RequestMetadata](#yandex.cloud.audit.RequestMetadata)** ||
|| eventStatus | **enum** (EventStatus)

- `STARTED`
- `ERROR`
- `DONE`
- `CANCELLED`
- `RUNNING` ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation. ||
|| details | **[ExternalDictionaryEventDetails](#yandex.cloud.audit.mdb.clickhouse.ExternalDictionaryEventDetails)** ||
|| requestParameters | **object** ||
|| response | **object** ||
|#

## IamAuthentication {#yandex.cloud.audit.IamAuthentication}

#|
||Field | Description ||
|| authenticated | **boolean** ||
|| subjectType | **enum** (IamSubjectType)

Includes only one of the fields `subjectType`.

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| subjectId | **string**

Includes only one of the fields `subjectId`. ||
|| subjectName | **string**

Includes only one of the fields `subjectName`. ||
|| federationId | **string**

Includes only one of the fields `federationId`. ||
|| federationName | **string**

Includes only one of the fields `federationName`. ||
|| federationType | **enum** (FederationType)

Includes only one of the fields `federationType`.

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|| tokenInfo | **[IamTokenInfo](#yandex.cloud.audit.IamAuthentication.IamTokenInfo)** ||
|#

## IamTokenInfo {#yandex.cloud.audit.IamAuthentication.IamTokenInfo}

#|
||Field | Description ||
|| maskedIamToken | **string** ||
|| iamTokenId | **string**

Includes only one of the fields `iamTokenId`. ||
|| impersonatorId | **string**

Includes only one of the fields `impersonatorId`. ||
|| impersonatorType | **enum** (IamSubjectType)

Includes only one of the fields `impersonatorType`.

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| impersonatorName | **string**

Includes only one of the fields `impersonatorName`. ||
|| impersonatorFederationId | **string**

Includes only one of the fields `impersonatorFederationId`. ||
|| impersonatorFederationName | **string**

Includes only one of the fields `impersonatorFederationName`. ||
|| impersonatorFederationType | **enum** (FederationType)

Includes only one of the fields `impersonatorFederationType`.

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|#

## Authorization {#yandex.cloud.audit.Authorization}

#|
||Field | Description ||
|| authorized | **boolean** ||
|#

## ResourceMetadata {#yandex.cloud.audit.ResourceMetadata}

#|
||Field | Description ||
|| path[] | **[Resource](#yandex.cloud.audit.Resource)** ||
|#

## Resource {#yandex.cloud.audit.Resource}

#|
||Field | Description ||
|| resourceType | **string** ||
|| resourceId | **string** ||
|| resourceName | **string**

Includes only one of the fields `resourceName`. ||
|#

## RequestMetadata {#yandex.cloud.audit.RequestMetadata}

#|
||Field | Description ||
|| remoteAddress | **string** ||
|| userAgent | **string** ||
|| requestId | **string** ||
|| remotePort | **string** (int64)

Includes only one of the fields `remotePort`. ||
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

## ExternalDictionaryEventDetails {#yandex.cloud.audit.mdb.clickhouse.ExternalDictionaryEventDetails}

#|
||Field | Description ||
|| clusterId | **string** ||
|| externalDictionaryName | **string** ||
|| externalDictionary | **[ExternalDictionary](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary)** ||
|| clusterName | **string** ||
|#

## ExternalDictionary {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary}

#|
||Field | Description ||
|| name | **string** ||
|| structure | **[Structure](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure)** ||
|| layout | **[Layout](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Layout)** ||
|| fixedLifetime | **string** (int64)

Includes only one of the fields `fixedLifetime`, `lifetimeRange`. ||
|| lifetimeRange | **[Range](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Range)**

Includes only one of the fields `fixedLifetime`, `lifetimeRange`. ||
|| httpSource | **[HttpSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource)**

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`. ||
|| mysqlSource | **[MysqlSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource)**

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`. ||
|| clickhouseSource | **[ClickhouseSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.ClickhouseSource)**

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`. ||
|| mongodbSource | **[MongodbSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MongodbSource)**

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`. ||
|| postgresqlSource | **[PostgresqlSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.PostgresqlSource)**

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`. ||
|#

## Structure {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure}

#|
||Field | Description ||
|| id | **[Id](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Id)** ||
|| key | **[Key](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Key)** ||
|| rangeMin | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)** ||
|| rangeMax | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)** ||
|| attributes[] | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**

The number of elements must be greater than 0. ||
|#

## Id {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Id}

#|
||Field | Description ||
|| name | **string** ||
|#

## Key {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Key}

#|
||Field | Description ||
|| attributes[] | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**

The number of elements must be greater than 0. ||
|#

## Attribute {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute}

#|
||Field | Description ||
|| name | **string** ||
|| type | **string** ||
|| nullValue | **string** ||
|| expression | **string** ||
|| hierarchical | **boolean** ||
|| injective | **boolean** ||
|#

## Layout {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Layout}

#|
||Field | Description ||
|| type | **enum** (Type)

- `FLAT`
- `HASHED`
- `COMPLEX_KEY_HASHED`
- `RANGE_HASHED`
- `CACHE`
- `COMPLEX_KEY_CACHE`
- `SPARSE_HASHED`
- `COMPLEX_KEY_SPARSE_HASHED`
- `COMPLEX_KEY_RANGE_HASHED`
- `DIRECT`
- `COMPLEX_KEY_DIRECT`
- `IP_TRIE` ||
|| sizeInCells | **string** (int64)

The minimum value is 0. ||
|| allowReadExpiredKeys | **boolean** ||
|| maxUpdateQueueSize | **string** (int64)

The minimum value is 0. ||
|| updateQueuePushTimeoutMilliseconds | **string** (int64)

The minimum value is 0. ||
|| queryWaitTimeoutMilliseconds | **string** (int64)

The minimum value is 0. ||
|| maxThreadsForUpdates | **string** (int64)

The minimum value is 0. ||
|| initialArraySize | **string** (int64)

The minimum value is 0. ||
|| maxArraySize | **string** (int64)

The minimum value is 0. ||
|| accessToKeyFromAttributes | **boolean** ||
|#

## Range {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Range}

#|
||Field | Description ||
|| min | **string** (int64) ||
|| max | **string** (int64) ||
|#

## HttpSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource}

#|
||Field | Description ||
|| url | **string** ||
|| format | **string** ||
|| headers[] | **[Header](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource.Header)** ||
|#

## Header {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource.Header}

#|
||Field | Description ||
|| name | **string** ||
|| value | **string** ||
|#

## MysqlSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource}

#|
||Field | Description ||
|| db | **string** ||
|| table | **string** ||
|| port | **string** (int64)

Acceptable values are 0 to 65535, inclusive. ||
|| user | **string** ||
|| password | **string** ||
|| replicas[] | **[Replica](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource.Replica)** ||
|| where | **string** ||
|| invalidateQuery | **string** ||
|| closeConnection | **boolean** ||
|| shareConnection | **boolean** ||
|#

## Replica {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource.Replica}

#|
||Field | Description ||
|| host | **string**

The maximum string length in characters is 253. ||
|| priority | **string** (int64)

The minimum value is 0. ||
|| port | **string** (int64)

Acceptable values are 0 to 65535, inclusive. ||
|| user | **string** ||
|| password | **string** ||
|#

## ClickhouseSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.ClickhouseSource}

#|
||Field | Description ||
|| db | **string** ||
|| table | **string** ||
|| host | **string**

The maximum string length in characters is 253. ||
|| port | **string** (int64)

Acceptable values are 0 to 65535, inclusive. ||
|| user | **string** ||
|| password | **string** ||
|| where | **string** ||
|| secure | **boolean** ||
|#

## MongodbSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MongodbSource}

#|
||Field | Description ||
|| db | **string** ||
|| collection | **string** ||
|| host | **string**

The maximum string length in characters is 253. ||
|| port | **string** (int64)

Acceptable values are 0 to 65535, inclusive. ||
|| user | **string** ||
|| password | **string** ||
|| options | **string** ||
|#

## PostgresqlSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.PostgresqlSource}

#|
||Field | Description ||
|| db | **string** ||
|| table | **string** ||
|| hosts[] | **string** ||
|| port | **string** (int64)

Acceptable values are 0 to 65535, inclusive. ||
|| user | **string** ||
|| password | **string** ||
|| invalidateQuery | **string** ||
|| sslMode | **enum** (SslMode)

- `DISABLE`
- `ALLOW`
- `PREFER`
- `VERIFY_CA`
- `VERIFY_FULL` ||
|#