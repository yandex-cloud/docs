# Managing extensions {{ ES }}

User extensions are any text data (dictionaries of words, word breaks, and so on), keys for integration with other clusters, and other data for cluster performance. For more information, see the [{{ ES }} documentation](https://www.elastic.co/guide/en/cloud/current/ec-plugins-guide.html).

## Retrieving a list of installed user extensions {#list}

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of cluster extensions, run the command:

   ```bash
   {{ yc-mdb-es }} extensions list <cluster ID or name>
   ```

   You can find out the cluster ID and name in the [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   Use the [list](../api-ref/Extension/list) API method and pass the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID [with a list of clusters in a folder](cluster-list.md#list-clusters).

{% endlist %}

## Adding user extensions {#add}

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

   {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API

   Use the [create](../api-ref/Extension/create) API method and pass the following information in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * The extension name in the `name` parameter.
   * The [link](../../storage/operations/objects/link-for-download.md) to a zip archive to extension files in {{ objstorage-full-name }} in the `uri` parameter. You can [configure](./s3-access.md) access to {{ objstorage-full-name }} using your service account.
   * The status of the user extension in the `disabled` parameter. Once added, it can be disabled with the `true` value and enabled with the `false` value.

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

   Use the [update](../api-ref/Extension/update) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * ID of the user extension in the `extensionId` parameter. To get the ID, [retrieve a list of installed user extensions](#list).
   * The status of the user extension in the `active` parameter: `true` — enabled, `false` — disabled.

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

   Use the [delete](../api-ref/Extension/delete) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * ID of the user extension in the `extensionId` parameter. To get the ID, [retrieve a list of installed user extensions](#list).

{% endlist %}
