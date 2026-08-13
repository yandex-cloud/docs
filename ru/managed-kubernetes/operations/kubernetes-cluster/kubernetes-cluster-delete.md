---
title: Как удалить кластер {{ k8s }}
description: Следуя данной инструкции, вы сможете удалить кластер {{ k8s }}.
---

# Удаление кластера {{ k8s }}

{% note alert %}

{% include [about-cluster-delete](../../../_includes/managed-kubernetes/note-k8s-cluster-delete.md) %}

{% endnote %}

{% include [yc-cluster-list](../../../_includes/managed-kubernetes/cluster-list.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), где нужно удалить [кластер {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster), откройте раздел **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. В строке кластера {{ managed-k8s-name }}, который нужно удалить, нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне подтвердите удаление кластера.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Удалите кластер {{ k8s }}:

     ```bash
     yc managed-kubernetes cluster delete test-k8s-cluster
     ```

     Результат:

     ```text
     done
     ```

  1. Проверьте, что кластер {{ k8s }} действительно удален:

     ```bash
     yc managed-kubernetes cluster list
     ```

     Результат:

     ```text
     +----+------+------------+--------+--------+-------------------+-------------------+
     | ID | NAME | CREATED AT | HEALTH | STATUS | EXTERNAL ENDPOINT | INTERNAL ENDPOINT |
     +----+------+------------+--------+--------+-------------------+-------------------+
     +----+------+------------+--------+--------+-------------------+-------------------+
     ```

- {{ TF }} {#tf}

  {% include [terraform-delete-mdb-cluster](../../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

- API {#api}

  Чтобы удалить кластер {{ k8s }}, воспользуйтесь методом REST API [delete](../../managed-kubernetes/api-ref/Cluster/delete.md) для ресурса [Cluster](../../managed-kubernetes/api-ref/Cluster/) или вызовом gRPC API [ClusterService/Delete](../../managed-kubernetes/api-ref/grpc/Cluster/delete.md).

{% endlist %}
