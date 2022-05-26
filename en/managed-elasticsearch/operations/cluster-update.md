---
title: Changing Elasticsearch cluster settings
description: 'After creating the cluster, you can change the host class settings, increase the storage size, or change additional settings for the Elasticsearch cluster.'
keywords:
  - Elasticsearch settings
  - Elasticsearch cluster settings
  - Elasticsearch
---

# Changing cluster settings

After creating a cluster, you can:

* [{#T}](#change-service-account).
* [{#T}](#change-resource-preset).
* [{#T}](#change-disk-size){% if audience != "internal" %} (not available for [storage](../concepts/storage.md) on non-replicated SSD disks){% endif %}.
* [{#T}](#change-admin-password).
* [{#T}](#change-additional-settings).

You can also update the {{ ES }} version or edition. For more information, see [{#T}](./cluster-version-update.md).

## Changing service account settings {#change-service-account}

{% list tabs %}

- Management console
    1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mes-name }}**.
    1. Select the cluster and click **Edit** in the top panel.

    {% if audience != "internal" %}
    1. Select the desired service account from the list or [create a new one](../../iam/operations/sa/create.md). For more information about setting up service accounts, see [{#T}](s3-access.md).

    {% else %}
    1. Select the desired service account from the list or create a new one. For more information about setting up service accounts, see [{#T}](s3-access.md).

   {% endif %}

        {% include [mdb-service-account-update](../../_includes/mdb/service-account-update.md) %}

{% endlist %}

## Changing the host class {#change-resource-preset}

{% list tabs %}

- Management console
  1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mes-name }}**.
  1. Select the cluster and click **Edit** in the top panel.
  1. To change the class of {{ ES }} hosts with the *Data node* role:
     1. Go to the **Data node** tab.
     1. Under **Host class**, select the desired class for the host.
  1. To change the class of {{ ES }} hosts with the *Master node* role:
     1. Go to the **Master node** tab.
     1. Under **Host class**, select the desired class for the host.
  1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the [host class](../concepts/instance-types.md) for the cluster:

   1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-es }} cluster update --help
      ```

   1. Set the desired host class with the _Data node_ and _Master node_ roles in the update cluster command:

        ```bash
        {{ yc-mdb-es }} cluster update <cluster name or ID> \
          --datanode-resource-preset <host class with Data node role> \
          --masternode-resource-preset <host class with Master node role>
        ```

   You can request a cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Host class in the parameters:
      * `configSpec.elasticsearchSpec.dataNode.resources.resourcePresetId` (for hosts with the *Data node* role).
      * `configSpec.elasticsearchSpec.masterNode.resources.resourcePresetId` (for hosts with the *Master node* role).
   * The list of settings to update in the `updateMask` parameter. If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.

   To request a list of supported values, use the [list](../api-ref/ResourcePreset/list.md) method for `ResourcePreset` resources.

{% endlist %}

## {% if audience != "internal" %}Increase{% else %}Change{% endif %} the storage size {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs %}

- Management console

  To {% if audience != "internal" %}increase{% else %}change{% endif %} the storage size for the cluster:
  1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mes-name }}**.
  1. Select the cluster and click **Edit** in the top panel.
  1. To {% if audience != "internal" %}increase{% else %}change{% endif %} the disk size for the {{ ES }} *Data node* hosts:
     1. Go to the **Data node** tab.
     1. Under **Storage**, specify the disk size.
  1. To {% if audience != "internal" %}increase{% else %}change{% endif %} the disk size for {{ ES }} *Master node* hosts:
     1. Go to the **Master node** tab.
     1. Under **Storage**, specify the disk size.
  1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To {% if audience != "internal" %}increase{% else %}change{% endif %} the storage size for the cluster:

   1. View a description of the CLI update configuration command:

      ```bash
      {{ yc-mdb-es }} cluster update --help
      ```

   1. Specify new [storage settings](../concepts/storage.md) for hosts with the _Data node_ and _Master node_ roles in the update cluster command:

        ```bash
        {{ yc-mdb-es }} cluster update <cluster name or ID> \
          --datanode-disk-size <storage size in gigabytes for Data node hosts> \
          --masternode-disk-size <storage size in gigabytes for hosts with the Master node role> \
        ```

   You can request a cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% if api != "noshow" %}

- API

  To {% if audience != "internal" %}increase{% else %}change{% endif %} the storage size for a cluster, use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
  * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  * Required storage size (in bytes) in the parameters:
    * `configSpec.elasticsearchSpec.dataNode.resources.diskSize` (for hosts with the *Data node* role).
    * `configSpec.elasticsearchSpec.masterNode.resources.diskSize`  (for hosts with the *Master node* role).
  * The list of settings to update in the `updateMask` parameter. If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.

{% endif %}

{% endlist %}

## Changing the admin password {#change-admin-password}

{% list tabs %}

- Management console
  1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mes-name }}**.
  1. Select the cluster and click **Edit** in the top panel.
  1. Enter a new password for `admin` in the **User** section.
  1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the `admin` password for a cluster:

   1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-es }} cluster update --help
      ```

   1. Specify a new password in the cluster update command using one of the available methods:

      * Entering a password in interactive mode.

         ```bash
         {{ yc-mdb-es }} cluster update <cluster name> \
           --read-admin-password
         ```

      * Entering a password as plain text (less secure method).

         ```bash
         {{ yc-mdb-es }} cluster update <cluster name> \
           --admin-password <new password>
         ```

      * Generating a password automatically. The generated password will be output to the console.

         ```bash
         {{ yc-mdb-es }} cluster update <cluster name> \
           --generate-admin-password
         ```

   {{ mes-short-name }} will launch the `admin` password update for a cluster.

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * The new password in the `configSpec.adminPassword` parameter. The maximum password length is 128 characters.
   * The list of settings to update in the `updateMask` parameter. If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mes-name }}**.

    1. Select the cluster and click **Edit** in the top panel.

    1. To change the service account used to work with the cluster, select an account from the drop-down list.

    1. Change additional cluster settings:

      {% include [extra-settings](../../_includes/mdb/mes/extra-settings.md) %}

    1. Specify the DBMS settings:

        You can configure the `Fielddata cache size` parameter. It sets the percentage or absolute value of the dynamic memory area allocated for the `fielddata` cache, for example: 10% or 512 MB.

    1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-es }} cluster update --help
      ```

    1. Run the command with a list of settings to update:

        ```bash
        {{ yc-mdb-es }} cluster update <cluster name or ID> \
           --plugins <name of plugin 1>,...,<name of plugin N> \
           --maintenance-window type=<type of maintenance: anytime or weekly>,`
                               `day=<day of the week for the weekly type>,`
                               `hour=<hour of the day for the weekly type> \
           --deletion-protection=<protect cluster from deletion: true or false>
        ```

    You can change the following settings:

    * `--plugins`: A list of [{{ ES }} plugins](cluster-extensions.md#elasticsearch) available in the cluster. In this case, plugins that are not included in the list will be disabled.

    * {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window.md) %}

    * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

   {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

   You can find out the cluster ID and name in the [list of clusters in the folder](cluster-list.md#list-clusters).

- API

    Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
    * The cluster ID in the `clusterId` parameter. To get the ID, [get the list of clusters in the folder](./cluster-list.md#list-clusters).
    * A list of [{{ ES }} plugins](cluster-extensions.md#elasticsearch) in the `plugins` list.

    {% if audience != "internal" %}
    * The ID of the [service account](../../iam/concepts/users/service-accounts.md) used for cluster operations in the `serviceAccountId` parameter.

    {% else %}
    * ID of the service account used for cluster operations in the `serviceAccountId` parameter.

    {% endif %}

    * {% include [maintenance-window](../../_includes/mdb/api/maintenance-window.md) %}

    * Cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

   * The list of settings to update in the `updateMask` parameter. If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.

   {% note warning %}

   This API method resets any cluster settings that aren't passed explicitly in the request to their defaults. To avoid this, be sure to pass the names of the fields to be changed in the `updateMask` parameter.

   {% endnote %}

{% endlist %}

