# Deleting clusters

{% note important %}

You cannot restore a DB cluster that has been deleted, because all the cluster's backups are removed with it.

{% endnote %}

{% list tabs %}

- Management console
  1. Open the folder page in the management console.
  1. Select **{{ mmg-name }}**.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) for the necessary cluster and select **Delete**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a cluster, run the command:

  ```
  $ yc managed-mongodb cluster delete <cluster name or ID>
  ```

  The cluster name and ID can be requested with a [list of clusters in the folder](list-clusters).

{% endlist %}

