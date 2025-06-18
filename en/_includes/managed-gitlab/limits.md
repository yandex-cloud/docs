#### Quotas {#quotas}

#|
|| Type of limit | Value ||
|| Number of instances per cloud 
`managed-gitlab.instances.count` | 5 ||
|| Disk size | 500 GB ||
|| Number of managed runners per cloud
`managed-gitlab.runners.count` | 5 ||
|| Number of managed workers per cloud
`managed-gitlab.workers.count` | 10 ||
|#


#### Limits {#limits}

Type of limit | Minimum value | Maximum value
--- | --- | ---
Host class | s2.micro (2 vCPU, 8 GB RAM) | s2.large (16 vCPU, 64 GB RAM)
Disk size | 30 GB | 500 GB