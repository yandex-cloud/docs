# Changing cluster settings

After creating a cluster, you can:

* [Change the host class](#change-resource-preset).
* [Increase the storage size](#change-disk-size) (only available for [storage types](../concepts/storage.md) `network-hdd` and `network-ssd`).
* [Change {{ MS }} settings](#change-sqlserver-config) according to the {{ MS }} documentation.
* [{#T}](#change-additional-settings).
* [Move the cluster](#move-cluster) to another folder.

{% note warning %}

You can't use SQL commands to change {{ MS }} settings, including managing server-level objects, such as `Linked Server`, `Login`, `Credential`, `SQL Server Agent Job`, `Maintenance Plan`, `Audit`, `Polybase`, `Replication`, `Backup devices`, `Server Triggers`, and `Extended events`.

{% endnote %}

## Change the host class {#change-resource-preset}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mms-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. Select a new [host class](../concepts/instance-types.md). When you change the host class for the cluster, the characteristics of all existing hosts change, too.
  1. Click **Save changes**.

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](./cluster-create.md).

    1. In the {{ mms-name }} cluster description, change the `resource_preset_id` parameter value under `resources`:

        ```hcl
        resource "yandex_mdb_sqlserver_cluster" "<cluster name>" {
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

    For more information, see [{{ TF }} provider documentation]({{ tf-provider-mms }}).

- API

  Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
  * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  * New host class, in the `configSpec.resources.resourcePresetId` parameter. To find out the list of supported values, use the `list` method for `ResourcePreset`.
  * List of cluster configuration fields to be edited (in this case, `configSpec.resources.resourcePresetId`) in the `updateMask` parameter.

  {% note warning %}

  This API method resets any cluster settings that aren't passed explicitly in the request to their defaults. To avoid this, in the `updateMask` parameter, list the settings you want to change (in a single line, separated by commas).

  {% endnote %}

{% endlist %}

## Increasing storage size {#change-disk-size}

{% include [storage type check](../../_includes/mdb/note-change-disk-size.md) %}

{% list tabs %}

- Management console

  To increase the storage size for a cluster:
  1. Go to the folder page and select **{{ mms-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. Under **Storage size**, specify the required value.
  1. Click **Save changes**.

- Terraform

  To increase the storage size for a cluster:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](./cluster-create.md).

    1. In the {{ mms-name }} cluster description, change the `disk_size` parameter value under `resources`:

        ```hcl
        resource "yandex_mdb_sqlserver_cluster" "<cluster name>" {
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

    For more information, see [{{ TF }} provider documentation]({{ tf-provider-mms }}).

- API

  To increase the storage size for a cluster, use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
  * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  * Required storage size (in bytes), in the `configSpec.resources.diskSize` parameter.
  * List of user configuration fields to be edited (in this case, `configSpec.resources.diskSize`) in the `updateMask` parameter.

      {% include [note-api-updatemask](../../_includes/mdb/note-api-updatemask.md) %}

{% endlist %}

## Changing {{ MS }} settings {#change-sqlserver-config}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mms-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. Under **DBMS settings**, click **Settings**.
  1. Edit the settings and click **Save**.
  1. Click **Save changes**.

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](./cluster-create.md).

    1. Edit the {{ mms-name }} cluster description to modify the parameters under `sqlserver_config`:

        ```hcl
        resource "yandex_mdb_sqlserver_cluster" "<cluster name>" {
          ...
          sqlserver_config {
            ...
          }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [{{ TF }} provider documentation]({{ tf-provider-mms }}).

- API

  Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
  * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  * The relevant values in the `configSpec.sqlserverConfig_2016sp2` parameter.
  * List of user configuration fields to be edited (in this case, `configSpec.sqlserverConfig_2016sp2`) in the `updateMask` parameter.

  {% note warning %}

  This API method resets any cluster settings that aren't passed explicitly in the request to their defaults. To avoid this, in the `updateMask` parameter, list the settings you want to change (in a single line, separated by commas).

  {% endnote %}

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs %}

- Management console

    1. Go to the folder page and select **{{ mms-name }}**.
    1. Select a cluster and click **Edit** at the top of the page.
    1. Change additional cluster settings:

        {% include [extra-settings](../../_includes/mdb/mms/extra-settings.md) %}

          {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

    1. Click **Save changes**.

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create such a file, see [{#T}](cluster-create.md).

    1. To change the backup start time, add a `backup_window_start` block to the {{ mms-name }} cluster description.

        ```hcl
        resource "yandex_mdb_sqlserver_cluster" "<cluster name>" {
          ...
          backup_window_start {
            hours   = <backup starting hour>
            minutes = <backup starting minute>
          }
          ...
        }
        ```

    1. To enable cluster protection against unintentional deletion by your cloud users, add the `deletion_protection` field to the cluster description and set it to `true`:

        ```hcl
        resource "yandex_mdb_sqlserver_cluster" "<cluster name>" {
          ...
          deletion_protection = <cluster protection against deletion: true or false>
        }
        ```

        {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [{{ TF }} provider documentation]({{ tf-provider-mms }}).

- API

  Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

  * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  * The new backup start time, in the `configSpec.backupWindowStart` parameter.
  * List of cluster configuration fields to be edited (in this case, `configSpec.backupWindowStart`) in the `updateMask` parameter.

  {% note warning %}

  This API method resets any cluster settings that aren't passed explicitly in the request to their defaults. To avoid this, in the `updateMask` parameter, list the settings you want to change (in a single line, separated by commas).

  {% endnote %}

{% endlist %}

## Moving a cluster {#move-cluster}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mms-name }}**.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) to the right of the row of the cluster that you want to move.
  1. Click **Move**.
  1. Select the folder you want to move the cluster to.
  1. Click **Move**.

- API

  Use the [move](../api-ref/Cluster/move.md) API method and pass the following in the query:
  * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  * The ID of the destination folder in the `destinationFolderId` parameter.

{% endlist %}
