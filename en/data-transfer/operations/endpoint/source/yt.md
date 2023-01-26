# Configuring a YT source endpoint

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, configure access to YT.

* Settings for connecting to a [YT cluster](#cluster). These are required parameters.
* [Additional settings](#additional-settings).

## Cluster {#cluster}

{% list tabs %}

- Management console

   * **YT cluster**: Name of the YT source cluster, for example, HAHN, ARNOLD, or FREUD.

   * **Token**: YT token with read table permissions.

   * **Tables and directories**: Paths to data tables. To add a new path, click **+ Path** and enter the value.

{% endlist %}

## Advanced settings {#additional-settings}

{% list tabs %}

- Management console

   * **Name of the column for string indexing**: Number of the string from the original YT table. It is used to verify data and ensure no duplication.

{% endlist %}

