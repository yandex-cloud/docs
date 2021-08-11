All prices are shown without VAT.

### Host computing resources {#prices-hosts}

The cost for computing resources depends on the selected {{ ES }} edition:

{% list tabs %}

- BASIC

   | Resource | Cost for 1 hour | Cost with CVoS for 1 year | Cost with CVoS for 3 years |
   | ----- | ----- | ----- | ----- |
   | **Intel Cascade Lake** |
   | 100% vCPU | {{ sku|USD|mdb.cluster.elasticsearch.v2.cpu.c100|string }} | {{ sku|USD|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v2|string }} (-29%) | {{ sku|USD|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v2|string }} (-45%) |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.elasticsearch.v2.ram.basic|string }} | {{ sku|USD|v1.commitment.y1.mdb.elasticsearch.ram.v2.basic|string }} (-6%) | {{ sku|USD|v1.commitment.y3.mdb.elasticsearch.ram.v2.basic|string }} (-9%) |

- GOLD

   | Resource | Cost for 1 hour | Cost with CVoS for 1 year | Cost with CVoS for 3 years |
   | ----- | ----- | ----- | ----- |
   | **Intel Cascade Lake** |
   | 100% vCPU | {{ sku|USD|mdb.cluster.elasticsearch.v2.cpu.c100|string }} | {{ sku|USD|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v2|string }} (-29%) | {{ sku|USD|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v2|string }} (-45%) |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.elasticsearch.v2.ram.gold|string }} | {{ sku|USD|v1.commitment.y1.mdb.elasticsearch.ram.v2.gold|string }} (-6%) | {{ sku|USD|v1.commitment.y3.mdb.elasticsearch.ram.v2.gold|string }} (-9%) |

- PLATINUM

   | Resource | Cost for 1 hour | Cost with CVoS for 1 year | Cost with CVoS for 3 years |
   | ----- | ----- | ----- | -----
   | **Intel Cascade Lake** |
   | 100% vCPU | {{ sku|USD|mdb.cluster.elasticsearch.v2.cpu.c100|string }} | {{ sku|USD|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v2|string }} (-29%) | {{ sku|USD|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v2|string }} (-45%) |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.elasticsearch.v2.ram.platinum|string }} | {{ sku|USD|v1.commitment.y1.mdb.elasticsearch.ram.v2.platinum|string }} (-6%) | {{ sku|USD|v1.commitment.y3.mdb.elasticsearch.ram.v2.platinum|string }} (-9%) |

{% endlist %}

### Storage {#prices-storage}

| Service | Cost of 1 GB per month |
| ----- | ----- |
| Standard network storage | {{ sku|USD|mdb.cluster.network-hdd.elasticsearch|month|string }} |
| Non-replicated network storage | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.elasticsearch|month|string }} |
| Fast network storage | {{ sku|USD|mdb.cluster.network-nvme.elasticsearch|month|string }} |
| Fast local storage | {{ sku|USD|mdb.cluster.local-nvme.elasticsearch|month|string }} |
