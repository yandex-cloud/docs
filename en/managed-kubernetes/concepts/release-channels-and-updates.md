# Release channels

{{ managed-k8s-name }} provides updates through [release channels](#release-channels).

The service supports three {{ k8s }} release channels. Master and node group versions are independent and you can specify different versions of {{ k8s }} available within a single release channel when creating them.

{% include [note-about-version](../../_includes/managed-kubernetes/note-about-version.md) %}

When creating a {{ k8s }} cluster, specify one of three release channels. You can't change the channel once the {{ k8s }} cluster is created, you can only recreate the {{ k8s }} cluster and specify a new release channel. The table below describes release channels and contains up-to-date information about supported {{ k8s }} versions.

| Channel | {{ k8s }} versions | Automatic updates | Channel description |
--- | --- | --- | ---
| `rapid` | {{ k8s-versions-rapid }} | Can't disable automatic updates. Can specify a time period for automatic updates. | Contains the latest versions of {{ k8s }}. Minor updates with new functions and improvements are often added. |
| `regular` | {{ k8s-versions-regular }} | Can disable automatic updates. | Contains different versions of {{ k8s }}. New functions and improvements are added in chunks shortly after they appear on `rapid`. |
| `stable` | {{ k8s-versions-stable }} | Can disable automatic updates. | Contains the stable version of {{ k8s }}. Only updates related to bug fixes or security improvements are added to the channel. |

## Updates {#updates}

When an update appears on a release channel, the corresponding information is displayed in the management console. You can install updates automatically or manually.
* Automatic updates are installed in the specified period of time with no interaction from the user.

  Updates are triggered and should be completed within the specified period. In some cases, when updating a node group, an update may continue beyond such period.

  Automatic updates include: new {{ managed-k8s-name }} functions, improvements, and fixes, as well as {{ k8s }} component fixes.

  {% note alert %}

  If [{{ k8s }} version support ends](#unsupported), minor {{ k8s }} versions get updated as well.

  {% endnote %}

* Manual updates can be initiated by the user at any time.

  These include {{ k8s }} minor version updates.

Read more about [{{k8s}} version support termination](#unsupported) and the [{{ k8s }} cluster component update process](#cluster-upd).

### {{ k8s }} version support termination {#unsupported}

When an old version of {{ k8s }} is no longer supported after an update:
* The master can't be updated automatically, update it manually.
* Minor versions (for example, from 1.20 to 1.21) must be updated manually.
* Node groups are automatically updated if automatic updates are enabled. If automatic updates are disabled, the old version of {{ k8s }} remains on the node groups. In this case, the user is fully responsible for solving problems related to the node group, since the old version of {{ k8s }} is deprecated.

### Updating {{ k8s }} cluster components {#cluster-upd}

The update process is different for [masters](#master) and [node groups](#node-group).

#### Master {#master}

{% if product == "yandex-cloud" %}

The amount of time a master is unavailable during an update depends on the kind of master:
* Zonal masters are unavailable during the update.
* Regional masters keep running during the update.

{% endif %}

{% if product == "cloud-il" %}

Zonal masters are unavailable during the update.

{% endif %}

For more information, see [Updating a cluster](../operations/update-kubernetes.md#cluster-upgrade).

#### Node group {#node-group}

You can update node groups with additional resources by creating nodes with a new configuration.

{% note warning %}

For an update to be successful, you need enough [quotas](limits.md) to create a new node with additional resources.

{% endnote %}

Update node group algorithm:
1. An updated node is created with the configuration specified for the entire node group.
1. All pods are [evicted](node-group/node-drain.md) from one of the old nodes based on the pre-defined PodDisruptionBudgets policy. Then the node is deleted.
1. The process is repeated until all nodes in the group are updated.

This ensures that the number of nodes in the node group never falls below the number specified when the group is created.

You can specify the maximum number of instances by which you can expand or reduce the size of the group when updating it. For more information, see [Updating a node group](../operations/update-kubernetes.md#node-group-upgrade).

#### Certificates {#certificates}

In accordance with the safety recommendations, [cluster and node group certificates](https://kubernetes.io/docs/setup/best-practices/certificates/) are issued for a year. When a certificate expires, a cluster or node group is disabled. To avoid this, {{ managed-k8s-name }} automatically updates their certificates.
* If automatic updates are enabled, certificates are updated automatically at every cluster or node group update.
* If automatic updates are disabled, a certificate update will be forced a week before they expire.

For more information about updating certificates, see the [{{ k8s }} documentation](https://kubernetes.io/docs/tasks/tls/certificate-rotation/).