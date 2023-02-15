### Host computing resources {#prices-hosts}

The cost for computing resources depends on the selected {{ ES }} edition:

{% list tabs %}

- Basic

   | Resource | Cost per hour |
   | ----- | ----- |
   | **Intel Cascade Lake** |
   | 100% vCPU | {{ sku|RUB|mdb.cluster.elasticsearch.v2.cpu.c100|string }} |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.elasticsearch.v2.ram.basic|string }} |
   | **Intel Ice Lake** |
   | 100% vCPU | {{ sku|RUB|mdb.cluster.elasticsearch.v3.cpu.c100|string }} |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.elasticsearch.v3.ram.basic|string }} |

   {% if audience == "cvos" %}

   | Resource | Cost per hour | Cost with CVoS for 1 year | Cost with CVoS for 3 years |
   |---------------|-------------------------------------------------------------|----------------------------------------------------------------------------|----------------------------------------------------------------------------|
   | **Intel Cascade Lake** |
   | 100% vCPU | {{ sku|RUB|mdb.cluster.elasticsearch.v2.cpu.c100|string }} | {{ sku|RUB|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v2|string }} (-29%) | {{ sku|RUB|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v2|string }} (-45%) |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.elasticsearch.v2.ram.basic|string }} | {{ sku|RUB|v1.commitment.y1.mdb.elasticsearch.ram.v2.basic|string }} (-6%) | {{ sku|RUB|v1.commitment.y3.mdb.elasticsearch.ram.v2.basic|string }} (-9%) |
   | **Intel Ice Lake** |
   | 100% vCPU | {{ sku|RUB|mdb.cluster.elasticsearch.v3.cpu.c100|string }} | {{ sku|RUB|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v3|string }} (-29%) | {{ sku|RUB|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v3|string }} (-45%) |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.elasticsearch.v3.ram.basic|string }} | {{ sku|RUB|v1.commitment.y1.mdb.elasticsearch.ram.v3.basic|string }} (-6%) | {{ sku|RUB|v1.commitment.y3.mdb.elasticsearch.ram.v3.basic|string }} (-9%) |

   {% endif %}

- Gold

   | Resource | Cost per hour |
   | ----- | ----- |
   | **Intel Cascade Lake** |
   | 100% vCPU | {{ sku|RUB|mdb.cluster.elasticsearch.v2.cpu.c100|string }} |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.elasticsearch.v2.ram.gold|string }} |
   | **Intel Ice Lake** |
   | 100% vCPU | {{ sku|RUB|mdb.cluster.elasticsearch.v3.cpu.c100|string }} |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.elasticsearch.v3.ram.gold|string }} |

   {% if audience == "cvos" %}
   | Resource        | Cost per hour                                              | Cost with CVoS for 1 year                                                       | Cost with CVoS for 3 years                                                      |
   |---------------|------------------------------------------------------------|----------------------------------------------------------------------------|----------------------------------------------------------------------------|
   | **Intel Cascade Lake**                                                                                                                                                                                                               |
   | 100% vCPU     | {{ sku|RUB|mdb.cluster.elasticsearch.v2.cpu.c100|string }} | {{ sku|RUB|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v2|string }} (-29%) | {{ sku|RUB|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v2|string }} (-45%) |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.elasticsearch.v2.ram.gold|string }} | {{ sku|RUB|v1.commitment.y1.mdb.elasticsearch.ram.v2.gold|string }} (-6%)  | {{ sku|RUB|v1.commitment.y3.mdb.elasticsearch.ram.v2.gold|string }} (-9%)  |
   | **Intel Ice Lake**                                                                                                                                                                                                                   |
   | 100% vCPU     | {{ sku|RUB|mdb.cluster.elasticsearch.v3.cpu.c100|string }} | {{ sku|RUB|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v3|string }} (-29%) | {{ sku|RUB|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v3|string }} (-45%) |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.elasticsearch.v3.ram.gold|string }} | {{ sku|RUB|v1.commitment.y1.mdb.elasticsearch.ram.v3.gold|string }} (-6%)  | {{ sku|RUB|v1.commitment.y3.mdb.elasticsearch.ram.v3.gold|string }} (-9%)  |
   {% endif %}

- Platinum

   | Resource | Cost per hour |
   | ----- | ----- |
   | **Intel Cascade Lake** |
   | 100% vCPU | {{ sku|RUB|mdb.cluster.elasticsearch.v2.cpu.c100|string }} |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.elasticsearch.v2.ram.platinum|string }} |
   | **Intel Ice Lake** |
   | 100% vCPU | {{ sku|RUB|mdb.cluster.elasticsearch.v3.cpu.c100|string }} |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.elasticsearch.v3.ram.platinum|string }} |

   {% if audience == "cvos" %}
   | Resource        | Cost per hour                                                  | Cost with CVoS for 1 year                                                          | Cost with CVoS for 3 years                                                         |
   |---------------|----------------------------------------------------------------|------------------------------------------------------------------------------ |-------------------------------------------------------------------------------|
   | **Intel Cascade Lake**                                                                                                                                                                                                                         |
   | 100% vCPU     | {{ sku|RUB|mdb.cluster.elasticsearch.v2.cpu.c100|string }}     | {{ sku|RUB|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v2|string }} (-29%)    | {{ sku|RUB|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v2|string }} (-45%)    |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.elasticsearch.v2.ram.platinum|string }} | {{ sku|RUB|v1.commitment.y1.mdb.elasticsearch.ram.v2.platinum|string }} (-6%) | {{ sku|RUB|v1.commitment.y3.mdb.elasticsearch.ram.v2.platinum|string }} (-9%) |
   | **Intel Ice Lake**                                                                                                                                                                                                                             |
   | 100% vCPU     | {{ sku|RUB|mdb.cluster.elasticsearch.v3.cpu.c100|string }}     | {{ sku|RUB|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v3|string }} (-29%)    | {{ sku|RUB|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v3|string }} (-45%)    |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.elasticsearch.v3.ram.platinum|string }} | {{ sku|RUB|v1.commitment.y1.mdb.elasticsearch.ram.v3.platinum|string }} (-6%) | {{ sku|RUB|v1.commitment.y3.mdb.elasticsearch.ram.v3.platinum|string }} (-9%) |
   {% endif %}

{% endlist %}

### Storage {#prices-storage}

{% include [local-ssd for Ice Lake only on request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service | Cost of 1 GB per month |
| ----- | ----- |
| HDD network storage | {{ sku|RUB|mdb.cluster.network-hdd.elasticsearch|month|string }} |
| Non-replicated SSD storage | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.elasticsearch|month|string }} |
| SSD network storage | {{ sku|RUB|mdb.cluster.network-nvme.elasticsearch|month|string }} |
| Local SSD storage | {{ sku|RUB|mdb.cluster.local-nvme.elasticsearch|month|string }} |
| Backups beyond the storage size | ₽1.92 |
