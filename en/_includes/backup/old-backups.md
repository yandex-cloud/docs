When reconnecting, the VM is added to {{ backup-name }} as a new resource. Backups of the new VM are stored as per the linked [backup policy](../../backup/concepts/policy.md#retention).

The backup policy rules do not apply to the old VM's backups. Their storage is subject to the [pricing policy](../../backup/pricing.md#backups). If you do not need those backups, [delete](../../backup/operations/backup-vm/delete.md) them manually or use [bulk delete](../../backup/operations/backup-vm/batch-delete.md).
