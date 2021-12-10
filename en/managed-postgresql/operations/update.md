# Changing cluster settings

After creating a cluster, you can:

* [Change the host class](#change-resource-preset).

* [Increase the storage size](#change-disk-size) (available only for `network-hdd` standard network storage and `network-ssd` fast network storage).

* [Configure {{ PG }} servers](#change-postgresql-config) according to the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config.html).

* [Change additional cluster settings](#change-additional-settings).

* [Set the operation mode for the connection pooler](#change-pooler-config).

* [Manually switch the master in the cluster](#start-manual-failover).

* [Change cluster security groups](#change-sg-set).

{% note warning %}

You can't change {{ PG }} server settings using SQL commands.

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

      ```
      $ {{ yc-mdb-pg }} cluster update --help
      ```

  1. Request a list of available host classes (the `ZONES` column specifies the availability zones where you can select the appropriate class):

     {% if audience != "internal" %}

     ```
     $ {{ yc-mdb-pg }} resource-preset list
     
     +-----------+--------------------------------+-------+----------+
     |    ID     |            ZONE IDS            | CORES |  MEMORY  |
     +-----------+--------------------------------+-------+----------+
     | s1.micro  | ru-central1-a, ru-central1-b,  |     2 | 8.0 GB   |
     |           | ru-central1-c                  |       |          |
     | ...                                                           |
     +-----------+--------------------------------+-------+----------+
     ```

     {% else %}

     ```
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

      ```
      $ {{ yc-mdb-pg }} cluster update <cluster name>
           --resource-preset <class ID>
      ```

      {{ mpg-short-name }} will run the update host class command for the cluster.

- Terraform

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For information about how to create this file, see [{#T}](cluster-create.md).

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

  For more information, see [provider documentation {{ TF }}]({{ tf-provider-mpg }}).

- API

  Use the API [update](../api-ref/Cluster/update.md) method and pass the requisite value in the `configSpec.resources.resourcePresetId` parameter.

  To request a list of supported values, use the [list](../api-ref/ResourcePreset/list.md) method for the `ResourcePreset` resources.

{% endlist %}

## Increasing storage size {#change-disk-size}

{% note info %}

Some {{ PG }} settings [depend on the storage size](../concepts/settings-list.md#settings-instance-dependent).

{% endnote %}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mpg-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. Under **Storage size**, specify the required value.
  1. Click **Save changes**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To increase the storage size for a cluster:

  {% if audience != "internal" %}

  1. Make sure the required cluster uses standard or fast network storage (it's not possible to increase the size of local or non-replicated network storage). To do this, request information about the cluster and find the `disk_type_id` field: it should be set to `network-hdd` or `network-ssd`:

      ```
      $ {{ yc-mdb-pg }} cluster get <cluster name>
      
      id: c7qkvr3u78qiopj3u4k2
      folder_id: b1g0ftj57rrjk9thribv
      ...
      config:
        ...
        resources:
          resource_preset_id: s1.micro
          disk_size: "10737418240"
          disk_type_id: network-ssd
      ...
      ```

  {% endif %}

  1. View a description of the CLI's update cluster command:

     ```
     $ {{ yc-mdb-pg }} cluster update --help
     ```

  1. Make sure the cloud's quota is sufficient to increase the storage size: open the [Quotas]({{ link-console-quotas }}) page for your cloud and check that the {{ mpg-full-name }} section still has space available in the **space** line.

  1. Specify the required amount of storage in the update cluster command (it must be at least as large as `disk_size` in the cluster properties):

      ```
      $ {{ yc-mdb-pg }} cluster update <cluster name>
           --disk-size <storage size in GB>
      ```

      If all these conditions are met, {{ mpg-short-name }} launches the operation to increase storage space.

- Terraform

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For information about how to create this file, see [{#T}](cluster-create.md).

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

  For more information, see [provider documentation {{ TF }}]({{ tf-provider-mpg }}).

- API

  Use the API [update](../api-ref/Cluster/update.md) method and transmit the requisite values in the `configSpec.postgresqlConfig_<version>.resources.diskSize`.

  Make sure the cloud's quota is sufficient to increase the storage size: open the [Quotas]({{ link-console-quotas }}) page for your cloud and check that the {{ mpg-full-name }} section still has space available in the **space** line.

{% endlist %}

## Changing {{ PG }} settings {#change-postgresql-config}

You can change the DBMS settings of the hosts in your cluster.

{% note info %}

Some {{ PG }} settings [depend on the selected host class or storage size](../concepts/settings-list.md#settings-instance-dependent).

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

  To update the [{{ PG }} server settings](../concepts/settings-list.md):

  1. View the full list of settings specified for the cluster:

     ```
     $ {{ yc-mdb-pg }} cluster get <cluster name> --full
     ```

  1. View a description of the CLI's update cluster configuration command:

      ```
      $ {{ yc-mdb-pg }} cluster update-config --help
      ```

  1. Set the required parameter values:

      ```
      $ {{ yc-mdb-pg }} cluster update-config <cluster name>
           --set <parameter name1>=<value1>,...
      ```

      {{ mpg-short-name }} runs the update cluster settings operation.

      All the supported parameters are listed in the [description of settings for {{ PG }}](../concepts/settings-list.md).

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. In the {{ mpg-short-name }} cluster description,  change the values of the parameters under `config.postgresql_config`. If there is no such block, create one:

        ```hcl
        resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
          ...
          config {
            ...
            postgresql_config = {
              max_connections                   = <maximum number of connections>
              enable_parallel_hash              = <true or false>
              vacuum_cleanup_index_scale_factor = <a number from 0 to 1>
              ...
            }
          }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [provider documentation {{ TF }}]({{ tf-provider-mpg }}).

- API

  Use the API [update](../api-ref/Cluster/update.md) method and transmit the requisite values in the `configSpec.postgresqlConfig_<version>.config`.

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
        {{ yc-mdb-pg }} cluster update <cluster name> \
            --backup-window-start <backup start time> \
            --datalens-access=<true or false> \
            --maintenance-window type=<weekly or anytime> \
            --websql-access=<true or false>
            --deletion-protection=<protect cluster from deletion: true or false>
        ```

    You can change the following settings:

    {% include [backup-window-start](../../_includes/mdb/cli-additional-settings/backup-window-start.md) %}
    * `--datalens-access`: Enables DataLens access. Default value: `false`. For more information about how to connect to DataLens, see [{#T}](datalens-connect.md).

    {% include [maintenance-window](../../_includes/mdb/cli-additional-settings/maintenance-window.md) %}
    * `--websql-access`: Enables [SQL queries](web-sql-query.md) to be run from the management console. Default value: `false`.

    {% include [deletion-protection-db](../../_includes/mdb/cli-additional-settings/deletion-protection-db.md) %}

    You can get the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- Terraform

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For information about how to create this file, see [{#T}](cluster-create.md).

  1. To change the backup start time, add a block named `config.backup_window_start` to the {{ mpg-name }} cluster description.

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
        ...
        config {
          backup_window_start {
            hours   = <backup starting hour>
            minutes = <backup starting minute>
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
            data_lens = <Access from DataLens: true or false>
            web_sql   = <execution of SQL queries from management console: true or false>
            ...
        }
        ...
      }
      ```

  1. To enable cluster protection against accidental deletion by a user of your cloud, add the `deletion_protection` field set to `true` to your cluster description:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
        ...
        deletion_protection = <protect cluster from deletion: true or false>
      }
      ```

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [provider documentation {{ TF }}]({{ tf-provider-mpg }}).

- API

    Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

    * The cluster ID in the `clusterId` parameter.

    * Settings for access from other services and access to SQL queries from the management console in the `configSpec.access` parameter.

    * Backup window settings in the `configSpec.backupWindowStart` parameter.

    * Cluster deletion protection settings in the `deletionProtection` parameter.

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

    * List of cluster configuration fields to be changed in the `updateMask` parameter.

     You can get the cluster ID with a [list of clusters in a folder ](./cluster-list.md#list-clusters).

    {% note warning %}

    This API method resets any cluster settings that aren't passed explicitly in the request to their defaults. To avoid this, pass the names of the fields to be changed in the `updateMask` parameter.

    {% endnote %}

{% endlist %}

## Setting the operation mode for the connection pooler {#change-pooler-config}

You can set session or transaction mode for the connection pooler. For more information, see [{#T}](../concepts/pooling.md).

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the connection pooler's operation mode:

  1. View a description of the CLI's update cluster command:

      ```
      $ {{ yc-mdb-pg }} cluster update --help
      ```

  1. Specify the necessary operation mode using the `--connection-pooling-mode` flag:

      ```
      $ {{ yc-mdb-pg }} cluster update <cluster name>
           --connection-pooling-mode <SESSION or TRANSACTION>
      ```

      {{ mpg-short-name }} runs the operation to change the connection pooler mode.

- Terraform

    To change the connection pooler mode:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. Specify the necessary operation mode under `config.pooler_config`.

        ```hcl
        resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
          ...
          config {
            pooler_config {
              pool_discard = <Odissey pool_discard parameter: true or false>
              pooling_mode = "<pooling mode: SESSION or TRANSACTION>"
            }
            ...
          }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [provider documentation {{ TF }}]({{ tf-provider-mpg }}).

- API

  You can change the connection pooler's operation mode for a cluster using the [update](../api-ref/Cluster/update.md) API method: pass the appropriate value in the `configSpec.poolerConfig.poolingMode` request parameter.

{% endlist %}

## Switching the master {#start-manual-failover}

In a failover {{ PG }} cluster with multiple hosts, you can switch the master role from the current master host to the cluster's replica host. After this operation, the current master host becomes the replica host of the new master.

Specifics of switching master hosts in {{ mpg-name }}

1. You can't switch the master host to a replica that the source of the replication thread is explicitly given for.
1. If you don't specify the replica host name explicitly, the master host will switch to a synchronous replica.

For more information, see [{#T}](../concepts/replication.md).

To switch the master:

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mpg-name }}**.
  1. Click on the name of the cluster you want and select the **Hosts** tab.
  1. Click **![image](../../_assets/pencil.svg) Switching the master**.
  1. To switch the master to a synchronous replica, leave the **Choose master host automatically** option enabled.
  1. To switch the master to another replica, disable the **Choose master host automatically** option and then select the desired replica from the drop-down list.
  1. Click **Switch**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Run the command:

  ```
  $ {{ yc-mdb-pg }} cluster start-failover <cluster name> --host <replica host name>
  ```

  You can request the replica host name with a [list of cluster hosts](hosts.md#list-hosts) and the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

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

    For more information, see [provider documentation {{ TF }}]({{ tf-provider-mpg }}).

- API

  Use the API [startFailover](../api-ref/Cluster/startFailover.md) method and pass the following in the request:
  1. In the `clusterId` parameter, the ID of the cluster where you want to switch the master. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  1. In the `hostName` parameter, the name of the replica host to switch to. To find out the name, [request a list of hosts in the cluster](hosts.md#list).

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

      ```
      $ {{ yc-mdb-pg }} cluster update --help
      ```

  1. Specify the security groups in the update cluster command:

      ```
      $ {{ yc-mdb-pg }} cluster update <cluster name>
           --security-group-ids <list of security groups>
      ```

- Terraform

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For information about how to create this file, see [{#T}](cluster-create.md).

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

  For more information, see [provider documentation {{ TF }}]({{ tf-provider-mpg }}).

- API

  Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
  * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
  * The list of groups in the `securityGroupIds` parameter.
  * The list of settings to update in the `updateMask` parameter. If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}

