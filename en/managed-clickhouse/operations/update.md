# Changing cluster settings

{% if product == "cloud-il" %}

{% include [one-az-disclaimer](../../_includes/overview/one-az-disclaimer.md) %}

{% endif %}

After creating a cluster, you can:

* [Change service account settings](#change-service-account).

* [{#T}](#change-resource-preset).

* [{#T}](#change-disk-size){% if audience != "internal" %} (unavailable for non-replicated SSD [storage](../concepts/storage.md)){% endif %}.

* [{#T}](#SQL-management)

* [Configure {{ CH }} servers](#change-clickhouse-config) by following the [{{ CH }} documentation]({{ ch.docs }}/operations/server_settings/settings/).

* [Change additional cluster settings](#change-additional-settings).

* [Change cluster security groups](#change-sg-set).

## Change service account settings {#change-service-account}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mch-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel.
       {% if audience != "internal" %}

   1. Select the desired service account from the list or [create a new one](../../iam/operations/sa/create.md). For more information about setting up service accounts, see [{#T}](s3-access.md).

   {% else %}

   1. Select the desired service account from the list or create a new one. For more information about setting up service accounts, see [{#T}](s3-access.md).

   {% endif %}

        {% include [mdb-service-account-update](../../_includes/mdb/service-account-update.md) %}

{% endlist %}

## Changing the host class {#change-resource-preset}

{% note info %}

In clusters with {{ CK }}, {{ ZK }} hosts cannot be used. For more information, see [{#T}](../concepts/replication.md).

{% endnote %}

The host class affects the amount of RAM that can be used by {{ CH }}. For more information, see [{#T}](../concepts/memory-management.md).

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mch-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel. 
   1. To change the class of {{ CH }} hosts, under **Host class**, select the required class.
   1. To change the class of {{ ZK }} hosts:

      1. Click **Configure {{ ZK }}**.

      1. Under **Host class {{ ZK }}**, select the class for the {{ ZK }} host.

   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the [host class](../concepts/instance-types.md) for the cluster:

   1. View a description of the CLI's update cluster command:

      ```
      {{ yc-mdb-ch }} cluster update --help
      ```

   1. Request a list of available host classes (the `ZONES` column specifies the availability zones where you can select the appropriate class):

      {% if audience != "internal" %}

      ```bash
      {{ yc-mdb-ch }} resource-preset list

      +-----------+--------------------------------+-------+----------+
      |    ID     |            ZONE IDS            | CORES |  MEMORY  |
      +-----------+--------------------------------+-------+----------+
      | s1.micro  | {{ region-id }}-a, {{ region-id }}-b,  |     2 | 8.0 GB   |
      |           | {{ region-id }}-c                  |       |          |
      | ...                                                           |
      +-----------+--------------------------------+-------+----------+
      ```

      {% else %}

      ```bash
      {{ yc-mdb-ch }} resource-preset list

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
      {{ yc-mdb-ch }} cluster update <cluster name> \
         --clickhouse-resource-preset <class ID>
      ```

      {{ mch-short-name }} will run the update host class command for the cluster.

   1. To change the class of a {{ ZK }} host, pass the desired value in the `--zookeeper-resource-preset` parameter.

- Terraform

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. In the {{ mch-name }} cluster description, change the value of the `resource_preset_id` parameter in the `clickhouse.resources` and `zookeeper.resources` blocks for {{ CH }} and {{ ZK }} hosts, respectively:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
        ...
        clickhouse {
          resources {
            resource_preset_id = "<{{ CH }} host class>"
            ...
          }
        }
        zookeeper {
          resources {
            resource_preset_id = "<{{ ZK }} host class>"
            ...
          }
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_clickhouse_cluster).

- API

   Use the API [update](../api-ref/Cluster/update.md) method and pass the requisite values in the `configSpec.clickhouse.resources.resourcePresetId` parameter (`configSpec.zookeeper.resources.resourcePresetId` for ZooKeeper).

   To request a list of supported values, use the [list](../api-ref/ResourcePreset/list.md) method for `ResourcePreset` resources.

{% endlist %}

## {% if audience != "internal" %}Increasing{% else %}Modifying{% endif %} storage size {#change-disk-size}

{% note info %}

In clusters with {{ CK }}, {{ ZK }} hosts cannot be used. For more information, see [{#T}](../concepts/replication.md).

{% endnote %}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs %}

- Management console

   To {% if audience != "internal" %}increase{% else %}modify{% endif %} a cluster's storage size:

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mch-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel. 
   1. Under **Storage size**, specify the required value.
   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To {% if audience != "internal" %}increase{% else %}modify{% endif %} a cluster's storage size:

   1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-ch }} cluster update --help
      ```

   1. Specify the required amount of storage in the {% if audience != "internal" %} cluster update command (it must be at least as large as `disk_size` in the cluster properties){% endif %}:

      ```bash
      {{ yc-mdb-ch }} cluster update <cluster name or ID> \
       --clickhouse-disk-size <storage size in GB>
      ```

   1. To {% if audience != "internal" %}increase{% else %}modify{% endif %} the storage capacity of {{ ZK }} hosts, pass the desired value in the `--zookeeper-disk-size` parameter.

- Terraform

   To {% if audience != "internal" %}increase{% else %}modify{% endif %} storage size:

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. In the {{ mch-name }} cluster description, change the value of the `disk_size` parameter in the `clickhouse.resources` and `zookeeper.resources` blocks for {{ CH }} and {{ ZK }}, respectively:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
        ...
        clickhouse {
          resources {
            disk_size = <storage size in gigabytes>
            ...
          }
        }
        zookeeper {
          resources {
            disk_size = <storage size in gigabytes>
            ...
          }
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_clickhouse_cluster).

- API

   To {% if audience != "internal" %}increase{% else %}modify{% endif %} storage size, use the API [update](../api-ref/Cluster/update.md) method and pass the following in in the call:

   * The cluster ID in the `clusterId` parameter. You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).
   * The required amount of storage in the `configSpec.clickhouse.resources.diskSize` parameter.
   * The required amount of the {{ ZK }} host storage in the `configSpec.zookeeper.resources.diskSize` parameter.
   * List of cluster configuration fields to be changed in the `updateMask` parameter.

      {% include [Resetting the settings of the object being modified](../../_includes/mdb/note-api-updatemask.md) %}

{% endlist %}

## Enabling user and database management via SQL {#SQL-management}

The {{ mch-name }} service lets enable cluster [user](./cluster-users.md#sql-user-management) and [database](./databases.md#sql-database-management) management via SQL.

{% note alert %}

Once enabled, user and database management settings for SQL cannot be disabled.

{% endnote %}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mch-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel. 
   1. To [manage users via SQL](./cluster-users.md#sql-user-management), enable the **User management via SQL** setting and specify the password of the `admin` user.
   1. To [manage databases via SQL](./databases.md#sql-database-management), enable the **User management via SQL** and **Database management via SQL** settings and specify the password of the `admin` user.
   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. To enable [SQL user management](./cluster-users.md#sql-user-management):

      * set `--enable-sql-user-management` to `true`.
      * Set a password for the `admin` user in the `--admin-password` parameter.

      ```bash
      {{ yc-mdb-ch }} cluster update <cluster name or ID>\
         ...
         --enable-sql-user-management true \
         --admin-password "<admin account password>"
      ```

   1. To enable [SQL database management](./databases.md#sql-database-management):

      * Set `--enable-sql-user-management` and `--enable-sql-database-management` to `true`;
      * Set a password for the `admin` user in the `--admin-password` parameter.

      ```bash
      {{ yc-mdb-ch }} cluster update <cluster name or ID>\
         ...
         --enable-sql-user-management true \
         --enable-sql-database-management true \
         --admin-password "<admin account password>"
      ```

- Terraform

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. {% include [Enable SQL user management with Terraform](../../_includes/mdb/mch/terraform/sql-management-users.md) %}

   1. {% include [Enable SQL database management with Terraform](../../_includes/mdb/mch/terraform/sql-management-databases.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [Terraform provider documentation]({{ tf-provider-mch }}).

- API

   Use the API [update](../api-ref/Cluster/update.md) method and pass all the requisite values in the `configSpec.clickhouse.config` parameter:
   * `sqlUserManagement`: Set to `true` to enable [user management via SQL](cluster-users.md#sql-user-management).
   * `sqlDatabaseManagement`: Set to `true` to enable [database management via SQL](databases.md#sql-database-management). User management via SQL needs to be enabled.
   * `adminPassword`: Set a password for the `admin` account to use for management tasks.

{% endlist %}

## Changing {{ CH }} settings {#change-clickhouse-config}

{% note info %}

You can only change the [Max server memory usage]({{ ch.docs }}/operations/server-configuration-parameters/settings/#max_server_memory_usage) setting value by [changing the class of {{ CH }} hosts](#change-resource-preset).

For more information, see [{#T}](../concepts/memory-management.md).

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mch-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel. 
   1. Change the [{{ CH }} settings](../concepts/settings-list.md#dbms-cluster-settings) by clicking **Configure** under **DBMS settings**:
   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change [{{ CH }} server](../concepts/settings-list.md) settings:

   1. View the full list of settings specified for the cluster:

      ```bash
      {{ yc-mdb-ch }} cluster get <cluster ID or name> --full
      ```

   1. View a description of the CLI's update cluster configuration command:

      ```bash
      {{ yc-mdb-ch }} cluster update-config --help
      ```

   1. Set the required parameter values:

      ```bash
      {{ yc-mdb-ch }} cluster update-config <cluster ID or name> \
           --set <parameter1 name>=<value1>,...
      ```

      {{ mch-short-name }} runs the update cluster settings operation.

      All the supported parameters are listed in the [description of settings for{{ CH }}](../concepts/settings-list.md).

- Terraform

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

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
              # General settings to get data from Apache Kafka
              ...
            }

            kafka_topic {
              # Settings for an individual Apache Kafka topic
              ...
            }

            rabbit_mq {
              # Settings to get data from {{ RMQ }}
              username = "<username>"
              password = "<password>"
            }

            compression {
              # Data compression settings
              method              = "<compression algorithm: LZ4 or ZSTD>"
              min_part_size       = <minimum table data chunk size in bytes>
              min_part_size_ratio = <ratio of smallest data chunk size to full table size>
            }

            graphite_rollup {
              # GraphiteMergeTree engine settings for thinning and aggregation/averaging
              # (rollup) of Graphite data.
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

   For more information, see the [Terraform provider documentation]({{ tf-provider-link }}/mdb_clickhouse_cluster).

- API

   Use the API [update](../api-ref/Cluster/update.md) method and pass all the requisite values in the `configSpec.clickhouse.config` parameter.

   All supported settings are described in [{#T}](../concepts/settings-list.md#dbms-cluster-settings) and the [API reference](../api-ref/Cluster/update.md).

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mch-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel. 
   1. Change additional cluster settings:

      {% include [mch-extra-settings](../../_includes/mdb/mch/extra-settings-web-console.md) %}

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
      {{ yc-mdb-ch }} cluster update <cluster ID or name> \
         --backup-window-start <backup start time> \
         --datalens-access=<true or false> \
         --maintenance-window type=<maintenance type: anytime or weekly>,`
                             `day=<day of week for weekly>,`
                             `hour=<hour for weekly> \
         --metrika-access=<true or false> \
         --websql-access=<true or false> \
         --deletion-protection=<cluster deletion protection: true or false> \
         --serverless-access=<true or false>
      ```

   You can change the following settings:

   {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

   -{% if product == "yandex-cloud" %}*`--datalens-access`: Enables DataLens access. Default value: `false`. For more information about setting up a connection, see [{#T}](datalens-connect.md).{% endif %}

   * {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window.md) %}

   * `--metrika-access` enables [data import from AppMetrica into a cluster]{% if lang == "ru" %}(https://appmetrica.yandex.ru/docs/common/cloud/about.html){% endif %}{% if lang == "en" %}(https://appmetrica.yandex.com/docs/common/cloud/about.html){% endif %}. Default value: `false`.

   * `--websql-access`: Enables [SQL queries to be run](web-sql-query.md) from the management console. Default value: `false`.
      {% if product == "yandex-cloud" %}
      {% if audience != "internal" %}

   * `--serverless-access`: Enables cluster access from [{{ sf-full-name }}](../../functions/concepts/index.md). Default value: `false`. For more detail on setting up access, see the [{{ sf-name }}](../../functions/operations/database-connection.md).

   {% else %}

   * `--serverless-access`: Enables cluster access from {{ sf-full-name }}. Default value: `false`.

   {% endif %}
   {% endif %}

   * {% include [Protection against cluster deletion](../../_includes/mdb/cli/deletion-protection.md) %}

      {% include [Limitations of Deletion protection](../../_includes/mdb/deletion-protection-limits-db.md) %}

   You can find out the cluster ID and name in a [list of clusters in the folder](cluster-list.md#list-clusters).

- Terraform

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. To change the backup start time, add a `backup_window_start` block to the {{ mch-name }} cluster description:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
        ...
        backup_window_start {
          hours   = <backup start hour>
          minutes = <backup start minute>
        }
        ...
      }
      ```

   1. To allow access from other services and [execution of SQL queries from the management console](web-sql-query.md), change the values of the appropriate fields in the `access` block:

      {% if product == "yandex-cloud" %}

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
        ...
        access {
          data_lens  = <Access from DataLens: true or false>
          metrika    = <Access from Yandex.Metrica and AppMetrica: true or false>
          serverless = <Access from Cloud Functions: true or false>
          web_sql    = <Run SQL queries from the management console: true or false>
        }
        ...
      }
      ```

      {% endif %}

      {% if product == "cloud-il" %}

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
        ...
        access {
          metrika    = <Access from Metrica and AppMetrika: true or false>
          web_sql    = <Executing SQL queries from the management console: true or false>
        }
        ...
      }
      ```

      {% endif %}

   1. {% include [maintenance-window](../../_includes/mdb/mch/terraform-maintenance-window.md) %}

   1. To enable cluster protection against accidental deletion by a user of your cloud, add the `deletion_protection` field set to `true` to your cluster description:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
        ...
        deletion_protection = <protect cluster from deletion: true or false>
      }
      ```

      {% include [Limitations of Deletion protection](../../_includes/mdb/deletion-protection-limits-db.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [Terraform provider documentation]({{ tf-provider-link }}/mdb_clickhouse_cluster).

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter.
   * Settings for access from other services and access to SQL queries from the management console in the `configSpec.access parameter`.
   * Backup window settings in the `configSpec.backupWindowStart` parameter.
   * {% include [maintenance-window](../../_includes/mdb/api/maintenance-window.md) %}
   * Cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [Limitations of Deletion protection](../../_includes/mdb/deletion-protection-limits-db.md) %}

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

   To allow cluster access from {{ yq-full-name }}, pass `true` for the `configSpec.access.yandexQuery` parameter.

{% endlist %}

## Changing security groups {#change-sg-set}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mch-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel. 
   1. Under **Network settings**, select security groups for cluster network traffic.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To edit the list of [security groups](../concepts/network.md#security-groups) for your cluster:

   1. View a description of the CLI's update cluster command:

      ```
      {{ yc-mdb-ch }} cluster update --help
      ```

   1. Specify the security groups in the update cluster command:

      ```
      {{ yc-mdb-ch }} cluster update <cluster name> \
         --security-group-ids <security group ID list>
      ```

- Terraform

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Change the value of the `security_group_ids` parameter in the cluster description:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
        ...
        security_group_ids  = ["<list of cluster security group IDs>"]
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [Terraform provider documentation]({{ tf-provider-link }}/mdb_clickhouse_cluster).

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
   * The list of security group IDs in the `securityGroupIds` parameter.
   * The list of settings to update in the `updateMask` parameter. If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}
