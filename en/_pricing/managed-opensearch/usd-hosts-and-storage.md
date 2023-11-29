### Host computing resources {#prices-hosts}

{% list tabs %}

- Costs per hour

   | Resource | Cost per hour | Cost with CVoS for 6 months | Cost with CVoS for 1 year |
   |----------------|--------------------------------------------------------:|-------------------------------------------------------------------------------------:|-------------------------------------------------------------------------------------:|
   | **Intel Cascade Lake** |
   | 50% vCPU | {{ sku|USD|mdb.cluster.opensearch.v2.cpu.c50|string }} | — | — |
   | 100% vCPU | {{ sku|USD|mdb.cluster.opensearch.v2.cpu.c100|string }} | — | — |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.opensearch.v2.ram|string }} | — | — |
   | **Intel Ice Lake** |
   | 50% vCPU | {{ sku|USD|mdb.cluster.opensearch.v3.cpu.c50|string }} | — | — |
   | 100% vCPU | {{ sku|USD|mdb.cluster.opensearch.v3.cpu.c100|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.mdb.opensearch.cpu.c100.v3|string }} (-15%) | {{ sku|USD|v1.commitment.selfcheckout.y1.mdb.opensearch.cpu.c100.v3|string }} (-22%) |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.opensearch.v3.ram|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.mdb.opensearch.ram.v3|string }} (-15%) | {{ sku|USD|v1.commitment.selfcheckout.y1.mdb.opensearch.ram.v3|string }} (-22%) |

- Costs per month

   | Resource | Cost per hour | Cost with CVoS for 6 months | Cost with CVoS for 1 year |
   |----------------|--------------------------------------------------------------:|-------------------------------------------------------------------------------------:|-------------------------------------------------------------------------------------------------:|
   | **Intel Cascade Lake** |
   | 50% vCPU | {{ sku|USD|mdb.cluster.opensearch.v2.cpu.c50|month|string }} | — | — |
   | 100% vCPU | {{ sku|USD|mdb.cluster.opensearch.v2.cpu.c100|month|string }} | — | — |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.opensearch.v2.ram|month|string }} | — | — |
   | **Intel Ice Lake** |
   | 50% vCPU | {{ sku|USD|mdb.cluster.opensearch.v3.cpu.c50|month|string }} | — | — |
   | 100% vCPU | {{ sku|USD|mdb.cluster.opensearch.v3.cpu.c100|month|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.mdb.opensearch.cpu.c100.v3|month|string }} (-15%) | {{ sku|USD|v1.commitment.selfcheckout.y1.mdb.opensearch.cpu.c100.v3|month|string }} (-22%) |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.opensearch.v3.ram|month|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.mdb.opensearch.ram.v3|month|string }} (-15%) | {{ sku|USD|v1.commitment.selfcheckout.y1.mdb.opensearch.ram.v3|month|string }} (-22%) |

{% endlist %}

### Storage {#prices-storage}

{% include [local-ssd for Intel Ice Lake only on request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service | Cost of 1 GB per month |
|---------------------------------|----------------------------------------------------------------------------:|
| Standard network storage | {{ sku|USD|mdb.cluster.network-hdd.opensearch|month|string }} |
| Non-replicated network storage | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.opensearch|month|string }} |
| Fast network storage | {{ sku|USD|mdb.cluster.network-nvme.opensearch|month|string }} |
| Fast local storage | {{ sku|USD|mdb.cluster.local-nvme.opensearch|month|string }} |
| Backups beyond the storage size | $0.024615 |
