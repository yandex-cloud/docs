#### Quotas {#backup-quotas}


#|
|| Type of limit | Value ||
|| Number of virtual machines connected to {{ backup-name }} per cloud^1^
`backup.vms.count` | 50 ||
|| Number of {{ baremetal-name }} servers connected to {{ backup-name }} per cloud^1^ 
`backup.bmservers.count` | 20 ||
|| Total size of backups per cloud 
`backup.storage.size` | 10 TB ||
|#

^1^ A virtual machine or {{ baremetal-name }} server is considered connected to {{ backup-name }} if it is associated with at least one [backup policy](../backup/concepts/policy.md). If the quota is exceeded, you will not be able to associate new VMs and {{ baremetal-name }} servers with backup policies.