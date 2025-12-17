# {{ MY }} version upgrade

You can upgrade a {{ mmy-name }} cluster to any supported minor or major version.

In single-host clusters, only the master host is taken offline for upgrades. Unlike multi-host clusters, these clusters are not available for reads and writes during an upgrade. After the DBMS resumes operation, it will take time to warm up the buffer pool, which may temporarily affect the query performance, particularly for large, heavily indexed databases.

In multi-host clusters, upgrades proceed in this sequence:

1. Replicas are taken offline for an upgrade and stopped, one by one. The replicas are queued randomly. Following the upgrade, the replicas get back online. Read performance may temporarily degrade at this stage, as some replicas will be unavailable.

1. The master becomes read-only. One of the replicas is [promoted to master](../concepts/replication.md#master-failover) and becomes write-enabled. This ensures the cluster is upgraded with minimal downtime.

1. The original master is taken offline, upgraded, and then brought online as a replica. The master does not switch back to avoid the risk of extra failovers.

{% note info %}

In {{ MY }} 8.0, replica failover is more reliable and efficient due to improved metadata processing.

{% endnote %}

For information on minor version upgrades and host maintenance, see [Maintenance](../concepts/maintenance.md).

{% note alert %}

* After the DBMS upgrade, you cannot revert the cluster to the previous version.
* Upgrade your cluster during low load periods to reduce risks and minimize the impact on users.
* Whether a {{ MY }} version upgrade succeeds depends on many factors, such as the following:

   * Cluster settings and specific configurations.
   * Nature and structure of stored data.
   * {{ MY }} features deployed (especially JSON functionality and full-text search).
   * App compatibility with the new version.
   * Correctness of stored procedures and triggers.
   * Current database state and data quality.

   We recommend that you start with [upgrading a test cluster](#before-update) with the same data and configuration.

{% endnote %}

## Before upgrading a version {#before-update}

When getting ready for an upgrade, a comprehensive approach to testing and compatibility analysis is of particular importance. Our experience shows that most upgrade issues can be prevented in advance:

1. Check the {{ MY }} [release notes](https://docs.percona.com/percona-server/8.0/release-notes/release-notes_index.html) to learn how upgrades may affect your applications.

   {% cut "Examples of changes in {{ MY }} 8.0" %}

   * Changes in the behavior of SQL functions and query optimizer:

      ```sql
      -- Example of a command for analyzing a query execution plan
      EXPLAIN ANALYZE
      SELECT * FROM <table_name>
      WHERE complex_condition
      ORDER BY <field>;
      ```

   * Deprecated and removed features, especially related to ​​security:

      ```sql
      -- Checking authentication
      SELECT user, host, plugin 
      FROM mysql.user 
      WHERE user NOT LIKE 'mysql.%';
      ```

   * Changes in full-text search and JSON processing:

      ```sql
      -- Checking the use of JSON functions
      SELECT COUNT(*) 
      FROM information_schema.routines 
      WHERE routine_definition LIKE '%JSON%';
      ```

   * New default values ​​for DBMS settings.
   * Aspects of working with metadata and temporary tables.

   {% endcut %}

1. Try upgrading a test cluster.
   
   1. Deploy a test cluster from a backup of the main cluster using the `PRESTABLE` environment and upgrade it to the required version.
   1. Make sure critical queries and stored procedures work as expected.
   1. Check the features that use JSON and full-text search.
   1. Run a load test:

      ```sql
      -- Monitoring performance during tests
      SELECT EVENT_NAME, COUNT_STAR, AVG_TIMER_WAIT
      FROM performance_schema.events_statements_summary_by_digest
      WHERE SCHEMA_NAME = '<DB_name>'
      ORDER BY AVG_TIMER_WAIT DESC
      LIMIT 10;
      ```

1. [Create a backup](cluster-backups.md) of the main cluster immediately before upgrading.

1. Ensure [high availability](../concepts/high-availability.md) of the cluster:
   
   1. Make sure the main and test clusters have at least one master and one replica. [Add hosts](hosts.md#add) as needed.
   1. Optionally, check the replication status and lag:

     ```sql
     -- Checking the replication status
     SHOW SLAVE STATUS\G

     -- Checking the replication lag
     SELECT
       SUBSTRING_INDEX(HOST, ':', 1) AS slave_host,
       SUBSTRING_INDEX(HOST, ':', -1) AS slave_port,
       SECONDS_BEHIND_MASTER,
       SLAVE_IO_RUNNING,
       SLAVE_SQL_RUNNING
     FROM information_schema.PROCESSLIST
     WHERE COMMAND = 'Binlog Dump';
     ```

## Updating the {{ MY }} version {#start-update}

{% list tabs group=instructions %}

- Management console {#console}

   1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Select your cluster from the list and click ![image](../../_assets/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
   1. In the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field, select the new version number.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

   As soon as you run the upgrade, the cluster status will change to **Updating**. Wait for the operation to complete and then check the cluster version.

   The time required for an upgrade depends on multiple factors, such as the amount of data or the number of databases in your cluster. Usually, an upgrade takes a few minutes; for large databases, it can take 10 minutes or more.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To upgrade a {{ MY }} version:

   1. Get the list of your {{ MY }} clusters using this command:

      ```bash
      {{ yc-mdb-my }} cluster list
      ```

   1. Get the details of the cluster in question and check its {{ MY }} version in the `config.version` setting:

      ```bash
      {{ yc-mdb-my }} cluster get <cluster_name_or_ID>
      ```

   1. Run the {{ MY }} upgrade:

      ```bash
      {{ yc-mdb-my }} cluster update <cluster_name_or_ID> \
         --mysql-version <new_version_number>
      ```

   The time required for an upgrade depends on multiple factors, such as the amount of data or the number of databases in your cluster. Usually, an upgrade takes a few minutes; for large databases, it can take 10 minutes or more.

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file describing your infrastructure.

      For information on how to create such a file, see [Creating a cluster](cluster-create.md).

   1. Add the `version` field to the `yandex_mdb_mysql_cluster` resource or change the field value if it already exists:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
         ...
         version = "<{{ MY }}_version>"
         ...
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see [this {{ TF }} provider article]({{ tf-provider-mmy }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- REST API {#api}

   1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

   1. Call the [Cluster.update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      ```bash
      curl \
         --request PATCH \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --header "Content-Type: application/json" \
         --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>' \
         --data '{
                   "updateMask": "configSpec.version",
                   "configSpec": {
                     "version": "<{{ MY }}_version>"
                   }
                 }'
      ```

      Where:

      * `updateMask`: Comma-separated list of settings you want to update.

         Here, we provide only one setting.

      * `configSpec.version`: New {{ MY }} version.

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

   1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

   1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

   1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
   1. Call the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

      ```bash
      grpcurl \
         -format json \
         -import-path ~/cloudapi/ \
         -import-path ~/cloudapi/third_party/googleapis/ \
         -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
         -rpc-header "Authorization: Bearer $IAM_TOKEN" \
         -d '{
               "cluster_id": "<cluster_ID>",
               "update_mask": {
                 "paths": [
                   "config_spec.version"
                 ]
               },
               "config_spec": {
                 "version": "<{{ MY }}_version>"
               }
             }' \
         {{ api-host-mdb }}:{{ port-https }} \
         yandex.cloud.mdb.mysql.v1.ClusterService.Update
      ```

      Where:

      * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

         Here, we provide only one setting.

      * `config_spec.version`: New {{ MY }} version.

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

   1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

The time required for an upgrade depends on multiple factors, such as the amount of data or the number of databases in your cluster. Usually, an upgrade takes a few minutes; for large databases, it can take 10 minutes or more.

## Examples {#examples}

Let's consider the following example showing how to upgrade a cluster from version 5.7 to 8.0. This use case is particularly interesting as it covers the most significant changes in the {{ MY }} architecture.

{% list tabs group=instructions %}

- CLI {#cli}

   1. Get the list of clusters with their IDs and names:

      ```bash
      {{ yc-mdb-my }} cluster list
      ```

      Result example:

      ```text
      +----------------------+------------+---------------------+--------+---------+
      |          ID          |    NAME    |     CREATED AT      | HEALTH | STATUS  |
      +----------------------+------------+---------------------+--------+---------+
      | c9q8p8j2gaih******** |  mysql406  | 2021-10-23 12:44:17 | ALIVE  | RUNNING |
      +----------------------+------------+---------------------+--------+---------+
      ```

   1. Get detailed information about a specific cluster:

      ```bash
      {{ yc-mdb-my }} cluster get mysql406
      ```

      The output will show the current {{ MY }} version:

      ```text
        id: c9q8p8j2gaih********
        ...
        config:
          version: "5.7"
          ...
      ```

   1. Start the upgrade to 8.0:

      ```bash
      {{ yc-mdb-my }} cluster update mysql406 --mysql-version 8.0
      ```

      As soon as you run this command, the system will start upgrading your cluster. It may take anywhere from a few minutes to an hour depending on the database size and cluster configuration.

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file describing your infrastructure.
   1. Set the `version` field to `8.0` in the `yandex_mdb_mysql_cluster` resource:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
         ...
         version = "8.0"
         ...
      }
      ```

   1. Make sure the settings are correct:

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Apply the changes:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   {{ TF }} will automatically detect the need for version upgrade and start the process.

{% endlist %}

After a successful upgrade:

1. Check the status of all critical components:

   ```sql
   -- Checking the InnoDB status
   SHOW ENGINE INNODB STATUS\G

   -- Checking the replication status
   SHOW SLAVE STATUS\G
   ```

1. Make sure your applications work correctly:

   * Check the execution time of critical queries.
   * Check error statistics.
   * Monitor resource usage.

1. Optimize your configuration for the new version:

   ```sql
   -- Analyzing buffer pool usage
   SELECT POOL_ID, POOL_SIZE, FREE_BUFFERS, DATABASE_PAGES
   FROM information_schema.INNODB_BUFFER_POOL_STATS;
   
   -- Checking performance settings
   SHOW VARIABLES LIKE '%buffer%';
   ```

## See also {#see-also}

* [Technical overview of {{ MY }} 8.0 features](../concepts/mysql-57-80-comparison.md) with focus on the new version's changes in terms of performance and functionality.
