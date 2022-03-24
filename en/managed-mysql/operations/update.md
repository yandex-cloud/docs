# Changing cluster settings

After creating a cluster, you can:

* [Change the host class](#change-resource-preset).

* [Increase the storage size](#change-disk-size) (available only for `network-hdd` standard network storage and `network-ssd` fast network storage).

* [Configure the {{ MY }} servers](#change-mysql-config).

    {% note warning %}

    You can't change {{ MY }} server settings using SQL commands.

    {% endnote %}

* [Change additional cluster settings](#change-additional-settings).

* [{#T}](#change-sg-set).

## Changing the host class {#change-resource-preset}

The choice of a host class in {{ mmy-short-name }} clusters is limited by the CPU and RAM quotas available to DB clusters in your cloud. To check the resources in use, open the [Quotas]({{ link-console-quotas }}) page and find the **Managed Databases** section.

{% include [mmy-settings-dependence](../../_includes/mdb/mmy/note-info-settings-dependence.md) %}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. To change the class of {{ MY }} hosts, under **Host class**, select the required class.
  1. Click **Save changes**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the [host class](../concepts/instance-types.md) for the cluster:

  1. View a description of the CLI's update cluster command:

      ```
      $ {{ yc-mdb-my }} cluster update --help
      ```

  1. Request a list of available host classes (the `ZONES` column specifies the availability zones where you can select the appropriate class):

     
     ```
     $ {{ yc-mdb-my }} resource-preset list
     
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
      $ {{ yc-mdb-my }} cluster update <cluster name>
           --resource-preset <class ID>
      ```

      {{ mmy-short-name }} will run the update host class command for the cluster.

- Terraform

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For information about how to create this file, see [{#T}](./cluster-create.md).

  1. In the {{ mmy-name }} cluster description, change the `resource_preset_id` parameter value under `resources`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster name>" {
        ...
        resources {
          resource_preset_id = "<host class>"
          ...
        }
      }
      ```

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [provider documentation {{ TF }}]({{ tf-provider-mmy }}).

- API

    To change the [host class](../concepts/instance-types.md), use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
    * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
    * The desired host class in the `configSpec.resources.resourcePresetId` parameter. To request a list of supported values, use the [list](../api-ref/ResourcePreset/list.md) method for the `ResourcePreset` resources.

{% endlist %}

## Increasing storage size {#change-disk-size}

Storage capacity in {{ mmy-short-name }} clusters is limited by the HDD and SSD storage size quotas available to DB clusters in your cloud. To check the storage size in use, open the [Quotas]({{ link-console-quotas }}) page and find the **Managed Databases** section.

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. Under **Storage size**, specify the required value.
  1. Click **Save changes**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To increase the storage size for a cluster:

  1. View a description of the CLI's update cluster command:

      ```
      $ {{ yc-mdb-my }} cluster update --help
      ```

  1. Make sure the required cluster uses standard or fast network storage. To do this, request information about the cluster and find the `disk_type_id` field: it should be set to `network-hdd` or `network-ssd`:

      ```
      $ {{ yc-mdb-my }} cluster get <cluster name>
      
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

      {% note warning %}

      It's not possible to increase the size of local or non-replicated network storage.

      {% endnote %}

  1. Specify the required amount of storage in the update cluster command (it must be at least as large as `disk_size` in the cluster properties):

      ```
      $ {{ yc-mdb-my }} cluster update <cluster name>
           --disk-size <storage size in GB>
      ```

      If all these conditions are met, {{ mmy-short-name }} launches the operation to increase storage space.

- Terraform

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For information about how to create this file, see [{#T}](./cluster-create.md).

  1. Make sure the required cluster uses standard or fast network storage. To do this, find the `disk_type_id` parameter in the configuration file. Its value should be `network-hdd` or `network-ssd`.

      {% note warning %}

      It's not possible to increase the size of local or non-replicated network storage.

      {% endnote %}

  1. Change the `disk_size` parameter value under `resources`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster name>" {
        ...
        resources {
          disk_size = <storage size in GB>
          ...
        }
      }
      ```

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [provider documentation {{ TF }}]({{ tf-provider-mmy }}).

- API

    Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
    * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
    * Storage size in the `configSpec.resources.diskSize` parameter.

{% endlist %}

## Changing {{ MY }} settings {#change-mysql-config}

{% include [mmy-settings-dependence](../../_includes/mdb/mmy/note-info-settings-dependence.md) %}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. Change the [{{ MY }} settings](../concepts/settings-list.md#dbms-cluster-settings) by clicking **Configure** under **DBMS settings**.
  1. Click **Save**.
  1. Click **Save changes**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To update the [{{ MY }} settings](../concepts/settings-list.md#dbms-cluster-settings):

  1. View a description of the CLI's update cluster configuration command:

      ```
      $ {{ yc-mdb-my }} cluster update-config --help
      ```

  1. Set the required parameter values.

     All supported parameters are listed in [the request format for the update method](../api-ref/Cluster/update.md), in the `mysql_config_5_7` field. To specify the parameter name in the CLI's call, convert the name from <q>lowerCamelCase</q> to <q>snake_case</q>. For example, the `logMinDurationStatement` parameter from an API request should be converted to `log_min_duration_statement` for the CLI command:

     ```
     $ {{ yc-mdb-my }} cluster update-config <cluster name>
          --set log_min_duration_statement=100,<parameter name>=<value>,...
     ```

     {{ mmy-short-name }} runs the update cluster settings operation.

- Terraform

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For information about how to create this file, see [{#T}](./cluster-create.md).

  1. In the {{ mmy-name }} cluster description, add or update the [DBMS settings](../concepts/settings-list.md) under `mysql_config`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster name>" {
        ...
        mysql_config = {
          <setting name {{ MY }}> = <value>
          ...
        }
      }
      ```

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}#mysql-config).

- API

    Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
    * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
    * An array with new {{ MY }} settings in the following parameter:
        * `configSpec.mysqlConfig_5_7.sqlMode` for {{ MY }} 5.7.
        * `configSpec.mysqlConfig_8_0.sqlMode` for {{ MY }} 8.0.

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmy-name }}**.

  1. Select the cluster and click **Edit cluster** in the top panel.

  1. Change additional cluster settings:

     {% include [mmy-extra-settings](../../_includes/mdb/mmy-extra-settings-web-console.md) %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change additional cluster settings:

    1. View a description of the CLI's update cluster command:

        ```bash
        {{ yc-mdb-my }} cluster update --help
        ```

    1. Run the command with a list of settings to update:

        ```bash
        {{ yc-mdb-my }} cluster update <cluster name> \
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

  1. To change the backup start time, add a {{ mmy-name }}backup_window_start` block to the ` cluster description:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster name>" {
        ...
        backup_window_start {
          hours   = <backup starting hour>
          minutes = <backup starting minute>
        }
        ...
      }
      ```

  1. To allow access to [SQL queries from the management console](web-sql-query.md) and [DataLens](datalens-connect.md), add a block named `access` to the {{ mmy-name }} cluster description:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster name>" {
        ...
        access {
          web_sql   = <true or false>
          data_lens = <true or false>
          ...
        }
        ...
      }
      ```

  1. To enable cluster protection against accidental deletion by a user of your cloud, add the `deletion_protection` field set to `true` to your cluster description:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster name>" {
        ...
        deletion_protection = <protect cluster from deletion: true or false>
      }
      ```

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [provider documentation {{ TF }}]({{ tf-provider-mmy }}).

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

## Changing security groups {#change-sg-set}

{% list tabs %}

- Management console
    1. Go to the folder page and select **{{ mmy-name }}**.
    1. Select the cluster and click **Edit cluster** in the top panel.
    1. Under **Network settings**, select security groups for cluster network traffic.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To edit the list of [security groups](../concepts/network.md#security-groups) for your cluster:

    1. View a description of the CLI's update cluster command:

        ```bash
        {{ yc-mdb-my }} cluster update --help
        ```

    1. Specify the security groups in the update cluster command:

        ```bash
        {{ yc-mdb-my }} cluster update <cluster name> \
           --security-group-ids <list of security groups>
        ```

- Terraform

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For information about how to create this file, see [{#T}](./cluster-create.md).

  1. In the {{ mmy-name }} cluster description, change the `security_group_ids` parameter value:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster name>" {
        ...
        security_group_ids = [<list of security group IDs>]
      }
      ```

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [provider documentation {{ TF }}]({{ tf-provider-mmy }}).

- API

    Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
    * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
    * The list of security group IDs in the `securityGroupIds` parameter.
    * The list of settings to update in the `updateMask` parameter.

    {% include [Resetting the settings of the object being modified](../../_includes/mdb/note-api-updatemask.md) %}

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](connect.md#configure-security-groups) to connect to the cluster.

{% endnote %}

