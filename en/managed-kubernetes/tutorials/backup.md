# {{ managed-k8s-name }} cluster backups in {{ objstorage-name }}

Data in [{{ managed-k8s-name }} clusters](../concepts/index.md#kubernetes-cluster) are securely stored and replicated within the {{ yandex-cloud }} infrastructure. However, you can back up data from [{{ managed-k8s-name }} cluster node groups](../concepts/index.md#node-group) at any time and store them in [{{ objstorage-full-name }}](../../storage/) or other types of storage.

You can create backups of {{ managed-k8s-name }} cluster node group data using the [Velero](https://velero.io/) tool. It supports working with {{ yandex-cloud }} [disks](../../compute/concepts/disk.md) using the {{ k8s }} CSI driver and helps create [snapshots of disks](../../compute/concepts/snapshot.md) and [volumes](../concepts/volume.md).

{% note tip %}

When working with Velero, you can use [nfs](https://kubernetes.io/docs/concepts/storage/volumes/#nfs), [emptyDir](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir), [local](https://kubernetes.io/docs/concepts/storage/volumes/#local), or any other type of volumes without built-in support for snapshots. To use such a volume type, install Velero with the [restic plugin](https://velero.io/docs/v1.8/restic/).

{% endnote %}

In this article, you will learn how to create a backup of a {{ k8s }} cluster node group using Velero, save it in {{ objstorage-name }}, and restore it in a node group in a different cluster:
1. [Create a node group backup](#backup).
1. [Recover a node group of another cluster from a backup](#restore).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-you-begin}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Select the [Velero client](https://github.com/vmware-tanzu/velero/releases) of version `1.8.1` or lower for your platform.
1. Download the Velero client, extract the contents of the archive, and install it. For more information about installation, see the [Velero documentation](https://velero.io/docs/v1.5/basic-install/#install-the-cli).
1. View a description of any Velero command:

   ```bash
   velero --help
   ```

1. [Create a bucket](../../storage/operations/buckets/create.md) {{ objstorage-name }}:
   * **Name**: `velero-backup`.
   * **Storage class**: `Standard`.
1. [Create a service account](../../iam/operations/sa/create.md):
   * **Name**: `velero-sa`.
   * **Folder roles**: `compute.admin`.
1. Grant the `velero-sa` service account **READ and WRITE** privileges for the `velero-backup` bucket. To do this, [configure the bucket ACL](../../storage/operations/buckets/edit-acl.md).
1. Create a [static access key](../../iam/concepts/authorization/access-key.md) for the `velero-sa` service account:

   ```bash
   yc iam access-key create --service-account-name velero-sa
   ```

   Result:

   ```bash
   access_key:
     id: abcdo12h3j04odg56def
     service_account_id: ajego12h3j03slk16upe
     created_at: "2020-10-19T13:22:29Z"
     key_id: <key ID>
   secret: <secret key value>
   ```

   {% note info %}

   Save the secret key ID and value. You will not be able to get the key value again.

   {% endnote %}

1. Create a file named `credentials` with the previously received static key data:

   ```ini
   [default]
     aws_access_key_id=<key ID>
     aws_secret_access_key=<secret key value>
   ```

## Backups {#backup}

To back up cluster group data:
1. [Create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration. When creating the node group, select automatic IP assignment.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Install the Velero server in the {{ managed-k8s-name }} cluster:

   ```bash
   kubectl label volumesnapshotclasses.snapshot.storage.k8s.io yc-csi-snapclass \
   velero.io/csi-volumesnapshot-class="true" && \
   velero install \
     --backup-location-config s3Url=https://{{ s3-storage-host }},region={{ region-id }} \
     --bucket velero-backup \
     --plugins velero/velero-plugin-for-aws:v1.3.0,velero/velero-plugin-for-csi:v0.2.0 \
     --provider aws \
     --secret-file ./credentials \
     --features=EnableCSI \
     --use-volume-snapshots=true \
     --snapshot-location-config region={{ region-id }}
     --use-restic
   ```

   Where:
   * `--backup-location-config`: Backup storage parameters. URL of {{ objstorage-name }} storage and region.
   * `--bucket`: Name of the backup storage bucket.
   * `--plugins`: Plugin images for AWS API compatibility.
   * `--provider`: Name of the object storage provider.
   * `--secret-file`: Full path to static access key data.
   * `--features`: List of active functionalities.
   * `--snapshot-location-config`: Availability zone where disk snapshots will be located.
   * (Optional) `--use-restic`: Enables the restic plugin.

   Result:

   ```text
   CustomResourceDefinition/backups.velero.io: attempting to create resource
   CustomResourceDefinition/backups.velero.io: already exists, proceeding
   CustomResourceDefinition/backups.velero.io: created
   ...
   Velero is installed! ⛵ Use 'kubectl logs deployment/velero -n velero' to view the status.
   ```

1. Make sure the Velero pod status has changed to `Running`:

   ```bash
   kubectl get pods -n velero
   ```

1. Back up data from the {{ managed-k8s-name }} cluster node group:

   ```bash
   velero backup create my-backup
   ```

   Result:

   ```text
   Backup request "my-backup" submitted successfully.
   Run `velero backup describe my-backup` or `velero backup logs my-backup` for more details.
   ```

1. Wait for the backup to complete. The value displayed in the `STATUS` field will be `Completed`.

   ```bash
   velero backup get
   ```

   Result:

   ```text
   NAME       STATUS     ERRORS  WARNINGS  CREATED                        EXPIRES  STORAGE LOCATION  SELECTOR
   my-backup  Completed  0       0         2020-10-19 17:13:25 +0300 MSK  29d      default           <none>
   ```

## Restoring data from backups {#restore}

To restore data from the {{ managed-k8s-name }} cluster node group:
1. [Create a new {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration. When creating the node group, select automatic IP assignment.
1. [Configure kubectl](../../managed-kubernetes/operations/connect/index.md#kubectl-connect) to work with the new cluster.
1. Install the Velero server in the {{ managed-k8s-name }} cluster:

   ```bash
   kubectl label volumesnapshotclasses.snapshot.storage.k8s.io yc-csi-snapclass \
   velero.io/csi-volumesnapshot-class="true" && \
   velero install \
     --backup-location-config s3Url=https://{{ s3-storage-host }},region={{ region-id }} \
     --bucket velero-backup \
     --plugins velero/velero-plugin-for-aws:v1.3.0,velero/velero-plugin-for-csi:v0.2.0 \
     --provider aws \
     --secret-file ./credentials \
     --features=EnableCSI \
     --use-volume-snapshots=true \
     --snapshot-location-config region={{ region-id }}
     --use-restic
   ```

   Where:
   * `--backup-location-config`: Backup storage parameters. URL of {{ objstorage-name }} storage and region.
   * `--bucket`: Name of the backup storage bucket.
   * `--plugins`: Plugin images for AWS API compatibility.
   * `--provider`: Name of the object storage provider.
   * `--secret-file`: Full path to static access key data.
   * `--features`: List of active functionalities.
   * `--snapshot-location-config`: Select the availability zone to host disk snapshots.
   * (Optional) `--use-restic`: Enables the restic plugin.

   Result:

   ```text
   CustomResourceDefinition/backups.velero.io: attempting to create resource
   CustomResourceDefinition/backups.velero.io: already exists, proceeding
   CustomResourceDefinition/backups.velero.io: created
   ...
   Velero is installed! ⛵ Use 'kubectl logs deployment/velero -n velero' to view the status.
   ```

1. Make sure the Velero pod status has changed to `Running`:

   ```bash
   kubectl get pods -n velero
   ```

1. Make sure the data backup is displayed in the new cluster:

   ```bash
   velero backup get
   ```

   Result:

   ```text
   NAME       STATUS     ERRORS  WARNINGS  CREATED                        EXPIRES  STORAGE LOCATION  SELECTOR
   my-backup  Completed  0       0         2020-10-19 17:13:25 +0300 MSK  29d      default           <none>
   ```

1. Restore data from the backup:

   ```bash
   velero restore create my-restore --exclude-namespaces velero --from-backup my-backup
   ```

   Where:
   * `--exclude-namespaces`: Parameter that allows users not to restore objects from the `velero` namespace.
   * `--from-backup`: Name of the bucket where the backup is stored.

   Result:

   ```text
   Restore request "my-restore" submitted successfully.
   Run `velero restore describe my-restore` or `velero restore logs my-restore` for more details.
   ```

1. Wait for the backup restoration to complete. The value displayed in the `STATUS` field will be `Completed`.

   ```bash
   velero get restore
   ```

   Result:

   ```text
   NAME        BACKUP     STATUS     STARTED                        COMPLETED                      ERRORS  WARNINGS  CREATED                        SELECTOR
   my-restore  my-backup  Completed  2020-10-20 14:04:55 +0300 MSK  2020-10-20 14:05:22 +0300 MSK  0       23        2020-10-20 14:04:55 +0300 MSK  <none>
   ```

## Delete the resources you created {#clear-out}

If you no longer need these resources, delete them:
1. [Delete the clusters {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. If you reserved public static IP addresses for the clusters, [delete them](../../vpc/operations/address-delete.md).
1. [Delete the bucket {{ objstorage-name }}](../../storage/operations/buckets/delete.md).
1. [Delete the service account](../../iam/operations/sa/delete.md) `velero-sa`.