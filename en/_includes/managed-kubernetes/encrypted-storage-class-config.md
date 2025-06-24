```yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: <storage_class_name>
provisioner: disk-csi-driver.mks.ycloud.io
volumeBindingMode: WaitForFirstConsumer
parameters:
  type: <disk_type>
  csi.storage.k8s.io/fstype: ext4
  kmsKeyId: <symmetric_key_ID>
allowVolumeExpansion: true
reclaimPolicy: Delete
```

Where:
* `metadata:name`: Random storage class name.
* `parameters:type`: [Disk type](../../managed-kubernetes/concepts/volume.md#disks-types) in {{ compute-name }}. The possible values are:
  * `network-ssd`: Network SSD.
  * `network-hdd`: Network HDD.
  * `network-ssd-nonreplicated`: Non-replicated SSD.
  * `network-ssd-io-m3`: Ultra high-speed network storage with three replicas (SSD).
* `parameters:kmsKeyId`: Symmetric key ID.