{% list tabs %}

- Prices per hour

   | Resource | Price per hour,<br>without VAT | Price with CVoS for 6 months,<br>without VAT | Price with CVoS for 1 year,<br>without VAT |
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
   | 100% vCPU | {{ sku|USD|mdb.cluster.opensearch.highfreq-v3.cpu.c100|string }}  | - | - |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.opensearch.highfreq-v3.ram|string }} | - | - |

- Prices per month

   | Resource | Price per hour,<br>without VAT | Price with CVoS for 6 months,<br>without VAT | Price with CVoS for 1 year,<br>without VAT |
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
   | 100% vCPU | {{ sku|USD|mdb.cluster.opensearch.highfreq-v3.cpu.c100|month|string }} | - | - |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.opensearch.highfreq-v3.ram|month|string }} | - | - |

{% endlist %}

### Storage {#prices-storage}

{% include [local-ssd for Intel Ice Lake only on request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service | Price of 1 GB per month,<br>without VAT |
|---------------------------------|----------------------------------------------------------------------------:|
| Network HDD storage | {{ sku|USD|mdb.cluster.network-hdd.opensearch|month|string }} |
| Non-replicated SSD storage | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.opensearch|month|string }} |
| Network SSD storage | {{ sku|USD|mdb.cluster.network-nvme.opensearch|month|string }} |
| High-performance SSD storage | {{ sku|USD|mdb.cluster.network-ssd-io-m3.opensearch|month|string }} |
| Local SSD storage | {{ sku|USD|mdb.cluster.local-nvme.opensearch|month|string }} |
| Backups beyond the storage size | {{ sku|USD|mdb.cluster.opensearch.backup|month|string }} |
