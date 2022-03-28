# Changing cluster settings

After creating a cluster, you can:

* [Change the host class](#change-resource-preset).

* [Increase the storage size](#change-disk-size) (only available for [storage types](../concepts/storage.md) `network-hdd` and `network-ssd`).

* [Configure {{ MG }} servers](#change-mongod-config) according to the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/configuration-options/).

* [Change additional cluster settings](#change-additional-settings).

* [{#T}](#change-sg-set).

## Changing the host class {#change-resource-preset}

{% include [mmg-settings-dependence](../../_includes/mdb/mmg/note-info-settings-dependence.md) %}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmg-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. To change the class of {{ MG }} hosts, under **Host class**, select the required class.
  1. Click **Save changes**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the [host class](../concepts/instance-types.md) for the cluster:

  1. View a description of the CLI's update cluster command:

      ```
      $ {{ yc-mdb-mg }} cluster update --help
      ```

  1. Request a list of available host classes (the `ZONES` column specifies the availability zones where you can select the appropriate class):

     {% if audience != "internal" %}

     ```bash
     $ {{ yc-mdb-mg }} resource-preset list
     
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
      $ {{ yc-mdb-mg }} cluster update <cluster name>
           --mongod-resource-preset <class ID>
      ```

      {{ mmg-short-name }} will run the update host class command for the cluster.

- Terraform

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For information about how to create this file, see [{#T}](cluster-create.md).

  1. In the {{ mmg-name }} cluster description, change the `resource_preset_id` parameter value under `resources`:

      ```hcl
      resource "yandex_mdb_mongodb_cluster" "<cluster name>" {
        ...
        resources {
            resource_preset_id = "<class of {{ MG }} hosts>"
            ...
        }
      }
      ```

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmg }}).

- API

  Use the API [update](../api-ref/Cluster/update.md) method and transmit the requisite values in the `configSpec.mongodbSpec_4_2.mongod.resources.resourcePresetId` parameter.

  To request a list of supported values, use the [list](../api-ref/ResourcePreset/list.md) method for the `ResourcePreset` resources.

{% endlist %}

## Increasing storage size {#change-disk-size}

{% include [storage type check](../../_includes/mdb/note-change-disk-size.md) %}

{% list tabs %}

- Management console

  To increase the storage size for a cluster:

  1. Go to the folder page and select **{{ mmg-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. Under **Storage size**, specify the required value.
  1. Click **Save changes**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To increase the storage size for a cluster:

  1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-mg }} cluster update --help
      ```

  1. Specify the storage size in the update cluster command: It must be at least as large as the current `disk_size` value in the cluster properties.

      ```bash
      {{ yc-mdb-mg }} cluster update <cluster name or ID> \
           --mongod-disk-size <storage size in GB>
      ```

      If all these conditions are met, {{ mmg-short-name }} launches the operation to increase storage space.

- Terraform

  To increase the storage size for a cluster:

  1. Open the current configuration file {{ TF }} with an infrastructure plan.

      For information about how to create this file, see [{#T}](cluster-create.md).

  1. In the {{ mmg-name }} cluster description, change the `disk_size` parameter value under `resources`:

      ```hcl
      resource "yandex_mdb_mongodb_cluster" "<cluster name>" {
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

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmg }}).

- API

  Make sure the cloud's quota is sufficient to increase storage: open the [Quotas]({{ link-console-quotas }}) page for your cloud and check that the **Managed Databases** section still has space available in the **HDD storage capacity** or **SSD storage capacity** line.

  To increase the storage size for your cluster, use the API [update](../api-ref/Cluster/update.md) method and pass the requisite values in the `configSpec.mongodbSpec_4_2.mongod.resources.diskSize` parameter.

{% endlist %}

## Changing {{ MG }} settings {#change-mongod-config}

You can change the DBMS settings of the hosts in your cluster.

{% include [mmg-settings-dependence](../../_includes/mdb/mmg/note-info-settings-dependence.md) %}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmg-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. Change the [{{ MG }} settings](../concepts/settings-list.md#dbms-cluster-settings) by clicking **Configure** under **DBMS settings**.
  1. Click **Save changes**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To update the [{{ MG }} settings](../concepts/settings-list.md#dbms-cluster-settings) for a cluster, run the command:

  ```
  $ {{ yc-mdb-mg }} cluster update-config
  ```

  For example, to set [net.maxIncomingConnections](https://docs.mongodb.com/manual/reference/configuration-options/#mongodb-setting-net.maxIncomingConnections) to `4096`, run the following command:

  ```
  $ {{ yc-mdb-mg }} cluster update-config <cluster name>
      --set net.max_incoming_connections=4096
  ```

  {{ mmg-short-name }} will run the update DBMS settings command for the cluster. If the setting being changed is only applied when the database is restarted, {{ mmg-short-name }} sequentially restarts the database on all the cluster hosts.

- API

  Use the API [update](../api-ref/Cluster/update.md) method and pass the requisite values in the `configSpec.mongodbSpec_4_2.mongod.config` parameter.

  All supported settings are described [in the API reference](../api-ref/Cluster/update.md).

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmg-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. Change additional cluster settings:

     {% include [mmg-extra-settings](../../_includes/mdb/mmg-extra-settings.md) %}

  1. Click **Save changes**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change additional cluster settings:

    1. View a description of the CLI's update cluster command:

        ```bash
        {{ yc-mdb-mg }} cluster update --help
        ```

    1. Run the command with a list of settings to update:

        ```bash
        {{ yc-mdb-mg }} cluster update <cluster name> \
           --backup-retain-period-days=<retention period> \
           --backup-window-start <backup start time> \
           --maintenance-window type=<weekly or anytime>
        ```

    You can change the following settings:

    * `--backup-retain-period`: The retention period for automatic backups (in days).
      {% if audience != "internal" %}

      The `<retention period>` parameter value must be in the range from {{ mmg-backup-retention-min }} to {{ mmg-backup-retention-max }} (the default value is {{ mmg-backup-retention }}). This feature is at the [Preview stage](../../overview/concepts/launch-stages.md). For more information, see [{#T}](../concepts/backup.md).

      {% else %}

      The `<retention period>` parameter value must be in the range from {{ mmg-backup-retention-min }} to {{ mmg-backup-retention-max }} (the default value is {{ mmg-backup-retention }}). This feature is in the Preview stage. For more information, see [{#T}](../concepts/backup.md).

      {% endif %}

      Changing the retention period affects both new automatic backups and existing backups.

      For example, if the original retention period was 7 days and the remaining lifetime of a separate automatic backup is 1 day, then when the retention period increases to 9 days, the remaining lifetime of this backup becomes 3 days.

    {% include [backup-window-start](../../_includes/mdb/cli-additional-settings/backup-window-start.md) %}

    {% include [maintenance-window](../../_includes/mdb/cli-additional-settings/maintenance-window.md) %}

    {% include [deletion-protection-db](../../_includes/mdb/cli-additional-settings/deletion-protection-db.md) %}

    You can get the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

       For information about how to create this file, see [{#T}](cluster-create.md).

    1. To change the backup start time, add a block named `backup_window_start` to the {{ mmg-name }} cluster description under `cluster_config`:

        ```hcl
        resource "yandex_mdb_mongodb_cluster" "<cluster name>" {
          ...
          cluster_config {
            backup_window_start {
              hours   = <backup starting hour>
              minutes = <backup starting minute>
            }
            ...
          }
          ...
        }
        ```

    1. To allow access [from {{ datalens-full-name }}](../../datalens/concepts/index.md), add a block named `access` to the {{ mmg-name }} cluster description under `cluster_config`:

        ```hcl
        resource "yandex_mdb_mongodb_cluster" "<cluster name>" {
          ...
          cluster_config {
            ...
            access {
              data_lens = <Access from DataLens: true or false>
            }
          ...
        }
        ```

    1. To enable cluster protection against accidental deletion by a user of your cloud, add the `deletion_protection` field set to `true` to your cluster description:

        ```hcl
        resource "yandex_mdb_mongodb_cluster" "<cluster name>" {
          ...
          deletion_protection = <protect cluster from deletion: true or false>
        }
        ```

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmg }}).

- API

    Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

    * The cluster ID in the `clusterId` parameter.
    * The new backup start time, in the `configSpec.backupWindowStart` parameter.
    * Settings for access from other services in the `configSpec.access` parameter.
    * Cluster deletion protection settings in the `deletionProtection` parameter.

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

    * List of cluster configuration fields to be changed in the `updateMask` parameter.

    You can get the cluster ID with a [list of clusters in a folder](./cluster-list.md#list-clusters).

    {% note warning %}

    This API method resets any cluster settings that aren't passed explicitly in the request to their defaults. To avoid this, be sure to pass the names of the fields to be changed in the `updateMask` parameter.

    {% endnote %}

{% endlist %}

## Changing security groups {#change-sg-set}

{% list tabs %}

- Management console

    1. Go to the folder page and select **{{ mmg-name }}**.
    1. Select the cluster and click **Edit cluster** in the top panel.
    1. Under **Network settings**, select security groups for cluster network traffic.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To edit the list of [security groups](../concepts/network.md#security-groups) for your cluster:

    1. View a description of the CLI's update cluster command:

        ```bash
        {{ yc-mdb-mg }} cluster update --help
        ```

    1. Specify the security groups in the update cluster command:

        ```bash
        {{ yc-mdb-mg }} cluster update <cluster name> \
           --security-group-ids <list of security groups>
        ```

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

       For information about how to create this file, see [{#T}](cluster-create.md).

    1. In the {{ mmg-name }} cluster description, change the `security_group_ids` parameter value:

        ```hcl
        resource "yandex_mdb_mongodb_cluster" "<cluster name>" {
          ...
          security_group_ids = [ <List of security group IDs> ]
          ...
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmg }}).

- API

  Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

    * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
    * The list of groups in the `securityGroupIds` parameter.
    * The list of settings to update in the `updateMask` parameter. If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}
