---
title: Удаление группы узлов на серверах {{ baremetal-name }}
description: Удалите группу узлов на серверах {{ baremetal-name }} из кластера {{ managed-k8s-name }} через консоль управления.
---

# Удаление группы узлов на серверах {{ baremetal-name }}

{% note info %}

Создавать, изменять и удалять группы узлов на серверах {{ baremetal-name }} можно только в консоли управления.

{% endnote %}

Чтобы удалить [группу узлов](../../concepts/index.md#node-group) на серверах {{ baremetal-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите]({{ link-console-main }}/link/managed-kubernetes) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Выберите кластер {{ managed-k8s-name }}.
  1. Перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_cluster-overview }}** и выберите раздел **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}**.
  1. В строке группы типа ![objects-align-justify-horizontal](../../../_assets/console-icons/objects-align-justify-horizontal.svg) **{{ ui-key.yacloud.k8s.cluster.node-groups.label_type-baremetal }}** нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление.
  1. [Откажитесь](../../../baremetal/operations/servers/server-lease-cancel.md) от продления аренды серверов {{ baremetal-name }}, которые входили в группу узлов. После отказа от аренды серверы проработают до конца оплаченного периода, а затем будут удалены.

{% endlist %}
