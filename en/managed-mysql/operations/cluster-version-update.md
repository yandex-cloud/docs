# {{ MY }} version upgrade

You can upgrade a {{ mmy-name }} cluster to any supported minor or major version.

In single-host clusters, the only master host is brought out of its running state for upgrades. Unlike multi-host clusters, these clusters are not available for reads and writes during an upgrade. After the DBMS resumes operation, it will take time to _warm up_ the buffer pool, which may temporarily affect the request performance: this is especially prominent for large databases with active use of indexes.

In multi-host clusters, upgrades follow the procedure below:

1. The replicas are withdrawn from service one by one for an upgrade. The replicas are queued randomly. Following the upgrade, the replicas get back online. Read performance may temporarily decrease at this stage because some replicas will be unavailable.

1. A master host is closed for writes. A [new master host is selected](../concepts/replication.md#master-failover) from among the replicas and opened for writes. As a result, the cluster is upgraded with minimal downtime.

1. The original master host is shut down, upgraded, and resumes its operation as a replica. The master does not switch back in order to minimize the risks of additional switching.

{% note info %}

In {{ MY }} 8.0, replica switching is more reliable and efficient due to improved metadata processing.

{% endnote %}

To learn more about updates within a single version and host maintenance, see [Maintenance](../concepts/maintenance.md).

{% note alert %}

* Once your DBMS is upgraded, you cannot roll a cluster back to the previous version.
* Update your cluster during low load periods to reduce risks and the impact on users.
* The success of {{ MY }} version upgrade depends on many factors, such as:

   * Cluster settings and specific configurations.
   * Nature and structure of stored data.
   * {{ MY }} features deployed (especially JSON functionality and full-text search).
   * App compatibility with the new version.
   * Correctness of stored procedures and triggers.
   * Current database condition and data quality.

   We recommend that you begin by [upgrading a test cluster](#before-update) that has the same data and settings.

{% endnote %}

## Before a version upgrade {#before-update}

When getting ready for an upgrade, a comprehensive approach to testing and compatibility analysis is of particular importance. Our experience shows that most upgrade issues can be prevented at the preparation stage:

1. See {{ MY }} [changelog](https://docs.percona.com/percona-server/8.0/release-notes/release-notes_index.html) for how upgrades may affect your applications.

   {% cut "Examples of changes in {{ MY }} 8.0" %}

   * Changes in the behavior of SQL functions and query optimizer:

      ```sql
      -- Example of query for execution plan analysis
      EXPLAIN ANALYZE
      SELECT * FROM <table_name>
      WHERE complex_condition
      ORDER BY <field>;
      ```

   * Deprecated and removed features, especially related to ​​security:

      ```sql
      -- Testing authentication mechanisms
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

1. Try a version upgrade on a test cluster.
   
   1. Deploy a test cluster from a backup of the main cluster using the `PRESTABLE` environment and upgrade it to the required version.
   1. Check the operation of critical queries and stored procedures.
   1. Check the functionality that uses JSON and full-text search.
   1. Perform load testing:

      ```sql
      -- Monitoring performance during tests
      SELECT EVENT_NAME, COUNT_STAR, AVG_TIMER_WAIT
      FROM performance_schema.events_statements_summary_by_digest
      WHERE SCHEMA_NAME = '<DB_name>'
      ORDER BY AVG_TIMER_WAIT DESC
      LIMIT 10;
      ```

1. [Create a backup](cluster-backups.md) of the main cluster just before the upgrade.

1. Ensure cluster fault tolerance:
   
   1. Make sure the main and test clusters have at least two replica hosts and one master host. [Add hosts](hosts.md#add) as needed.
   1. Optionally, check replication status and latency:

     ```sql
     -- Checking replication status
     SHOW SLAVE STATUS\G

     -- Checking replication latency
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

   1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Select the cluster you need from the list and click ![image](../../_assets/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
   1. In the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field, select a new version number.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

   As soon as you run the upgrade, the cluster status will change to **Updating**. Wait for the operation to complete and then check the cluster version.

   The upgrade time depends on multiple factors, e.g., the amount of data or the number of databases in the cluster. The upgrade usually takes several minutes, and 10 minutes or more for large databases.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To update the {{ MY }} version:

   1. Get a list of your {{ MY }} clusters using this command:

      ```bash
      {{ yc-mdb-my }} cluster list
      ```

   1. Get information about the cluster you need and check the {{ MY }} version in the `config.version` parameter:

      ```bash
      {{ yc-mdb-my }} cluster get <cluster_name_or_ID>
      ```

   1. Run the {{ MY }} upgrade:

      ```bash
      {{ yc-mdb-my }} cluster update <cluster_name_or_ID> \
         --mysql-version <new_version_number>
      ```

   The upgrade time depends on multiple factors, e.g., the amount of data or the number of databases in the cluster. The upgrade usually takes several minutes, and 10 minutes or more for large databases.

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file that defines your infrastructure.

      For more information about creating this file, see [Creating clusters](cluster-create.md).

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

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- REST API {#api}

   1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

   1. Use the [Cluster.update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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

      * `updateMask`: List of parameters to update as a single string, separated by commas.

         Only one parameter is provided in this case.

      * `configSpec.version`: New {{ MY }} version.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

   1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

   1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

   1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
   1. Use the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

      * `update_mask`: List of parameters to update as an array of `paths[]` strings.

         Only one parameter is provided in this case.

      * `config_spec.version`: New {{ MY }} version.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

   1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

The upgrade time depends on multiple factors, e.g., the amount of data or the number of databases in the cluster. The upgrade usually takes several minutes, and 10 minutes or more for large databases.

## Examples {#examples}

Let's look at a case where a cluster is upgraded from version 5.7 to 8.0. This scenario is particularly interesting because it covers the most significant changes in the {{ MY }} architecture.

{% list tabs group=instructions %}

- CLI {#cli}

   1. Get a list of clusters and find out their IDs and names:

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

      The output will show the current version of {{ MY }}:

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

      Once you execute this command, the upgrade process will start, which will take anywhere from a few minutes to an hour depending on database size and cluster configuration.

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file that defines your infrastructure.
   1. In the `version` field, specify the `8.0` value in the `yandex_mdb_mysql_cluster` resource:

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

   {{ TF }} will automatically detect the need to upgrade the version and start the process.

{% endlist %}

After a successful upgrade:

1. Check the status of all critical components:

   ```sql
   -- Checking InnoDB status
   SHOW ENGINE INNODB STATUS\G

   -- Checking replication status
   SHOW SLAVE STATUS\G
   ```

1. Make sure the applications work correctly:

   * Check the execution time of critical requests.
   * Check error statistics.
   * Track resource usage.

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
