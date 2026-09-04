---
title: How to delete a {{ k8s }} cluster
description: Follow this guide to delete a {{ k8s }} cluster.
---

# Deleting a {{ k8s }} cluster

{% note alert %}

{% include [about-cluster-delete](../../../_includes/managed-kubernetes/note-k8s-cluster-delete.md) %}

{% endnote %}

{% include [yc-cluster-list](../../../_includes/managed-kubernetes/cluster-list.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to delete a [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster), open the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}** section.
  1. Click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) in the row with the {{ managed-k8s-name }} cluster to delete and select ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, confirm the cluster deletion.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Delete the {{ k8s }} cluster:

     ```bash
     yc managed-kubernetes cluster delete test-k8s-cluster
     ```

     Result:

     ```text
     done
     ```

  1. Make sure the {{ k8s }} cluster was deleted:

     ```bash
     yc managed-kubernetes cluster list
     ```

     Result:

     ```text
     +----+------+------------+--------+--------+-------------------+-------------------+
     | ID | NAME | CREATED AT | HEALTH | STATUS | EXTERNAL ENDPOINT | INTERNAL ENDPOINT |
     +----+------+------------+--------+--------+-------------------+-------------------+
     +----+------+------------+--------+--------+-------------------+-------------------+
     ```

- {{ TF }} {#tf}

  {% include [terraform-delete-mdb-cluster](../../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

- API {#api}

  To delete a {{ k8s }} cluster, use the [delete](../../managed-kubernetes/api-ref/Cluster/delete.md) REST API method for the [Cluster](../../managed-kubernetes/api-ref/Cluster/) resource or the [ClusterService/Delete](../../managed-kubernetes/api-ref/grpc/Cluster/delete.md) gRPC API call.

{% endlist %}
