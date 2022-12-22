# Configuring and updating

#### What do I do if some data gets lost after I update the {{ k8s }} version? {#backups-update}

Your data won't get lost: prior to [updating the {{ k8s }} version](../../managed-kubernetes/concepts/release-channels-and-updates.md) {{ managed-k8s-name }} creates a data backup. You can manually configure [cluster backup in {{ objstorage-full-name }}](../../managed-kubernetes/tutorials/backup.md). We also recommend backing up your database using the application tools.

#### Can I configure a backup for a {{ k8s }} cluster? {#cluster-backups}

Data in [{{ managed-k8s-name }} clusters](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) is stored securely and replicated within the {{ yandex-cloud }} infrastructure. However, you can back up data from [{{ k8s }} cluster node groups](../../managed-kubernetes/concepts/index.md#node-group) and store them in [{{ objstorage-full-name }}](../../storage/) or another storage anytime you want.

For more information, see [{#T}](../../managed-kubernetes/tutorials/backup.md).

#### Will resources be idle while the {{ k8s }} version? {#downtime-update} is updating?

When a [master](../../managed-kubernetes/concepts/index.md#master) is being updated, Control Plane resources will be idle. For this reason, operations like [node group](../../managed-kubernetes/concepts/index.md#node-group) [create](../../managed-kubernetes/operations/node-group/node-group-create.md) or [delete](../../managed-kubernetes/operations/node-group/node-group-delete.md) will be unavailable. User load on the application will continue to be processed.

If the `max_expansion` value is more than zero, new nodes are created after node groups are updated. All the load is transferred to new nodes, and the old node groups are deleted. In this case, idle time will be equal to the [pod](../../managed-kubernetes/concepts/index.md#pod) restart time when it's transferred to a new node group.

#### Can I send you a YAML configuration file so that you apply it to my cluster? {#configs}

No. You can a kubeconfig file to apply a YAML cluster configuration file on your own.

#### Can you install Web UI Dashboard, Rook, and other tools? {#install-tools}

No. You can install all the necessary tools on your own.