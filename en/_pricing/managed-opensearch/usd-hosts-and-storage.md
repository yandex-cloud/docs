{% list tabs %}

- Prices per hour

   | Resource | Price per hour | Price with CVoS for 6 months | Price with CVoS for 1 year |
   |----------------|--------------------------------------------------------:|-------------------------------------------------------------------------------------:|-------------------------------------------------------------------------------------:|
   | **Intel Cascade Lake** |
   | 50% vCPU | {{ sku|USD|mdb.cluster.opensearch.v2.cpu.c50|string }} | — | — |
   | 100% vCPU | {{ sku|USD|mdb.cluster.opensearch.v2.cpu.c100|string }} | — | — |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.opensearch.v2.ram|string }} | — | — |
   | **Intel Ice Lake** |
   | 50% vCPU | {{ sku|USD|mdb.cluster.opensearch.v3.cpu.c50|string }} | — | — |
   | 100% vCPU | {{ sku|USD|mdb.cluster.opensearch.v3.cpu.c100|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.mdb.opensearch.cpu.c100.v3|string }} (-15%) | {{ sku|USD|v1.commitment.selfcheckout.y1.mdb.opensearch.cpu.c100.v3|string }} (-22%) |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.opensearch.v3.ram|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.mdb.opensearch.ram.v3|string }} (-15%) | {{ sku|USD|v1.commitment.selfcheckout.y1.mdb.opensearch.ram.v3|string }} (-22%) |
   | **Intel Ice Lake (Compute Optimized)** |
   | 100% vCPU | $0.021520 | - | - |
   | RAM (for 1 GB) | $0.006480 | - | - |

- Prices per month

   | Resource | Price per hour | Price with CVoS for 6 months | Price with CVoS for 1 year |
   |----------------|--------------------------------------------------------------:|-------------------------------------------------------------------------------------:|-------------------------------------------------------------------------------------------------:|
   | **Intel Cascade Lake** |
   | 50% vCPU | {{ sku|USD|mdb.cluster.opensearch.v2.cpu.c50|month|string }} | — | — |
   | 100% vCPU | {{ sku|USD|mdb.cluster.opensearch.v2.cpu.c100|month|string }} | — | — |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.opensearch.v2.ram|month|string }} | — | — |
   | **Intel Ice Lake** |
   | 50% vCPU | {{ sku|USD|mdb.cluster.opensearch.v3.cpu.c50|month|string }} | — | — |
   | 100% vCPU | {{ sku|USD|mdb.cluster.opensearch.v3.cpu.c100|month|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.mdb.opensearch.cpu.c100.v3|month|string }} (-15%) | {{ sku|USD|v1.commitment.selfcheckout.y1.mdb.opensearch.cpu.c100.v3|month|string }} (-22%) |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.opensearch.v3.ram|month|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.mdb.opensearch.ram.v3|month|string }} (-15%) | {{ sku|USD|v1.commitment.selfcheckout.y1.mdb.opensearch.ram.v3|month|string }} (-22%) |
   | **Intel Ice Lake (Compute Optimized)** |
   | 100% vCPU | $15.494400 | - | - |
   | RAM (for 1 GB) | $4.665600 | - | - |

{% endlist %}

### Storage {#prices-storage}

{% include [local-ssd for Intel Ice Lake only on request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service | Price of 1 GB per month |
|---------------------------------|----------------------------------------------------------------------------:|
| Network HDD storage | {{ sku|USD|mdb.cluster.network-hdd.opensearch|month|string }} |
| Non-replicated SSD storage | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.opensearch|month|string }} |
| Network SSD storage | {{ sku|USD|mdb.cluster.network-nvme.opensearch|month|string }} |
| High-performance SSD storage | $0.174240 |
| Local SSD storage | {{ sku|USD|mdb.cluster.local-nvme.opensearch|month|string }} |
| Backups beyond the storage size | $0.015360 |
