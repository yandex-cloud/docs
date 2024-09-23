---
title: "How to delete a {{ k8s }} cluster"
description: "Follow this guide to delete a {{ k8s }} cluster."
---

# Deleting a {{ k8s }} cluster

{% note alert %}

{% include [about-cluster-delete](../../../_includes/managed-kubernetes/note-k8s-cluster-delete.md) %}

{% endnote %}

{% include [yc-cluster-list](../../../_includes/managed-kubernetes/cluster-list.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}** in the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you want to delete the [{{ k8s }}](../../concepts/index.md#kubernetes-cluster) cluster from.
  1. Click the ![image](../../../_assets/console-icons/ellipsis.svg) icon in the row of the {{ k8s }} cluster to be deleted.
  1. In the menu that opens, click **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.k8s.clusters.popup-confirm_button_delete }}**.

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

  1. Make sure that the {{ k8s }} cluster was deleted:

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

  To delete a {{ k8s }} cluster, use the [delete](../../api-ref/Cluster/delete.md) method for the [Cluster](../../api-ref/Cluster/) resource.

{% endlist %}