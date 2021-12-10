---
title: "Deleting SQL Server clusters"
description: "After deleting a SQL Server database cluster, its backups are preserved and can be used for recovery within 7 days. To restore a deleted cluster from a backup, you will need its ID, so save the cluster ID in a safe place before deleting."
---

# Deleting clusters

## Before deleting a cluster {#before-you-delete}

* [Disable deletion protection](update.md#change-additional-settings) for the cluster if it is enabled.

* [Save the cluster ID](cluster-list.md#list-clusters).

  {% include [backups-stored](../../_includes/mdb/backups-stored.md) %}

## Deleting the cluster {#delete}

{% list tabs %}

- Management console
  1. Open the folder page in the management console.
  1. Select **{{ mms-name }}**.
  1. Click ![image](../../_assets/options.svg) for the cluster and select **Delete cluster**.
  1. Confirm cluster deletion and click **Delete**.

- Terraform

    {% include [terraform-delete-mdb-cluster](../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

- API

  Use the API [delete](../api-ref/Cluster/delete.md) method: transmit the requisite cluster ID in the `clusterId` parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

