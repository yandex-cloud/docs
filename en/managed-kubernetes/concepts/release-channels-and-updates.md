---
title: Release channels
description: In this article, you will learn about release channels and how to update them.
---

# Release channels


{{ managed-k8s-name }} provides updates through release channels.

{{ managed-k8s-name }} supports three {{ k8s }} release channels. [Master](index.md#master) node and [{{ managed-k8s-name }} node group](index.md#node-group) versions are independent. You can specify different {{ k8s }} versions in a single release channel when creating them.

{% include [note-about-version](../../_includes/managed-kubernetes/note-about-version.md) %}

When creating a [{{ managed-k8s-name }} cluster](index.md#kubernetes-cluster), specify one of the below release channels. You cannot change the channel after the {{ managed-k8s-name }} cluster is created. You can only recreate the cluster and specify a new release channel.

Channel | Auto updates | Channel description
--- | --- | ---
`RAPID` | Auto updates cannot be disabled. You can specify a time period for auto updates. | A channel receives updates with new features and improvements first.
`REGULAR`| Auto updates can be disabled. | New features and improvements are added shortly after they appear on `RAPID`.
`STABLE`| Auto updates can be disabled. | New features and improvements are added shortly after they appear on `REGULAR`.

_For information on supported {{ k8s }} versions in channels, see [this page](./k8s-supported-versions.md)._

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

Read more about the [end of support for {{ k8s }}](#unsupported) versions and [how different {{ managed-k8s-name }}](#cluster-upd) cluster components are updated.

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

The {{ k8s }} version is [updated](../operations/update-kubernetes.md#node-group-upgrade) on group nodes in line with the [deploy policy](./node-group/deploy-policy.md). This policy applies not only during {{ k8s }} version upgrades but also when [editing](../operations/node-group/node-group-update.md) node group settings.

The cluster's behavior will vary depending on how the policy is configured:

{% include [deploy-policy-concept-behavior](../../_includes/managed-kubernetes/deploy-policy/concept-behavior.md) %}

For more information, see [{#T}](../operations/node-group/node-group-update.md#configure-deploy-policy).

#### Certificates {#certificates}

In accordance with the safety recommendations, [{{ managed-k8s-name }} cluster and node group certificates](https://kubernetes.io/docs/setup/best-practices/certificates/) are valid for one year. When a certificate expires, a {{ managed-k8s-name }} cluster or node group will be disabled. To avoid this, {{ managed-k8s-name }} automatically updates their certificates.
* If automatic updates are enabled, certificates are auto updated whenever a {{ managed-k8s-name }} cluster or node group updates.
* If automatic updates are disabled, a certificate update will be forced a week before they expire.

For more information about updating certificates, see [this {{ k8s }} guide](https://kubernetes.io/docs/tasks/tls/certificate-rotation/).

## Required update {#necessary-update}

All {{ managed-k8s-name }} release channels enforce required updates, such as replacements for outdated {{ k8s }} versions or critical updates for vulnerability patching. They may be installed both during and outside the update window.

If a cluster has a scheduled required update:

* You will get a [notification about a scheduled update](../../support/notify.md). Make sure you have set up your notification methods.
* On the cluster information page, you will see the **Mandatory update scheduled** section indicating the date.

{% note info %}

You can get information about a required cluster update via the API using the [get](../managed-kubernetes/api-ref/Cluster/get.md) method for the [Cluster](../managed-kubernetes/api-ref/Cluster/) resource in the `scheduledMaintenance` section.

{% endnote %}

Features of a required update:

* You cannot opt out of required updates.

* If the random update time mode is enabled in your cluster, {{ managed-k8s-name }} will initiate the update on its own schedule.

* If the cluster has no update window or the window is set for a specific time, by default, the required update will be installed after 14 days. You can reschedule the required update to an earlier date.

* If the cluster has an update window, this is when the required update will take place. However, if the cluster is unavailable at the time of the update, it will be applied during one of the next update windows.

* Stopped clusters will be updated during their update windows in the order defined by {{ managed-k8s-name }}.

For more information, see [Working with required updates](../operations/update-kubernetes.md#necessary-update).

### See also {#see-also}

* [{#T}](./k8s-supported-versions.md)
* [{#T}](../release-notes.md)
* [{{ k8s }} Release History](https://kubernetes.io/releases/)