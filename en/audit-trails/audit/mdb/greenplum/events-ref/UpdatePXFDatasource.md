---
editable: false
---

# Managed Service for Greenplum® Audit Trails Events: UpdatePXFDatasource

## Event JSON schema {#yandex.cloud.audit.mdb.greenplum.UpdatePXFDatasource2-schema}

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
    "datasourceName": "string",
    "clusterName": "string",
    "datasource": {
      "name": "string",
      // Includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`
      "s3": {
        "accessKey": "string",
        "secretKey": "string",
        "fastUpload": "boolean",
        "endpoint": "string"
      },
      "jdbc": {
        "driver": "string",
        "url": "string",
        "user": "string",
        "password": "string",
        "statementBatchSize": "string",
        "statementFetchSize": "string",
        "statementQueryTimeout": "string",
        "poolEnabled": "boolean",
        "poolMaximumSize": "string",
        "poolConnectionTimeout": "string",
        "poolIdleTimeout": "string",
        "poolMinimumIdle": "string"
      },
      "hdfs": {
        "core": {
          "defaultFs": "string",
          "securityAuthToLocal": "string"
        },
        "kerberos": {
          "enable": "boolean",
          "primary": "string",
          "realm": "string",
          "kdcServers": [
            "string"
          ],
          "adminServer": "string",
          "defaultDomain": "string",
          "keytabBase64": "string"
        },
        "userImpersonation": "boolean",
        "username": "string",
        "saslConnectionRetries": "string",
        "zkHosts": [
          "string"
        ],
        "dfs": {
          "haAutomaticFailoverEnabled": "boolean",
          "blockAccessTokenEnabled": "boolean",
          "useDatanodeHostname": "boolean",
          "namenodes": "object",
          "nameservices": "string"
        },
        "yarn": {
          "resourcemanagerHaEnabled": "boolean",
          "resourcemanagerHaAutoFailoverEnabled": "boolean",
          "resourcemanagerHaAutoFailoverEmbedded": "boolean",
          "resourcemanagerClusterId": "string",
          "haRm": "object"
        }
      },
      "hive": {
        "core": {
          "defaultFs": "string",
          "securityAuthToLocal": "string"
        },
        "kerberos": {
          "enable": "boolean",
          "primary": "string",
          "realm": "string",
          "kdcServers": [
            "string"
          ],
          "adminServer": "string",
          "defaultDomain": "string",
          "keytabBase64": "string"
        },
        "userImpersonation": "boolean",
        "username": "string",
        "saslConnectionRetries": "string",
        "zkHosts": [
          "string"
        ],
        "ppd": "boolean",
        "metastoreUris": [
          "string"
        ],
        "metastoreKerberosPrincipal": "string",
        "authKerberosPrincipal": "string"
      }
      // end of the list of possible fields
    }
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.mdb.greenplum.UpdatePXFDatasource2}

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
|| details | **[PXFDatasourceEventDetails](#yandex.cloud.audit.mdb.greenplum.PXFDatasourceEventDetails)** ||
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

## PXFDatasourceEventDetails {#yandex.cloud.audit.mdb.greenplum.PXFDatasourceEventDetails}

#|
||Field | Description ||
|| clusterId | **string** ||
|| datasourceName | **string** ||
|| clusterName | **string** ||
|| datasource | **[PXFDatasource](#yandex.cloud.mdb.greenplum.v1.PXFDatasource)** ||
|#

## PXFDatasource {#yandex.cloud.mdb.greenplum.v1.PXFDatasource}

#|
||Field | Description ||
|| name | **string**

The string length in characters must be 3-200. Value must match the regular expression ``` ^[^\|/*?.,;'<>]+$ ```. ||
|| s3 | **[PXFDatasourceS3](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceS3)**

Includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`. ||
|| jdbc | **[PXFDatasourceJDBC](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceJDBC)**

Includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`. ||
|| hdfs | **[PXFDatasourceHDFS](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFS)**

Includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`. ||
|| hive | **[PXFDatasourceHive](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHive)**

Includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`. ||
|#

## PXFDatasourceS3 {#yandex.cloud.mdb.greenplum.v1.PXFDatasourceS3}

#|
||Field | Description ||
|| accessKey | **string**

The maximum string length in characters is 200. ||
|| secretKey | **string**

The maximum string length in characters is 200. ||
|| fastUpload | **boolean** ||
|| endpoint | **string**

The maximum string length in characters is 200. Value must match the regular expression ``` (((s3|https?)://)?([a-z0-9]([a-z0-9-]*[a-z0-9])?[.])+[a-z]{2,})? ```. ||
|#

## PXFDatasourceJDBC {#yandex.cloud.mdb.greenplum.v1.PXFDatasourceJDBC}

#|
||Field | Description ||
|| driver | **string**

The maximum string length in characters is 50. ||
|| url | **string**

The maximum string length in characters is 1000. ||
|| user | **string**

The maximum string length in characters is 200. ||
|| password | **string**

The maximum string length in characters is 200. ||
|| statementBatchSize | **string** (int64)

Acceptable values are 50 to 1000, inclusive. ||
|| statementFetchSize | **string** (int64)

Acceptable values are 50 to 10000, inclusive. ||
|| statementQueryTimeout | **string** (int64)

Acceptable values are 5 to 43200, inclusive. ||
|| poolEnabled | **boolean** ||
|| poolMaximumSize | **string** (int64)

Acceptable values are 1 to 200, inclusive. ||
|| poolConnectionTimeout | **string** (int64)

Acceptable values are 5000 to 600000, inclusive. ||
|| poolIdleTimeout | **string** (int64)

Acceptable values are 5000 to 600000, inclusive. ||
|| poolMinimumIdle | **string** (int64)

Acceptable values are 0 to 200, inclusive. ||
|#

## PXFDatasourceHDFS {#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFS}

#|
||Field | Description ||
|| core | **[PXFDatasourceCore](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceCore)** ||
|| kerberos | **[PXFDatasourceKerberos](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceKerberos)** ||
|| userImpersonation | **boolean** ||
|| username | **string**

The maximum string length in characters is 128. ||
|| saslConnectionRetries | **string** (int64)

Acceptable values are 1 to 50, inclusive. ||
|| zkHosts[] | **string**

The maximum number of elements is 200. The string length in characters for each value must be 1-200. ||
|| dfs | **[PXFDatasourceHDFSDfs](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFSDfs)** ||
|| yarn | **[PXFDatasourceHDFSYarn](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFSYarn)** ||
|#

## PXFDatasourceCore {#yandex.cloud.mdb.greenplum.v1.PXFDatasourceCore}

#|
||Field | Description ||
|| defaultFs | **string**

The maximum string length in characters is 200. ||
|| securityAuthToLocal | **string**

The maximum string length in characters is 1000. ||
|#

## PXFDatasourceKerberos {#yandex.cloud.mdb.greenplum.v1.PXFDatasourceKerberos}

#|
||Field | Description ||
|| enable | **boolean** ||
|| primary | **string**

The maximum string length in characters is 128. ||
|| realm | **string**

The maximum string length in characters is 1000. ||
|| kdcServers[] | **string**

The maximum number of elements is 200. The string length in characters for each value must be 1-200. ||
|| adminServer | **string**

The maximum string length in characters is 128. ||
|| defaultDomain | **string**

The maximum string length in characters is 128. ||
|| keytabBase64 | **string**

Value must match the regular expression ``` ^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=)?$ ```. The maximum string length in characters is 65536. ||
|#

## PXFDatasourceHDFSDfs {#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFSDfs}

#|
||Field | Description ||
|| haAutomaticFailoverEnabled | **boolean** ||
|| blockAccessTokenEnabled | **boolean** ||
|| useDatanodeHostname | **boolean** ||
|| namenodes | **object** (map<**string**, **[PXFDatasourceHDFSDfsNamenode](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFSDfsNamenode)**>)

No more than 10000 per resource. ||
|| nameservices | **string** ||
|#

## PXFDatasourceHDFSDfsNamenode {#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFSDfsNamenode}

#|
||Field | Description ||
|| rpcAddress | **string**

The maximum string length in characters is 1000. ||
|| serviceRpcAddress | **string**

The maximum string length in characters is 1000. ||
|| httpAddress | **string**

The maximum string length in characters is 1000. ||
|| httpsAddress | **string**

The maximum string length in characters is 1000. ||
|#

## PXFDatasourceHDFSYarn {#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFSYarn}

#|
||Field | Description ||
|| resourcemanagerHaEnabled | **boolean** ||
|| resourcemanagerHaAutoFailoverEnabled | **boolean** ||
|| resourcemanagerHaAutoFailoverEmbedded | **boolean** ||
|| resourcemanagerClusterId | **string**

The maximum string length in characters is 1000. ||
|| haRm | **object** (map<**string**, **[PXFDatasourceHDFSYarnHaRm](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFSYarnHaRm)**>)

No more than 10000 per resource. ||
|#

## PXFDatasourceHDFSYarnHaRm {#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFSYarnHaRm}

#|
||Field | Description ||
|| resourcemanagerAddress | **string** ||
|| resourcemanagerSchedulerAddress | **string** ||
|| resourcemanagerResourceTrackerAddress | **string** ||
|| resourcemanagerAdminAddress | **string** ||
|| resourcemanagerWebappAddress | **string** ||
|| resourcemanagerWebappHttpsAddress | **string** ||
|#

## PXFDatasourceHive {#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHive}

#|
||Field | Description ||
|| core | **[PXFDatasourceCore](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceCore)** ||
|| kerberos | **[PXFDatasourceKerberos](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceKerberos)** ||
|| userImpersonation | **boolean** ||
|| username | **string**

The maximum string length in characters is 128. ||
|| saslConnectionRetries | **string** (int64)

Acceptable values are 1 to 50, inclusive. ||
|| zkHosts[] | **string**

The maximum number of elements is 200. The string length in characters for each value must be 1-200. ||
|| ppd | **boolean** ||
|| metastoreUris[] | **string**

The maximum number of elements is 200. The string length in characters for each value must be 1-200. ||
|| metastoreKerberosPrincipal | **string**

The maximum string length in characters is 1000. ||
|| authKerberosPrincipal | **string**

The maximum string length in characters is 1000. ||
|#