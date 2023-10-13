Install the Velero server in the [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster):

```bash
kubectl label volumesnapshotclasses.snapshot.storage.k8s.io yc-csi-snapclass \
velero.io/csi-volumesnapshot-class="true" && \
velero install \
  --backup-location-config s3Url=https://{{ s3-storage-host }},region={{ region-id }} \
  --bucket <bucket name in {{ objstorage-name }}> \
  --plugins velero/velero-plugin-for-aws:v1.5.0,velero/velero-plugin-for-csi:v0.3.0 \
  --provider aws \
  --secret-file ./credentials \
  --features=EnableCSI \
  --use-volume-snapshots=true \
  --snapshot-location-config region={{ region-id }}
```

Where:
* `--backup-location-config`: Backup storage parameters. URL of [{{ objstorage-full-name }}](../../storage/) storage and region.
* `--bucket`: Name of the backup storage [bucket](../../storage/concepts/bucket.md).
* `--plugins`: Plugin images for AWS API compatibility.
* `--provider`: Name of the object storage provider.
* `--secret-file`: Full path to static access key data.
* `--features`: List of active functionalities.
* `--snapshot-location-config`: Region where [disk snapshots](../../compute/concepts/snapshot.md) will be located.

Result:

```text
CustomResourceDefinition/backups.velero.io: attempting to create resource
CustomResourceDefinition/backups.velero.io: already exists, proceeding
CustomResourceDefinition/backups.velero.io: created
...
Velero is installed! ⛵ Use 'kubectl logs deployment/velero -n velero' to view the status.
```

1. Make sure the Velero [pod](../../managed-kubernetes/concepts/index.md#pod) status has changed to `Running`:

   ```bash
   kubectl get pods -n velero
   ```
