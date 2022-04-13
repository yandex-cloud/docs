### Host computing resources {#prices-hosts}

The cost for computing resources depends on the selected {{ ES }} edition:

{% list tabs %}

- BASIC

   | Resource       | Cost for 1 hour                                             |
   |----------------|-------------------------------------------------------------|
   | **Intel Cascade Lake**                                                       |
   | 100% vCPU      | {{ sku|USD|mdb.cluster.elasticsearch.v2.cpu.c100|string }}  |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.elasticsearch.v2.ram.basic|string }} |
   | **Intel Ice Lake**                                                           |
   | 100% vCPU      | {{ sku|USD|mdb.cluster.elasticsearch.v3.cpu.c100|string }}  |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.elasticsearch.v3.ram.basic|string }} |

- GOLD

   | Resource       | Cost for 1 hour                                            |
   |----------------|------------------------------------------------------------|
   | **Intel Cascade Lake**                                                      |
   | 100% vCPU      | {{ sku|USD|mdb.cluster.elasticsearch.v2.cpu.c100|string }} |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.elasticsearch.v2.ram.gold|string }} |
   | **Intel Ice Lake**                                                          |
   | 100% vCPU      | {{ sku|USD|mdb.cluster.elasticsearch.v3.cpu.c100|string }} |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.elasticsearch.v3.ram.gold|string }} |

- PLATINUM

   | Resource       | Cost for 1 hour                                                |
   |----------------|----------------------------------------------------------------|
   | **Intel Cascade Lake**                                                          |
   | 100% vCPU      | {{ sku|USD|mdb.cluster.elasticsearch.v2.cpu.c100|string }}     |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.elasticsearch.v2.ram.platinum|string }} |
   | **Intel Ice Lake**                                                              |
   | 100% vCPU      | {{ sku|USD|mdb.cluster.elasticsearch.v3.cpu.c100|string }}     |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.elasticsearch.v3.ram.platinum|string }} |
   
{% endlist %}

{% if audience == "cvos" %}

{% list tabs %}

- BASIC

   | Resource       | Cost for 1 hour                                             | Cost with CVoS for 1 year                                                  | Cost with CVoS for 3 years                                                 |
   |----------------|-------------------------------------------------------------|----------------------------------------------------------------------------|----------------------------------------------------------------------------|
   | **Intel Cascade Lake**                                                                                                                                                                                                                 |
   | 100% vCPU      | {{ sku|USD|mdb.cluster.elasticsearch.v2.cpu.c100|string }}  | {{ sku|USD|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v2|string }} (-29%) | {{ sku|USD|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v2|string }} (-45%) |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.elasticsearch.v2.ram.basic|string }} | {{ sku|USD|v1.commitment.y1.mdb.elasticsearch.ram.v2.basic|string }} (-6%) | {{ sku|USD|v1.commitment.y3.mdb.elasticsearch.ram.v2.basic|string }} (-9%) |
   | **Intel Ice Lake**                                                                                                                                                                                                                     |
   | 100% vCPU      | {{ sku|USD|mdb.cluster.elasticsearch.v3.cpu.c100|string }}  | $0.009615 (-29%)                                                           | $0.007436 (-45%)                                                           |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.elasticsearch.v3.ram.basic|string }} | $0.015769 (-6%)                                                            | $0.015256 (-9%)                                                            |

- GOLD

   | Resource       | Cost for 1 hour                                            | Cost with CVoS for 1 year                                                  | Cost with CVoS for 3 years                                                 |
   |----------------|------------------------------------------------------------|----------------------------------------------------------------------------|----------------------------------------------------------------------------|
   | **Intel Cascade Lake**                                                                                                                                                                                                                |
   | 100% vCPU      | {{ sku|USD|mdb.cluster.elasticsearch.v2.cpu.c100|string }} | {{ sku|USD|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v2|string }} (-29%) | {{ sku|USD|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v2|string }} (-45%) |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.elasticsearch.v2.ram.gold|string }} | {{ sku|USD|v1.commitment.y1.mdb.elasticsearch.ram.v2.gold|string }} (-6%)  | {{ sku|USD|v1.commitment.y3.mdb.elasticsearch.ram.v2.gold|string }} (-9%)  |
   | **Intel Ice Lake**                                                                                                                                                                                                                    |
   | 100% vCPU      | {{ sku|USD|mdb.cluster.elasticsearch.v3.cpu.c100|string }} | $0.009615 (-29%)                                                           | $0.007436 (-45%)                                                           |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.elasticsearch.v3.ram.gold|string }} | $0.018590 (-6%)                                                            | $0.017949 (-9%)                                                            |

- PLATINUM

   | Resource       | Cost for 1 hour                                                | Cost with CVoS for 1 year                                                     | Cost with CVoS for 3 years                                                    |
   |----------------|----------------------------------------------------------------|-------------------------------------------------------------------------------|-------------------------------------------------------------------------------|
   | **Intel Cascade Lake**                                                                                                                                                                                                                          |
   | 100% vCPU      | {{ sku|USD|mdb.cluster.elasticsearch.v2.cpu.c100|string }}     | {{ sku|USD|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v2|string }} (-29%)    | {{ sku|USD|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v2|string }} (-45%)    |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.elasticsearch.v2.ram.platinum|string }} | {{ sku|USD|v1.commitment.y1.mdb.elasticsearch.ram.v2.platinum|string }} (-6%) | {{ sku|USD|v1.commitment.y3.mdb.elasticsearch.ram.v2.platinum|string }} (-9%) |
   | **Intel Ice Lake**                                                                                                                                                                                                                              |
   | 100% vCPU      | {{ sku|USD|mdb.cluster.elasticsearch.v3.cpu.c100|string }}     | $0.009615 (-29%)                                                              | $0.007436 (-45%)                                                              |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.elasticsearch.v3.ram.platinum|string }} | $0.021410 (-6%)                                                               | $0.020641 (-9%)                                                               |

{% endlist %}

{% endif %}

### Storage {#prices-storage}

{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

| Service                         | Cost of 1 GB per month                                                         |
|---------------------------------|--------------------------------------------------------------------------------|
| Standard network storage        | {{ sku|USD|mdb.cluster.network-hdd.elasticsearch|month|string }}               |
| Non-replicated network storage  | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.elasticsearch|month|string }} |
| Fast network storage            | {{ sku|USD|mdb.cluster.network-nvme.elasticsearch|month|string }}              |
| Fast local storage              | {{ sku|USD|mdb.cluster.local-nvme.elasticsearch|month|string }}                |
| Backups beyond the storage size | $0.032594                                                                      |
