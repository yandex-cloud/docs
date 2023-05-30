#### Quotas {#dataproc-quotas}

VMs that make up {{ dataproc-name }} service clusters utilize your {{ compute-full-name }} cloud [quotas]({{ link-console-quotas }}).

#### Limits {#dataproc-limits}

Type of limit | Value
--- | ---
Minimum host configuration | b2.medium (2 × [50%](../../compute/concepts/performance-levels.md) vCPU Intel Cascade Lake, 4 GB RAM)
Maximum host configuration | s3-c96-m576 (96 vCPU Intel Ice Lake, 576 GB RAM)
Maximum number of hosts per subcluster | 32
Maximum storage capacity for a host when using network HDD (`network-hdd`) or network SSD (`network-ssd`) | 4096 GB
Maximum storage capacity for a host when using network non-replicated SSD (`network-ssd-nonreplicated`) | 262074 GB