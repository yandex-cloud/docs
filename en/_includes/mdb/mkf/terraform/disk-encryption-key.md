To encrypt disks with a [custom KMS key](../../../../kms/concepts/key.md), add the `disk_encryption_key_id` parameter:

```hcl
resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
    ...
    disk_encryption_key_id = <KMS_key_ID>
    ...
}
```

To learn more about disk encryption, see [Storage](../../../../managed-kafka/concepts/storage.md#disk-encryption).
