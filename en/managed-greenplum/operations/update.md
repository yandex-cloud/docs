---
title: How to change {{ GP }} cluster settings in {{ mgp-full-name }}
description: Follow this guide to change {{ GP }} cluster settings.
---

# Updating {{ GP }} cluster settings


After creating a cluster, you can:

* [{#T}](#change-name-and-description).

* [{#T}](#change-public-access).

* [{#T}](#change-additional-settings).

* [{#T}](#change-gp-settings).

* [{#T}](#change-resource-preset).

* [{#T}](#change-disk-size).

* [Configure {{ GP }} servers according to the {{ GP }} documentation](#change-gp-settings).

To move a cluster to a different availability zone, [restore it from a backup](cluster-backups.md#restore). While restoring the cluster, specify a new availability zone. You will thus move the cluster hosts.

If you use [external data sources](../concepts/external-tables.md) for PXF operations, [learn how to configure the protocol](./pxf/settings.md). This will allow you to optimize operations with external data.

## Changing the cluster name and description {#change-name-and-description}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** at the top of the page.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, enter a new name and description for the cluster.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the name and description of a {{ GP }} cluster:

  1. View the current `name` and `description` of the cluster:

     ```bash
     {{ yc-mdb-gp }} cluster get <cluster_name_or_ID>
     ```

  1. View a description of the update cluster configuration CLI command:

      ```bash
      {{ yc-mdb-gp }} cluster update --help
      ```

  1. Enter a new name and description for the cluster:

      ```bash
      {{ yc-mdb-gp }} cluster update <cluster_name_or_ID> \
         --new-name <new_cluster_name> \
         --description <new_cluster_description>
      ```

- API {#api}

    To change a cluster's name and description, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) gRPC API call and provide the following in the request:

    * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
    * New name in the `name` parameter.
    * New description in the `description` parameter.
    * List of updatable cluster configuration fields in the `updateMask` parameter (in this case, `name`, `description`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Change the public access setting {#change-public-access}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ mgp-name }}**.
    1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** at the top of the page.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, enable or disable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the public access setting {{ GP }}:

  1. View a description of the update cluster configuration CLI command:

      ```bash
      {{ yc-mdb-gp }} cluster update --help
      ```

  1. Configure public access in the `--assign-public-ip` parameter:

      ```bash
      {{ yc-mdb-gp }} cluster update <cluster_name_or_ID> \
         --assign-public-ip=<public_access_to_cluster>
      ```

      Where `assign-public-ip` is the public access to the cluster, true or false.

- API {#api}

    Use the [update](../api-ref/Cluster/update.md) API method and include the following in the request:

    * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
    * Public access settings in the `config.assignPublicIp` parameter.
    * List of updatable cluster configuration fields in the `updateMask` parameter (in this case, `name`, `description`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% note tip %}

If you enabled public access to the cluster but cannot access it from the internet:

* Check the [security group settings](./connect#configuring-security-groups).
* Wait a while. It may take some time to enable public access.

{% endnote %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
    1. Change additional cluster settings:

        * {% include [Backup time](../../_includes/mdb/console/backup-time.md) %}
        * **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}**: [Maintenance](../concepts/maintenance.md) window settings:

            {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}


        * {% include [Datalens access](../../_includes/mdb/console/datalens-access.md) %}
        * {% include [Query access](../../_includes/mdb/console/query-access.md) %}



        * {% include [Deletion protection](../../_includes/mdb/console/deletion-protection.md) %}

            {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

        * **{{ ui-key.yacloud.greenplum.section_cloud-storage }}**: Activates the {{ yandex-cloud }} [{{ YZ }} extension](https://github.com/yezzey-gp/yezzey/). This extension is used to export [AO and AOCO tables](../tutorials/yezzey.md) from disks within the {{ mgp-name }} cluster to a cold storage in {{ objstorage-full-name }}. This way, the data will be stored in a service bucket in a compressed and encrypted form. This is a [more cost-efficient storage method](../../storage/pricing.md).

            You cannot disable this option after you save your cluster settings.


            {% note info %}

            This feature is at the [Preview](../../overview/concepts/launch-stages.md) stage and is free of charge.

            {% endnote %}


        * **{{ ui-key.yacloud.mdb.forms.section_pooler }}**: Operation mode and parameters of the [connection pooler](../concepts/pooling.md):

            {% include [Pooling mode](../../_includes/mdb/mgp/pooling-mode.md) %}

    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change additional cluster settings:

    1. View the description of the update cluster CLI command:

        ```bash
        {{ yc-mdb-gp }} cluster update --help
        ```

    1. Run the following command with a list of settings to update:


        ```bash
        {{ yc-mdb-gp }} cluster update <cluster_name_or_ID> \
            --backup-window-start <backup_start_time> \
            --datalens-access=<access_from_{{ datalens-name }}> \
            --yandexquery-access=<access_from_Yandex_Query> \
            --maintenance-window type=<maintenance_type>,`
                                `day=<day_of_week>,`
                                `hour=<hour> \
            --assign-public-ip=<public_access_to_cluster> \
            --deletion-protection
        ```




    You can change the following settings:

    {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}


    * `--datalens-access`: Access to the cluster from [{{ datalens-full-name }}](../../datalens/concepts/index.md), `true` or `false`.

    * `--yandexquery-access`: Access to the cluster from [{{ yq-full-name }}](../../query/concepts/index.md), `true` or `false`.



    * `--maintenance-window`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters), where `type` is the maintenance type:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

    * `--assign-public-ip`: Cluster accessibility from the internet.

    * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [Deletion protection limits db](../../_includes/mdb/deletion-protection-limits-db.md) %}

    You can [get the cluster name with a list of clusters in the folder](cluster-list.md#list-clusters).

- API {#api}

    To change additional cluster settings, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) gRPC API call and provide the following in the request:

    * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
    * Public access in the `config.assignPublicIp` parameter.
    * Backup window in the `config.backupWindowStart` parameter.


    * Cluster access from [{{ datalens-full-name }}](../../datalens/concepts/index.md) in the `config.access.dataLens` parameter.
    * Cluster access from [{{ yq-full-name }}](../../query/concepts/index.md) in the `config.access.yandexQuery` parameter.



    * [Maintenance window](../concepts/maintenance.md) (including for disabled clusters) in the `maintenanceWindow` parameter.
    * Cluster deletion protection in the `deletionProtection` parameter.

        {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

    * List of cluster configuration fields to update in the `updateMask` parameter.

    {% include [note-api-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Editing the scheduled maintenance operations settings {#change-background-settings}

You can edit your cluster's [scheduled maintenance operations](../concepts/maintenance.md#regular-ops) settings.

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
    1. Under **{{ ui-key.yacloud.greenplum.section_background-activities }}**, change the parameters:

        {% include [background activities](../../_includes/mdb/mgp/background-activities-console.md) %}

    1. Click **{{ ui-key.yacloud.common.save }}**.

- API {#api}

    To edit your cluster's scheduled maintenance operations settings, use the REST API [update](../api-ref/Cluster/update.md) method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) gRPC API call, and provide the following in the request:

    * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
    * New parameter values for the `configSpec.backgroundActivities.analyzeAndVacuum` object:

        * `start.hours`: Start hour of the `VACUUM` operation in UTC. Values range from `0` to `23`, the default one is `19`.
        * `start.minutes`: Start minute of the `VACUUM` operation in UTC. Values range from `0` to `59`, the default one is `0`.
        * `vacuumTimeout`: Maximum duration of the `VACUUM` operation, in seconds. Values range from `7200` to `86399`, the default one is `36000`. As soon as this period expires, the `VACUUM` operation will be forced to terminate.
        * `analyzeTimeout`: Maximum duration of the `ANALYZE` operation, in seconds. Values range from `7200` to `86399`, the default one is `36000`. As soon as this period expires, the `ANALYZE` operation will be forced to terminate.

    * List of cluster configuration fields to update in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing {{ GP }} settings {#change-gp-settings}

You can change the DBMS settings of the hosts in your cluster.

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
  1. Change the [{{ GP }} settings](../concepts/settings-list.md) by clicking **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** under **{{ ui-key.yacloud.mdb.forms.section_settings }}**.
  1. Click **{{ ui-key.yacloud.component.mdb.settings.popup_settings-submit }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the [{{ GP }} DBMS settings](../concepts/settings-list.md):

  1. View the full list of settings specified for the cluster:

     ```bash
     {{ yc-mdb-gp }} cluster get <cluster_name_or_ID>
     ```

  1. View a description of the update cluster configuration CLI command:

      ```bash
      {{ yc-mdb-gp }} cluster update-config --help
      ```

  1. Set the required parameter values:

      All supported parameters are listed in the [request format for the update method](../api-ref/Cluster/update.md), in the `greenplumConfig_<Greenplum_version>` field. To specify a parameter name in the CLI call, convert its name from <q>lowerCamelCase</q> to <q>snake_case</q>. For example, convert the `maxConnections` parameter from an API request to `max_connections` for the CLI command:

      ```bash
      {{ yc-mdb-gp }} cluster update-config <cluster_name_or_ID> \
         --set <parameter_1_name>=<value1>,<parameter_2_name>=<value2>,...
      ```

      {{ mgp-short-name }} runs the update cluster settings operation.

- API {#api}

    To change {{ GP }} settings, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) gRPC API call and provide the following in the request:

    * New values ​​in the `configSpec.greenplumConfig_<version>` parameter.
    * List of cluster configuration fields to update, in the `updateMask` parameter.

        {% include [note-api-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing the host class {#change-resource-preset}

You can change the host class for both master hosts and segment hosts. When changing the host class:

* The cluster's primary master host will change.
* Using a [special FQDN](./connect.md#fqdn-master) does not guarantee a stable database connection: user sessions may be terminated.

We recommend changing the host class only when the cluster has no active workload.

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. Select a cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_resource }}**, select the required class for {{ GP }} master hosts or segment hosts.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the [host class](../concepts/instance-types.md) for the cluster:

  1. View the description of the update cluster CLI command:

      ```bash
      {{ yc-mdb-gp }} cluster update --help
      ```

  1. Request a list of available classes (the `ZONE IDS` column specifies the availability zones where you can select the appropriate class):
     * For master hosts:

        ```bash
        {{ yc-mdb-gp }} resource-preset list master
        ```

     * For segment hosts:

        ```bash
        {{ yc-mdb-gp }} resource-preset list segment
        ```


     ```text
     +-------------+--------------------------------+--------------------------------+-------+----------+--------------------+---------------------+
     |     ID      |            ZONE IDS            |           DISK TYPES           | CORES |  MEMORY  | HOST COUNT DIVIDER | MAX SEGMENT IN HOST |
     +-------------+--------------------------------+--------------------------------+-------+----------+--------------------+---------------------+
     | i2.2xlarge  | {{ region-id }}-a, {{ region-id }}-b   | local-ssd,                     |    16 | 128.0 GB |                  1 |                   0 |
     |             |                                | network-ssd-nonreplicated      |       |          |                    |                     |
     | ...                                                                                                                                         |
     +-------------+--------------------------------+--------------------------------+-------+----------+--------------------+---------------------+
     ```


  1. Specify the required classes in the cluster update command:

      ```bash
      {{ yc-mdb-gp }} cluster update <cluster_name_or_ID> \
          --master-config resource-id=<master_host_class_ID> \
          --segment-config resource-id=<segment_host_class_ID>
      ```

      {{ mgp-short-name }} will run the update host class command for the cluster.

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [Creating clusters](cluster-create.md).

      For a complete list of available {{ mgp-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mgp }}).

  1. In the {{ mgp-name }} cluster description, change the `resource_preset_id` attribute value under `master_subcluster.resources` or `segment_subcluster.resources`:

      ```hcl
      resource "yandex_mdb_greenplum_cluster" "<cluster_name>" {
        ...
        master_subcluster {
          resources {
            resource_preset_id = "<host_class>"
            ...
          }
        segment_subcluster {
          resources {
            resource_preset_id = "<host_class>"
            ...
          }
        }
      }
      ```

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mgp/terraform-timeouts.md) %}

- API {#api}

  To change the class of cluster hosts, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) gRPC API call and provide the following in the request:

  * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
  * Master host class ID in the `masterConfig.resources.resourcePresetId` parameter or segment host class ID in the `segmentConfig.resources.resourcePresetId` parameter. You can get a list of supported values by using the [list](../api-ref/ResourcePreset/list.md) method for the `ResourcePreset`.
  * List of settings to update (in this case, `masterConfig.resources.resourcePresetId` or `segmentConfig.resources.resourcePresetId`), in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Increasing storage size {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  To increase the cluster storage size:

  1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. Select the cluster you need.
  1. At the top of the page, click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. Edit the settings in the **{{ ui-key.yacloud.mdb.forms.section_storage }}** section.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- API {#api}

  To increase the cluster storage size, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) gRPC API call and provide the following in the request:

  * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
  * New master and segment host storage size in the `masterConfig.resources.diskSize` and `segmentConfig.resources.diskSize` parameters.
  * List of cluster configuration fields to update in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
