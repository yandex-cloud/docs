# Changing {{ GP }} cluster settings

After creating a cluster, you can:

* [{#T}](#change-name-and-description).

* [{#T}](#change-additional-settings).

* [{#T}](#change-gp-settings).

* [{#T}](#change-disk-size).

* [Configure {{ GP }} servers according to the {{ GP }} documentation](#change-gp-settings).

## Change the cluster name and description {#change-name-and-description}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mgp-name }}**.
   1. Select the cluster and click **Edit** at the top of the page.
   1. Under **Basic parameters**, enter a new name and description for the cluster.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the name and description of a {{ GP }} cluster:

   1. View the current name (`name`) and description (`description`) of the cluster:

      ```bash
      {{ yc-mdb-gp }} cluster get <cluster ID or name>
      ```

   1. View a description of the CLI's update cluster configuration command:

      ```bash
      {{ yc-mdb-gp }} cluster update --help
      ```

   1. Enter a new name and description for the cluster:

      ```bash
      {{ yc-mdb-gp }} cluster update <cluster ID or name> \
         --new-name <new cluster name> \
         --description <new cluster description>
      ```

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * A new name in the `name` parameter.
   * A new description in the `description` parameter.
   * List of cluster configuration fields to update in the `updateMask` parameter (`name` and `description` in this case).

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mgp-name }}**.
   1. Select the cluster and click **Edit** in the top panel.
   1. Change additional cluster settings:

      * {% include [Backup time](../../_includes/mdb/console/backup-time.md) %}
      * **Maintenance window**: [Maintenance window](../concepts/maintenance.md) settings:

         {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}

      * {% include [Datalens access](../../_includes/mdb/console/datalens-access.md) %}
      * {% include [DataTransfer access](../../_includes/mdb/console/datatransfer-access.md) %}
      * {% include [Deletion protection](../../_includes/mdb/console/deletion-protection.md) %}

         {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

      * **Connection pooler**: Operation mode and parameters of the [connection pooler](../concepts/pooling.md):

         {% include [Pooling mode](../../_includes/mdb/mgp/pooling-mode.md) %}

   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change additional cluster settings:

   1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-gp }} cluster update --help
      ```

   1. Run the command with a list of settings to update:

      ```bash
      {{ yc-mdb-gp }} cluster update <cluster ID or name> \
          --backup-window-start <backup start time> \
          --datalens-access=<true or false> \
          --datatransfer-access=<true or false> \
          --maintenance-window type=<maintenance type: anytime or weekly>,`
                              `day=<day of week for weekly>,`
                              `hour=<hour for weekly> \
          --assign-public-ip=<public access to the cluster: true or false> \
          --deletion-protection=<cluster deletion protection: true or false> \
      ```

   You can change the following settings:

   {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

   {% if product == "yandex-cloud" %}* `--datalens-access`: Enables [{{ datalens-full-name }}](../../datalens/concepts/index.md) access. Default value: `false`.{% endif %}

   * `--datatransfer-access`: Enables [{{ data-transfer-full-name }}](../../data-transfer/) access. Default value: `false`.

   * `--maintenance-window`: Settings for the [maintenance window](../concepts/maintenance.md) (including disabled clusters):

      {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

   * `--assign-public-ip`: Access to the cluster from the internet.

   * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

      {% include [Deletion protection limits db](../../_includes/mdb/deletion-protection-limits-db.md) %}

   You can [retrieve the cluster name with a list of clusters in the folder](cluster-list.md#list-clusters).

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Public access settings in the `config.assignPublicIp` parameter.
   * Backup window settings, in the `config.backupWindowStart` parameter.
   * Settings for access from [{{ datalens-full-name }}](../../datalens/concepts/index.md), in the `config.access.dataLens` parameter.
   * Settings for the [maintenance window](../concepts/maintenance.md) (including for disabled clusters) in the `maintenanceWindow` parameter.
   * Cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

   * List of cluster configuration fields to update in the `UpdateMask` parameter.

   {% include [note-api-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing {{ GP }} settings {#change-gp-settings}

You can change the DBMS settings of the hosts in your cluster.

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mgp-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel.
   1. Change the [{{ GP }} settings](../concepts/settings-list.md) by clicking **Configure** under **DBMS settings**.
   1. Click **Save**.
   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the [{{ GP }} DBMS settings](../concepts/settings-list.md):

   1. View the full list of settings specified for the cluster:

      ```bash
      {{ yc-mdb-gp }} cluster get <cluster ID or name>
      ```

   1. View a description of the CLI's update cluster configuration command:

      ```bash
      {{ yc-mdb-gp }} cluster update-config --help
      ```

   1. Set the required parameter values:

      All supported parameters are listed in the [request format for the update method](../api-ref/Cluster/update.md), in the `greenplumConfig_<{{ GP }} version>` field. To specify a parameter name in the CLI call, convert the name from <q>lowerCamelCase</q> to <q>snake_case</q>. For example, the `maxConnections` parameter from an API call must be converted to `max_connections` for the CLI command:

      ```bash
      {{ yc-mdb-gp }} cluster update-config <cluster ID or name> \
         --set <parameter1 name>=<value1>,<parameter2 name>=<value2>,...
      ```

      {{ mgp-short-name }} runs the update cluster settings operation.

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * New settings in the `configSpec.greenplumConfig_<version>` parameter.
   * List of cluster configuration fields to be changed in the `updateMask` parameter.

      {% include [note-api-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

## {% if audience != "internal" %}Increasing{% else %}Modifying{% endif %} storage size {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs %}

- Management console

   To {% if audience != "internal" %}increase{% else %}modify{% endif %} a cluster's storage size:

   1. In the [management console]({{ link-console-main }}), select the folder with the desired cluster.
   1. Select **{{ mgp-name }}**.
   1. Select the desired cluster.
   1. At the top of the page, click **Edit cluster**.
   1. Edit the settings in the **Storage** section.
   1. Click **Save changes**.

- API

   To {% if audience != "internal" %}increase{% else %}modify{% endif %} a cluster's storage size, use the API [update](../api-ref/Cluster/update.md) method and pass in the call:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
   * New master and segment host storage size in the `masterConfig.resources.diskSize` and `segmentConfig.resources.diskSize` parameters.
   * List of cluster configuration fields to update in the `UpdateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
