### Host computing resources {#prices-hosts}

The cost for computing resources depends on the selected {{ ES }} edition.

{% list tabs %}

- Basic

   | Resource | Cost per hour | Cost for 1 month |
   |----------------|------------------------------------------------------------:|------------------------------------------------------------------:|
   | **Intel Cascade Lake** |
   | 100% vCPU | {{ sku|USD|mdb.cluster.elasticsearch.v2.cpu.c100|string }} | {{ sku|USD|mdb.cluster.elasticsearch.v2.cpu.c100|month|string }} |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.elasticsearch.v2.ram.basic|string }} | {{ sku|USD|mdb.cluster.elasticsearch.v2.ram.basic|month|string }} |
   | **Intel Ice Lake** |
   | 100% vCPU | {{ sku|USD|mdb.cluster.elasticsearch.v3.cpu.c100|string }} | {{ sku|USD|mdb.cluster.elasticsearch.v3.cpu.c100|month|string }} |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.elasticsearch.v3.ram.basic|string }} | {{ sku|USD|mdb.cluster.elasticsearch.v3.ram.basic|month|string }} |


- Gold

   | Resource | Cost per hour | Cost for 1 month |
   |------------------|-----------------------------------------------------------:|-----------------------------------------------------------------:|
   | **Intel Cascade Lake** |
   | 100% vCPU | {{ sku|USD|mdb.cluster.elasticsearch.v2.cpu.c100|string }} | {{ sku|USD|mdb.cluster.elasticsearch.v2.cpu.c100|month|string }} |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.elasticsearch.v2.ram.gold|string }} | {{ sku|USD|mdb.cluster.elasticsearch.v2.ram.gold|month|string }} |
   | **Intel Ice Lake** |
   | 100% vCPU | {{ sku|USD|mdb.cluster.elasticsearch.v3.cpu.c100|string }} | {{ sku|USD|mdb.cluster.elasticsearch.v3.cpu.c100|month|string }} |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.elasticsearch.v3.ram.gold|string }} | {{ sku|USD|mdb.cluster.elasticsearch.v3.ram.gold|month|string }} |


- Platinum

   | Resource | Cost per hour | Cost for 1 month |
   |----------------|---------------------------------------------------------------:|---------------------------------------------------------------------:|
   | **Intel Cascade Lake** |
   | 100% vCPU | {{ sku|USD|mdb.cluster.elasticsearch.v2.cpu.c100|string }} | {{ sku|USD|mdb.cluster.elasticsearch.v2.cpu.c100|month|string }} |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.elasticsearch.v2.ram.platinum|string }} | {{ sku|USD|mdb.cluster.elasticsearch.v2.ram.platinum|month|string }} |
   | **Intel Ice Lake** |
   | 100% vCPU | {{ sku|USD|mdb.cluster.elasticsearch.v3.cpu.c100|string }} | {{ sku|USD|mdb.cluster.elasticsearch.v3.cpu.c100|month|string }} |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.elasticsearch.v3.ram.platinum|string }} | {{ sku|USD|mdb.cluster.elasticsearch.v3.ram.platinum|month|string }} |


{% endlist %}

### Storage {#prices-storage}

{% include [local-ssd for Ice Lake only on request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service | Cost of 1 GB per month |
|--------------------------------|-------------------------------------------------------------------------------:|
| Standard network storage | {{ sku|USD|mdb.cluster.network-hdd.elasticsearch|month|string }} |
| Non-replicated network storage | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.elasticsearch|month|string }} |
| Fast network storage | {{ sku|USD|mdb.cluster.network-nvme.elasticsearch|month|string }} |
| Fast local storage | {{ sku|USD|mdb.cluster.local-nvme.elasticsearch|month|string }} |
| Backup over storage size | $0.032594 |
