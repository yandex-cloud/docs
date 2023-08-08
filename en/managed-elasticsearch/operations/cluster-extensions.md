# Managing {{ ES }} extensions

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

User extensions are any text data (dictionaries of words, word breaks, and so on), keys for integration with other clusters, and other data for cluster performance. For more information, see the [{{ ES }} documentation](https://www.elastic.co/guide/en/cloud/current/ec-plugins-guide.html).

## Retrieving a list of installed user extensions {#list}

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of cluster extensions, run the following command:

   ```bash
   {{ yc-mdb-es }} extensions list <cluster ID or name>
   ```

   You can find out the cluster ID and name in the [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To get a list of installed user extensions, use the [list](../api-ref/Extension/list.md) REST API method for the [Extension](../api-ref/Extension/index.md) resource or the [ExtensionService/List](../api-ref/grpc/extension_service.md#List) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

{% endlist %}

## Adding user extensions {#add}

{% note info %}

All extensions must be in TXT format and added to a ZIP archive.

{% endnote %}

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add an extension to a cluster, run the command:

   ```bash
   {{ yc-mdb-es }} extensions create <cluster ID or name> \
      --name <extension name> \
      --uri <URI of zip archive with extension>
   ```

   You can retrieve the cluster ID and name in the [list of folder clusters](cluster-list.md#list-clusters), and the extension ID in the [list of cluster extensions](#list).

   
   To get a link to a zip archive with extension files in {{ objstorage-full-name }}, [follow the instructions](../../storage/operations/objects/link-for-download.md). You can [configure](./s3-access.md) access to {{ objstorage-full-name }} using your service account.


- API

   To add a user extension, use the [create](../api-ref/Extension/create.md) REST API method for the [Extension](../api-ref/Extension/index.md) resource or the [ExtensionService/Create](../api-ref/grpc/extension_service.md#Create) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter.

      {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

   * Extension name in the `name` parameter.

   
   * [Link](../../storage/operations/objects/link-for-download.md) to a ZIP archive with extension files in {{ objstorage-full-name }}, in the `uri` parameter. You can [configure](./s3-access.md) access to {{ objstorage-full-name }} using your service account.


   * Status of the user extension in the `disabled` parameter. Once added, it can be disabled with the `true` value and enabled with the `false` value.

{% endlist %}

## Enabling or disabling user extensions {#update}

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To enable or disable an extension, run the command:

   ```bash
   {{ yc-mdb-es }} extensions update <extension ID> \
      <cluster ID or name> \
      --active <extension status: true|false>
   ```

   You can retrieve the cluster ID and name in the [list of folder clusters](cluster-list.md#list-clusters), and the extension ID in the [list of cluster extensions](#list).

   To enable a user extension, pass `true` in the `--active` parameter, to disable one, pass `false`.

- API

   To enable or disable a user extension, use the [update](../api-ref/Extension/update.md) REST API method for the [Extension](../api-ref/Extension/index.md) resource or the [ExtensionService/Update](../api-ref/grpc/extension_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter.

      {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

   * ID of the user extension in the `extensionId` parameter. To get the ID, [retrieve a list of installed user extensions](#list).
   * Status of the user extension in the `active` parameter: `true` for enabled and `false` for disabled.
   * List of extension configuration fields to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Deleting user extensions {#delete}

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To delete an extension, run the command:

   ```bash
   {{ yc-mdb-es }} extensions delete <extension ID> \
      <cluster ID or name>
   ```

   You can retrieve the cluster ID and name in the [list of folder clusters](cluster-list.md#list-clusters), and the extension ID in the [list of cluster extensions](#list).

- API

   To delete a user extension, use the [delete](../api-ref/Extension/delete.md) REST API method for the [Extension](../api-ref/Extension/index.md) resource or the [ExtensionService/Delete](../api-ref/grpc/extension_service.md#Delete) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter.

      {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

   * ID of the user extension in the `extensionId` parameter. To get the ID, [retrieve a list of installed user extensions](#list).

{% endlist %}
