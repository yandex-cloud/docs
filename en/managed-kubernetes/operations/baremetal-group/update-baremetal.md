---
title: Updating a node group on {{ baremetal-name }} servers
description: Update the name or node count of a node group on {{ baremetal-name }} servers.
---

# Updating a node group on {{ baremetal-name }} servers

{% note info %}

You can create, modify, and delete node groups on {{ baremetal-name }} servers only via the management console.

{% endnote %}

You can change the name and node count in a node group on {{ baremetal-name }} servers. When scaling a group up, make sure servers with the required configuration are available in the selected [pool](../../../baremetal/concepts/servers.md#server-pools).

When scaling a group down, the service automatically stops renewing the rent for servers removed from the group. You do not need any separate action to cancel the rent. After the paid period ends, servers are [quarantined](../../../baremetal/concepts/servers.md#quarantine) and then deleted from the folder.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select the {{ managed-k8s-name }} cluster.
  1. Go to the **{{ ui-key.yacloud.k8s.cluster.switch_cluster-overview }}** tab and select the **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}** section.
  1. In the ![objects-align-justify-horizontal](../../../_assets/console-icons/objects-align-justify-horizontal.svg) **{{ ui-key.yacloud.k8s.cluster.node-groups.label_type-baremetal }}** group row, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
  1. Change the name or **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.field_node-count }}**.
  1. Save your changes.

{% endlist %}
