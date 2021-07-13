# Changing cluster settings

After creating a cluster, you can:

* [Change the host class](#change-resource-preset).

* [Increase the storage size](#change-disk-size) (available only for network storage, `network-hdd`, and `network-ssd`).

* [Configure {{ CH }} servers](#change-clickhouse-config) according to the [{{ CH }} documentation](https://clickhouse.yandex/docs/en/operations/server_settings/settings/).

* [Change additional cluster settings](#change-additional-settings).

* [Change cluster security groups](#change-sg-set).

## Change the host class {#change-resource-preset}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mch-name }}**.

  1. Select the cluster and click **Edit cluster** in the top panel.

  1. To change the class of {{ CH }} hosts, under **Host class**, select the required class.

  1. To change the class of {{ ZK }} hosts:

      1. Click **Configure{{ ZK }}**.

      1. Under **Host class {{ ZK }}**, select the class for the {{ ZK }} host.

  1. Click **Save changes**.

  {% note info %}

  You can change the class of {{ ZK }} hosts only if [fault tolerance](zk-hosts.md#add-zk) is enabled for the cluster.

  {% endnote %}

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

  3. Specify the class in the update cluster command:

     ```
     $ {{ yc-mdb-ch }} cluster update <cluster name>
          --clickhouse-resource-preset <class ID>
     ```

     {{ mch-short-name }} will run the update host class command for the cluster.

     You can change the {{ZK}} host class using a similar parameter: `--zookeeper-resource-preset`.

- Terraform

    To change the [host class](../concepts/instance-types.md) for the cluster:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

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

    For more information, see the [{{ TF }} provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- API

  You can change the [host class](../concepts/instance-types.md) using the API [update](../api-ref/Cluster/update.md) method: pass the appropriate values in the request parameter `configSpec.clickhouse.resources.resourcePresetId` (for ZooKeeper — `configSpec.zookeeper.resources.resourcePresetId`).

  To request a list of supported values, use the [list](../api-ref/ResourcePreset/list.md) method for the `ResourcePreset` resources.

{% endlist %}

## Increasing storage size {#change-disk-size}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. Under **Storage size**, specify the required value.
  1. Click **Save changes**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To increase the storage size for a cluster:

  
  1. Make sure the required cluster uses network storage (it's currently not possible to increase the size of local storage). To do this, request information about the cluster and find the `disk_type_id` field: it should be set to `network-hdd` or `network-ssd`:

     ```
     $ {{ yc-mdb-ch }} cluster get <cluster name>
     
     id: c7qkvr3u78qiopj3u4k2
     folder_id: b1g0ftj57rrjk9thribv
     ...
     config:
       clickhouse:
         resources:
           resource_preset_id: s1.micro
           disk_size: "21474836480"
           disk_type_id: network-ssd
     ...
     ```

  1. View a description of the CLI's update cluster command:

     ```
     $ {{ yc-mdb-ch }} cluster update --help
     ```

  1. Make sure the cloud's quota is sufficient to increase the storage size: open the [Quotas]({{ link-console-quotas }}) page for your cloud and check that the {{ mch-full-name }} section still has space available in the **space** line.

  1. Specify the required amount of storage in the update cluster command (it must be at least as large as `disk_size` in the cluster properties):

     ```
     $ {{ yc-mdb-ch }} cluster update <cluster name>
          --clickhouse-disk-size <storage size in GB>
     ```

     If all these conditions are met, {{ mch-short-name }} launches the operation to increase storage space.

     You can change the storage size for ZooKeeper by using the same parameter, `--zookeeper-disk-size`.

- Terraform

    To increase the storage size for a cluster:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

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

    For more information, see the [{{ TF }} provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- API

  You can change the cluster's storage size using the API [update](../api-ref/Cluster/update.md) method: pass the appropriate values in the request parameter `configSpec.clickhouse.resources.diskSize` (for ZooKeeper, the parameter is `configSpec.zookeeper.resources.diskSize`).

  Make sure the cloud's quota is sufficient to increase the storage size: open the [Quotas]({{link-console-quotas}}) page for your cloud and check that the {{ mch-full-name }} section still has space available in the **space** line.

{% endlist %}

## Changing {{ CH }} settings {#change-clickhouse-config}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. Change the [{{ CH }} settings](../concepts/settings-list.md#dbms-cluster-settings) by clicking **Configure** under **DBMS settings**:
  1. Click **Save changes**.

- Terraform

    To change [cluster settings](../concepts/settings-list.md#dbms-cluster-settings):

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

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

    For more information, see the [Terraform provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- API

  Use the [update](../api-ref/Cluster/update.md) API method and pass the required values in the `configSpec.clickhouse.config` request parameter.

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
        ```

    You can change the following settings:

    {% include [backup-window-start](../../_includes/mdb/cli-additional-settings/backup-window-start.md) %}
    * `--datalens-access`: Enables DataLens access. Default value: `false`. For more information about how to connect to DataLens, see [{#T}](datalens-connect.md).

    {% include [maintenance-window](../../_includes/mdb/cli-additional-settings/maintenance-window.md) %}

    * `--metrika-access`: Enables the [import of AppMetrica data to a cluster](https://appmetrica.yandex.com/docs/cloud/index.html). Default value: `false`.

    * `--websql-access`: Enables [SQL queries](web-sql-query.md) to be run from the management console. Default value: `false`.

    You can get the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- Terraform

    To change additional cluster settings:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

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
            datalens   = <access from DataLens: true or false>
            metrika    = <access from Yandex.Metrica and AppMetrica: true or false>
            serverless = <access from Serverless: true or false>
            web_sql    = <execution of SQL queries from management console: true or false>
          }
          ...
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [Terraform provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- API

  Use the [update](../api-ref/Cluster/update.md) API method and pass the required values in the `configSpec.access` and `configSpec.backupWindowStart` request parameters.

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
           --security-group-ids <list of security groups>
      ```

- Terraform

    To change cluster security groups:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. Change the value of the `security_group_ids` parameter in the cluster description:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
          ...
          security_group_ids = [ <list of cluster security groups> ]
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [Terraform provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- API

  To edit the list of cluster [security groups](../concepts/network.md#security-groups), use the `update` API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
  - The list of groups in the `securityGroupIds` parameter.
  - The list of settings to update in the `updateMask` parameter. If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}

