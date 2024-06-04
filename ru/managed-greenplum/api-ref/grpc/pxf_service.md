---
editable: false
sourcePath: en/_api-ref-grpc/managed-greenplum/api-ref/grpc/pxf_service.md
---

# Managed Service for Greenplum® API, gRPC: PXFDatasourceService



| Call | Description |
| --- | --- |
| [List](#List) | List all PXF datasources |
| [Create](#Create) | Creates PXF datasource |
| [Update](#Update) | Update PXF datasource |
| [Delete](#Delete) | Delete PXF datasource |

## Calls PXFDatasourceService {#calls}

## List {#List}

List all PXF datasources

**rpc List ([ListPXFDatasourcesRequest](#ListPXFDatasourcesRequest)) returns ([ListPXFDatasourcesResponse](#ListPXFDatasourcesResponse))**

### ListPXFDatasourcesRequest {#ListPXFDatasourcesRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required.  The maximum string length in characters is 50.


### ListPXFDatasourcesResponse {#ListPXFDatasourcesResponse}

Field | Description
--- | ---
datasources[] | **[PXFDatasource](#PXFDatasource)**<br> 


### PXFDatasource {#PXFDatasource}

Field | Description
--- | ---
name | **string**<br>Required. Data source name. The string length in characters must be 3-200. Value must match the regular expression ` ^[^\\\|/*?.,;\"'<>]+$ `.
settings | **oneof:** `s3`, `jdbc`, `hdfs` or `hive`<br>
&nbsp;&nbsp;s3 | **[PXFDatasourceS3](#PXFDatasourceS3)**<br>Settings of an external S3 data source. 
&nbsp;&nbsp;jdbc | **[PXFDatasourceJDBC](#PXFDatasourceJDBC)**<br>Settings of an external JDBC data source. 
&nbsp;&nbsp;hdfs | **[PXFDatasourceHDFS](#PXFDatasourceHDFS)**<br>Settings of an external HDFS data source. 
&nbsp;&nbsp;hive | **[PXFDatasourceHive](#PXFDatasourceHive)**<br>Settings of an external Hive data source. 


### PXFDatasourceS3 {#PXFDatasourceS3}

Field | Description
--- | ---
access_key | **string**<br>Public key to access S3 storage. The maximum string length in characters is 200.
secret_key | **string**<br>Secret key to access S3 storage. The maximum string length in characters is 200.
fast_upload | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Manages a fast upload of big files to S3 storage. In case of the `false` value, the PXF generates files on disk before sending them to the S3 storage. In case of the `true` value, the PXF generates files in RAM (the PXF writes to disc only if there is not enough RAM). <br>The fast upload is enabled by default. 
endpoint | **string**<br>S3 storage address. The default value is `storage.yandexcloud.net` used for Yandex Object Storage. The maximum string length in characters is 200. Value must match the regular expression ` (((s3\|https?)://)?([a-z0-9]([a-z0-9-]*[a-z0-9])?[.])+[a-z]{2,})? `.


### PXFDatasourceJDBC {#PXFDatasourceJDBC}

Field | Description
--- | ---
driver | **string**<br>JDBC driver class in Java. The possible values are the following: <br><ul><li>`com.simba.athena.jdbc.Driver` </li><li>`com.clickhouse.jdbc.ClickHouseDriver` </li><li>`com.ibm.as400.access.AS400JDBCDriver` </li><li>`com.microsoft.sqlserver.jdbc.SQLServerDriver` </li><li>`com.mysql.cj.jdbc.Driver` </li><li>`org.postgresql.Driver` </li><li>`oracle.jdbc.driver.OracleDriver` </li><li>`net.snowflake.client.jdbc.SnowflakeDriver` </li><li>`io.trino.jdbc.TrinoDriver`</li></ul> The maximum string length in characters is 50.
url | **string**<br>URL that the JDBC driver uses to connect to the database. Examples: <br><ul><li>`jdbc:mysql://mysqlhost:3306/testdb`: Local MySQL DB. </li><li>`jdbc:postgresql://c-<cluster_id>.rw.mdb.yandexcloud.net:6432/db1`: Managed Service for PostgreSQL cluster. The address contains the special FQDN of the cluster's master. </li><li>`jdbc:oracle:thin:@host.example:1521:orcl`: Oracle DB.</li></ul> The maximum string length in characters is 1000.
user | **string**<br>Username of the DB owner. The maximum string length in characters is 200.
password | **string**<br>Password of the DB owner. The maximum string length in characters is 200.
statement_batch_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of rows to read in an external table, in a batch. <br>The default value is `100`. Acceptable values are 50 to 1000, inclusive.
statement_fetch_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of rows to fetch (buffer) when reading from an external table. <br>The default value is `1000`. Acceptable values are 50 to 10000, inclusive.
statement_query_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Amount of time (in seconds) the JDBC driver waits for a statement to run. This timeout applies to statements created for both read and write operations. <br>The default value is `60`. Acceptable values are 5 to 43200, inclusive.
pool_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether JDBC connection pooling is used in a server configuration. By default, it is used. 
pool_maximum_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of connections to the DB backend. <br>The default value is `5`. Acceptable values are 1 to 200, inclusive.
pool_connection_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum amount of time, in milliseconds, after which an inactive connection is considered idle. <br>The default value is `30000`. Acceptable values are 5000 to 600000, inclusive.
pool_idle_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum amount of time, in milliseconds, after which an inactive connection is considered idle. <br>The default value is `30000`. Acceptable values are 5000 to 600000, inclusive.
pool_minimum_idle | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of idle connections maintained in the connection pool. <br>The default value is `0`. Acceptable values are 0 to 200, inclusive.


### PXFDatasourceHDFS {#PXFDatasourceHDFS}

Field | Description
--- | ---
core | **[PXFDatasourceCore](#PXFDatasourceCore)**<br>Settings of the file system and security rules. 
kerberos | **[PXFDatasourceKerberos](#PXFDatasourceKerberos)**<br>Settings of the Kerberos network authentication protocol. 
user_impersonation | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables authentication on behalf of the Greenplum® user when connecting to the remote file storage or DBMS. <br>The authentication is disabled by default. 
username | **string**<br>Login username for the remote file storage or DBMS if authentication on behalf of the Greenplum® user is enabled. The maximum string length in characters is 128.
sasl_connection_retries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of times that PXF retries a SASL connection request after a refused connection returns a `GSS initiate failed` error. <br>The default value is `5`. Acceptable values are 1 to 50, inclusive.
zk_hosts[] | **string**<br>ZooKeeper server hosts. <br>Specify values in the `<address>:<port>` format. The maximum number of elements is 200. The string length in characters for each value must be 1-200.
dfs | **[PXFDatasourceHDFSDfs](#PXFDatasourceHDFSDfs)**<br>Settings of the distributed file system. 
yarn | **[PXFDatasourceHDFSYarn](#PXFDatasourceHDFSYarn)**<br>Settings of the ResourceManager service that is responsible for tracking resources in a cluster and scheduling applications (e.g., MapReduce jobs). 


### PXFDatasourceCore {#PXFDatasourceCore}

Field | Description
--- | ---
default_fs | **string**<br>URI whose scheme and authority determine the file system implementation. The maximum string length in characters is 200.
security_auth_to_local | **string**<br>Rules for mapping Kerberos principals to operating system user accounts. The maximum string length in characters is 1000.


### PXFDatasourceKerberos {#PXFDatasourceKerberos}

Field | Description
--- | ---
enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether the Kerberos authentication server is used. By default, it is not used. 
primary | **string**<br>Host of the primary KDC server (Key Distribution Center). The maximum string length in characters is 128.
realm | **string**<br>Kerberos realm for a Greenplum® DB. The maximum string length in characters is 1000.
kdc_servers[] | **string**<br>KDC server hosts. The maximum number of elements is 200. The string length in characters for each value must be 1-200.
admin_server | **string**<br>Administration server host. Usually, this is the primary Kerberos server. The maximum string length in characters is 128.
default_domain | **string**<br>Domain that is used for the host name extension. Applicable when Kerberos 4 service members become Kerberos 5 service members (for example, when rcmd.hostname is replaced with host/hostname.domain). The maximum string length in characters is 128.
keytab_base64 | **string**<br>Base64 encoded contents of the keytab file. Value must match the regular expression ` ^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==\|[A-Za-z0-9+/]{3}=)?$ `. The maximum string length in characters is 65536.


### PXFDatasourceHDFSDfs {#PXFDatasourceHDFSDfs}

Field | Description
--- | ---
ha_automatic_failover_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether automatic failover is enabled for the high availability of the file system. <br>The automatic failover is enabled by default. 
block_access_token_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>If `true`, access tokens are used as capabilities for accessing datanodes. If `false`, no access tokens are checked on accessing datanodes. <br>The check of access tokens is enabled by default. 
use_datanode_hostname | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether the datanode hostname is used when connecting to datanodes. 
namenodes | **map<string,PXFDatasourceHDFSDfsNamenode>**<br>List of HDFS service logical names. <br>Specify them separated by commas. The names can be arbitrary. No more than 10000 per resource.
nameservices | **string**<br>Corresponds well-known HDFS client setting "dfs.nameservices" for this datasource 


### PXFDatasourceHDFSYarn {#PXFDatasourceHDFSYarn}

Field | Description
--- | ---
resourcemanager_ha_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether high availability is enabled for YARN's ResourceManager services. <br>The high availability is enabled by default. 
resourcemanager_ha_auto_failover_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether another ResourceManager should automatically become active when the active ResourceManager has failed and does not respond. <br>The switch of ResourceManagers is enabled by default if the high availability is enabled. 
resourcemanager_ha_auto_failover_embedded | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether the embedded ActiveStandbyElector method should be used for the election of the active ResourceManager. If the current active ResourceManager has failed and does not respond, the ActiveStandbyElector method makes another ResourceManager active which then takes over. 
resourcemanager_cluster_id | **string**<br>Cluster ID. Specify it, so the ResourceManager service does not become active for a different cluster. The maximum string length in characters is 1000.
ha_rm | **map<string,PXFDatasourceHDFSYarnHaRm>**<br>Highly available ResourceManager service. No more than 10000 per resource.


### PXFDatasourceHive {#PXFDatasourceHive}

Field | Description
--- | ---
core | **[PXFDatasourceCore](#PXFDatasourceCore1)**<br>Settings of the file system and security rules. 
kerberos | **[PXFDatasourceKerberos](#PXFDatasourceKerberos1)**<br>Settings of the Kerberos network authentication protocol. 
user_impersonation | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables authentication on behalf of the Greenplum® user when connecting to the remote file storage or DBMS. <br>The authentication is disabled by default. 
username | **string**<br>Login username for the remote file storage or DBMS if authentication on behalf of the Greenplum® user is enabled. The maximum string length in characters is 128.
sasl_connection_retries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of times that PXF retries a SASL connection request after a refused connection returns a `GSS initiate failed` error. <br>The default value is `5`. Acceptable values are 1 to 50, inclusive.
zk_hosts[] | **string**<br>ZooKeeper server hosts. <br>Specify values in the `<address>:<port>` format. The maximum number of elements is 200. The string length in characters for each value must be 1-200.
ppd | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies if predicate pushdown is enabled for queries on external tables. <br>The predicate pushdown is enabled by default. 
metastore_uris[] | **string**<br>List of URIs separated by commas. To request metadata, the remote DBMS connects to Metastore by one of these URIs. The maximum number of elements is 200. The string length in characters for each value must be 1-200.
metastore_kerberos_principal | **string**<br>Service principal for the Metastore Thrift server. The maximum string length in characters is 1000.
auth_kerberos_principal | **string**<br>Kerberos server principal. The maximum string length in characters is 1000.


## Create {#Create}

Creates PXF datasource

**rpc Create ([CreatePXFDatasourceRequest](#CreatePXFDatasourceRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreatePXFDatasourceMetadata](#CreatePXFDatasourceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[PXFDatasource](#PXFDatasource1)<br>

### CreatePXFDatasourceRequest {#CreatePXFDatasourceRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required.  The maximum string length in characters is 50.
datasource | **[PXFDatasource](#PXFDatasource1)**<br> 


### PXFDatasource {#PXFDatasource1}

Field | Description
--- | ---
name | **string**<br>Required. Data source name. The string length in characters must be 3-200. Value must match the regular expression ` ^[^\\\|/*?.,;\"'<>]+$ `.
settings | **oneof:** `s3`, `jdbc`, `hdfs` or `hive`<br>
&nbsp;&nbsp;s3 | **[PXFDatasourceS3](#PXFDatasourceS31)**<br>Settings of an external S3 data source. 
&nbsp;&nbsp;jdbc | **[PXFDatasourceJDBC](#PXFDatasourceJDBC1)**<br>Settings of an external JDBC data source. 
&nbsp;&nbsp;hdfs | **[PXFDatasourceHDFS](#PXFDatasourceHDFS1)**<br>Settings of an external HDFS data source. 
&nbsp;&nbsp;hive | **[PXFDatasourceHive](#PXFDatasourceHive1)**<br>Settings of an external Hive data source. 


### PXFDatasourceS3 {#PXFDatasourceS31}

Field | Description
--- | ---
access_key | **string**<br>Public key to access S3 storage. The maximum string length in characters is 200.
secret_key | **string**<br>Secret key to access S3 storage. The maximum string length in characters is 200.
fast_upload | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Manages a fast upload of big files to S3 storage. In case of the `false` value, the PXF generates files on disk before sending them to the S3 storage. In case of the `true` value, the PXF generates files in RAM (the PXF writes to disc only if there is not enough RAM). <br>The fast upload is enabled by default. 
endpoint | **string**<br>S3 storage address. The default value is `storage.yandexcloud.net` used for Yandex Object Storage. The maximum string length in characters is 200. Value must match the regular expression ` (((s3\|https?)://)?([a-z0-9]([a-z0-9-]*[a-z0-9])?[.])+[a-z]{2,})? `.


### PXFDatasourceJDBC {#PXFDatasourceJDBC1}

Field | Description
--- | ---
driver | **string**<br>JDBC driver class in Java. The possible values are the following: <br><ul><li>`com.simba.athena.jdbc.Driver` </li><li>`com.clickhouse.jdbc.ClickHouseDriver` </li><li>`com.ibm.as400.access.AS400JDBCDriver` </li><li>`com.microsoft.sqlserver.jdbc.SQLServerDriver` </li><li>`com.mysql.cj.jdbc.Driver` </li><li>`org.postgresql.Driver` </li><li>`oracle.jdbc.driver.OracleDriver` </li><li>`net.snowflake.client.jdbc.SnowflakeDriver` </li><li>`io.trino.jdbc.TrinoDriver`</li></ul> The maximum string length in characters is 50.
url | **string**<br>URL that the JDBC driver uses to connect to the database. Examples: <br><ul><li>`jdbc:mysql://mysqlhost:3306/testdb`: Local MySQL DB. </li><li>`jdbc:postgresql://c-<cluster_id>.rw.mdb.yandexcloud.net:6432/db1`: Managed Service for PostgreSQL cluster. The address contains the special FQDN of the cluster's master. </li><li>`jdbc:oracle:thin:@host.example:1521:orcl`: Oracle DB.</li></ul> The maximum string length in characters is 1000.
user | **string**<br>Username of the DB owner. The maximum string length in characters is 200.
password | **string**<br>Password of the DB owner. The maximum string length in characters is 200.
statement_batch_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of rows to read in an external table, in a batch. <br>The default value is `100`. Acceptable values are 50 to 1000, inclusive.
statement_fetch_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of rows to fetch (buffer) when reading from an external table. <br>The default value is `1000`. Acceptable values are 50 to 10000, inclusive.
statement_query_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Amount of time (in seconds) the JDBC driver waits for a statement to run. This timeout applies to statements created for both read and write operations. <br>The default value is `60`. Acceptable values are 5 to 43200, inclusive.
pool_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether JDBC connection pooling is used in a server configuration. By default, it is used. 
pool_maximum_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of connections to the DB backend. <br>The default value is `5`. Acceptable values are 1 to 200, inclusive.
pool_connection_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum amount of time, in milliseconds, after which an inactive connection is considered idle. <br>The default value is `30000`. Acceptable values are 5000 to 600000, inclusive.
pool_idle_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum amount of time, in milliseconds, after which an inactive connection is considered idle. <br>The default value is `30000`. Acceptable values are 5000 to 600000, inclusive.
pool_minimum_idle | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of idle connections maintained in the connection pool. <br>The default value is `0`. Acceptable values are 0 to 200, inclusive.


### PXFDatasourceHDFS {#PXFDatasourceHDFS1}

Field | Description
--- | ---
core | **[PXFDatasourceCore](#PXFDatasourceCore1)**<br>Settings of the file system and security rules. 
kerberos | **[PXFDatasourceKerberos](#PXFDatasourceKerberos1)**<br>Settings of the Kerberos network authentication protocol. 
user_impersonation | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables authentication on behalf of the Greenplum® user when connecting to the remote file storage or DBMS. <br>The authentication is disabled by default. 
username | **string**<br>Login username for the remote file storage or DBMS if authentication on behalf of the Greenplum® user is enabled. The maximum string length in characters is 128.
sasl_connection_retries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of times that PXF retries a SASL connection request after a refused connection returns a `GSS initiate failed` error. <br>The default value is `5`. Acceptable values are 1 to 50, inclusive.
zk_hosts[] | **string**<br>ZooKeeper server hosts. <br>Specify values in the `<address>:<port>` format. The maximum number of elements is 200. The string length in characters for each value must be 1-200.
dfs | **[PXFDatasourceHDFSDfs](#PXFDatasourceHDFSDfs1)**<br>Settings of the distributed file system. 
yarn | **[PXFDatasourceHDFSYarn](#PXFDatasourceHDFSYarn1)**<br>Settings of the ResourceManager service that is responsible for tracking resources in a cluster and scheduling applications (e.g., MapReduce jobs). 


### PXFDatasourceCore {#PXFDatasourceCore1}

Field | Description
--- | ---
default_fs | **string**<br>URI whose scheme and authority determine the file system implementation. The maximum string length in characters is 200.
security_auth_to_local | **string**<br>Rules for mapping Kerberos principals to operating system user accounts. The maximum string length in characters is 1000.


### PXFDatasourceKerberos {#PXFDatasourceKerberos1}

Field | Description
--- | ---
enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether the Kerberos authentication server is used. By default, it is not used. 
primary | **string**<br>Host of the primary KDC server (Key Distribution Center). The maximum string length in characters is 128.
realm | **string**<br>Kerberos realm for a Greenplum® DB. The maximum string length in characters is 1000.
kdc_servers[] | **string**<br>KDC server hosts. The maximum number of elements is 200. The string length in characters for each value must be 1-200.
admin_server | **string**<br>Administration server host. Usually, this is the primary Kerberos server. The maximum string length in characters is 128.
default_domain | **string**<br>Domain that is used for the host name extension. Applicable when Kerberos 4 service members become Kerberos 5 service members (for example, when rcmd.hostname is replaced with host/hostname.domain). The maximum string length in characters is 128.
keytab_base64 | **string**<br>Base64 encoded contents of the keytab file. Value must match the regular expression ` ^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==\|[A-Za-z0-9+/]{3}=)?$ `. The maximum string length in characters is 65536.


### PXFDatasourceHDFSDfs {#PXFDatasourceHDFSDfs1}

Field | Description
--- | ---
ha_automatic_failover_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether automatic failover is enabled for the high availability of the file system. <br>The automatic failover is enabled by default. 
block_access_token_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>If `true`, access tokens are used as capabilities for accessing datanodes. If `false`, no access tokens are checked on accessing datanodes. <br>The check of access tokens is enabled by default. 
use_datanode_hostname | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether the datanode hostname is used when connecting to datanodes. 
namenodes | **map<string,PXFDatasourceHDFSDfsNamenode>**<br>List of HDFS service logical names. <br>Specify them separated by commas. The names can be arbitrary. No more than 10000 per resource.
nameservices | **string**<br>Corresponds well-known HDFS client setting "dfs.nameservices" for this datasource 


### PXFDatasourceHDFSYarn {#PXFDatasourceHDFSYarn1}

Field | Description
--- | ---
resourcemanager_ha_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether high availability is enabled for YARN's ResourceManager services. <br>The high availability is enabled by default. 
resourcemanager_ha_auto_failover_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether another ResourceManager should automatically become active when the active ResourceManager has failed and does not respond. <br>The switch of ResourceManagers is enabled by default if the high availability is enabled. 
resourcemanager_ha_auto_failover_embedded | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether the embedded ActiveStandbyElector method should be used for the election of the active ResourceManager. If the current active ResourceManager has failed and does not respond, the ActiveStandbyElector method makes another ResourceManager active which then takes over. 
resourcemanager_cluster_id | **string**<br>Cluster ID. Specify it, so the ResourceManager service does not become active for a different cluster. The maximum string length in characters is 1000.
ha_rm | **map<string,PXFDatasourceHDFSYarnHaRm>**<br>Highly available ResourceManager service. No more than 10000 per resource.


### PXFDatasourceHive {#PXFDatasourceHive1}

Field | Description
--- | ---
core | **[PXFDatasourceCore](#PXFDatasourceCore2)**<br>Settings of the file system and security rules. 
kerberos | **[PXFDatasourceKerberos](#PXFDatasourceKerberos2)**<br>Settings of the Kerberos network authentication protocol. 
user_impersonation | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables authentication on behalf of the Greenplum® user when connecting to the remote file storage or DBMS. <br>The authentication is disabled by default. 
username | **string**<br>Login username for the remote file storage or DBMS if authentication on behalf of the Greenplum® user is enabled. The maximum string length in characters is 128.
sasl_connection_retries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of times that PXF retries a SASL connection request after a refused connection returns a `GSS initiate failed` error. <br>The default value is `5`. Acceptable values are 1 to 50, inclusive.
zk_hosts[] | **string**<br>ZooKeeper server hosts. <br>Specify values in the `<address>:<port>` format. The maximum number of elements is 200. The string length in characters for each value must be 1-200.
ppd | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies if predicate pushdown is enabled for queries on external tables. <br>The predicate pushdown is enabled by default. 
metastore_uris[] | **string**<br>List of URIs separated by commas. To request metadata, the remote DBMS connects to Metastore by one of these URIs. The maximum number of elements is 200. The string length in characters for each value must be 1-200.
metastore_kerberos_principal | **string**<br>Service principal for the Metastore Thrift server. The maximum string length in characters is 1000.
auth_kerberos_principal | **string**<br>Kerberos server principal. The maximum string length in characters is 1000.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreatePXFDatasourceMetadata](#CreatePXFDatasourceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[PXFDatasource](#PXFDatasource2)>**<br>if operation finished successfully. 


### CreatePXFDatasourceMetadata {#CreatePXFDatasourceMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>Required.  The maximum string length in characters is 50.
datasource_name | **string**<br>Required.  The string length in characters must be 3-200. Value must match the regular expression ` ^[^\\\|/*?.,;\"'<>]+$ `.


### PXFDatasource {#PXFDatasource2}

Field | Description
--- | ---
name | **string**<br>Required. Data source name. The string length in characters must be 3-200. Value must match the regular expression ` ^[^\\\|/*?.,;\"'<>]+$ `.
settings | **oneof:** `s3`, `jdbc`, `hdfs` or `hive`<br>
&nbsp;&nbsp;s3 | **[PXFDatasourceS3](#PXFDatasourceS32)**<br>Settings of an external S3 data source. 
&nbsp;&nbsp;jdbc | **[PXFDatasourceJDBC](#PXFDatasourceJDBC2)**<br>Settings of an external JDBC data source. 
&nbsp;&nbsp;hdfs | **[PXFDatasourceHDFS](#PXFDatasourceHDFS2)**<br>Settings of an external HDFS data source. 
&nbsp;&nbsp;hive | **[PXFDatasourceHive](#PXFDatasourceHive2)**<br>Settings of an external Hive data source. 


## Update {#Update}

Update PXF datasource

**rpc Update ([UpdatePXFDatasourceRequest](#UpdatePXFDatasourceRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdatePXFDatasourceMetadata](#UpdatePXFDatasourceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[PXFDatasource](#PXFDatasource3)<br>

### UpdatePXFDatasourceRequest {#UpdatePXFDatasourceRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required.  The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
datasource | **[PXFDatasource](#PXFDatasource3)**<br> 


### PXFDatasource {#PXFDatasource3}

Field | Description
--- | ---
name | **string**<br>Required. Data source name. The string length in characters must be 3-200. Value must match the regular expression ` ^[^\\\|/*?.,;\"'<>]+$ `.
settings | **oneof:** `s3`, `jdbc`, `hdfs` or `hive`<br>
&nbsp;&nbsp;s3 | **[PXFDatasourceS3](#PXFDatasourceS32)**<br>Settings of an external S3 data source. 
&nbsp;&nbsp;jdbc | **[PXFDatasourceJDBC](#PXFDatasourceJDBC2)**<br>Settings of an external JDBC data source. 
&nbsp;&nbsp;hdfs | **[PXFDatasourceHDFS](#PXFDatasourceHDFS2)**<br>Settings of an external HDFS data source. 
&nbsp;&nbsp;hive | **[PXFDatasourceHive](#PXFDatasourceHive2)**<br>Settings of an external Hive data source. 


### PXFDatasourceS3 {#PXFDatasourceS32}

Field | Description
--- | ---
access_key | **string**<br>Public key to access S3 storage. The maximum string length in characters is 200.
secret_key | **string**<br>Secret key to access S3 storage. The maximum string length in characters is 200.
fast_upload | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Manages a fast upload of big files to S3 storage. In case of the `false` value, the PXF generates files on disk before sending them to the S3 storage. In case of the `true` value, the PXF generates files in RAM (the PXF writes to disc only if there is not enough RAM). <br>The fast upload is enabled by default. 
endpoint | **string**<br>S3 storage address. The default value is `storage.yandexcloud.net` used for Yandex Object Storage. The maximum string length in characters is 200. Value must match the regular expression ` (((s3\|https?)://)?([a-z0-9]([a-z0-9-]*[a-z0-9])?[.])+[a-z]{2,})? `.


### PXFDatasourceJDBC {#PXFDatasourceJDBC2}

Field | Description
--- | ---
driver | **string**<br>JDBC driver class in Java. The possible values are the following: <br><ul><li>`com.simba.athena.jdbc.Driver` </li><li>`com.clickhouse.jdbc.ClickHouseDriver` </li><li>`com.ibm.as400.access.AS400JDBCDriver` </li><li>`com.microsoft.sqlserver.jdbc.SQLServerDriver` </li><li>`com.mysql.cj.jdbc.Driver` </li><li>`org.postgresql.Driver` </li><li>`oracle.jdbc.driver.OracleDriver` </li><li>`net.snowflake.client.jdbc.SnowflakeDriver` </li><li>`io.trino.jdbc.TrinoDriver`</li></ul> The maximum string length in characters is 50.
url | **string**<br>URL that the JDBC driver uses to connect to the database. Examples: <br><ul><li>`jdbc:mysql://mysqlhost:3306/testdb`: Local MySQL DB. </li><li>`jdbc:postgresql://c-<cluster_id>.rw.mdb.yandexcloud.net:6432/db1`: Managed Service for PostgreSQL cluster. The address contains the special FQDN of the cluster's master. </li><li>`jdbc:oracle:thin:@host.example:1521:orcl`: Oracle DB.</li></ul> The maximum string length in characters is 1000.
user | **string**<br>Username of the DB owner. The maximum string length in characters is 200.
password | **string**<br>Password of the DB owner. The maximum string length in characters is 200.
statement_batch_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of rows to read in an external table, in a batch. <br>The default value is `100`. Acceptable values are 50 to 1000, inclusive.
statement_fetch_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of rows to fetch (buffer) when reading from an external table. <br>The default value is `1000`. Acceptable values are 50 to 10000, inclusive.
statement_query_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Amount of time (in seconds) the JDBC driver waits for a statement to run. This timeout applies to statements created for both read and write operations. <br>The default value is `60`. Acceptable values are 5 to 43200, inclusive.
pool_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether JDBC connection pooling is used in a server configuration. By default, it is used. 
pool_maximum_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of connections to the DB backend. <br>The default value is `5`. Acceptable values are 1 to 200, inclusive.
pool_connection_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum amount of time, in milliseconds, after which an inactive connection is considered idle. <br>The default value is `30000`. Acceptable values are 5000 to 600000, inclusive.
pool_idle_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum amount of time, in milliseconds, after which an inactive connection is considered idle. <br>The default value is `30000`. Acceptable values are 5000 to 600000, inclusive.
pool_minimum_idle | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of idle connections maintained in the connection pool. <br>The default value is `0`. Acceptable values are 0 to 200, inclusive.


### PXFDatasourceHDFS {#PXFDatasourceHDFS2}

Field | Description
--- | ---
core | **[PXFDatasourceCore](#PXFDatasourceCore2)**<br>Settings of the file system and security rules. 
kerberos | **[PXFDatasourceKerberos](#PXFDatasourceKerberos2)**<br>Settings of the Kerberos network authentication protocol. 
user_impersonation | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables authentication on behalf of the Greenplum® user when connecting to the remote file storage or DBMS. <br>The authentication is disabled by default. 
username | **string**<br>Login username for the remote file storage or DBMS if authentication on behalf of the Greenplum® user is enabled. The maximum string length in characters is 128.
sasl_connection_retries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of times that PXF retries a SASL connection request after a refused connection returns a `GSS initiate failed` error. <br>The default value is `5`. Acceptable values are 1 to 50, inclusive.
zk_hosts[] | **string**<br>ZooKeeper server hosts. <br>Specify values in the `<address>:<port>` format. The maximum number of elements is 200. The string length in characters for each value must be 1-200.
dfs | **[PXFDatasourceHDFSDfs](#PXFDatasourceHDFSDfs2)**<br>Settings of the distributed file system. 
yarn | **[PXFDatasourceHDFSYarn](#PXFDatasourceHDFSYarn2)**<br>Settings of the ResourceManager service that is responsible for tracking resources in a cluster and scheduling applications (e.g., MapReduce jobs). 


### PXFDatasourceCore {#PXFDatasourceCore2}

Field | Description
--- | ---
default_fs | **string**<br>URI whose scheme and authority determine the file system implementation. The maximum string length in characters is 200.
security_auth_to_local | **string**<br>Rules for mapping Kerberos principals to operating system user accounts. The maximum string length in characters is 1000.


### PXFDatasourceKerberos {#PXFDatasourceKerberos2}

Field | Description
--- | ---
enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether the Kerberos authentication server is used. By default, it is not used. 
primary | **string**<br>Host of the primary KDC server (Key Distribution Center). The maximum string length in characters is 128.
realm | **string**<br>Kerberos realm for a Greenplum® DB. The maximum string length in characters is 1000.
kdc_servers[] | **string**<br>KDC server hosts. The maximum number of elements is 200. The string length in characters for each value must be 1-200.
admin_server | **string**<br>Administration server host. Usually, this is the primary Kerberos server. The maximum string length in characters is 128.
default_domain | **string**<br>Domain that is used for the host name extension. Applicable when Kerberos 4 service members become Kerberos 5 service members (for example, when rcmd.hostname is replaced with host/hostname.domain). The maximum string length in characters is 128.
keytab_base64 | **string**<br>Base64 encoded contents of the keytab file. Value must match the regular expression ` ^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==\|[A-Za-z0-9+/]{3}=)?$ `. The maximum string length in characters is 65536.


### PXFDatasourceHDFSDfs {#PXFDatasourceHDFSDfs2}

Field | Description
--- | ---
ha_automatic_failover_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether automatic failover is enabled for the high availability of the file system. <br>The automatic failover is enabled by default. 
block_access_token_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>If `true`, access tokens are used as capabilities for accessing datanodes. If `false`, no access tokens are checked on accessing datanodes. <br>The check of access tokens is enabled by default. 
use_datanode_hostname | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether the datanode hostname is used when connecting to datanodes. 
namenodes | **map<string,PXFDatasourceHDFSDfsNamenode>**<br>List of HDFS service logical names. <br>Specify them separated by commas. The names can be arbitrary. No more than 10000 per resource.
nameservices | **string**<br>Corresponds well-known HDFS client setting "dfs.nameservices" for this datasource 


### PXFDatasourceHDFSYarn {#PXFDatasourceHDFSYarn2}

Field | Description
--- | ---
resourcemanager_ha_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether high availability is enabled for YARN's ResourceManager services. <br>The high availability is enabled by default. 
resourcemanager_ha_auto_failover_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether another ResourceManager should automatically become active when the active ResourceManager has failed and does not respond. <br>The switch of ResourceManagers is enabled by default if the high availability is enabled. 
resourcemanager_ha_auto_failover_embedded | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether the embedded ActiveStandbyElector method should be used for the election of the active ResourceManager. If the current active ResourceManager has failed and does not respond, the ActiveStandbyElector method makes another ResourceManager active which then takes over. 
resourcemanager_cluster_id | **string**<br>Cluster ID. Specify it, so the ResourceManager service does not become active for a different cluster. The maximum string length in characters is 1000.
ha_rm | **map<string,PXFDatasourceHDFSYarnHaRm>**<br>Highly available ResourceManager service. No more than 10000 per resource.


### PXFDatasourceHive {#PXFDatasourceHive2}

Field | Description
--- | ---
core | **[PXFDatasourceCore](#PXFDatasourceCore3)**<br>Settings of the file system and security rules. 
kerberos | **[PXFDatasourceKerberos](#PXFDatasourceKerberos3)**<br>Settings of the Kerberos network authentication protocol. 
user_impersonation | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables authentication on behalf of the Greenplum® user when connecting to the remote file storage or DBMS. <br>The authentication is disabled by default. 
username | **string**<br>Login username for the remote file storage or DBMS if authentication on behalf of the Greenplum® user is enabled. The maximum string length in characters is 128.
sasl_connection_retries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of times that PXF retries a SASL connection request after a refused connection returns a `GSS initiate failed` error. <br>The default value is `5`. Acceptable values are 1 to 50, inclusive.
zk_hosts[] | **string**<br>ZooKeeper server hosts. <br>Specify values in the `<address>:<port>` format. The maximum number of elements is 200. The string length in characters for each value must be 1-200.
ppd | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies if predicate pushdown is enabled for queries on external tables. <br>The predicate pushdown is enabled by default. 
metastore_uris[] | **string**<br>List of URIs separated by commas. To request metadata, the remote DBMS connects to Metastore by one of these URIs. The maximum number of elements is 200. The string length in characters for each value must be 1-200.
metastore_kerberos_principal | **string**<br>Service principal for the Metastore Thrift server. The maximum string length in characters is 1000.
auth_kerberos_principal | **string**<br>Kerberos server principal. The maximum string length in characters is 1000.


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdatePXFDatasourceMetadata](#UpdatePXFDatasourceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[PXFDatasource](#PXFDatasource4)>**<br>if operation finished successfully. 


### UpdatePXFDatasourceMetadata {#UpdatePXFDatasourceMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>Required.  The maximum string length in characters is 50.
datasource_name | **string**<br>Required.  The string length in characters must be 3-200. Value must match the regular expression ` ^[^\\\|/*?.,;\"'<>]+$ `.


### PXFDatasource {#PXFDatasource4}

Field | Description
--- | ---
name | **string**<br>Required. Data source name. The string length in characters must be 3-200. Value must match the regular expression ` ^[^\\\|/*?.,;\"'<>]+$ `.
settings | **oneof:** `s3`, `jdbc`, `hdfs` or `hive`<br>
&nbsp;&nbsp;s3 | **[PXFDatasourceS3](#PXFDatasourceS33)**<br>Settings of an external S3 data source. 
&nbsp;&nbsp;jdbc | **[PXFDatasourceJDBC](#PXFDatasourceJDBC3)**<br>Settings of an external JDBC data source. 
&nbsp;&nbsp;hdfs | **[PXFDatasourceHDFS](#PXFDatasourceHDFS3)**<br>Settings of an external HDFS data source. 
&nbsp;&nbsp;hive | **[PXFDatasourceHive](#PXFDatasourceHive3)**<br>Settings of an external Hive data source. 


## Delete {#Delete}

Delete PXF datasource

**rpc Delete ([DeletePXFDatasourceRequest](#DeletePXFDatasourceRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeletePXFDatasourceMetadata](#DeletePXFDatasourceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeletePXFDatasourceRequest {#DeletePXFDatasourceRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required.  The maximum string length in characters is 50.
datasource_name | **string**<br>Required.  The string length in characters must be 3-200. Value must match the regular expression ` ^[^\\\|/*?.,;\"'<>]+$ `.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeletePXFDatasourceMetadata](#DeletePXFDatasourceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeletePXFDatasourceMetadata {#DeletePXFDatasourceMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>Required.  The maximum string length in characters is 50.
datasource_name | **string**<br>Required.  The string length in characters must be 3-200. Value must match the regular expression ` ^[^\\\|/*?.,;\"'<>]+$ `.


