---
title: "Deleting PostgreSQL clusters"
description: "After deleting a PostgreSQL database cluster, its backups are preserved and can be used for recovery within 7 days. To restore a deleted cluster from a backup, you will need its ID, so save the cluster ID in a safe place before deleting."
---

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

