#### What should I do if I lose some of my data during a {{ k8s }} version upgrade? {#backups-update}

Your data will not get lost: {{ managed-k8s-name }} creates a data backup prior to a [{{ k8s }} version upgrade](../../managed-kubernetes/concepts/release-channels-and-updates.md). You can manually configure [cluster backup in {{ objstorage-full-name }}](../../managed-kubernetes/tutorials/kubernetes-backup.md). We also recommend backing up your database using the application tools.

#### Can I configure a backup for a {{ k8s }} cluster? {#cluster-backups}

The {{ yandex-cloud }} infrastructure provides secure storage and replication for data in [{{ managed-k8s-name }} clusters](../../managed-kubernetes/concepts/index.md#kubernetes-cluster). However, you can back up data from [{{ managed-k8s-name }} cluster node groups](../../managed-kubernetes/concepts/index.md#node-group) at any time and store them in [{{ objstorage-name }}](../../storage/) or other types of storage.

For more information, see [{#T}](../../managed-kubernetes/tutorials/kubernetes-backup.md).

#### Will the resources be idle while {{ k8s }} is going through a version upgrade? {#downtime-update}

When a [master](../../managed-kubernetes/concepts/index.md#master) is going through an upgrade, Control Plane resources will be idle. For this reason, operations like [creating](../../managed-kubernetes/operations/node-group/node-group-create.md) or [deleting](../../managed-kubernetes/operations/node-group/node-group-delete.md) a [{{ managed-k8s-name }} node group](../../managed-kubernetes/concepts/index.md#node-group) will be unavailable. The application's user load will continue to be processed.

If `max_expansion` is greater than zero, new nodes are created when upgrading {{ managed-k8s-name }} node groups. All load is diverted to the new nodes, and the old node groups get deleted. The idle time will be equal to [pod](../../managed-kubernetes/concepts/index.md#pod) restart time when transferred to a new {{ managed-k8s-name }} group.

#### Can I upgrade a {{ managed-k8s-name }} cluster in one step? {#upgrade-in-one-step}

It depends on the source and target version you want to migrate your {{ managed-k8s-name }} cluster from/to. You can only upgrade your {{ managed-k8s-name }} cluster in a single step to the next minor version from the current one. Upgrading to newer versions is done in steps, e.g.: 1.19 → 1.20 → 1.21. For more information, see [{#T}](../../managed-kubernetes/operations/update-kubernetes.md#cluster-upgrade).

If you want to skip interim versions, [create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) of the appropriate version and transfer the load from the old cluster to the new one.

#### Is the Container Network Interface plugin upgraded together with the {{ managed-k8s-name }} cluster? {#upgrade-cni}

Yes. If you are using [Calico](../../managed-kubernetes/concepts/network-policy.md#calico) and [Cilium](../../managed-kubernetes/concepts/network-policy.md#cilium) controllers, they are upgraded together with your {{ managed-k8s-name }} cluster. To upgrade your {{ managed-k8s-name }} cluster, do one of the following:
* [Create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) of the appropriate version and transfer the load from the old cluster to the new one.
* [Upgrade your {{ managed-k8s-name }} cluster manually](../../managed-kubernetes/operations/update-kubernetes.md#cluster-manual-upgrade).

To get timely {{ managed-k8s-name }} cluster version upgrades, [set up auto upgrading](../../managed-kubernetes/operations/update-kubernetes.md#cluster-auto-upgrade).

#### Can I send you a YAML configuration file so that you apply it to my cluster? {#configs}

No. You can use a kubeconfig file to apply a YAML cluster configuration file on your own.

#### Can you install Web UI Dashboard, Rook, and other tools? {#install-tools}

No. You can install all the necessary tools on your own.

#### What should I do if volumes refuse to connect after I upgrade {{ k8s }}? {#pvc}

If you get the following error after you upgrade {{ k8s }}:

```text
AttachVolume.Attach failed for volume "pvc":
Attach timeout for volume yadp-k8s-volumes/pvc
```

Upgrade the [s3-CSI driver](https://github.com/ctrox/csi-s3) to the latest version.
