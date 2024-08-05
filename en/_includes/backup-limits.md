#### Quotas {#backup-quotas}

| Type of limit | Value |
--- | ---
| Number of virtual machines connected to {{ backup-name }} per cloud^1^ | 50 |
| Total size of backups per cloud | 10 TB |

^1^ To consider a virtual machine connected to {{ backup-name }}, it has to be linked to at least one [backup policy](../backup/concepts/policy.md). If the quota is exceeded, you will not be able to link new VMs to backup policies.