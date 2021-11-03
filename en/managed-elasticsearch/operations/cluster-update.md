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
* [{#T}](#change-disk-size) (available only for `network-hdd` standard network storage and `network-ssd` fast network storage).
* [{#T}](#change-admin-password).
* [{#T}](#update-additional-settings).

You can also update the {{ ES }} version or edition. For more information, see [{#T}](cluster-version-update.md).

## Changing service account settings {#change-service-account}

{% list tabs %}

- Management console

    1. Go to the folder page and select **{{ mes-name }}**.
    1. Select the cluster and click **Edit** in the top panel.
    1. Select the desired service account from the list or [create a new one](../../iam/operations/sa/create.md). For more information about setting up service accounts, see [{#T}](s3-access.md).

       {% include [mdb-service-account-update](../../_includes/mdb/service-account-update.md) %}

{% endlist %}


## Changing the host class {#change-resource-preset}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mes-name }}**.
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

  To change the [host class](../concepts/instance-types.md) for the cluster, use the [update](../api-ref/Cluster/update.md) method and pass the following in the request:
  * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  * Host class in the parameters:
    * `configSpec.elasticsearchSpec.dataNode.resources.resourcePresetId` (for hosts with the *Data node* role).
    * `configSpec.elasticsearchSpec.masterNode.resources.resourcePresetId` (for hosts with the *Master node* role).
  * The list of settings to update in the `updateMask` parameter. If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.

  To request a list of supported values, use the [list](../api-ref/ResourcePreset/list.md) method for the `ResourcePreset` resources.

{% endlist %}

## Increasing storage size {#change-disk-size}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mes-name }}**.
  1. Select the cluster and click **Edit** in the top panel.
  1. To increase the disk size for {{ ES }} hosts with the *Data node* role:
     1. Go to the **Data node** tab.
     1. Under **Storage**, specify the disk size.
  1. To increase the disk size for {{ ES }} hosts with the *Master node* role:
     1. Go to the **Master node** tab.
     1. Under **Storage**, specify the disk size.
  1. Click **Save**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To increase the storage size for a cluster:

    1. View a description of the CLI update configuration command:

        ```bash
        {{ yc-mdb-es }} cluster update --help
        ```

    1. Specify new [storage settings](../concepts/storage.md) for hosts with the _Data node_ and _Master node_ roles in the update cluster command:

        ```bash
        {{ yc-mdb-es }} cluster update <cluster name or ID> \
           --datanode-disk-size <storage size in gigabytes for hosts with the Data node role> \
           --masternode-disk-size <storage size in gigabytes for hosts with the Master node role> \
        ```

    You can request a cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).


- API

  To change the disk size for a cluster, use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
  * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  * Required disk size (in bytes) in the parameters:
    * `configSpec.elasticsearchSpec.dataNode.resources.diskSize` (for hosts with the *Data node* role).
    * `configSpec.elasticsearchSpec.masterNode.resources.diskSize`  (for hosts with the *Master node* role).
  * The list of settings to update in the `updateMask` parameter. If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.

{% endlist %}

## Changing the admin password {#change-admin-password}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mes-name }}**.
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

         ```
         {{ yc-mdb-es }} cluster update <cluster name> \
            --read-admin-password
         ```

       * Entering a password as plain text (less secure method).

         ```
         {{ yc-mdb-es }} cluster update <cluster name> \
            --admin-password <new password>
         ```

       * Generating a password automatically. The generated password will be output to the console.

         ```
         {{ yc-mdb-es }} cluster update <cluster name> \
            --generate-admin-password
         ```

    {{ mes-short-name }} will launch the `admin` password update for a cluster.

- API

  To update the `admin` password for a cluster, use the [update](../api-ref/Cluster/update.md) method and pass the following in the request:
  * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  * The new password in the `configSpec.adminPassword` parameter. The maximum password length is 128 characters.
  * The list of settings to update in the `updateMask` parameter. If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.

{% endlist %}

## Changing additional cluster settings {#update-additional-settings}

{% list tabs %}

- Management console
    1. Go to the folder page and select **{{ mes-name }}**.
    1. Select the cluster and click **Edit** in the top panel.
    1. To change the service account used to work with the cluster, select an account from the drop-down list.
    1. Click **Save**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. View a description of the CLI's update cluster command:

        ```bash
        {{ yc-mdb-es }} cluster update --help
        ```

    1. To change the list of [{{ ES }} plugins](../concepts/plugins.md) available in a cluster, pass the list in the `--plugins` argument of the CLI command. In this case, plugins that are not included in the list will be disabled.

        ```bash
        {{ yc-mdb-es }} cluster update <cluster name> \
           --plugins <list of plugins>
        ```

- API

    To edit an {{ ES }} cluster's advanced settings, use the [update](../api-ref/Cluster/update.md) method and pass the following information in your request:
    * The cluster ID in the `clusterId` parameter. To get the ID, [get the list of clusters in the folder](cluster-list.md#list-clusters).
    * The list of [{{ ES }} plugins](../concepts/plugins.md) in the `plugins` parameter.
    * The ID of the [service account](../../iam/concepts/users/service-accounts.md) used for cluster operations in the `serviceAccountId` parameter.
    * The list of settings to update in the `updateMask` parameter. If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.

{% endlist %}
