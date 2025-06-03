#### Quotas {#backup-quotas}

Type of limitation | Value
--- | ---
Number of virtual machines connected to {{ backup-name }} per cloud^1^ | 50
Total size of backups per cloud | 10 TB

^1^ A virtual machine is considered connected to {{ backup-name }} if it is associated with at least one [backup policy](../backup/concepts/policy.md). If the quota is exceeded, you will not be able to associate new VMs with backup policies.