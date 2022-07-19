# Changing cluster settings

{% if product == "cloud-il" %}

{% include [one-az-disclaimer](../../_includes/overview/one-az-disclaimer.md) %}

{% endif %}

After creating a cluster, you can:

* [Change the host class](#change-resource-preset).

* [{#T}](#change-disk-size){% if audience != "internal" %}  (unavailable for non-replicated SSD [storage](../concepts/storage.md)){% endif %}.

* [Configure {{ PG }} servers](#change-postgresql-config) according to the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config.html).

* [Changing additional cluster settings](#change-additional-settings).

* [Manually switch the master in the cluster](#start-manual-failover).

* [Move a cluster](#move-cluster) to another folder.

* [Change cluster security groups](#change-sg-set).

{% note info %}

For information about how to update the {{ PG }} cluster version, see [{#T}](cluster-version-update.md).

{% endnote %}

## Changing the host class {#change-resource-preset}

{% note info %}

Some {{ PG }} settings [depend on the selected host class](../concepts/settings-list.md#settings-instance-dependent).

{% endnote %}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel. 
   1. Under **Host class**, select the class for the {{ PG }} hosts.
   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the [host class](../concepts/instance-types.md) for the cluster:

   1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-pg }} cluster update --help
      ```

   1. Request a list of available host classes (the `ZONES` column specifies the availability zones where you can select the appropriate class):

      {% if audience != "internal" %}

      ```bash
      {{ yc-mdb-pg }} resource-preset list
      ```

      ```text
      +-----------+--------------------------------+-------+----------+
      |    ID     |            ZONE IDS            | CORES |  MEMORY  |
      +-----------+--------------------------------+-------+----------+
      | s1.micro  | {{ region-id }}-a, {{ region-id }}-b,  |     2 | 8.0 GB   |
      |           | {{ region-id }}-c                  |       |          |
      | ...                                                           |
      +-----------+--------------------------------+-------+----------+
      ```

      {% else %}

      ```text
      +------------+---------------+-------+----------+
      |     ID     |   ZONE IDS    | CORES |  MEMORY  |
      +------------+---------------+-------+----------+
      | db1.nano   | man, sas, vla |     1 | 2.0 GB   |
      | db1.micro  | man, sas, vla |     1 | 8.0 GB   |
      | db1.small  | man, sas, vla |     2 | 16.0 GB  |
      | db1.medium | man, sas, vla |     4 | 32.0 GB  |
      | db1.large  | man, sas, vla |     8 | 64.0 GB  |
      | db1.xlarge | man, sas, vla |    16 | 128.0 GB |
      +------------+---------------+-------+----------+
      ```

      {% endif %}

   1. Specify the class in the update cluster command:

      ```bash
      {{ yc-mdb-pg }} cluster update <cluster ID or name> \
          --resource-preset <host class ID>
      ```

      {{ mpg-short-name }} will run the update host class command for the cluster.

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

   1. In the {{ mpg-name }} cluster description, change the `resource_preset_id` attribute value under `config.resources`:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
        ...
        config {
          resources {
            resource_preset_id = "<host class>"
            ...
          }
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

   Use the API [update](../api-ref/Cluster/update.md) method and pass the requisite value in the `configSpec.resources.resourcePresetId` parameter.

   To request a list of supported values, use the [list](../api-ref/ResourcePreset/list.md) method for `ResourcePreset` resources.

{% endlist %}

## {% if audience != "internal" %}Increasing{% else %}Modifying{% endif %} storage size {#change-disk-size}

{% note info %}

Some {{ PG }} settings [depend on the storage size](../concepts/settings-list.md#settings-instance-dependent).

{% endnote %}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs %}

- Management console

   To {% if audience != "internal" %}increase{% else %}modify{% endif %} a cluster's storage size:

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel. 
   1. Under **Storage size**, specify the required value.
   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To {% if audience != "internal" %}increase{% else %}modify{% endif %} a cluster's storage size:

   1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-pg }} cluster update --help
      ```

   1. Specify the required amount of storage in the {% if audience != "internal" %} cluster update command (it must be at least as large as `disk_size` in the cluster properties){% endif %}:

      ```bash
      {{ yc-mdb-pg }} cluster update <cluster ID or name> \
           --disk-size <storage size in GB>
      ```

- {{ TF }}

   To {% if audience != "internal" %}increase{% else %}modify{% endif %} a cluster's storage size:

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

   1. In the {{ mpg-name }} cluster description, change the `disk_size` attribute value under `config.resources`:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
        ...
        config {
          resources {
            disk_size = <storage size in GB>
            ...
          }
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

   To {% if audience != "internal" %}increase{% else %}modify{% endif %} a cluster's storage size, use the API [update](../api-ref/Cluster/update.md) method and pass in in the call:

   * The cluster ID in the `clusterId` parameter.
   * New storage size in the `configSpec.postgresqlConfig_<version {{ PG }}>.resources.diskSize` parameter.
   * List of cluster configuration fields to be changed in the `updateMask` parameter.

      {% include [note-api-updatemask](../../_includes/mdb/note-api-updatemask.md) %}

{% endlist %}

## Changing {{ PG }} settings {#change-postgresql-config}

You can change the DBMS settings of the hosts in your cluster.

{% note warning %}

* You can't change {{ PG }} settings using SQL commands.
* Some {{ PG }} settings [depend on the selected host class or storage size](../concepts/settings-list.md#settings-instance-dependent).

{% endnote %}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel. 
   1. Change the [{{ PG }} settings](../concepts/settings-list.md) by clicking **Configure** under **DBMS settings**.
   1. Click **Save**.
   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change [{{ PG }} server](../concepts/settings-list.md) settings:

   1. View the full list of settings specified for the cluster:

      ```bash
      {{ yc-mdb-pg }} cluster get <cluster ID or name> --full
      ```

   1. View a description of the CLI's update cluster configuration command:

      ```bash
      {{ yc-mdb-pg }} cluster update-config --help
      ```

   1. Set the required parameter values:

      All supported parameters are listed in the [request format for the update method](../api-ref/Cluster/update.md), in the `postgresqlConfig_<version {{ PG }}>` field. To specify a parameter name in the CLI call, convert the name from <q>lowerCamelCase</q> to <q>snake_case</q>. For example, the `maxPreparedTransactions` parameter from an API call should be converted to `max_prepared_transactions` for the CLI command:

      ```bash
      {{ yc-mdb-pg }} cluster update-config <cluster ID or name> \
         --set <parameter1 name>=<value1>,<parameter2 name>=<value2>,...
      ```

      {{ mpg-short-name }} runs the update cluster settings operation.

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

   1. In the {{ mpg-short-name }} cluster description, change the values of the parameters under `config.postgresql_config`. If there is no such block, create one:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
        ...
        config {
          ...
          postgresql_config = {
            max_connections                   = <max. number of connections>
            enable_parallel_hash              = <true or false>
            vacuum_cleanup_index_scale_factor = <number 0 to 1>
            ...
          }
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

   Use the API [update](../api-ref/Cluster/update.md) method and pass the requisite values in the `configSpec.postgresqlConfig_<version>.config` parameter.

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel. 
   1. Change additional cluster settings:

      {% include [mpg-extra-settings](../../_includes/mdb/mpg-extra-settings-web-console.md) %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change additional cluster settings:

   1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-pg }} cluster update --help
      ```

   1. Run the command with a list of settings to update:

      ```bash
      {{ yc-mdb-pg }} cluster update <cluster ID or name> \
          --backup-window-start <backup start time> \
          --datalens-access=<true or false> \
          --maintenance-window type=<maintenance type: anytime or weekly>,`
                              `day=<day of week for weekly>,`
                              `hour=<hour for weekly> \
          --websql-access=<true or false> \
          --deletion-protection=<cluster deletion protection: true or false> \
          --connection-pooling-mode=<connection manager mode> \
          --serverless-access=<true or false>
      ```

   You can change the following settings:

   {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

   {% if product == "yandex-cloud" %}*`--datalens-access`: Enables DataLens access. Default value: `false`. For more information about setting up a connection, see [{#T}](datalens-connect.md).{% endif %}

   * {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window.md) %}

   * `--websql-access`: Enables [SQL queries to be run](web-sql-query.md) from the management console. Default value: `false`.
      {% if product == "yandex-cloud" %}
      {% if audience != "internal" %}

   * `--serverless-access`: Enables cluster access from [{{ sf-full-name }}](../../functions/concepts/index.md). Default value: `false`. For more detail on setting up access, see the [{{ sf-name }}](../../functions/operations/database-connection.md).

   {% else %}

   * `--serverless-access`: Enables cluster access from {{ sf-full-name }}. Default value: `false`.

   {% endif %}
   {% endif %}

   * `--connection-pooling-mode`: Specifies the [connection pooler mode](../concepts/pooling.md): `SESSION`, `TRANSACTION`, or `STATEMENT`.

   * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

      {% include [deletion-protection](../../_includes/mdb/deletion-protection-limits-db.md) %}

   You can [retrieve the cluster name with a list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

   1. To change the backup start time, add a block named `config.backup_window_start` to the {{ mpg-name }} cluster description.

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
        ...
        config {
          backup_window_start {
            hours   = <backup start hour>
            minutes = <backup start minute>
          }
          ...
        }
      }
      ```

   1. To allow access from {{ datalens-full-name }} and [execution of SQL queries from the management console](web-sql-query.md), change the values of the appropriate fields in the `config.access` block:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
        ...
        config {
          access {
            data_lens = <access from DataLens: true or false>
            web_sql   = <execution of SQL queries from management console: true or false>
            ...
        }
        ...
      }
      ```

   1. To change the [connection pooler mode](../concepts/pooling.md), add the `config.pooler_config` section to the {{ mpg-name }} cluster description:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
        ...
        config {
          pooler_config {
            pool_discard = <Odyssey pool_discard parameter: true or false>
            pooling_mode = "<operation mode: SESSION, TRANSACTION, or STATEMENT>"
          }
          ...
        }
      }
      ```

   1. {% include [maintenance-window](../../_includes/mdb/mkf/terraform/maintenance-window.md) %}

   1. To enable cluster protection against accidental deletion by a user of your cloud, add the `deletion_protection` field set to `true` to your cluster description:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
        ...
        deletion_protection = <protect cluster from deletion: true or false>
      }
      ```

      {% include [deletion-protection](../../_includes/mdb/deletion-protection-limits-db.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter.
   * Settings for access from other services and access to SQL queries from the management console in the `configSpec.access` parameter.
   * Backup window settings in the `configSpec.backupWindowStart` parameter.
   * [Connection pooler mode](../concepts/pooling.md) in the `configSpec.poolerConfig.poolingMode` parameter.
   * {% include [maintenance-window](../../_includes/mdb/api/maintenance-window.md) %}
   * Cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [deletion-protection](../../_includes/mdb/deletion-protection-limits-db.md) %}

   * List of cluster configuration fields to be changed in the `updateMask` parameter.

   You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

   {% note warning %}

   This API method resets any cluster settings that aren't passed explicitly in the request to their defaults. To avoid this, be sure to pass the names of the fields to be changed in the `updateMask` parameter.

   {% endnote %}

   {% if product == "yandex-cloud" %}
   {% if audience != "internal" %}

   To allow cluster access from [{{ sf-full-name }}](../../functions/concepts/index.md), pass `true` for the `configSpec.access.serverless` parameter. For more detail on setting up access, see the [{{ sf-name }}](../../functions/operations/database-connection.md).

   {% else %}

   To allow cluster access from {{ sf-full-name }}, pass `true` for the `configSpec.access.serverless` parameter.

   {% endif %}
   {% endif %}

   {% include [datatransfer access](../../_includes/mdb/api/datatransfer-access-create.md) %}

{% endlist %}

## Switching the master {#start-manual-failover}

In a failover {{ PG }} cluster with multiple hosts, you can switch the master role from the current master host to the cluster's replica host. After this operation, the current master host becomes the replica host of the new master.

Specifics of switching master hosts in {{ mpg-name }}

1. You can't switch the master host to a replica that the source of the replication thread is explicitly given for.
1. If you don't specify the replica host name explicitly, the master host will switch to one of the quorum replicas.

For more information, see [{#T}](../concepts/replication.md).

To switch the master:

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click on the name of the cluster you want and select the **Hosts** tab.
   1. Click **Switch master**.
   1. To switch the master to one of the quorum replicas, leave the **Choose master host automatically** option enabled.
   1. To switch the master to a specific replica, disable the **Choose master host automatically** option and then select the desired replica from the drop-down list.
   1. Click **Switch**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Run the command:

   ```bash
   {{ yc-mdb-pg }} cluster start-failover <cluster ID or name> \
       --host <replica host name>
   ```

   You can request the replica host name with a [list of cluster hosts](hosts.md#list) and the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

   1. In the `host_master_name` parameter, specify the name of the replica host to switch to.

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
          ...
          host_master_name = "<replica host name: the name attribute of the appropriate host block>"
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

   Use the API [startFailover](../api-ref/Cluster/startFailover.md) method and pass the following in the request:
   1. In the `clusterId` parameter, the ID of the cluster where you want to switch the master. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   1. In the `hostName` parameter, the name of the replica host to switch to. To find out the name, [request a list of hosts in the cluster](hosts.md#list).

{% endlist %}

## Moving a cluster {#move-cluster}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon to the right of the cluster you want to move.
   1. Click **Move**.
   1. Select the folder you want to move the cluster to.
   1. Click **Move**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To move a cluster:

   1. View a description of the CLI move cluster command:

      ```bash
      {{ yc-mdb-pg }} cluster move --help
      ```

   1. Specify the destination folder in the move cluster command:

      ```bash
      {{ yc-mdb-pg }} cluster move <cluster ID> \
         --destination-folder-name=<destination folder name>
      ```

      You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   Use the [move](../api-ref/Cluster/move.md) API method and pass the following in the query:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * The ID of the destination folder in the `destinationFolderId` parameter.

{% endlist %}

## Changing security groups {#change-sg-set}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel. 
   1. Under **Network settings**, select security groups for cluster network traffic.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To edit the list of [security groups](../concepts/network.md#security-groups) for your cluster:

   1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-pg }} cluster update --help
      ```

   1. Specify the security groups in the update cluster command:

      ```bash
      {{ yc-mdb-pg }} cluster update <cluster ID or name> \
          --security-group-ids <security group list>
      ```

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

   1. Change the value of the `security_group_ids` parameter in the cluster description:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
        ...
        security_group_ids = [ <list of cluster security groups> ]
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
   * The list of groups in the `securityGroupIds` parameter.
   * The list of settings to update in the `updateMask` parameter. If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}
