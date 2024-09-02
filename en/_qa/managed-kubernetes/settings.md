# Configuring and updating

#### What do I do if some data gets lost after I update the {{ k8s }} version? {#backups-update}

Your data will not get lost: prior to [updating the {{ k8s }} version](../../managed-kubernetes/concepts/release-channels-and-updates.md) {{ managed-k8s-name }} creates a data backup. You can manually configure [cluster backup in {{ objstorage-full-name }}](../../managed-kubernetes/tutorials/kubernetes-backup.md). We also recommend backing up your database using the application tools.

#### Can I configure a backup for a {{ k8s }} cluster? {#cluster-backups}

Data in [{{ managed-k8s-name }} clusters](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) is securely stored and replicated within the {{ yandex-cloud }} infrastructure. However, you can back up data from [{{ managed-k8s-name }} cluster node groups](../../managed-kubernetes/concepts/index.md#node-group) at any time and store them in [{{ objstorage-name }}](../../storage/) or other types of storage.

For more information, see [{#T}](../../managed-kubernetes/tutorials/kubernetes-backup.md).

#### Will resources be idle while the {{ k8s }} version is updating? {#downtime-update}

When a [master](../../managed-kubernetes/concepts/index.md#master) is being updated, Control Plane resources will be idle. For this reason, such operations as [{{ managed-k8s-name }} node group](../../managed-kubernetes/concepts/index.md#node-group) [create](../../managed-kubernetes/operations/node-group/node-group-create.md) or [delete](../../managed-kubernetes/operations/node-group/node-group-delete.md) will be unavailable. User load on the application will continue to be processed.

If the `max_expansion` value is greater than zero, new nodes are created when {{ managed-k8s-name }} node groups are updated. All the load is transferred to new nodes, and the old node groups are deleted. In this case, idle time will be equal to the [pod](../../managed-kubernetes/concepts/index.md#pod) restart time when it is transferred to a new {{ managed-k8s-name }} node group.

#### Can I update a {{ managed-k8s-name }} cluster in one step? {#upgrade-in-one-step}

It depends on the source and target version you want to migrate your {{ managed-k8s-name }} cluster from/to. You can only update your {{ managed-k8s-name }} cluster in a single step to the next minor version from the current one. Updating to newer versions is done in steps, e.g., 1.19 → 1.20 → 1.21. For more information, see [{#T}](../../managed-kubernetes/operations/update-kubernetes.md#cluster-upgrade).

If you want to skip interim versions, [create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) of the appropriate version and transfer the load from the old cluster to the new one.

#### Is the Container Network Interface plugin updated along with a {{ managed-k8s-name }} cluster? {#upgrade-cni}

Yes, it is. If you are using [Calico](../../managed-kubernetes/concepts/network-policy.md#calico) and [Cilium](../../managed-kubernetes/concepts/network-policy.md#cilium) controllers, they are updated along with your {{ managed-k8s-name }} cluster. To update your {{ managed-k8s-name }} cluster, do one of the following:
* [Create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) of the appropriate version and transfer the load from the old cluster to the new one.
* [Update your {{ managed-k8s-name }} cluster manually](../../managed-kubernetes/operations/update-kubernetes.md#cluster-manual-upgrade).

To make sure the current {{ managed-k8s-name }} cluster version is updated on time, [set up automatic updates](../../managed-kubernetes/operations/update-kubernetes.md#cluster-auto-upgrade).

#### Can I send you a YAML configuration file so that you apply it to my cluster? {#configs}

No. You can use a kubeconfig file to apply a YAML cluster configuration file on your own.

#### Can you install Web UI Dashboard, Rook, and other tools? {#install-tools}

No. You can install all the necessary tools on your own.

#### What do I do if I cannot attach volumes after updating {{ k8s }}? {#pvc}

If the following error occurs after you update {{ k8s }}:

```text
AttachVolume.Attach failed for volume "pvc":
Attach timeout for volume yadp-k8s-volumes/pvc
```

Update the [s3-CSI driver](https://github.com/ctrox/csi-s3) to the latest version.