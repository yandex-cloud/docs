---
title: How to manage {{ ES }} extensions
description: Follow this guide to learn how to manage {{ ES }} extensions.
---

# Managing {{ ES }} extensions

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

User extensions are any text data (dictionaries of words, word breaks, and so on), keys for integration with other clusters, and other data for cluster performance. For more information, see the [{{ ES }} documentation](https://www.elastic.co/guide/en/cloud/current/ec-plugins-guide.html).

## Retrieving a list of installed user extensions {#list}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of cluster extensions, run the following command:

    ```bash
    {{ yc-mdb-es }} extensions list --cluster-id <cluster_ID>
    ```

    You can [get](cluster-list.md#list-clusters) the cluster ID with a list of clusters in the folder.

- API {#api}

    To get a list of installed user extensions, use the [list](../api-ref/Extension/list.md) REST API method for the [Extension](../api-ref/Extension/index.md) resource or the [ExtensionService/List](../api-ref/grpc/Extension/list.md) gRPC API call, and provide the cluster ID in the `clusterId` request parameter.

    {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

{% endlist %}

## Adding or updating user extensions {#add}

{% note info %}

All extensions must be in TXT format and added to a ZIP archive.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To add or update a user extension, run this command:

    ```bash
    {{ yc-mdb-es }} extensions create --cluster-id <cluster_ID> \
       --name <extension_name> \
       --uri <URI_of_zip_archive_with_extension> \
       --disabled
    ```

    In the command, specify the following parameters:

    * `--cluster-id`: Cluster ID. You can [get it with a list of clusters in the folder](cluster-list.md#list-clusters).
    * `--name`: Extension name. If a previously added extension is specified, it is updated:

       * The extension version number is increased by one.
       * A new extension version is uploaded via the link in the `--uri` parameter and gets a new ID.


    * `--uri`: [Link](../../storage/operations/objects/link-for-download.md) to a ZIP archive with the extension files in {{ objstorage-full-name }}. You can [configure](./s3-access.md) access to {{ objstorage-full-name }} using your service account.


    * `--disabled`: User extension status. Provide this parameter to disable the new version of a user extension immediately after it is added or updated. Do not set this parameter to enable it. When the new extension version is enabled, the old one is disabled automatically.

- API {#api}

    To add or update a user extension, use the [create](../api-ref/Extension/create.md) REST API method for the [Extension](../api-ref/Extension/index.md) resource or the [ExtensionService/Create](../api-ref/grpc/Extension/create.md) gRPC API call and provide the following in the request:
    * Cluster ID in the `clusterId` parameter.

      {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

    * Extension name in the `name` parameter. If a previously added extension is specified, it is updated:

       * The extension version number is increased by one.
       * A new extension version is uploaded via the link in the `uri` parameter and gets a new ID.


    * [Link](../../storage/operations/objects/link-for-download.md) to a ZIP archive with the extension files in {{ objstorage-full-name }}, in the `uri` parameter. You can [configure](./s3-access.md) access to {{ objstorage-full-name }} using your service account.


    * User extension status in the `disabled` parameter. Once added, the extension will be disabled if `true` and enabled if `false`. When the new extension version is enabled, the old one is disabled automatically.

{% endlist %}

## Enabling or disabling user extensions {#update}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To enable or disable a user extension, run this command:

    ```bash
    {{ yc-mdb-es }} extensions update <extension_ID> \
       --cluster-id <cluster_ID> \
       --active
    ```

    You can get the cluster ID with a [list of folder clusters](cluster-list.md#list-clusters), and the extension ID, with a [list of cluster extensions](#list).

    To enable an extension, provide the `--active` parameter (to disable, do not provide it).

- API {#api}

    To enable or disable a user extension, use the [update](../api-ref/Extension/update.md) REST API method for the [Extension](../api-ref/Extension/index.md) resource or the [ExtensionService/Update](../api-ref/grpc/Extension/update.md) gRPC API call and provide the following in the request:

    * Cluster ID in the `clusterId` parameter.

      {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

    * ID of the user extension in the `extensionId` parameter. To get the ID, [retrieve a list of installed user extensions](#list).
    * User extension status in the `active` parameter (enabled if `true`, disabled if `false`).

{% endlist %}

## Deleting user extensions {#delete}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To delete an extension, run the command:

    ```bash
    {{ yc-mdb-es }} extensions delete <extension_ID> \
       --cluster-id <cluster_ID>
    ```

    You can get the cluster ID with a [list of folder clusters](cluster-list.md#list-clusters), and the extension ID, with a [list of cluster extensions](#list).

- API {#api}

    To delete a user extension, use the [delete](../api-ref/Extension/delete.md) REST API method for the [Extension](../api-ref/Extension/index.md) resource or the [ExtensionService/Delete](../api-ref/grpc/Extension/delete.md) gRPC API call and provide the following in the request:

    * Cluster ID in the `clusterId` parameter.

      {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}
      
    * ID of the user extension in the `extensionId` parameter. To get the ID, [retrieve a list of installed user extensions](#list).

{% endlist %}
