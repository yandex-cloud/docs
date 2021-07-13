# Deleting a cluster

{% include [backups-stored](../../_includes/mdb/backups-stored.md) %}

{% list tabs %}

- Management console
  1. Open the folder page in the management console.
  1. Select **{{ mch-name }}**.
  1. Click ![image](../../_assets/options.svg) for the necessary cluster and select **Delete**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a cluster, run the command:

  ```
  $ {{ yc-mdb-ch }} cluster delete <cluster name or ID>
  ```

  The cluster name and ID can be requested with a [list of clusters in the folder](list-clusters).

- Terraform

  {% include [terraform-delete-mdb-cluster](../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

{% endlist %}

