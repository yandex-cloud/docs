---
editable: false
sourcePath: en/_api-ref/mdb/greenplum/v1/api-ref/PXFDatasource/list.md
---

# Managed Service for Greenplum® API, REST: PXFDatasource.list
List all PXF datasources
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/{clusterId}/pxf_datasources
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "datasources": [
    {
      "name": "string",

      // `datasources[]` includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`
      "s3": {
        "accessKey": "string",
        "secretKey": "string",
        "fastUpload": true,
        "endpoint": "string"
      },
      "jdbc": {
        "driver": "string",
        "url": "string",
        "user": "string",
        "password": "string",
        "statementBatchSize": "integer",
        "statementFetchSize": "integer",
        "statementQueryTimeout": "integer",
        "poolEnabled": true,
        "poolMaximumSize": "integer",
        "poolConnectionTimeout": "integer",
        "poolIdleTimeout": "integer",
        "poolMinimumIdle": "integer"
      },
      "hdfs": {
        "core": {
          "defaultFs": "string",
          "securityAuthToLocal": "string"
        },
        "kerberos": {
          "enable": true,
          "primary": "string",
          "realm": "string",
          "kdcServers": [
            "string"
          ],
          "adminServer": "string",
          "defaultDomain": "string",
          "keytabBase64": "string"
        },
        "userImpersonation": true,
        "username": "string",
        "saslConnectionRetries": "integer",
        "zkHosts": [
          "string"
        ],
        "dfs": {
          "haAutomaticFailoverEnabled": true,
          "blockAccessTokenEnabled": true,
          "useDatanodeHostname": true,
          "namenodes": "object",
          "nameservices": "string"
        },
        "yarn": {
          "resourcemanagerHaEnabled": true,
          "resourcemanagerHaAutoFailoverEnabled": true,
          "resourcemanagerHaAutoFailoverEmbedded": true,
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
          "enable": true,
          "primary": "string",
          "realm": "string",
          "kdcServers": [
            "string"
          ],
          "adminServer": "string",
          "defaultDomain": "string",
          "keytabBase64": "string"
        },
        "userImpersonation": true,
        "username": "string",
        "saslConnectionRetries": "integer",
        "zkHosts": [
          "string"
        ],
        "ppd": true,
        "metastoreUris": [
          "string"
        ],
        "metastoreKerberosPrincipal": "string",
        "authKerberosPrincipal": "string"
      },
      // end of the list of possible fields`datasources[]`

    }
  ]
}
```

 
Field | Description
--- | ---
datasources[] | **object**
datasources[].<br>name | **string**<br><p>Required. Data source name.</p> <p>The string length in characters must be 3-200. Value must match the regular expression ``^[^\\|/*?.,;"'<>]+$``.</p> 
datasources[].<br>s3 | **object**<br>Settings of an external S3 data source. <br>`datasources[]` includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`<br>
datasources[].<br>s3.<br>accessKey | **string**<br><p>Public key to access S3 storage.</p> <p>The maximum string length in characters is 200.</p> 
datasources[].<br>s3.<br>secretKey | **string**<br><p>Secret key to access S3 storage.</p> <p>The maximum string length in characters is 200.</p> 
datasources[].<br>s3.<br>fastUpload | **boolean** (boolean)<br><p>Manages a fast upload of big files to S3 storage. In case of the ``false`` value, the PXF generates files on disk before sending them to the S3 storage. In case of the ``true`` value, the PXF generates files in RAM (the PXF writes to disc only if there is not enough RAM).</p> <p>The fast upload is enabled by default.</p> 
datasources[].<br>s3.<br>endpoint | **string**<br><p>S3 storage address. The default value is ``storage.yandexcloud.net`` used for Yandex Object Storage.</p> <p>The maximum string length in characters is 200. Value must match the regular expression ``(((s3\|https?)://)?([a-z0-9]([a-z0-9-]*[a-z0-9])?[.])+[a-z]{2,})?``.</p> 
datasources[].<br>jdbc | **object**<br>Settings of an external JDBC data source. <br>`datasources[]` includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`<br>
datasources[].<br>jdbc.<br>driver | **string**<br><p>JDBC driver class in Java. The possible values are the following:</p> <ul> <li>``com.simba.athena.jdbc.Driver``</li> <li>``com.clickhouse.jdbc.ClickHouseDriver``</li> <li>``com.ibm.as400.access.AS400JDBCDriver``</li> <li>``com.microsoft.sqlserver.jdbc.SQLServerDriver``</li> <li>``com.mysql.cj.jdbc.Driver``</li> <li>``org.postgresql.Driver``</li> <li>``oracle.jdbc.driver.OracleDriver``</li> <li>``net.snowflake.client.jdbc.SnowflakeDriver``</li> <li>``io.trino.jdbc.TrinoDriver``</li> </ul> <p>The maximum string length in characters is 50.</p> 
datasources[].<br>jdbc.<br>url | **string**<br><p>URL that the JDBC driver uses to connect to the database. Examples:</p> <ul> <li>``jdbc:mysql://mysqlhost:3306/testdb``: Local MySQL DB.</li> <li>``jdbc:postgresql://c-<cluster_id>.rw.mdb.yandexcloud.net:6432/db1``: Managed Service for PostgreSQL cluster. The address contains the special FQDN of the cluster's master.</li> <li>``jdbc:oracle:thin:@host.example:1521:orcl``: Oracle DB.</li> </ul> <p>The maximum string length in characters is 1000.</p> 
datasources[].<br>jdbc.<br>user | **string**<br><p>Username of the DB owner.</p> <p>The maximum string length in characters is 200.</p> 
datasources[].<br>jdbc.<br>password | **string**<br><p>Password of the DB owner.</p> <p>The maximum string length in characters is 200.</p> 
datasources[].<br>jdbc.<br>statementBatchSize | **integer** (int64)<br><p>Number of rows to read in an external table, in a batch.</p> <p>The default value is ``100``.</p> <p>Acceptable values are 50 to 1000, inclusive.</p> 
datasources[].<br>jdbc.<br>statementFetchSize | **integer** (int64)<br><p>Number of rows to fetch (buffer) when reading from an external table.</p> <p>The default value is ``1000``.</p> <p>Acceptable values are 50 to 10000, inclusive.</p> 
datasources[].<br>jdbc.<br>statementQueryTimeout | **integer** (int64)<br><p>Amount of time (in seconds) the JDBC driver waits for a statement to run. This timeout applies to statements created for both read and write operations.</p> <p>The default value is ``60``.</p> <p>Acceptable values are 5 to 43200, inclusive.</p> 
datasources[].<br>jdbc.<br>poolEnabled | **boolean** (boolean)<br><p>Determines whether JDBC connection pooling is used in a server configuration. By default, it is used.</p> 
datasources[].<br>jdbc.<br>poolMaximumSize | **integer** (int64)<br><p>Maximum number of connections to the DB backend.</p> <p>The default value is ``5``.</p> <p>Acceptable values are 1 to 200, inclusive.</p> 
datasources[].<br>jdbc.<br>poolConnectionTimeout | **integer** (int64)<br><p>Maximum amount of time, in milliseconds, after which an inactive connection is considered idle.</p> <p>The default value is ``30000``.</p> <p>Acceptable values are 5000 to 600000, inclusive.</p> 
datasources[].<br>jdbc.<br>poolIdleTimeout | **integer** (int64)<br><p>Maximum amount of time, in milliseconds, after which an inactive connection is considered idle.</p> <p>The default value is ``30000``.</p> <p>Acceptable values are 5000 to 600000, inclusive.</p> 
datasources[].<br>jdbc.<br>poolMinimumIdle | **integer** (int64)<br><p>Minimum number of idle connections maintained in the connection pool.</p> <p>The default value is ``0``.</p> <p>Acceptable values are 0 to 200, inclusive.</p> 
datasources[].<br>hdfs | **object**<br>Settings of an external HDFS data source. <br>`datasources[]` includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`<br>
datasources[].<br>hdfs.<br>core | **object**<br><p>Settings of the file system and security rules.</p> 
datasources[].<br>hdfs.<br>core.<br>defaultFs | **string**<br><p>URI whose scheme and authority determine the file system implementation.</p> <p>The maximum string length in characters is 200.</p> 
datasources[].<br>hdfs.<br>core.<br>securityAuthToLocal | **string**<br><p>Rules for mapping Kerberos principals to operating system user accounts.</p> <p>The maximum string length in characters is 1000.</p> 
datasources[].<br>hdfs.<br>kerberos | **object**<br><p>Settings of the Kerberos network authentication protocol.</p> 
datasources[].<br>hdfs.<br>kerberos.<br>enable | **boolean** (boolean)<br><p>Determines whether the Kerberos authentication server is used. By default, it is not used.</p> 
datasources[].<br>hdfs.<br>kerberos.<br>primary | **string**<br><p>Host of the primary KDC server (Key Distribution Center).</p> <p>The maximum string length in characters is 128.</p> 
datasources[].<br>hdfs.<br>kerberos.<br>realm | **string**<br><p>Kerberos realm for a Greenplum® DB.</p> <p>The maximum string length in characters is 1000.</p> 
datasources[].<br>hdfs.<br>kerberos.<br>kdcServers[] | **string**<br><p>KDC server hosts.</p> <p>The maximum number of elements is 200. The string length in characters for each value must be 1-200.</p> 
datasources[].<br>hdfs.<br>kerberos.<br>adminServer | **string**<br><p>Administration server host. Usually, this is the primary Kerberos server.</p> <p>The maximum string length in characters is 128.</p> 
datasources[].<br>hdfs.<br>kerberos.<br>defaultDomain | **string**<br><p>Domain that is used for the host name extension. Applicable when Kerberos 4 service members become Kerberos 5 service members (for example, when rcmd.hostname is replaced with host/hostname.domain).</p> <p>The maximum string length in characters is 128.</p> 
datasources[].<br>hdfs.<br>kerberos.<br>keytabBase64 | **string**<br><p>Base64 encoded contents of the keytab file.</p> <p>The maximum string length in characters is 65536. Value must match the regular expression ``^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==\|[A-Za-z0-9+/]{3}=)?$``.</p> 
datasources[].<br>hdfs.<br>userImpersonation | **boolean** (boolean)<br><p>Enables authentication on behalf of the Greenplum® user when connecting to the remote file storage or DBMS.</p> <p>The authentication is disabled by default.</p> 
datasources[].<br>hdfs.<br>username | **string**<br><p>Login username for the remote file storage or DBMS if authentication on behalf of the Greenplum® user is enabled.</p> <p>The maximum string length in characters is 128.</p> 
datasources[].<br>hdfs.<br>saslConnectionRetries | **integer** (int64)<br><p>Maximum number of times that PXF retries a SASL connection request after a refused connection returns a ``GSS initiate failed`` error.</p> <p>The default value is ``5``.</p> <p>Acceptable values are 1 to 50, inclusive.</p> 
datasources[].<br>hdfs.<br>zkHosts[] | **string**<br><p>ZooKeeper server hosts.</p> <p>Specify values in the ``<address>:<port>`` format.</p> <p>The maximum number of elements is 200. The string length in characters for each value must be 1-200.</p> 
datasources[].<br>hdfs.<br>dfs | **object**<br><p>Settings of the distributed file system.</p> 
datasources[].<br>hdfs.<br>dfs.<br>haAutomaticFailoverEnabled | **boolean** (boolean)<br><p>Determines whether automatic failover is enabled for the high availability of the file system.</p> <p>The automatic failover is enabled by default.</p> 
datasources[].<br>hdfs.<br>dfs.<br>blockAccessTokenEnabled | **boolean** (boolean)<br><p>If ``true``, access tokens are used as capabilities for accessing datanodes. If ``false``, no access tokens are checked on accessing datanodes.</p> <p>The check of access tokens is enabled by default.</p> 
datasources[].<br>hdfs.<br>dfs.<br>useDatanodeHostname | **boolean** (boolean)<br><p>Determines whether the datanode hostname is used when connecting to datanodes.</p> 
datasources[].<br>hdfs.<br>dfs.<br>namenodes | **object**<br><p>List of HDFS service logical names.</p> <p>Specify them separated by commas. The names can be arbitrary.</p> <p>No more than 10000 per resource.</p> 
datasources[].<br>hdfs.<br>dfs.<br>nameservices | **string**<br><p>Corresponds well-known HDFS client setting "dfs.nameservices" for this datasource</p> 
datasources[].<br>hdfs.<br>yarn | **object**<br><p>Settings of the ResourceManager service that is responsible for tracking resources in a cluster and scheduling applications (e.g., MapReduce jobs).</p> 
datasources[].<br>hdfs.<br>yarn.<br>resourcemanagerHaEnabled | **boolean** (boolean)<br><p>Determines whether high availability is enabled for YARN's ResourceManager services.</p> <p>The high availability is enabled by default.</p> 
datasources[].<br>hdfs.<br>yarn.<br>resourcemanagerHaAutoFailoverEnabled | **boolean** (boolean)<br><p>Determines whether another ResourceManager should automatically become active when the active ResourceManager has failed and does not respond.</p> <p>The switch of ResourceManagers is enabled by default if the high availability is enabled.</p> 
datasources[].<br>hdfs.<br>yarn.<br>resourcemanagerHaAutoFailoverEmbedded | **boolean** (boolean)<br><p>Determines whether the embedded ActiveStandbyElector method should be used for the election of the active ResourceManager. If the current active ResourceManager has failed and does not respond, the ActiveStandbyElector method makes another ResourceManager active which then takes over.</p> 
datasources[].<br>hdfs.<br>yarn.<br>resourcemanagerClusterId | **string**<br><p>Cluster ID. Specify it, so the ResourceManager service does not become active for a different cluster.</p> <p>The maximum string length in characters is 1000.</p> 
datasources[].<br>hdfs.<br>yarn.<br>haRm | **object**<br><p>Highly available ResourceManager service.</p> <p>No more than 10000 per resource.</p> 
datasources[].<br>hive | **object**<br>Settings of an external Hive data source. <br>`datasources[]` includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`<br>
datasources[].<br>hive.<br>core | **object**<br><p>Settings of the file system and security rules.</p> 
datasources[].<br>hive.<br>core.<br>defaultFs | **string**<br><p>URI whose scheme and authority determine the file system implementation.</p> <p>The maximum string length in characters is 200.</p> 
datasources[].<br>hive.<br>core.<br>securityAuthToLocal | **string**<br><p>Rules for mapping Kerberos principals to operating system user accounts.</p> <p>The maximum string length in characters is 1000.</p> 
datasources[].<br>hive.<br>kerberos | **object**<br><p>Settings of the Kerberos network authentication protocol.</p> 
datasources[].<br>hive.<br>kerberos.<br>enable | **boolean** (boolean)<br><p>Determines whether the Kerberos authentication server is used. By default, it is not used.</p> 
datasources[].<br>hive.<br>kerberos.<br>primary | **string**<br><p>Host of the primary KDC server (Key Distribution Center).</p> <p>The maximum string length in characters is 128.</p> 
datasources[].<br>hive.<br>kerberos.<br>realm | **string**<br><p>Kerberos realm for a Greenplum® DB.</p> <p>The maximum string length in characters is 1000.</p> 
datasources[].<br>hive.<br>kerberos.<br>kdcServers[] | **string**<br><p>KDC server hosts.</p> <p>The maximum number of elements is 200. The string length in characters for each value must be 1-200.</p> 
datasources[].<br>hive.<br>kerberos.<br>adminServer | **string**<br><p>Administration server host. Usually, this is the primary Kerberos server.</p> <p>The maximum string length in characters is 128.</p> 
datasources[].<br>hive.<br>kerberos.<br>defaultDomain | **string**<br><p>Domain that is used for the host name extension. Applicable when Kerberos 4 service members become Kerberos 5 service members (for example, when rcmd.hostname is replaced with host/hostname.domain).</p> <p>The maximum string length in characters is 128.</p> 
datasources[].<br>hive.<br>kerberos.<br>keytabBase64 | **string**<br><p>Base64 encoded contents of the keytab file.</p> <p>The maximum string length in characters is 65536. Value must match the regular expression ``^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==\|[A-Za-z0-9+/]{3}=)?$``.</p> 
datasources[].<br>hive.<br>userImpersonation | **boolean** (boolean)<br><p>Enables authentication on behalf of the Greenplum® user when connecting to the remote file storage or DBMS.</p> <p>The authentication is disabled by default.</p> 
datasources[].<br>hive.<br>username | **string**<br><p>Login username for the remote file storage or DBMS if authentication on behalf of the Greenplum® user is enabled.</p> <p>The maximum string length in characters is 128.</p> 
datasources[].<br>hive.<br>saslConnectionRetries | **integer** (int64)<br><p>Maximum number of times that PXF retries a SASL connection request after a refused connection returns a ``GSS initiate failed`` error.</p> <p>The default value is ``5``.</p> <p>Acceptable values are 1 to 50, inclusive.</p> 
datasources[].<br>hive.<br>zkHosts[] | **string**<br><p>ZooKeeper server hosts.</p> <p>Specify values in the ``<address>:<port>`` format.</p> <p>The maximum number of elements is 200. The string length in characters for each value must be 1-200.</p> 
datasources[].<br>hive.<br>ppd | **boolean** (boolean)<br><p>Specifies if predicate pushdown is enabled for queries on external tables.</p> <p>The predicate pushdown is enabled by default.</p> 
datasources[].<br>hive.<br>metastoreUris[] | **string**<br><p>List of URIs separated by commas. To request metadata, the remote DBMS connects to Metastore by one of these URIs.</p> <p>The maximum number of elements is 200. The string length in characters for each value must be 1-200.</p> 
datasources[].<br>hive.<br>metastoreKerberosPrincipal | **string**<br><p>Service principal for the Metastore Thrift server.</p> <p>The maximum string length in characters is 1000.</p> 
datasources[].<br>hive.<br>authKerberosPrincipal | **string**<br><p>Kerberos server principal.</p> <p>The maximum string length in characters is 1000.</p> 