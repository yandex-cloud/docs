# Deleting an {{ k8s }} cluster

{% note alert %}

{% include [about-cluster-delete](../../../_includes/managed-kubernetes/note-k8s-cluster-delete.md) %}

{% endnote %}

{% include [yc-cluster-list](../../../_includes/managed-kubernetes/cluster-list.md) %}

{% list tabs %}

- Management console

  1. Open **{{ managed-k8s-name }}** in the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you want to delete the [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster) from.
  1. Click ![image](../../../_assets/horizontal-ellipsis.svg) in the row of the {{ k8s }} cluster to delete.
  1. In the resulting menu, click **Delete**.
  1. In the window that opens, click **Delete**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Delete a {{ k8s }} cluster:

     ```bash
     yc managed-kubernetes cluster delete test-k8s-cluster
     ```

     Command result:

     ```bash
     done
     ```

  1. Make sure that the {{ k8s }} cluster was deleted:

     ```bash
     yc managed-kubernetes cluster list
     ```

     Command result:

     ```bash
     +----+------+------------+--------+--------+-------------------+-------------------+
     | ID | NAME | CREATED AT | HEALTH | STATUS | EXTERNAL ENDPOINT | INTERNAL ENDPOINT |
     +----+------+------------+--------+--------+-------------------+-------------------+
     +----+------+------------+--------+--------+-------------------+-------------------+
     ```

- {{ TF }}

  {% include [terraform-delete-mdb-cluster](../../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

- API

  To delete a {{ k8s }} cluster, use the [delete](../../api-ref/Cluster/delete.md) method for the [Cluster](../../api-ref/Cluster/) resource.

{% endlist %}