---
title: "Deleting MongoDB clusters"
description: "After deleting a MongoDB database cluster, its backups are preserved and can be used for recovery within 7 days. To restore a deleted cluster from a backup, you will need its ID, so save the cluster ID in a safe place before deleting."
---
# Deleting a cluster

## Before deleting a cluster {#before-you-delete}

* [Disable deletion protection](update.md#change-additional-settings) for the cluster if it is enabled.

* [Save the cluster ID](cluster-list.md#list-clusters).

  {% include [backups-stored](../../_includes/mdb/backups-stored.md) %}

## Deleting the cluster {#delete}

{% list tabs %}

- Management console
  1. Open the [folder page]({{ link-console-main }}) in the management console.
  1. Select **{{ mmg-name }}**.
  1. Click ![image](../../_assets/options.svg) for the necessary cluster and select **Delete**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a cluster, run the command:

  ```bash
  {{ yc-mdb-mg }} cluster delete <cluster name or ID>
  ```

  You can query the cluster ID and name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- Terraform

  {% include [terraform-delete-mdb-cluster](../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

{% endlist %}

