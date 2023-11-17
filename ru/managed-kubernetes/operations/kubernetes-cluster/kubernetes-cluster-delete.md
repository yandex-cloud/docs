---
title: "Как удалить кластер {{ k8s }}"
description: "Следуя данной инструкции, вы сможете удалить кластер {{ k8s }}."
---

# Удаление кластера {{ k8s }}

{% note alert %}

{% include [about-cluster-delete](../../../_includes/managed-kubernetes/note-k8s-cluster-delete.md) %}

{% endnote %}

{% include [yc-cluster-list](../../../_includes/managed-kubernetes/cluster-list.md) %}

{% list tabs %}

- Консоль управления

  1. Откройте раздел **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}** в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), где требуется удалить [кластер {{ k8s }}](../../concepts/index.md#kubernetes-cluster).
  1. Нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) в строке кластера {{ k8s }}, который требуется удалить.
  1. В открывшемся меню нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.k8s.clusters.popup-confirm_button_delete }}**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Удалите кластер {{ k8s }}:

     ```bash
     yc managed-kubernetes cluster delete test-k8s-cluster
     ```

     Результат:

     ```bash
     done
     ```

  1. Проверьте, что кластер {{ k8s }} действительно удален:

     ```bash
     yc managed-kubernetes cluster list
     ```

     Результат:

     ```bash
     +----+------+------------+--------+--------+-------------------+-------------------+
     | ID | NAME | CREATED AT | HEALTH | STATUS | EXTERNAL ENDPOINT | INTERNAL ENDPOINT |
     +----+------+------------+--------+--------+-------------------+-------------------+
     +----+------+------------+--------+--------+-------------------+-------------------+
     ```

- {{ TF }}

  {% include [terraform-delete-mdb-cluster](../../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

- API

  Чтобы удалить кластер {{ k8s }}, воспользуйтесь методом [delete](../../api-ref/Cluster/delete.md) для ресурса [Cluster](../../api-ref/Cluster/).

{% endlist %}