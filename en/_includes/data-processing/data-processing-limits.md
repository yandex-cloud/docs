#### Quotas {#dataproc-quotas}

VMs that make up {{ dataproc-name }} clusters utilize your {{ compute-full-name }} cloud [quotas]({{ link-console-quotas }}).

#### Limits {#dataproc-limits}

Type of limit | Value
--- | ---
Minimum host configuration | b2.medium (2 × [50%](../../compute/concepts/performance-levels.md) vCPU Intel Cascade Lake, 4 GB RAM)
Maximum host configuration | m4a-c224-m1792 (224 vCPU AMD Zen 4, 1,792 GB RAM)
Maximum total number of subclusters | 12
Maximum number of hosts per subcluster | 32
Maximum storage capacity per host on network HDDs (`network-hdd`) or SSDs (`network-ssd`) | 4,096 GB
Maximum storage capacity per host on non-replicated network drives (`network-ssd-nonreplicated`) | 262,074 GB