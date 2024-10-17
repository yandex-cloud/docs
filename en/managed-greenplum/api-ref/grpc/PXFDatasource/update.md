---
editable: false
sourcePath: en/_api-ref-grpc/mdb/greenplum/v1/api-ref/grpc/PXFDatasource/update.md
---

# Managed Service for Greenplum® API, gRPC: PXFDatasourceService.Update {#Update}

Update PXF datasource

## gRPC request

**rpc Update ([UpdatePXFDatasourceRequest](#yandex.cloud.mdb.greenplum.v1.UpdatePXFDatasourceRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdatePXFDatasourceRequest {#yandex.cloud.mdb.greenplum.v1.UpdatePXFDatasourceRequest}

```json
{
  "clusterId": "string",
  "updateMask": "google.protobuf.FieldMask",
  "datasource": {
    "name": "string",
    // Includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`
    "s3": {
      "accessKey": "string",
      "secretKey": "string",
      "fastUpload": "google.protobuf.BoolValue",
      "endpoint": "string"
    },
    "jdbc": {
      "driver": "string",
      "url": "string",
      "user": "string",
      "password": "string",
      "statementBatchSize": "google.protobuf.Int64Value",
      "statementFetchSize": "google.protobuf.Int64Value",
      "statementQueryTimeout": "google.protobuf.Int64Value",
      "poolEnabled": "google.protobuf.BoolValue",
      "poolMaximumSize": "google.protobuf.Int64Value",
      "poolConnectionTimeout": "google.protobuf.Int64Value",
      "poolIdleTimeout": "google.protobuf.Int64Value",
      "poolMinimumIdle": "google.protobuf.Int64Value"
    },
    "hdfs": {
      "core": {
        "defaultFs": "string",
        "securityAuthToLocal": "string"
      },
      "kerberos": {
        "enable": "google.protobuf.BoolValue",
        "primary": "string",
        "realm": "string",
        "kdcServers": [
          "string"
        ],
        "adminServer": "string",
        "defaultDomain": "string",
        "keytabBase64": "string"
      },
      "userImpersonation": "google.protobuf.BoolValue",
      "username": "string",
      "saslConnectionRetries": "google.protobuf.Int64Value",
      "zkHosts": [
        "string"
      ],
      "dfs": {
        "haAutomaticFailoverEnabled": "google.protobuf.BoolValue",
        "blockAccessTokenEnabled": "google.protobuf.BoolValue",
        "useDatanodeHostname": "google.protobuf.BoolValue",
        "namenodes": {
          "rpcAddress": "string",
          "serviceRpcAddress": "string",
          "httpAddress": "string",
          "httpsAddress": "string"
        },
        "nameservices": "string"
      },
      "yarn": {
        "resourcemanagerHaEnabled": "google.protobuf.BoolValue",
        "resourcemanagerHaAutoFailoverEnabled": "google.protobuf.BoolValue",
        "resourcemanagerHaAutoFailoverEmbedded": "google.protobuf.BoolValue",
        "resourcemanagerClusterId": "string",
        "haRm": {
          "resourcemanagerAddress": "string",
          "resourcemanagerSchedulerAddress": "string",
          "resourcemanagerResourceTrackerAddress": "string",
          "resourcemanagerAdminAddress": "string",
          "resourcemanagerWebappAddress": "string",
          "resourcemanagerWebappHttpsAddress": "string"
        }
      }
    },
    "hive": {
      "core": {
        "defaultFs": "string",
        "securityAuthToLocal": "string"
      },
      "kerberos": {
        "enable": "google.protobuf.BoolValue",
        "primary": "string",
        "realm": "string",
        "kdcServers": [
          "string"
        ],
        "adminServer": "string",
        "defaultDomain": "string",
        "keytabBase64": "string"
      },
      "userImpersonation": "google.protobuf.BoolValue",
      "username": "string",
      "saslConnectionRetries": "google.protobuf.Int64Value",
      "zkHosts": [
        "string"
      ],
      "ppd": "google.protobuf.BoolValue",
      "metastoreUris": [
        "string"
      ],
      "metastoreKerberosPrincipal": "string",
      "authKerberosPrincipal": "string"
    }
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field.  ||
|| updateMask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)** ||
|| datasource | **[PXFDatasource](#yandex.cloud.mdb.greenplum.v1.PXFDatasource)** ||
|#

## PXFDatasource {#yandex.cloud.mdb.greenplum.v1.PXFDatasource}

#|
||Field | Description ||
|| name | **string**

Required field. Data source name. ||
|| s3 | **[PXFDatasourceS3](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceS3)**

Settings of an external S3 data source.

Includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`. ||
|| jdbc | **[PXFDatasourceJDBC](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceJDBC)**

Settings of an external JDBC data source.

Includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`. ||
|| hdfs | **[PXFDatasourceHDFS](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFS)**

Settings of an external HDFS data source.

Includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`. ||
|| hive | **[PXFDatasourceHive](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHive)**

Settings of an external Hive data source.

Includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`. ||
|#

## PXFDatasourceS3 {#yandex.cloud.mdb.greenplum.v1.PXFDatasourceS3}

#|
||Field | Description ||
|| accessKey | **string**

Public key to access S3 storage. ||
|| secretKey | **string**

Secret key to access S3 storage. ||
|| fastUpload | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Manages a fast upload of big files to S3 storage. In case of the `false` value, the PXF generates files on disk before sending them to the S3 storage. In case of the `true` value, the PXF generates files in RAM (the PXF writes to disc only if there is not enough RAM).

The fast upload is enabled by default. ||
|| endpoint | **string**

S3 storage address. The default value is `storage.yandexcloud.net` used for Yandex Object Storage. ||
|#

## PXFDatasourceJDBC {#yandex.cloud.mdb.greenplum.v1.PXFDatasourceJDBC}

#|
||Field | Description ||
|| driver | **string**

JDBC driver class in Java. The possible values are the following:

* `com.simba.athena.jdbc.Driver`
* `com.clickhouse.jdbc.ClickHouseDriver`
* `com.ibm.as400.access.AS400JDBCDriver`
* `com.microsoft.sqlserver.jdbc.SQLServerDriver`
* `com.mysql.cj.jdbc.Driver`
* `org.postgresql.Driver`
* `oracle.jdbc.driver.OracleDriver`
* `net.snowflake.client.jdbc.SnowflakeDriver`
* `io.trino.jdbc.TrinoDriver` ||
|| url | **string**

URL that the JDBC driver uses to connect to the database. Examples:

* `jdbc:mysql://mysqlhost:3306/testdb`: Local MySQL DB.
* `jdbc:postgresql://c-<cluster_id>.rw.mdb.yandexcloud.net:6432/db1`: Managed Service for PostgreSQL cluster. The address contains the special FQDN of the cluster's master.
* `jdbc:oracle:thin:@host.example:1521:orcl`: Oracle DB. ||
|| user | **string**

Username of the DB owner. ||
|| password | **string**

Password of the DB owner. ||
|| statementBatchSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Number of rows to read in an external table, in a batch.

The default value is `100`. ||
|| statementFetchSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Number of rows to fetch (buffer) when reading from an external table.

The default value is `1000`. ||
|| statementQueryTimeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Amount of time (in seconds) the JDBC driver waits for a statement to run. This timeout applies to statements created for both read and write operations.

The default value is `60`. ||
|| poolEnabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether JDBC connection pooling is used in a server configuration. By default, it is used. ||
|| poolMaximumSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of connections to the DB backend.

The default value is `5`. ||
|| poolConnectionTimeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum time, in milliseconds, to wait for a connection from the pool.

The default value is `30000`. ||
|| poolIdleTimeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum amount of time, in milliseconds, after which an inactive connection is considered idle.

The default value is `30000`. ||
|| poolMinimumIdle | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum number of idle connections maintained in the connection pool.

The default value is `0`. ||
|#

## PXFDatasourceHDFS {#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFS}

#|
||Field | Description ||
|| core | **[PXFDatasourceCore](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceCore)**

Settings of the file system and security rules. ||
|| kerberos | **[PXFDatasourceKerberos](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceKerberos)**

Settings of the Kerberos network authentication protocol. ||
|| userImpersonation | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables authentication on behalf of the Greenplum® user when connecting to the remote file storage or DBMS.

The authentication is disabled by default. ||
|| username | **string**

Login username for the remote file storage or DBMS if authentication on behalf of the Greenplum® user is enabled. ||
|| saslConnectionRetries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of times that PXF retries a SASL connection request after a refused connection returns a `GSS initiate failed` error.

The default value is `5`. ||
|| zkHosts[] | **string**

ZooKeeper server hosts.

Specify values in the `<address>:<port>` format. ||
|| dfs | **[PXFDatasourceHDFSDfs](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFSDfs)**

Settings of the distributed file system. ||
|| yarn | **[PXFDatasourceHDFSYarn](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFSYarn)**

Settings of the ResourceManager service that is responsible for tracking resources in a cluster and scheduling applications (e.g., MapReduce jobs). ||
|#

## PXFDatasourceCore {#yandex.cloud.mdb.greenplum.v1.PXFDatasourceCore}

#|
||Field | Description ||
|| defaultFs | **string**

URI whose scheme and authority determine the file system implementation. ||
|| securityAuthToLocal | **string**

Rules for mapping Kerberos principals to operating system user accounts. ||
|#

## PXFDatasourceKerberos {#yandex.cloud.mdb.greenplum.v1.PXFDatasourceKerberos}

#|
||Field | Description ||
|| enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether the Kerberos authentication server is used. By default, it is not used. ||
|| primary | **string**

Host of the primary KDC server (Key Distribution Center). ||
|| realm | **string**

Kerberos realm for a Greenplum® DB. ||
|| kdcServers[] | **string**

KDC server hosts. ||
|| adminServer | **string**

Administration server host. Usually, this is the primary Kerberos server. ||
|| defaultDomain | **string**

Domain that is used for the host name extension. Applicable when Kerberos 4 service members become Kerberos 5 service members (for example, when rcmd.hostname is replaced with host/hostname.domain). ||
|| keytabBase64 | **string**

Base64 encoded contents of the keytab file. ||
|#

## PXFDatasourceHDFSDfs {#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFSDfs}

#|
||Field | Description ||
|| haAutomaticFailoverEnabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether automatic failover is enabled for the high availability of the file system.

The automatic failover is enabled by default. ||
|| blockAccessTokenEnabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If `true`, access tokens are used as capabilities for accessing datanodes. If `false`, no access tokens are checked on accessing datanodes.

The check of access tokens is enabled by default. ||
|| useDatanodeHostname | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether the datanode hostname is used when connecting to datanodes. ||
|| namenodes | **[PXFDatasourceHDFSDfsNamenode](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFSDfsNamenode)**

List of HDFS service logical names.

Specify them separated by commas. The names can be arbitrary. ||
|| nameservices | **string**

Corresponds well-known HDFS client setting "dfs.nameservices" for this datasource ||
|#

## PXFDatasourceHDFSDfsNamenode {#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFSDfsNamenode}

#|
||Field | Description ||
|| rpcAddress | **string** ||
|| serviceRpcAddress | **string** ||
|| httpAddress | **string** ||
|| httpsAddress | **string** ||
|#

## PXFDatasourceHDFSYarn {#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFSYarn}

#|
||Field | Description ||
|| resourcemanagerHaEnabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether high availability is enabled for YARN's ResourceManager services.

The high availability is enabled by default. ||
|| resourcemanagerHaAutoFailoverEnabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether another ResourceManager should automatically become active when the active ResourceManager has failed and does not respond.

The switch of ResourceManagers is enabled by default if the high availability is enabled. ||
|| resourcemanagerHaAutoFailoverEmbedded | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether the embedded ActiveStandbyElector method should be used for the election of the active ResourceManager. If the current active ResourceManager has failed and does not respond, the ActiveStandbyElector method makes another ResourceManager active which then takes over. ||
|| resourcemanagerClusterId | **string**

Cluster ID. Specify it, so the ResourceManager service does not become active for a different cluster. ||
|| haRm | **[PXFDatasourceHDFSYarnHaRm](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFSYarnHaRm)**

Highly available ResourceManager service. ||
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
|| core | **[PXFDatasourceCore](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceCore)**

Settings of the file system and security rules. ||
|| kerberos | **[PXFDatasourceKerberos](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceKerberos)**

Settings of the Kerberos network authentication protocol. ||
|| userImpersonation | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables authentication on behalf of the Greenplum® user when connecting to the remote file storage or DBMS.

The authentication is disabled by default. ||
|| username | **string**

Login username for the remote file storage or DBMS if authentication on behalf of the Greenplum® user is enabled. ||
|| saslConnectionRetries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of times that PXF retries a SASL connection request after a refused connection returns a `GSS initiate failed` error.

The default value is `5`. ||
|| zkHosts[] | **string**

ZooKeeper server hosts.

Specify values in the `<address>:<port>` format. ||
|| ppd | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Specifies if predicate pushdown is enabled for queries on external tables.

The predicate pushdown is enabled by default. ||
|| metastoreUris[] | **string**

List of URIs separated by commas. To request metadata, the remote DBMS connects to Metastore by one of these URIs. ||
|| metastoreKerberosPrincipal | **string**

Service principal for the Metastore Thrift server. ||
|| authKerberosPrincipal | **string**

Kerberos server principal. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "clusterId": "string",
    "datasourceName": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "name": "string",
    // Includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`
    "s3": {
      "accessKey": "string",
      "secretKey": "string",
      "fastUpload": "google.protobuf.BoolValue",
      "endpoint": "string"
    },
    "jdbc": {
      "driver": "string",
      "url": "string",
      "user": "string",
      "password": "string",
      "statementBatchSize": "google.protobuf.Int64Value",
      "statementFetchSize": "google.protobuf.Int64Value",
      "statementQueryTimeout": "google.protobuf.Int64Value",
      "poolEnabled": "google.protobuf.BoolValue",
      "poolMaximumSize": "google.protobuf.Int64Value",
      "poolConnectionTimeout": "google.protobuf.Int64Value",
      "poolIdleTimeout": "google.protobuf.Int64Value",
      "poolMinimumIdle": "google.protobuf.Int64Value"
    },
    "hdfs": {
      "core": {
        "defaultFs": "string",
        "securityAuthToLocal": "string"
      },
      "kerberos": {
        "enable": "google.protobuf.BoolValue",
        "primary": "string",
        "realm": "string",
        "kdcServers": [
          "string"
        ],
        "adminServer": "string",
        "defaultDomain": "string",
        "keytabBase64": "string"
      },
      "userImpersonation": "google.protobuf.BoolValue",
      "username": "string",
      "saslConnectionRetries": "google.protobuf.Int64Value",
      "zkHosts": [
        "string"
      ],
      "dfs": {
        "haAutomaticFailoverEnabled": "google.protobuf.BoolValue",
        "blockAccessTokenEnabled": "google.protobuf.BoolValue",
        "useDatanodeHostname": "google.protobuf.BoolValue",
        "namenodes": {
          "rpcAddress": "string",
          "serviceRpcAddress": "string",
          "httpAddress": "string",
          "httpsAddress": "string"
        },
        "nameservices": "string"
      },
      "yarn": {
        "resourcemanagerHaEnabled": "google.protobuf.BoolValue",
        "resourcemanagerHaAutoFailoverEnabled": "google.protobuf.BoolValue",
        "resourcemanagerHaAutoFailoverEmbedded": "google.protobuf.BoolValue",
        "resourcemanagerClusterId": "string",
        "haRm": {
          "resourcemanagerAddress": "string",
          "resourcemanagerSchedulerAddress": "string",
          "resourcemanagerResourceTrackerAddress": "string",
          "resourcemanagerAdminAddress": "string",
          "resourcemanagerWebappAddress": "string",
          "resourcemanagerWebappHttpsAddress": "string"
        }
      }
    },
    "hive": {
      "core": {
        "defaultFs": "string",
        "securityAuthToLocal": "string"
      },
      "kerberos": {
        "enable": "google.protobuf.BoolValue",
        "primary": "string",
        "realm": "string",
        "kdcServers": [
          "string"
        ],
        "adminServer": "string",
        "defaultDomain": "string",
        "keytabBase64": "string"
      },
      "userImpersonation": "google.protobuf.BoolValue",
      "username": "string",
      "saslConnectionRetries": "google.protobuf.Int64Value",
      "zkHosts": [
        "string"
      ],
      "ppd": "google.protobuf.BoolValue",
      "metastoreUris": [
        "string"
      ],
      "metastoreKerberosPrincipal": "string",
      "authKerberosPrincipal": "string"
    }
    // end of the list of possible fields
  }
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdatePXFDatasourceMetadata](#yandex.cloud.mdb.greenplum.v1.UpdatePXFDatasourceMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[PXFDatasource](#yandex.cloud.mdb.greenplum.v1.PXFDatasource2)**

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

## UpdatePXFDatasourceMetadata {#yandex.cloud.mdb.greenplum.v1.UpdatePXFDatasourceMetadata}

#|
||Field | Description ||
|| clusterId | **string**

Required field.  ||
|| datasourceName | **string**

Required field.  ||
|#

## PXFDatasource {#yandex.cloud.mdb.greenplum.v1.PXFDatasource2}

#|
||Field | Description ||
|| name | **string**

Required field. Data source name. ||
|| s3 | **[PXFDatasourceS3](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceS32)**

Settings of an external S3 data source.

Includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`. ||
|| jdbc | **[PXFDatasourceJDBC](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceJDBC2)**

Settings of an external JDBC data source.

Includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`. ||
|| hdfs | **[PXFDatasourceHDFS](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFS2)**

Settings of an external HDFS data source.

Includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`. ||
|| hive | **[PXFDatasourceHive](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHive2)**

Settings of an external Hive data source.

Includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`. ||
|#

## PXFDatasourceS3 {#yandex.cloud.mdb.greenplum.v1.PXFDatasourceS32}

#|
||Field | Description ||
|| accessKey | **string**

Public key to access S3 storage. ||
|| secretKey | **string**

Secret key to access S3 storage. ||
|| fastUpload | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Manages a fast upload of big files to S3 storage. In case of the `false` value, the PXF generates files on disk before sending them to the S3 storage. In case of the `true` value, the PXF generates files in RAM (the PXF writes to disc only if there is not enough RAM).

The fast upload is enabled by default. ||
|| endpoint | **string**

S3 storage address. The default value is `storage.yandexcloud.net` used for Yandex Object Storage. ||
|#

## PXFDatasourceJDBC {#yandex.cloud.mdb.greenplum.v1.PXFDatasourceJDBC2}

#|
||Field | Description ||
|| driver | **string**

JDBC driver class in Java. The possible values are the following:

* `com.simba.athena.jdbc.Driver`
* `com.clickhouse.jdbc.ClickHouseDriver`
* `com.ibm.as400.access.AS400JDBCDriver`
* `com.microsoft.sqlserver.jdbc.SQLServerDriver`
* `com.mysql.cj.jdbc.Driver`
* `org.postgresql.Driver`
* `oracle.jdbc.driver.OracleDriver`
* `net.snowflake.client.jdbc.SnowflakeDriver`
* `io.trino.jdbc.TrinoDriver` ||
|| url | **string**

URL that the JDBC driver uses to connect to the database. Examples:

* `jdbc:mysql://mysqlhost:3306/testdb`: Local MySQL DB.
* `jdbc:postgresql://c-<cluster_id>.rw.mdb.yandexcloud.net:6432/db1`: Managed Service for PostgreSQL cluster. The address contains the special FQDN of the cluster's master.
* `jdbc:oracle:thin:@host.example:1521:orcl`: Oracle DB. ||
|| user | **string**

Username of the DB owner. ||
|| password | **string**

Password of the DB owner. ||
|| statementBatchSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Number of rows to read in an external table, in a batch.

The default value is `100`. ||
|| statementFetchSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Number of rows to fetch (buffer) when reading from an external table.

The default value is `1000`. ||
|| statementQueryTimeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Amount of time (in seconds) the JDBC driver waits for a statement to run. This timeout applies to statements created for both read and write operations.

The default value is `60`. ||
|| poolEnabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether JDBC connection pooling is used in a server configuration. By default, it is used. ||
|| poolMaximumSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of connections to the DB backend.

The default value is `5`. ||
|| poolConnectionTimeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum time, in milliseconds, to wait for a connection from the pool.

The default value is `30000`. ||
|| poolIdleTimeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum amount of time, in milliseconds, after which an inactive connection is considered idle.

The default value is `30000`. ||
|| poolMinimumIdle | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum number of idle connections maintained in the connection pool.

The default value is `0`. ||
|#

## PXFDatasourceHDFS {#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFS2}

#|
||Field | Description ||
|| core | **[PXFDatasourceCore](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceCore2)**

Settings of the file system and security rules. ||
|| kerberos | **[PXFDatasourceKerberos](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceKerberos2)**

Settings of the Kerberos network authentication protocol. ||
|| userImpersonation | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables authentication on behalf of the Greenplum® user when connecting to the remote file storage or DBMS.

The authentication is disabled by default. ||
|| username | **string**

Login username for the remote file storage or DBMS if authentication on behalf of the Greenplum® user is enabled. ||
|| saslConnectionRetries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of times that PXF retries a SASL connection request after a refused connection returns a `GSS initiate failed` error.

The default value is `5`. ||
|| zkHosts[] | **string**

ZooKeeper server hosts.

Specify values in the `<address>:<port>` format. ||
|| dfs | **[PXFDatasourceHDFSDfs](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFSDfs2)**

Settings of the distributed file system. ||
|| yarn | **[PXFDatasourceHDFSYarn](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFSYarn2)**

Settings of the ResourceManager service that is responsible for tracking resources in a cluster and scheduling applications (e.g., MapReduce jobs). ||
|#

## PXFDatasourceCore {#yandex.cloud.mdb.greenplum.v1.PXFDatasourceCore2}

#|
||Field | Description ||
|| defaultFs | **string**

URI whose scheme and authority determine the file system implementation. ||
|| securityAuthToLocal | **string**

Rules for mapping Kerberos principals to operating system user accounts. ||
|#

## PXFDatasourceKerberos {#yandex.cloud.mdb.greenplum.v1.PXFDatasourceKerberos2}

#|
||Field | Description ||
|| enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether the Kerberos authentication server is used. By default, it is not used. ||
|| primary | **string**

Host of the primary KDC server (Key Distribution Center). ||
|| realm | **string**

Kerberos realm for a Greenplum® DB. ||
|| kdcServers[] | **string**

KDC server hosts. ||
|| adminServer | **string**

Administration server host. Usually, this is the primary Kerberos server. ||
|| defaultDomain | **string**

Domain that is used for the host name extension. Applicable when Kerberos 4 service members become Kerberos 5 service members (for example, when rcmd.hostname is replaced with host/hostname.domain). ||
|| keytabBase64 | **string**

Base64 encoded contents of the keytab file. ||
|#

## PXFDatasourceHDFSDfs {#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFSDfs2}

#|
||Field | Description ||
|| haAutomaticFailoverEnabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether automatic failover is enabled for the high availability of the file system.

The automatic failover is enabled by default. ||
|| blockAccessTokenEnabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If `true`, access tokens are used as capabilities for accessing datanodes. If `false`, no access tokens are checked on accessing datanodes.

The check of access tokens is enabled by default. ||
|| useDatanodeHostname | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether the datanode hostname is used when connecting to datanodes. ||
|| namenodes | **[PXFDatasourceHDFSDfsNamenode](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFSDfsNamenode2)**

List of HDFS service logical names.

Specify them separated by commas. The names can be arbitrary. ||
|| nameservices | **string**

Corresponds well-known HDFS client setting "dfs.nameservices" for this datasource ||
|#

## PXFDatasourceHDFSDfsNamenode {#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFSDfsNamenode2}

#|
||Field | Description ||
|| rpcAddress | **string** ||
|| serviceRpcAddress | **string** ||
|| httpAddress | **string** ||
|| httpsAddress | **string** ||
|#

## PXFDatasourceHDFSYarn {#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFSYarn2}

#|
||Field | Description ||
|| resourcemanagerHaEnabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether high availability is enabled for YARN's ResourceManager services.

The high availability is enabled by default. ||
|| resourcemanagerHaAutoFailoverEnabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether another ResourceManager should automatically become active when the active ResourceManager has failed and does not respond.

The switch of ResourceManagers is enabled by default if the high availability is enabled. ||
|| resourcemanagerHaAutoFailoverEmbedded | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether the embedded ActiveStandbyElector method should be used for the election of the active ResourceManager. If the current active ResourceManager has failed and does not respond, the ActiveStandbyElector method makes another ResourceManager active which then takes over. ||
|| resourcemanagerClusterId | **string**

Cluster ID. Specify it, so the ResourceManager service does not become active for a different cluster. ||
|| haRm | **[PXFDatasourceHDFSYarnHaRm](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFSYarnHaRm2)**

Highly available ResourceManager service. ||
|#

## PXFDatasourceHDFSYarnHaRm {#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHDFSYarnHaRm2}

#|
||Field | Description ||
|| resourcemanagerAddress | **string** ||
|| resourcemanagerSchedulerAddress | **string** ||
|| resourcemanagerResourceTrackerAddress | **string** ||
|| resourcemanagerAdminAddress | **string** ||
|| resourcemanagerWebappAddress | **string** ||
|| resourcemanagerWebappHttpsAddress | **string** ||
|#

## PXFDatasourceHive {#yandex.cloud.mdb.greenplum.v1.PXFDatasourceHive2}

#|
||Field | Description ||
|| core | **[PXFDatasourceCore](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceCore2)**

Settings of the file system and security rules. ||
|| kerberos | **[PXFDatasourceKerberos](#yandex.cloud.mdb.greenplum.v1.PXFDatasourceKerberos2)**

Settings of the Kerberos network authentication protocol. ||
|| userImpersonation | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables authentication on behalf of the Greenplum® user when connecting to the remote file storage or DBMS.

The authentication is disabled by default. ||
|| username | **string**

Login username for the remote file storage or DBMS if authentication on behalf of the Greenplum® user is enabled. ||
|| saslConnectionRetries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of times that PXF retries a SASL connection request after a refused connection returns a `GSS initiate failed` error.

The default value is `5`. ||
|| zkHosts[] | **string**

ZooKeeper server hosts.

Specify values in the `<address>:<port>` format. ||
|| ppd | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Specifies if predicate pushdown is enabled for queries on external tables.

The predicate pushdown is enabled by default. ||
|| metastoreUris[] | **string**

List of URIs separated by commas. To request metadata, the remote DBMS connects to Metastore by one of these URIs. ||
|| metastoreKerberosPrincipal | **string**

Service principal for the Metastore Thrift server. ||
|| authKerberosPrincipal | **string**

Kerberos server principal. ||
|#