#### What should I do if I lose some of my data during a {{ k8s }} version upgrade? {#backups-update}

Your data will not get lost as {{ managed-k8s-name }} creates a data backup prior to [upgrading the {{ k8s }} version](../../managed-kubernetes/concepts/release-channels-and-updates.md). You can manually configure [cluster backup in {{ objstorage-full-name }}](../../managed-kubernetes/tutorials/kubernetes-backup.md). We also recommend using the application's native features to back up your databases.

#### Can I configure a backup for a {{ k8s }} cluster? {#cluster-backups}

{{ yandex-cloud }} provides secure storage and replication for data in [{{ managed-k8s-name }} clusters](../../managed-kubernetes/concepts/index.md#kubernetes-cluster). However, you can back up data from your [{{ managed-k8s-name }} cluster node groups](../../managed-kubernetes/concepts/index.md#node-group) at any time and store it in [{{ objstorage-name }}](../../storage/) or other types of storage.

For more information, see [{#T}](../../managed-kubernetes/tutorials/kubernetes-backup.md).

#### Will my resources be unavailable while {{ k8s }} is going through a version upgrade? {#downtime-update}

When a [master](../../managed-kubernetes/concepts/index.md#master) is going through an upgrade, control plane resources will experience downtime. For this reason, operations like [creating](../../managed-kubernetes/operations/node-group/node-group-create.md) or [deleting](../../managed-kubernetes/operations/node-group/node-group-delete.md) a [{{ managed-k8s-name }} node group](../../managed-kubernetes/concepts/index.md#node-group) will be unavailable. Still, the application will continue serving user requests.

If `max_expansion` is greater than zero, {{ managed-k8s-name }} creates new nodes when upgrading node groups. The system moves all workloads to the new nodes and deletes the old node groups. The downtime in this case equals the time it takes for a [pod](../../managed-kubernetes/concepts/index.md#pod) to restart when moved to the new {{ managed-k8s-name }} node group.

#### Can I upgrade my {{ managed-k8s-name }} cluster in one step? {#upgrade-in-one-step}

It depends on the source and target versions of the {{ managed-k8s-name }} cluster upgrade. In one step, you can only upgrade your {{ managed-k8s-name }} cluster to the next minor version from the current one. Upgrading to newer versions is done in multiple steps, e.g., 1.19 → 1.20 → 1.21. For details, see [{#T}](../../managed-kubernetes/operations/update-kubernetes.md#cluster-upgrade).

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

Check the installed version and [CSI for {{ objstorage-name }} settings](../../managed-kubernetes/operations/volumes/s3-csi-integration.md). Use a [supported driver](https://github.com/yandex-cloud/k8s-csi-s3) and follow its installation guide. Upgrading an individual `csi-attacher` component is not a universal solution for the error.

If the issue persists, [create a support ticket]({{ link-console-support }}). Specify the cluster ID, the time the error occurred, and the diagnostic results.

#### How to use {{ certificate-manager-name }} certificates in applications in {{ managed-k8s-name }}? {#application-certificate}

The connection method depends on the application and the controller that terminates your TLS connection. For an [{{ alb-name }} Ingress controller](../../managed-kubernetes/alb-ref/ingress.md), you can specify a {{ certificate-manager-name }} certificate in the Ingress configuration.

If an application requires a certificate as a file, [export the certificate](../../certificate-manager/operations/managed/cert-get-content.md) from {{ certificate-manager-name }} and configure the application to use it. Note that a one-time export does not provide for updating the file within the application when the certificate is reissued; you must set up a separate procedure for such updates.

#### How do I set a time zone for an application or CronJob? {#timezone}

For an application, configure bringing the time to the desired time zone within the application itself.

For a CronJob, specify the time zone in the `.spec.timeZone` field, e.g., `Europe/Moscow`. If this field is not set, the schedule is interpreted according to the _kube-controller-manager_ time zone. Learn more about [CronJob time zones](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/#time-zones).

If your particular case still requires changing the time zone of the node itself, you can [create a support ticket]({{ link-console-support }}). Specify the cluster ID and describe your use case.
