#### What should I do if I lose some of my data during a {{ k8s }} version upgrade? {#backups-update}

Your data will not get lost as {{ managed-k8s-name }} creates a data backup prior to [upgrading the {{ k8s }} version](../../managed-kubernetes/concepts/release-channels-and-updates.md). You can manually configure [cluster backup in {{ objstorage-full-name }}](../../managed-kubernetes/tutorials/kubernetes-backup.md). We also recommend using the application's native features to back up your databases.

#### Can I configure a backup for a {{ k8s }} cluster? {#cluster-backups}

{{ yandex-cloud }} provides secure storage and replication for data in [{{ managed-k8s-name }} clusters](../../managed-kubernetes/concepts/index.md#kubernetes-cluster). However, you can back up data from your [{{ managed-k8s-name }} cluster node groups](../../managed-kubernetes/concepts/index.md#node-group) at any time and store it in [{{ objstorage-name }}](../../storage/) or other types of storage.

For more information, see [{#T}](../../managed-kubernetes/tutorials/kubernetes-backup.md).

#### Will my resources be unavailable while {{ k8s }} is going through a version upgrade? {#downtime-update}

When a [master](../../managed-kubernetes/concepts/index.md#master) is going through an upgrade, control plane resources will experience downtime. For this reason, operations like [creating](../../managed-kubernetes/operations/node-group/node-group-create.md) or [deleting](../../managed-kubernetes/operations/node-group/node-group-delete.md) a [{{ managed-k8s-name }} node group](../../managed-kubernetes/concepts/index.md#node-group) will be unavailable. Still, the application will continue serving user requests.

If `max_expansion` is greater than zero, {{ managed-k8s-name }} creates new nodes when upgrading node groups. The system moves all workloads to the new nodes and deletes the old node groups. The downtime in this case equals the time it takes for a [pod](../../managed-kubernetes/concepts/index.md#pod) to restart when moved to the new {{ managed-k8s-name }} node group.

#### Can I upgrade my {{ managed-k8s-name }} cluster in one step? {#upgrade-in-one-step}

It depends on the source and target versions of the {{ managed-k8s-name }} cluster upgrade. In one step, you can only upgrade your {{ managed-k8s-name }} cluster to the next minor version from the current one. Upgrading to newer versions is done in multiple steps, e.g., 1.19 → 1.20 → 1.21. For more information, see [{#T}](../../managed-kubernetes/operations/update-kubernetes.md#cluster-upgrade).

If you want to skip intermediate versions, [create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) of the version you need and migrate the workloads from the old cluster to the new one.

#### Is the Container Network Interface plugin upgraded together with the {{ managed-k8s-name }} cluster? {#upgrade-cni}

Yes. If you are using the [Calico](../../managed-kubernetes/concepts/network-policy.md#calico) and [Cilium](../../managed-kubernetes/concepts/network-policy.md#cilium) controllers, they are upgraded along with your {{ managed-k8s-name }} cluster. To upgrade your {{ managed-k8s-name }} cluster, do one of the following:
* [Create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) of the version you need and migrate the workloads from the old cluster to the new one.
* [Upgrade your {{ managed-k8s-name }} cluster manually](../../managed-kubernetes/operations/update-kubernetes.md#cluster-manual-upgrade).

To get timely {{ managed-k8s-name }} cluster version upgrades, [set up auto upgrading](../../managed-kubernetes/operations/update-kubernetes.md#cluster-auto-upgrade).

#### Can I send you a YAML configuration file so that you apply it to my cluster? {#configs}

No. You can use a `kubeconfig` file to apply the YAML file with cluster configuration on your own.

#### Can you install Web UI Dashboard, Rook, and other tools? {#install-tools}

No. You can install all the required tools on your own.

#### What should I do if volumes fail to attach after a {{ k8s }} upgrade? {#pvc}

If you get the following error after a {{ k8s }} upgrade:

```text
AttachVolume.Attach failed for volume "pvc":
Attach timeout for volume yadp-k8s-volumes/pvc
```

Update the [s3-CSI driver](https://github.com/ctrox/csi-s3) to the latest version.
