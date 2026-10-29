---
title: Deleting a node group on {{ baremetal-name }} servers
description: Delete a node group on {{ baremetal-name }} servers from a {{ managed-k8s-name }} cluster via the management console.
---

# Deleting a node group on {{ baremetal-name }} servers

{% note info %}

You can create, modify, and delete node groups on {{ baremetal-name }} servers only via the management console.

{% endnote %}

When deleting a group, the service automatically cancels rent renewal for servers that belonged to the group. You do not need any separate action to cancel the rent. After the paid period ends, servers are [quarantined](../../../baremetal/concepts/servers.md#quarantine) and then deleted from the folder.

To delete a [node group](../../concepts/index.md#node-group) on {{ baremetal-name }} servers:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select the {{ managed-k8s-name }} cluster.
  1. Go to the **{{ ui-key.yacloud.k8s.cluster.switch_cluster-overview }}** tab and select the **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}** section.
  1. In the ![objects-align-justify-horizontal](../../../_assets/console-icons/objects-align-justify-horizontal.svg) **{{ ui-key.yacloud.k8s.cluster.node-groups.label_type-baremetal }}** group row, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. Confirm the deletion.

{% endlist %}
