# Release channels and updates

{{ managed-k8s-name }} provides [updates](#updates) through [release channels](#release-channels).

The service supports three {{ k8s }} versions. Master and node group versions are independent, and you can specify different {{ k8s }} versions available within a single release channel when creating them.

{% include [note-about-version](../../_includes/managed-kubernetes/note-about-version.md) %}

## Release channels {#release-channels}

When creating a {{ k8s }} cluster, you specify one of three release channels. You can't change the channel once the {{ k8s }} cluster is created, you can only recreate the {{ k8s }} cluster and specify a new release channel.

The table below describes release channels and contains up-to-date information about supported {{ k8s }} versions.

| Channel | {{ k8s }} versions | Automatic updates | Channel description |
| ---- | ---- | ---- | ---- |
| `rapid` | 1.14, 1.15, 1.16 | Can't disable automatic updates. Can specify a time period for automatic updates. | Contains the latest versions of {{ k8s }}. Minor updates with new functions and improvements are often added. |
| `regular` | 1.13, 1.14, 1.15 | Can disable automatic updates. | Contains different versions of {{ k8s }}. New functions and improvements are added in chunks shortly after they appear on `rapid`. |
| `stable` | 1.13, 1.14, 1.15 | Can disable automatic updates. | Contains the stable {{ k8s }} versions. Only updates related to bug fixes or security improvements are added. |

## Updates {#updates}

When an update appears on a release channel, the corresponding information is displayed in the management console. You can install updates automatically or manually.

- Automatic updates are installed in the specified period of time with no interaction from the user.

    Updates are triggered and should be completed within the specified period. In some cases, when updating a node group, an update may continue beyond such period.

    Automatic updates include: new {{ managed-k8s-name }} functions, improvements, and fixes, as well as {{ k8s }} component fixes.

    {% note alert %}

    If [{{ k8s }} version support ends](#unsupported), minor {{ k8s }} versions get updated as well.

    {% endnote %}

- Manual updates can be initiated by the user at any time.

    These include {{ k8s }} minor version updates.

Read more about [{{k8s}} version support termination](#unsupported) and the [cluster component update {{ k8s }}](#cluster-upd) process.

### Version support termination {{ k8s }} {#unsupported}

When an old {{ k8s }} versions is no longer supported after an update:

- The master is automatically updated even if automatic updates are disabled.
- Node groups are automatically updated if automatic updates are enabled. If automatic updates are disabled, the old {{ k8s }} versions remains on the node groups. In this case, the user is fully responsible for solving problems related to the node group, since the old {{ k8s }} versions is deprecated.

### Updating cluster components in {{ k8s }} {#cluster-upd}

The update process is different for [masters](#master) and [node groups](#node-group).

#### Masters {#master}

Depending on the type of master, it may or may not be available during an update:

- Zonal masters are unavailable during updates.
- Regional masters remain available during updates.

#### Node groups {#node-group}

You can update node groups with additional resources by creating nodes with a new configuration.

{% note important %}

For an update to be successful, you need enough quotas to create a new node with additional resources.

{% endnote %}

Update process:

1. An updated node is created with the configuration specified for the entire node group.

1. All pods are moved from one of the old nodes, which is then deleted.

    {% note important %}

    A pod can only be moved if it was created by one of the application replication controllers: [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/), [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/), or [StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/). If a pod is created without a controller, it's lost during the update.

    {% endnote %}

1. The process is repeated until all nodes in the node group are updated.

This ensures that the number of nodes in the node group never falls below the number specified when the group is created.

