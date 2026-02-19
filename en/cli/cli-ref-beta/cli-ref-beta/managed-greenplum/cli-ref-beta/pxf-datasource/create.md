---
editable: false
noIndex: true
---

# yc beta managed-greenplum pxf-datasource create

Creates PXF datasource

#### Command Usage

Syntax:

`yc beta managed-greenplum pxf-datasource create <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--cluster-id` | `string`

 ||
|| `--datasource` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  name = string,
  settings = hdfs={
    core = {
      default-fs = string,
      security-auth-to-local = string
    },
    dfs = {
      block-access-token-enabled = boolean,
      ha-automatic-failover-enabled = boolean,
      namenodes = {key={
        http-address = string,
        https-address = string,
        rpc-address = string,
        service-rpc-address = string
      }, key=...},
      nameservices = string,
      use-datanode-hostname = boolean
    },
    kerberos = {
      admin-server = string,
      default-domain = string,
      enable = boolean,
      kdc-servers = string,...,
      keytab-base64 = string,
      primary = string,
      realm = string
    },
    sasl-connection-retries = integer,
    user-impersonation = boolean,
    username = string,
    yarn = {
      ha-rm = {key={
        resourcemanager-address = string,
        resourcemanager-admin-address = string,
        resourcemanager-resource-tracker-address = string,
        resourcemanager-scheduler-address = string,
        resourcemanager-webapp-address = string,
        resourcemanager-webapp-https-address = string
      }, key=...},
      resourcemanager-cluster-id = string,
      resourcemanager-ha-auto-failover-embedded = boolean,
      resourcemanager-ha-auto-failover-enabled = boolean,
      resourcemanager-ha-enabled = boolean
    },
    zk-hosts = string,...
  } | hive={
    auth-kerberos-principal = string,
    core = {
      default-fs = string,
      security-auth-to-local = string
    },
    kerberos = {
      admin-server = string,
      default-domain = string,
      enable = boolean,
      kdc-servers = string,...,
      keytab-base64 = string,
      primary = string,
      realm = string
    },
    metastore-kerberos-principal = string,
    metastore-uris = string,...,
    ppd = boolean,
    sasl-connection-retries = integer,
    user-impersonation = boolean,
    username = string,
    zk-hosts = string,...
  } | jdbc={
    driver = string,
    password = string,
    pool-connection-timeout = integer,
    pool-enabled = boolean,
    pool-idle-timeout = integer,
    pool-maximum-size = integer,
    pool-minimum-idle = integer,
    statement-batch-size = integer,
    statement-fetch-size = integer,
    statement-query-timeout = integer,
    url = string,
    user = string
  } | s3={
    access-key = string,
    endpoint = string,
    fast-upload = boolean,
    secret-key = string
  }
}
```

JSON Syntax:

```json
{
  "name": "string",
  "settings": {
    "hdfs": {
      "core": {
        "default-fs": "string",
        "security-auth-to-local": "string"
      },
      "dfs": {
        "block-access-token-enabled": "boolean",
        "ha-automatic-failover-enabled": "boolean",
        "namenodes": {
          "<key>": {
            "http-address": "string",
            "https-address": "string",
            "rpc-address": "string",
            "service-rpc-address": "string"
          }, ...
        },
        "nameservices": "string",
        "use-datanode-hostname": "boolean"
      },
      "kerberos": {
        "admin-server": "string",
        "default-domain": "string",
        "enable": "boolean",
        "kdc-servers": [
          "string", ...
        ],
        "keytab-base64": "string",
        "primary": "string",
        "realm": "string"
      },
      "sasl-connection-retries": "integer",
      "user-impersonation": "boolean",
      "username": "string",
      "yarn": {
        "ha-rm": {
          "<key>": {
            "resourcemanager-address": "string",
            "resourcemanager-admin-address": "string",
            "resourcemanager-resource-tracker-address": "string",
            "resourcemanager-scheduler-address": "string",
            "resourcemanager-webapp-address": "string",
            "resourcemanager-webapp-https-address": "string"
          }, ...
        },
        "resourcemanager-cluster-id": "string",
        "resourcemanager-ha-auto-failover-embedded": "boolean",
        "resourcemanager-ha-auto-failover-enabled": "boolean",
        "resourcemanager-ha-enabled": "boolean"
      },
      "zk-hosts": [
        "string", ...
      ]
    },
    "hive": {
      "auth-kerberos-principal": "string",
      "core": {
        "default-fs": "string",
        "security-auth-to-local": "string"
      },
      "kerberos": {
        "admin-server": "string",
        "default-domain": "string",
        "enable": "boolean",
        "kdc-servers": [
          "string", ...
        ],
        "keytab-base64": "string",
        "primary": "string",
        "realm": "string"
      },
      "metastore-kerberos-principal": "string",
      "metastore-uris": [
        "string", ...
      ],
      "ppd": "boolean",
      "sasl-connection-retries": "integer",
      "user-impersonation": "boolean",
      "username": "string",
      "zk-hosts": [
        "string", ...
      ]
    },
    "jdbc": {
      "driver": "string",
      "password": "string",
      "pool-connection-timeout": "integer",
      "pool-enabled": "boolean",
      "pool-idle-timeout": "integer",
      "pool-maximum-size": "integer",
      "pool-minimum-idle": "integer",
      "statement-batch-size": "integer",
      "statement-fetch-size": "integer",
      "statement-query-timeout": "integer",
      "url": "string",
      "user": "string"
    },
    "s3": {
      "access-key": "string",
      "endpoint": "string",
      "fast-upload": "boolean",
      "secret-key": "string"
    }
  }
}
```

Fields:

```
name -> (string)
  Data source name.
settings -> (oneof<hdfs|hive|jdbc|s3>)
  Oneof settings field
  s3 -> (struct)
    Settings of an external S3 data source.
    access-key -> (string)
      Public key to access S3 storage.
    endpoint -> (string)
      S3 storage address. The default value is 'storage.yandexcloud.net' used for Yandex Object Storage.
    fast-upload -> (boolean)
      Manages a fast upload of big files to S3 storage. In case of the 'false' value, the PXF generates files on disk before sending them to the S3 storage. In case of the 'true' value, the PXF generates files in RAM (the PXF writes to disc only if there is not enough RAM). The fast upload is enabled by default.
    secret-key -> (string)
      Secret key to access S3 storage.
  jdbc -> (struct)
    Settings of an external JDBC data source.
    driver -> (string)
      JDBC driver class in Java. The possible values are the following: * 'com.simba.athena.jdbc.Driver' * 'com.clickhouse.jdbc.ClickHouseDriver' * 'com.ibm.as400.access.AS400JDBCDriver' * 'com.microsoft.sqlserver.jdbc.SQLServerDriver' * 'com.mysql.cj.jdbc.Driver' * 'org.postgresql.Driver' * 'oracle.jdbc.driver.OracleDriver' * 'net.snowflake.client.jdbc.SnowflakeDriver' * 'io.trino.jdbc.TrinoDriver'
    password -> (string)
      Password of the DB owner.
    pool-connection-timeout -> (integer)
      Maximum time, in milliseconds, to wait for a connection from the pool. The default value is '30000'.
    pool-enabled -> (boolean)
      Determines whether JDBC connection pooling is used in a server configuration. By default, it is used.
    pool-idle-timeout -> (integer)
      Maximum amount of time, in milliseconds, after which an inactive connection is considered idle. The default value is '30000'.
    pool-maximum-size -> (integer)
      Maximum number of connections to the DB backend. The default value is '5'.
    pool-minimum-idle -> (integer)
      Minimum number of idle connections maintained in the connection pool. The default value is '0'.
    statement-batch-size -> (integer)
      Number of rows to read in an external table, in a batch. The default value is '100'.
    statement-fetch-size -> (integer)
      Number of rows to fetch (buffer) when reading from an external table. The default value is '1000'.
    statement-query-timeout -> (integer)
      Amount of time (in seconds) the JDBC driver waits for a statement to run. This timeout applies to statements created for both read and write operations. The default value is '60'.
    url -> (string)
      URL that the JDBC driver uses to connect to the database. Examples: * 'jdbc:mysql://mysqlhost:3306/testdb': Local MySQL DB. * 'jdbc:postgresql://c-<cluster_id>.rw.mdb.yandexcloud.net:6432/db1': Managed Service for PostgreSQL cluster. The address contains the special FQDN of the cluster's master. * 'jdbc:oracle:thin:@host.example:1521:orcl': Oracle DB.
    user -> (string)
      Username of the DB owner.
  hdfs -> (struct)
    Settings of an external HDFS data source.
    core -> (struct)
      Settings of the file system and security rules.
      default-fs -> (string)
        URI whose scheme and authority determine the file system implementation.
      security-auth-to-local -> (string)
        Rules for mapping Kerberos principals to operating system user accounts.
    dfs -> (struct)
      Settings of the distributed file system.
      block-access-token-enabled -> (boolean)
        If 'true', access tokens are used as capabilities for accessing datanodes. If 'false', no access tokens are checked on accessing datanodes. The check of access tokens is enabled by default.
      ha-automatic-failover-enabled -> (boolean)
        Determines whether automatic failover is enabled for the high availability of the file system. The automatic failover is enabled by default.
      namenodes -> (map[string,struct])
        List of HDFS service logical names. Specify them separated by commas. The names can be arbitrary.
        http-address -> (string)
        https-address -> (string)
        rpc-address -> (string)
        service-rpc-address -> (string)
      nameservices -> (string)
        Corresponds well-known HDFS client setting "dfs.nameservices" for this datasource
      use-datanode-hostname -> (boolean)
        Determines whether the datanode hostname is used when connecting to datanodes.
    kerberos -> (struct)
      Settings of the Kerberos network authentication protocol.
      admin-server -> (string)
        Administration server host. Usually, this is the primary Kerberos server.
      default-domain -> (string)
        Domain that is used for the host name extension. Applicable when Kerberos 4 service members become Kerberos 5 service members (for example, when rcmd.hostname is replaced with host/hostname.domain).
      enable -> (boolean)
        Determines whether the Kerberos authentication server is used. By default, it is not used.
      kdc-servers -> ([]string)
        KDC server hosts.
      keytab-base64 -> (string)
        Base64 encoded contents of the keytab file.
      primary -> (string)
        Host of the primary KDC server (Key Distribution Center).
      realm -> (string)
        Kerberos realm for a Greenplum® DB.
    sasl-connection-retries -> (integer)
      Maximum number of times that PXF retries a SASL connection request after a refused connection returns a 'GSS initiate failed' error. The default value is '5'.
    user-impersonation -> (boolean)
      Enables authentication on behalf of the Greenplum® user when connecting to the remote file storage or DBMS. The authentication is disabled by default.
    username -> (string)
      Login username for the remote file storage or DBMS if authentication on behalf of the Greenplum® user is enabled.
    yarn -> (struct)
      Settings of the ResourceManager service that is responsible for tracking resources in a cluster and scheduling applications (e.g., MapReduce jobs).
      ha-rm -> (map[string,struct])
        Highly available ResourceManager service.
        resourcemanager-address -> (string)
        resourcemanager-admin-address -> (string)
        resourcemanager-resource-tracker-address -> (string)
        resourcemanager-scheduler-address -> (string)
        resourcemanager-webapp-address -> (string)
        resourcemanager-webapp-https-address -> (string)
      resourcemanager-cluster-id -> (string)
        Cluster ID. Specify it, so the ResourceManager service does not become active for a different cluster.
      resourcemanager-ha-auto-failover-embedded -> (boolean)
        Determines whether the embedded ActiveStandbyElector method should be used for the election of the active ResourceManager. If the current active ResourceManager has failed and does not respond, the ActiveStandbyElector method makes another ResourceManager active which then takes over.
      resourcemanager-ha-auto-failover-enabled -> (boolean)
        Determines whether another ResourceManager should automatically become active when the active ResourceManager has failed and does not respond. The switch of ResourceManagers is enabled by default if the high availability is enabled.
      resourcemanager-ha-enabled -> (boolean)
        Determines whether high availability is enabled for YARN's ResourceManager services. The high availability is enabled by default.
    zk-hosts -> ([]string)
      ZooKeeper server hosts. Specify values in the '<address>:<port>' format.
  hive -> (struct)
    Settings of an external Hive data source.
    auth-kerberos-principal -> (string)
      Kerberos server principal.
    core -> (struct)
      Settings of the file system and security rules.
      default-fs -> (string)
        URI whose scheme and authority determine the file system implementation.
      security-auth-to-local -> (string)
        Rules for mapping Kerberos principals to operating system user accounts.
    kerberos -> (struct)
      Settings of the Kerberos network authentication protocol.
      admin-server -> (string)
        Administration server host. Usually, this is the primary Kerberos server.
      default-domain -> (string)
        Domain that is used for the host name extension. Applicable when Kerberos 4 service members become Kerberos 5 service members (for example, when rcmd.hostname is replaced with host/hostname.domain).
      enable -> (boolean)
        Determines whether the Kerberos authentication server is used. By default, it is not used.
      kdc-servers -> ([]string)
        KDC server hosts.
      keytab-base64 -> (string)
        Base64 encoded contents of the keytab file.
      primary -> (string)
        Host of the primary KDC server (Key Distribution Center).
      realm -> (string)
        Kerberos realm for a Greenplum® DB.
    metastore-kerberos-principal -> (string)
      Service principal for the Metastore Thrift server.
    metastore-uris -> ([]string)
      List of URIs separated by commas. To request metadata, the remote DBMS connects to Metastore by one of these URIs.
    ppd -> (boolean)
      Specifies if predicate pushdown is enabled for queries on external tables. The predicate pushdown is enabled by default.
    sasl-connection-retries -> (integer)
      Maximum number of times that PXF retries a SASL connection request after a refused connection returns a 'GSS initiate failed' error. The default value is '5'.
    user-impersonation -> (boolean)
      Enables authentication on behalf of the Greenplum® user when connecting to the remote file storage or DBMS. The authentication is disabled by default.
    username -> (string)
      Login username for the remote file storage or DBMS if authentication on behalf of the Greenplum® user is enabled.
    zk-hosts -> ([]string)
      ZooKeeper server hosts. Specify values in the '<address>:<port>' format.
``` ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#