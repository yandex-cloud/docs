# DBMS settings

In {{ mgp-name }}, you can configure DBMS-related settings. Some settings are configured [at the cluster level](#dbms-cluster-settings), while others, at the level of external data sources, such as [S3](#s3-settings), [JDBC](#jdbc-settings), [HDFS](#hdfs-settings), [Hive](#hive-settings).

The label next to the setting name helps determine which interface is used to set the value of this setting: the management console, CLI, API, SQL, or Terraform. The {{ tag-all }} label means you can use any of the above interfaces.

The name for a setting depends on the interface you use. For example, **max_connections** in the management console is the same as:

* `max_connections` in the gRPC API
* `maxConnections` in the REST API

## Settings dependent on storage size {#settings-instance-dependent}

Some DBMS setting values may be automatically changed as you edit storage size:

* If no values are set or the values are not compatible with the new size, the defaults for this size will apply.
* If the settings you specify manually are compatible with the new size, they will not be changed.

Settings dependent on storage size:

* [gp_workfile_limit_per_segment](#setting-gp-workfile-limit-per-segment)
* [max_slot_wal_keep_size](#setting-max-slot-wal-keep-size)

## Cluster-level DBMS settings {#dbms-cluster-settings}

This section contains information about the DBMS configuration settings that can be edited by the user as well as those default settings the user cannot edit.

Some {{ mgp-name }} settings here differ from those given in the [official guides](https://cloudberry.apache.org/docs/config-params-guc-list/), in particular:

- Possible (boundary) values.
- Default values.
- Build-specific settings for [open-gpdb](https://github.com/open-gpdb/gpdb).

{% include [mgp-dbms-settings](../../_includes/mdb/mgp/dbms-settings.md) %}

## External S3 data source settings {#s3-settings}

The following settings are available:

* **Access Key**{#setting-access-key} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    S3 storage public access key.

* **Secret Key**{#setting-secret-key} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    S3 storage secret access key.

* **Fast Upload**{#setting-fast-upload} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    This setting controls fast uploading of large files to S3 storage. If disabled, PXF generates files on the disk before sending them to S3 storage. If enabled, PXF generates files in RAM (if RAM capacity is reached, it writes them to disk).

    Fast upload is enabled by default.

* **Endpoint**{#setting-endpoint} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    S3 storage address. The value for {{ objstorage-full-name }} is `{{ s3-storage-host }}`. This is the default value.

## External JDBC data source settings {#jdbc-settings}

The following settings are available:

* **Driver**{#setting-driver} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    JDBC driver class in Java. The possible values are:

    {% include [JBDC driver](../../_includes/mdb/mgp/jdbc-driver.md) %}

* **Url**{#setting-url} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Database URL. Here are some examples:

    {% include [URL examples](../../_includes/mdb/mgp/url-examples.md) %}

* **User**{#setting-user} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    DB owner username.

* **Password**{#setting-password} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    DB user password.

* **Statement Batch Size**{#setting-statement-batch-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Number of rows in a batch for reading from an external table.

    The default value is `100`.

* **Statement Fetch Size**{#setting-statement-fetch-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Number of rows to buffer when reading from an external table.

    The default value is `1000`.

* **Statement Query Timeout**{#setting-statement-query-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Time (in seconds) the JDBC driver waits for a read or write operation to complete.

    The default value is `60`.

* **Pool Enabled**{#setting-pool-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    This setting determines whether the JDBC connection pool is used. It is enabled by default.

* **Pool Maximum Size**{#setting-pool-maximum-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Maximum number of database server connections.

    The default value is `5`.

* **Pool Connection Timeout**{#setting-pool-connection-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Maximum time (in milliseconds) to wait for a connection from the pool.

    The default value is `30000`.

* **Pool Idle Timeout**{#setting-pool-idle-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Maximum time (in milliseconds) before an inactive connection is considered idle.

    The default value is `30000`.

* **Pool Minimum Idle**{#setting-pool-minimum-idle} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Minimum number of idle connections in the pool.

    The default value is `0`.

## External HDFS data source settings {#hdfs-settings}

The following settings are available:

{% include [HDFS and Hive settings](../../_includes/mdb/mgp/external-sources-additional-settings.md) %}

* **Dfs**{#setting-dfs} {{ tag-con }} {{ tag-api }}

    Distributed file system settings.

    For more information, see the [Apache Hadoop documentation](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-hdfs/hdfs-default.xml).

    * **Ha Automatic Failover Enabled**{#setting-ha-automatic-failover-enabled}

        This setting determines whether automatic fault tolerance for high availability of the file system is enabled. It is enabled by default.

    * **Block Access Token Enabled**{#setting-block-access-token-enabled}

        This setting determines whether access tokens are used. By default, tokens are verified when connecting to datanodes.

    * **Use Datanode Hostname**{#setting-use-datanode-hostname}

        This setting determines whether datanode names are used when connecting to the relevant nodes. These are used by default.

    * **Nameservices**

        List of logical names of HDFS services. You can specify any names separating them by commas.

* **Yarn**{#setting-yarn} {{ tag-con }} {{ tag-api }}

    Settings for the ResourceManager service, which tracks resources within a cluster and schedules running apps, such as MapReduce jobs.

    For more information, see the [Apache Hadoop documentation](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/ResourceManagerHA.html).

    * **Resourcemanager Ha Enabled**{#setting-resourcemanager-ha-enabled}

        This setting determines whether high availability for ResourceManager is enabled. It is enabled by default.

    * **Resourcemanager Ha Auto Failover Enabled**{#setting-resourcemanager-ha-auto-failover-enabled}

        This setting determines whether automatic failover to a different resource is enabled if the active service fails or becomes unresponsive. Automatic failover is enabled by default only if **Resourcemanager Ha Enabled** is enabled.

    * **Resourcemanager Ha Auto Failover Embedded**{#setting-resourcemanager-ha-auto-failover-embedded}

        This setting determines whether to use the embedded ActiveStandbyElector method for selecting the active service. If the current active service fails or becomes unresponsive, ActiveStandbyElector designates another ResourceManager service as active, assuming the managing role.

        It is enabled by default only if the **Resourcemanager Ha Enabled** and **Resourcemanager Ha Auto Failover Enabled** settings are enabled.

    * **Resourcemanager Cluster Id**{#setting-resourcemanager-cluster-id}

        Cluster ID. It is used to prevent the ResourceManager service from becoming active for another cluster.

## External Hive data source settings {#hive-settings}

The following settings are available:

{% include [HDFS and Hive settings](../../_includes/mdb/mgp/external-sources-additional-settings.md) %}

* **Ppd**{#setting-ppd} {{ tag-con }} {{ tag-api }}

    This setting determines whether predicate pushdown is enabled for external table queries. This parameter is enabled by default.

* **Metastore Uris**{#setting-metastore-uris} {{ tag-con }} {{ tag-api }}

    List of comma-separated URIs. To request metadata, the external DBMS connects to Metastore using one of these URIs.

* **Metastore Kerberos Principal**{#setting-metastore-kerberos-principal} {{ tag-con }} {{ tag-api }}

    Service principal for the Metastore Thrift server.

* **Auth Kerberos Principal**{#setting-auth-kerberos-principal} {{ tag-con }} {{ tag-api }}

    Kerberos server principal.
