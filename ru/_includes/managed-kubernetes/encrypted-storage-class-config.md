```yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: <название_класса_хранилища>
provisioner: disk-csi-driver.mks.ycloud.io
volumeBindingMode: WaitForFirstConsumer
parameters:
  type: <тип_диска>
  csi.storage.k8s.io/fstype: ext4
  kmsKeyId: <идентификатора_симметричного_ключа>
allowVolumeExpansion: true
reclaimPolicy: Delete
```

Где:
* `metadata:name` — произвольное название класса хранилища.
* `parameters:type` — [тип диска](../../managed-kubernetes/concepts/volume.md#disks-types) в {{ compute-name }}. Возможные значения:
  * `network-ssd` — сетевой SSD-диск.
  * `network-hdd` — сетевой HDD-диск.
  * `network-ssd-nonreplicated` — нереплицируемый SSD-диск.
  * `network-ssd-io-m3` — сверхбыстрое сетевое хранилище с тремя репликами (SSD).
* `parameters:kmsKeyId` — идентификатор симметричного ключа.