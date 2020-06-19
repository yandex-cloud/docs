---
editable: false
---
# Quotas and limits

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

#### Quotas {#quotas}

VMs that make up {{ dataproc-name }} service clusters utilize your cloud quotas for {{ compute-full-name }}.

#### Limits {#limits}

| Type of limit | Value |
| ----- | ----- |
| Minimum host configuration | b1.small ([20%](../../compute/concepts/performance-levels.md) × 2 vCPU Intel Broadwell, 4 GB RAM) |
| Maximum host configuration | m2.6xlarge (48 vCPU, 384 GB RAM) |
| Maximum number of hosts per subcluster | 32 |
| Maximum storage capacity for a cluster | 4096 GB |

