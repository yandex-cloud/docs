---
title: Release channels
description: In this article, you will learn about release channels and how to update them.
---

# Release channels


{{ managed-k8s-name }} provides updates through release channels.

The service supports three {{ k8s }} release channels. [Master](index.md#master) node and [{{ managed-k8s-name }} node group](index.md#node-group) versions are independent; therefore, you can specify different {{ k8s }} versions from a single release channel when creating them.

{% include [note-about-version](../../_includes/managed-kubernetes/note-about-version.md) %}

When creating a [{{ managed-k8s-name }} cluster](index.md#kubernetes-cluster), specify one of the three release channels. You cannot change the channel after the {{ managed-k8s-name }} cluster is created. You can only recreate the cluster and specify a new release channel. The table below describes the release channels and supported {{ k8s }} versions.

Channel | {{ k8s }} versions | Auto updates | Channel description
--- | --- | --- | ---
`rapid`| {{ k8s-versions-rapid }} | Auto updates cannot be disabled. You can specify a time period for auto updates. | A channel receives updates with new features and improvements first.
`regular`| {{ k8s-versions-regular }} | Auto updates can be disabled. | New features and improvements are added shortly after they appear on `rapid`.
`stable`| {{ k8s-versions-stable }} | Auto updates can be disabled. | New features and improvements are added shortly after they appear on `regular`.

{% include [os-new-version](../../_includes/managed-kubernetes/note-os-new-version.md) %}

## Updates {#updates}

When a release channel receives an update, you get a notification in the management console. You can install updates automatically or manually.
* Auto updates are installed within the specified time period. They do not require any user actions.

  Updates are initiated and should be completed within this time period. In some cases, when updating a {{ managed-k8s-name }} node group, an update may continue beyond this period.

  Auto updates include new {{ managed-k8s-name }} features, improvements, and fixes, as well as {{ k8s }} component fixes.

* [Manual updates](../operations/update-kubernetes.md#cluster-manual-upgrade) can be initiated by the user at any time.

  They include {{ k8s }} minor version updates. Note that you can only update to one minor version at a time.
  
  > For example, from 1.31 to 1.32.

  The difference between the cluster and node group versions must not be more than two minor versions. The node group version cannot be higher than the cluster version.

  > For example, if the cluster version is 1.33, the node group version may be 1.33, 1.32, or 1.31

{% include [preflight-check](../../_includes/managed-kubernetes/preflight-check.md) %}

Read more about the [end of support for {{ k8s }} versions](#unsupported) and [how different {{ managed-k8s-name }} cluster components](#cluster-upd) are updated.

### End of support for a {{ k8s }} version {#unsupported}

When upgrading from a {{ k8s }} version that is no longer supported:
* The {{ managed-k8s-name }} master is not auto updated, you need to do it manually.
* Minor versions (e.g., 1.20 to 1.21) must be updated manually.
* {{ managed-k8s-name }} node groups are updated automatically if auto updates are enabled. If auto updates are disabled, the old version of {{ k8s }} remains on the {{ managed-k8s-name }} node groups. In this case, the user has to deal with any issues with their {{ managed-k8s-name }} node group on their own, since the old version of {{ k8s }} is no longer supported.

### Updating {{ k8s }} cluster components {#cluster-upd}

The update process is different for a [{{ managed-k8s-name }} master](#master) and a [node group](#node-group).

#### Master {#master}

The amount of time a {{ managed-k8s-name }} master is unavailable during an update depends on the master type:
* The basic master is unavailable during the update.
* The highly available master maintains network connectivity during the update.

For more information, see [Updating a cluster](../operations/update-kubernetes.md#cluster-upgrade).

#### Node group {#node-group}

You can update a {{ managed-k8s-name }} node group with additional resources allocated by creating nodes with a new configuration.

{% note warning %}

For a successful update with additional resources, you should have enough [quotas](limits.md) to create one additional {{ managed-k8s-name }} node.

{% endnote %}

The {{ managed-k8s-name }} node group update algorithm is as follows:
1. An updated node is created with the configuration specified for the entire {{ managed-k8s-name }} node group.
1. All the [pods](index.md#pod) are [evicted](node-group/node-drain.md) from one of the old {{ managed-k8s-name }} nodes based on the pre-defined `PodDisruptionBudgets` policy. Then the node is deleted.
1. The process is repeated until all the {{ managed-k8s-name }} nodes in the group are updated.

This ensures that the number of nodes in the group never falls below the number specified when creating a {{ managed-k8s-name }} node group.

You can specify the maximum number of [VM instances](../../compute/concepts/vm.md) by which you can expand or reduce the size of the {{ managed-k8s-name }} group when updating it. For more information, see [Updating a node group](../operations/update-kubernetes.md#node-group-upgrade).

#### Certificates {#certificates}

In accordance with the safety recommendations, [{{ managed-k8s-name }} cluster and node group certificates](https://kubernetes.io/docs/setup/best-practices/certificates/) are valid for one year. When a certificate expires, a {{ managed-k8s-name }} cluster or node group will be disabled. To avoid this, {{ managed-k8s-name }} automatically updates their certificates.
* If automatic updates are enabled, certificates are auto updated whenever a {{ managed-k8s-name }} cluster or node group updates.
* If automatic updates are disabled, a certificate update will be forced a week before they expire.

For more information about updating certificates, see [this {{ k8s }} guide](https://kubernetes.io/docs/tasks/tls/certificate-rotation/).
