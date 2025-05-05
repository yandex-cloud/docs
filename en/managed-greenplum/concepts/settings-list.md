# {{ GP }} settings

For {{ mgp-name }} clusters, you can configure {{ GP }} settings. Some settings are configured [at the cluster level](#dbms-cluster-settings), while others, at the level of external data sources, such as [S3](#s3-settings), [JDBC](#jdbc-settings), [HDFS](#hdfs-settings), [Hive](#hive-settings).

The label next to the setting name helps determine which interface is used to set the value of this setting: the management console, CLI, API, SQL, or Terraform. The {{ tag-all }} label means that all of the above interfaces are supported.

Depending on the interface you select, the same setting will be represented differently. For example, **Max connections** in the management console is the same as:

* `max_connections` in the gRPC API
* `maxConnections` in the REST API

## Settings depending on the storage size {#settings-instance-dependent}

The values of some {{ GP }} settings may be automatically adjusted when you change the storage size:

* If the values were not specified or are not suitable for the new size, the default settings for this size will apply.
* If the settings you specified manually are suitable for the new size, they will be preserved.

The settings that depend on the storage size are:

* [Gp workfile limit per segment](#setting-gp-workfile-limit-per-segment)
* [Max slot wal keep size](#setting-max-slot-wal-keep-size)

## Cluster-level DBMS settings {#dbms-cluster-settings}

The following settings are available:

{% include [mgp-dbms-settings](../../_includes/mdb/mgp/dbms-settings.md) %}

## External S3 data source settings {#s3-settings}

The following settings are available:

* **Access Key**{#setting-access-key} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    S3 storage public access key.

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/s3_objstore_cfg.html#minio-server-configuration-1).

* **Secret Key**{#setting-secret-key} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    S3 storage secret access key.

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/s3_objstore_cfg.html#minio-server-configuration-1).

* **Fast Upload**{#setting-fast-upload} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    This setting controls fast uploading of large files to S3 storage. If disabled, PXF generates files on the disk before sending them to S3 storage. If enabled, PXF generates files in RAM (if RAM capacity is reached, it writes them to disk).

    Fast upload is enabled by default.

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/s3_objstore_cfg.html#minio-server-configuration-1).

* **Endpoint**{#setting-endpoint} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    S3 storage address. {{ objstorage-full-name }} is set to `{{ s3-storage-host }}`. This is a default value.

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/s3_objstore_cfg.html#minio-server-configuration-1).

## External JDBC data source settings {#jdbc-settings}

The following settings are available:

* **Driver**{#setting-driver} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    JDBC driver class in Java. The possible values are:

    {% include [JBDC driver](../../_includes/mdb/mgp/jdbc-driver.md) %}

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/jdbc_cfg.html#jdbc-server-configuration-2).

* **Url**{#setting-url} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Database URL. Examples:

    {% include [URL examples](../../_includes/mdb/mgp/url-examples.md) %}

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/jdbc_cfg.html#jdbc-server-configuration-2).

* **User**{#setting-user} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    DB owner username.

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/jdbc_cfg.html#jdbc-server-configuration-2).

* **Password**{#setting-password} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    DB user password.

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/jdbc_cfg.html#jdbc-server-configuration-2).

* **Statement Batch Size**{#setting-statement-batch-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Number of rows in a batch for reading from an external table.

    The default value is `100`.

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/jdbc_cfg.html#statementlevel-properties-5).

* **Statement Fetch Size**{#setting-statement-fetch-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Number of rows to buffer when reading from an external table.

    The default value is `1000`.

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/jdbc_cfg.html#statementlevel-properties-5).

* **Statement Query Timeout**{#setting-statement-query-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Time (in seconds) the JDBC driver waits for a read or write operation to complete.

    The default value is `60`.

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/jdbc_cfg.html#statementlevel-properties-5).

* **Pool Enabled**{#setting-pool-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    This setting determines whether the JDBC connection pool is used. It is enabled by default.

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/jdbc_cfg.html#about-jdbc-connection-pooling-9).

* **Pool Maximum Size**{#setting-pool-maximum-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Maximum number of database server connections.

    The default value is `5`.

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/jdbc_cfg.html#about-jdbc-connection-pooling-9).

* **Pool Connection Timeout**{#setting-pool-connection-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Maximum time (in milliseconds) to wait for a connection from the pool.

    The default value is `30000`.

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/jdbc_cfg.html#about-jdbc-connection-pooling-9).

* **Pool Idle Timeout**{#setting-pool-idle-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Maximum time (in milliseconds) before an inactive connection is considered idle.

    The default value is `30000`.

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/jdbc_cfg.html#about-jdbc-connection-pooling-9).

* **Pool Minimum Idle**{#setting-pool-minimum-idle} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Minimum number of idle connections in the pool.

    The default value is `0`.

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/jdbc_cfg.html#about-jdbc-connection-pooling-9).

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

    This setting determines whether predicate pushdown is enabled for external table queries. Enabled by default.

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.vmware }}-Platform-Extension-Framework/6.10/greenplum-platform-extension-framework/cfg_server.html#about-the-pxfsitexml-configuration-file-3).

* **Metastore Uris**{#setting-metastore-uris} {{ tag-con }} {{ tag-api }}

    List of comma-separated URIs. To request metadata, the external DBMS connects to Metastore using one of these URIs.

* **Metastore Kerberos Principal**{#setting-metastore-kerberos-principal} {{ tag-con }} {{ tag-api }}

    Service principal for the Metastore Thrift server.

* **Auth Kerberos Principal**{#setting-auth-kerberos-principal} {{ tag-con }} {{ tag-api }}

    Kerberos server principal.
