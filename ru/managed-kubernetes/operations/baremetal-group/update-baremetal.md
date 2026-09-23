---
title: Изменение группы узлов на серверах {{ baremetal-name }}
description: Измените имя или количество узлов группы на серверах {{ baremetal-name }} через консоль управления.
---

# Изменение группы узлов на серверах {{ baremetal-name }}

{% note info %}

Создавать, изменять и удалять группы узлов на серверах {{ baremetal-name }} можно только в консоли управления.

{% endnote %}

У группы узлов на серверах {{ baremetal-name }} можно изменить имя и количество узлов. При увеличении группы убедитесь, что в выбранном [пуле](../../../baremetal/concepts/servers.md#server-pools) доступны серверы нужной конфигурации.

При уменьшении группы сервис автоматически отказывается от продления аренды серверов, исключенных из группы. Отдельно отказываться от аренды не нужно. После окончания оплаченного периода серверы переходят в [карантин](../../../baremetal/concepts/servers.md#quarantine), а затем удаляются из каталога.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/managed-kubernetes) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Выберите кластер {{ managed-k8s-name }}.
  1. Перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_cluster-overview }}** и выберите раздел **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}**.
  1. В строке группы типа ![objects-align-justify-horizontal](../../../_assets/console-icons/objects-align-justify-horizontal.svg) **{{ ui-key.yacloud.k8s.cluster.node-groups.label_type-baremetal }}** нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Измените имя или **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.field_node-count }}**.
  1. Сохраните изменения.

{% endlist %}
