#### Quotas {#datasphere-quotas}

Type of limit | Value
--- | ---
Number of [projects](../datasphere/concepts/project.md) per [community](../datasphere/concepts/community.md) | 50
Total [dataset](../datasphere/concepts/dataset.md) size per community | 1,024 GB
Number of datasets per community | 10
Number of Docker images per community | 3
Project [storage](../datasphere/concepts/project.md#storage) size ([can be increased per project](../datasphere/operations/projects/storage-resize.md)) | 10 GB
Number of communities linked to a single [billing account](../billing/concepts/billing-account.md) | 100
Number of communities per [organization](../organization/) | 10
**VM usage restrictions** |
c1.32 ^1^ | 0
c1.80 ^2^ | 0
g1.4 ^1^ | 0
g2.1 ^1^ | 0
g2.2 ^1^ | 0
g2.4 ^1^ | 0
g2.8 ^2^ | 0
gt4.1 ^1^ | 0

^1^ To increase this quota, top up your billing account by at least $10 or create a request to support.

^2^ Quota increase is available for businesses only on a case-by-case basis.

#### Limits {#datasphere-limits}

Type of limit | Value
--- | ---
Maximum project storage size | 4,096 GB
Maximum dataset size | 4,096 GB
Number of datasets concurrently connected to a project | 3
Maximum data size per job | 10 GB
Maximum size of each job file | 5 GB
Maximum size of each log file in a job | 100 MB
Total size of files available for download via {{ ds-cli }} | 1 GB
Maximum job data size per community | 10 TB