# Changing cluster settings

After creating a cluster, you can:

* [Change service account settings](#change-service-account).

* [{#T}](#change-resource-preset).

* [{#T}](#change-disk-size) (only available for [storage types](../concepts/storage.md) `network-hdd` and `network-ssd`).

* [Configure {{ CH }} servers](#change-clickhouse-config) according to the [{{ CH }} documentation](https://clickhouse.yandex/docs/en/operations/server_settings/settings/).

* [Change additional cluster settings](#change-additional-settings).

* [Change cluster security groups](#change-sg-set).

## Changing service account settings {#change-service-account}

{% list tabs %}

- Management console

    1. Go to the folder page and select **{{ mch-name }}**.
    1. Select the cluster and click **Edit cluster** in the top panel.
    
    1. Select the desired service account from the list or [create a new one](../../iam/operations/sa/create.md). For more information about setting up service accounts, see [{#T}](s3-access.md).

       {% include [mdb-service-account-update](../../_includes/mdb/service-account-update.md) %}

{% endlist %}

## Changing the host class {#change-resource-preset}

{% note info %}

In clusters with {{ CK }} support, {{ ZK }} hosts cannot be used. For more information, see [{#T}](../concepts/replication.md).

{% endnote %}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mch-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. To change the class of a {{ CH }} host, under **Host class**, select the class.
  1. To change the class of {{ ZK }} hosts:

      1. Click **Configure{{ ZK }}**.

      1. Under **Host class {{ ZK }}**, select the class for the {{ ZK }} host.

  1. Click **Save changes**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the [host class](../concepts/instance-types.md) for the cluster:

  1. View a description of the CLI's update cluster command:

     ```
     $ {{ yc-mdb-ch }} cluster update --help
     ```

  1. Request a list of available host classes (the `ZONES` column specifies the availability zones where you can select the appropriate class):

     
     ```bash
     $ {{ yc-mdb-ch }} resource-preset list
     
     +-----------+--------------------------------+-------+----------+
     |    ID     |            ZONE IDS            | CORES |  MEMORY  |
     +-----------+--------------------------------+-------+----------+
     | s1.micro  | ru-central1-a, ru-central1-b,  |     2 | 8.0 GB   |
     |           | ru-central1-c                  |       |          |
     | ...                                                           |
     +-----------+--------------------------------+-------+----------+
     ```

  1. Specify the class in the update cluster command:

     ```
     $ {{ yc-mdb-ch }} cluster update <cluster name>
          --clickhouse-resource-preset <class ID>
     ```

     {{ mch-short-name }} will run the update host class command for the cluster.

  1. To change the class of a {{ ZK }} host, pass the desired value in the `--zookeeper-resource-preset` parameter.

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create such a file, see [{#T}](cluster-create.md).

    1. In the {{ mch-name }} cluster description, change the value of the `resource_preset_id` parameter in the `clickhouse.resources` and `zookeeper.resources` blocks for {{ CH }} and {{ ZK }} hosts, respectively:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
          ...
          clickhouse {
            resources {
              resource_preset_id = "<class of {{ CH }} hosts>"
              ...
            }
          }
          zookeeper {
            resources {
              resource_preset_id = "<class of {{ ZK }} hosts>"
              ...
            }
          }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mch }}).

- API

  Use the API [update](../api-ref/Cluster/update.md) method and pass the requisite values in the `configSpec.clickhouse.resources.resourcePresetId` parameter (`configSpec.zookeeper.resources.resourcePresetId` for ZooKeeper).

  To request a list of supported values, use the [list](../api-ref/ResourcePreset/list.md) method for the `ResourcePreset` resources.

{% endlist %}

## Increasing storage size {#change-disk-size}

{% note info %}

In clusters with {{ CK }}, {{ ZK }} hosts cannot be used. For more information, see [{#T}](../concepts/replication.md).

{% endnote %}

{% include [storage type check](../../_includes/mdb/note-change-disk-size.md) %}

{% list tabs %}

- Management console

  To increase the storage size for a cluster:

  1. Go to the folder page and select **{{ mch-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. Under **Storage size**, specify the required value.
  1. Click **Save changes**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To increase the storage size for a cluster:

  1. View a description of the CLI's update cluster command:

     ```bash
     {{ yc-mdb-ch }} cluster update --help
     ```

  1. Make sure the cloud's quota is sufficient to increase storage: open the [Quotas]({{ link-console-quotas }}) page for your cloud and check that the **Managed Databases** section still has space available in the **HDD storage capacity** or **SSD storage capacity** line.

  1. Specify the required amount of storage in the update cluster command (it must be at least as large as `disk_size` in the cluster properties):

     ```bash
     {{ yc-mdb-ch }} cluster update <cluster name or ID> \
        --clickhouse-disk-size <storage size in GB>
     ```

     If all these conditions are met, {{ mch-short-name }} launches the operation to increase storage space.

  1. To increase the storage capacity of {{ ZK }} hosts, pass the desired value in the `--zookeeper-disk-size` parameter.

- Terraform

  To increase storage size:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create such a file, see [{#T}](cluster-create.md).

    1. In the {{ mch-name }} cluster description, change the value of the `disk_size` parameter in the `clickhouse.resources` and `zookeeper.resources` blocks for {{ CH }} and {{ ZK }}, respectively:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
          ...
          clickhouse {
            resources {
              disk_size = <storage size in GB>
              ...
            }
          }
          zookeeper {
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

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mch }}).

- API

  Make sure the cloud's quota is sufficient to increase storage: open the [Quotas]({{link-console-quotas}}) page for your cloud and check that the **Managed Databases** section still has space available in the **HDD storage capacity** or **SSD storage capacity** line.

  To increase the storage size, use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

  * The cluster ID in the `clusterId` parameter. You can get the cluster ID with a [list of clusters in a folder ](./cluster-list.md#list-clusters).
  * The required amount of storage in the `configSpec.clickhouse.resources.diskSize` parameter.
  * The required amount of the {{ ZK }} host storage in the `configSpec.zookeeper.resources.diskSize` parameter.
  * List of cluster configuration fields to be changed in the `updateMask` parameter.

    {% include [Reset the values of all parameters of the object to update](../../_includes/mdb/note-api-updatemask.md) %}

{% endlist %}

## Changing {{ CH }} settings {#change-clickhouse-config}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mch-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. Change the [{{ CH }} settings](../concepts/settings-list.md#dbms-cluster-settings) by clicking **Configure** under **DBMS settings**:
  1. Click **Save changes**.

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create such a file, see [{#T}](cluster-create.md).

    1. In the {{ mch-name }} cluster description, change the values of the parameters in the `clickhouse.config` block:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
          ...
          clickhouse {
            ...
        
            config {
              # General DBMS settings
              ...
        
              merge_tree {
                # MergeTree engine settings
                ...
              }
        
              kafka {
                # General settings for getting data from Apache Kafka
                ...
              }
        
              kafka_topic {
                # Settings of an individual Apache Kafka topic
                ...
              }
        
              rabbit_mq {
                # Settings for getting data from {{ RMQ }}
                username = "<username>"
                password = "<password>"
              }
        
              compression {
                # Data compression settings
                method              = "<compression method: LZ4 or ZSTD>"
                min_part_size       = <minimum size of a data part in a table in bytes>
                min_part_size_ratio = <ratio of the size of the smallest data part in table to total table size>
              }
        
              graphite_rollup {
                # GraphiteMergeTree engine settings for thinning and aggregating/averaging
                # (rollup) of Graphite data
                ...
              }
            }
          ...
          }
        ...
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [Terraform provider documentation]({{ tf-provider-mch }}).

- API

  Use the API [update](../api-ref/Cluster/update.md) method and pass all the requisite values in the `configSpec.clickhouse.config` parameter.

  All supported settings are described in [{#T}](../concepts/settings-list.md#dbms-cluster-settings) and the [API reference](../api-ref/Cluster/update.md).

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mch-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. Change additional cluster settings:

     {% include [mch-extra-settings](../../_includes/mdb/mch-extra-settings-web-console.md) %}

  1. Click **Save changes**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change additional cluster settings:

    1. View a description of the CLI's update cluster command:

        ```bash
        {{ yc-mdb-ch }} cluster update --help
        ```

    1. Run the command with a list of settings to update:

        ```bash
        {{ yc-mdb-ch }} cluster update <cluster name> \
           --backup-window-start <backup start time> \
           --datalens-access=<true or false> \
           --maintenance-window type=<weekly or anytime> \
           --metrika-access=<true or false> \
           --websql-access=<true or false>
           --deletion-protection=<protect cluster from deletion: true or false> \
           --serverless-access=<true or false>
        ```

    You can change the following settings:

    {% include [backup-window-start](../../_includes/mdb/cli-additional-settings/backup-window-start.md) %}

    * `--datalens-access`: Enables DataLens access. Default value: `false`. For more information about how to connect to DataLens, see [{#T}](datalens-connect.md).

    {% include [maintenance-window](../../_includes/mdb/cli-additional-settings/maintenance-window.md) %}

    * `--metrika-access`: Enables [import of AppMetrica data to a cluster](https://appmetrica.yandex.com/docs/cloud/index.html). Default value: `false`.

    * `--websql-access`: Enables [SQL queries](web-sql-query.md) to be run from the management console. The default value is `false`.
    
    * `--serverless-access`: Enables cluster access from [{{ sf-full-name }}](../../functions/concepts/index.md). Default value: `false`. For more information about setting up access, see the [{{ sf-name }}](../../functions/operations/database-connection.md) documentation.

    {% include [Cluster protection from accidental deletion](../../_includes/mdb/cli-additional-settings/deletion-protection-db.md) %}

    You can get the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create such a file, see [{#T}](cluster-create.md).

    1. To change the backup start time, add a `backup_window_start` block to the {{ mch-name }} cluster description.

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
          ...
          backup_window_start {
            hours   = <backup starting hour>
            minutes = <backup starting minute>
          }
          ...
        }
        ```

    1. To allow access from other {{ yandex-cloud }} services and [execution of SQL queries from the management console](web-sql-query.md), change the values of the appropriate fields in the `access` block:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
          ...
          access {
            data_lens  = <access from DataLens: true or false>
            metrika    = <access from Yandex.Metrica and AppMetrica: true or false>
            serverless = <access from Cloud Functions: true or false>
            web_sql    = <execution of SQL queries from management console: true or false>
          }
          ...
        }
        ```

    1. To enable cluster protection against the accidental deletion by a user, add the `deletion_protection` field set to `true` to your cluster description:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
          ...
          deletion_protection = <protect cluster from deletion: true or false>
        }
        ```

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [Terraform provider documentation]({{ tf-provider-mch }}).

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

    This API method resets any cluster settings that aren't passed explicitly in the request to their defaults. To avoid this, be sure to pass the names of the fields to be changed in the `updateMask` parameter.

    {% endnote %}

  
  To enable cluster access from [{{ sf-full-name }}](../../functions/concepts/index.md), pass the value `true` for the `configSpec.access.serverless` parameter. For more information about setting up access, see the [{{ sf-name }}](../../functions/operations/database-connection.md) documentation.

{% endlist %}

## Changing security groups {#change-sg-set}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mch-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. Under **Network settings**, select security groups for cluster network traffic.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To edit the list of [security groups](../concepts/network.md#security-groups) for your cluster:

  1. View a description of the CLI's update cluster command:

      ```
      $ {{ yc-mdb-ch }} cluster update --help
      ```

  1. Specify the security groups in the update cluster command:

      ```
      $ {{ yc-mdb-ch }} cluster update <cluster name>
           --security-group-ids <list of security group IDs>
      ```

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create such a file, see [{#T}](cluster-create.md).

    1. Change the value of the `security_group_ids` parameter in the cluster description:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
          ...
          security_group_ids = [ <list of IDs of cluster security groups> ]
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [Terraform provider documentation]({{ tf-provider-mch }}).

- API

  Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

  * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
  * The list of security group IDs in the `securityGroupIds` parameter.
  * The list of settings to update in the `updateMask` parameter. If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}
