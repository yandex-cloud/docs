Установите серверную часть Velero в [кластер {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster):

```bash
kubectl label volumesnapshotclasses.snapshot.storage.k8s.io yc-csi-snapclass \
velero.io/csi-volumesnapshot-class="true" && \
velero install \
  --backup-location-config s3Url=https://{{ s3-storage-host }},region={{ region-id }} \
  --bucket <имя бакета в {{ objstorage-name }}> \
  --plugins velero/velero-plugin-for-aws:v1.5.0,velero/velero-plugin-for-csi:v0.3.0 \
  --provider aws \
  --secret-file ./credentials \
  --features=EnableCSI \
  --use-volume-snapshots=true \
  --snapshot-location-config region={{ region-id }}
```

Где:
* `--backup-location-config` — параметры хранилища резервных копий. URL-адрес хранилища [{{ objstorage-full-name }}](../../storage/) и регион.
* `--bucket` — имя [бакета](../../storage/concepts/bucket.md) для хранения резервных копий.
* `--plugins` — образы плагина для совместимости с AWS API.
* `--provider` — имя провайдера объектного хранилища.
* `--secret-file` — полный путь к файлу с данными статического ключа доступа.
* `--features` — список активных функциональных возможностей.
* `--snapshot-location-config` — регион, в котором будут размещены [снимки дисков](../../compute/concepts/snapshot.md).

Результат:

```text
CustomResourceDefinition/backups.velero.io: attempting to create resource
CustomResourceDefinition/backups.velero.io: already exists, proceeding
CustomResourceDefinition/backups.velero.io: created
...
Velero is installed! ⛵ Use 'kubectl logs deployment/velero -n velero' to view the status.
```

1. Убедитесь, что [под](../../managed-kubernetes/concepts/index.md#pod) Velero перешел в состояние `Running`:

   ```bash
   kubectl get pods -n velero
   ```