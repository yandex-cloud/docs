---
title: Release channels
description: In this article, you will learn about release channels and how to update them.
---

# Release channels


{{ managed-k8s-name }} provides updates through release channels.

The service supports three {{ k8s }} release channels. [Master](index.md#master) node and [{{ managed-k8s-name }} node group](index.md#node-group) versions are independent; therefore, you can specify different {{ k8s }} versions from a single release channel when creating them.

{% include [note-about-version](../../_includes/managed-kubernetes/note-about-version.md) %}

When creating a [{{ managed-k8s-name }} cluster](index.md#kubernetes-cluster), specify one of the three release channels. You cannot change the channel after the {{ managed-k8s-name }} cluster is created, you can only recreate the cluster and specify a new release channel. The table below describes the release channels and contains up-to-date information about the supported {{ k8s }} versions.

Channel | {{ k8s }} versions | Automatic updates | Channel description
--- | --- | --- | ---
`rapid`| {{ k8s-versions-rapid }} | Automatic updates cannot be disabled. You can specify a time period for automatic updates. | Updates with new features and improvements are added to the channel first.
`regular`| {{ k8s-versions-regular }} | Automatic updates can be disabled. | New features and improvements are added shortly after they appear on `rapid`.
`stable`| {{ k8s-versions-stable }} | Automatic updates can be disabled. | New features and improvements are added shortly after they appear on `regular`.

## Updates {#updates}

When an update appears on a release channel, the corresponding information is displayed in the management console. You can install updates automatically or manually.
* Automatic updates are installed in the specified period of time with no user interaction.

  Updates are triggered and should be completed within the specified period. In some cases, when updating a {{ managed-k8s-name }} node group, an update may continue beyond this period.

  Automatic updates include new {{ managed-k8s-name }} functions, improvements, and fixes, as well as {{ k8s }} component fixes.

* [Manual updates](../operations/update-kubernetes.md#cluster-manual-upgrade) can be initiated by the user at any time.

  They include {{ k8s }} minor version updates.

Read more about [{{ k8s }} version support termination](#unsupported) and the [{{ managed-k8s-name }} cluster component update process](#cluster-upd).

### {{ k8s }} version support termination {#unsupported}

When upgrading from a deprecated {{ k8s }} version:
* The {{ managed-k8s-name }} master cannot be updated automatically, update it manually.
* Minor versions (e.g., from 1.20 to 1.21) must be updated manually.
* {{ managed-k8s-name }} node groups update automatically if automatic updates are enabled. If automatic updates are disabled, the old version of {{ k8s }} remains on the {{ managed-k8s-name }} node groups. In this case, the user is fully responsible for solving problems related to the {{ managed-k8s-name }} node group, since the old version of {{ k8s }} is deprecated.

### Updating {{ k8s }} cluster components {#cluster-upd}

The update process is different for a [{{ managed-k8s-name }} master](#master) and [node groups](#node-group).

#### Master {#master}


The amount of time a {{ managed-k8s-name }} master is unavailable during an update depends on the master type:
* Zonal masters are unavailable during the update.
* Regional masters keep running during the update.



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

This ensures that the number of nodes in the group never falls below the number specified when the {{ managed-k8s-name }} node group is created.

You can specify the maximum number of [VM instances](../../compute/concepts/vm.md) by which you can expand or reduce the size of the {{ managed-k8s-name }} group when updating it. For more information, see [Updating a node group](../operations/update-kubernetes.md#node-group-upgrade).

#### Certificates {#certificates}

In accordance with the safety recommendations, [{{ managed-k8s-name }} cluster and node group certificates](https://kubernetes.io/docs/setup/best-practices/certificates/) are valid for one year. When a certificate expires, a {{ managed-k8s-name }} cluster or node group will be disabled. To avoid this, {{ managed-k8s-name }} automatically updates their certificates.
* If automatic updates are enabled, certificates are updated automatically whenever a {{ managed-k8s-name }} cluster or node group updates.
* If automatic updates are disabled, a certificate update will be forced a week before they expire.

For more information about updating certificates, see the [{{ k8s }} documentation](https://kubernetes.io/docs/tasks/tls/certificate-rotation/).