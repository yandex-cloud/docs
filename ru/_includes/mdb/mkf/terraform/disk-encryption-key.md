Чтобы зашифровать диски [пользовательским ключом KMS](../../../../kms/concepts/key.md), добавьте параметр `disk_encryption_key_id`:

```hcl
resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
    ...
    disk_encryption_key_id = <идентификатор_ключа_KMS>
    ...
}
```

Подробнее о шифровании дисков см. в разделе [Хранилище](../../../../managed-kafka/concepts/storage.md#disk-encryption).
