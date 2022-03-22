### Host computing resources {#prices-hosts}

The cost for computing resources depends on the selected {{ ES }} edition:

{% list tabs %}

- BASIC

   | Resource       | Cost for 1 hour                                             | |
   | ----- | ----- | ----- |
   | | **Up until April 12, 2022** | **Starting April 13, 2022** |
   | **Intel Cascade Lake**                                                       | |
   | 100% vCPU      | {{ sku|KZT|mdb.cluster.elasticsearch.v2.cpu.c100|string }}  | ₸8.4000 |
   | RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.elasticsearch.v2.ram.basic|string }} | ₸10.5000 |
   | **Intel Ice Lake**                                                           | |
   | 100% vCPU      | {{ sku|KZT|mdb.cluster.elasticsearch.v3.cpu.c100|string }}  | ₸8.4000 |
   | RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.elasticsearch.v3.ram.basic|string }} | ₸10.5000 |

- GOLD

   | Resource       | Cost for 1 hour                                            | |
   | ----- | ----- | ----- |
   | | **Up until April 12, 2022** | **Starting April 13, 2022** |
   | **Intel Cascade Lake**                                                      | |
   | 100% vCPU      | {{ sku|KZT|mdb.cluster.elasticsearch.v2.cpu.c100|string }} | ₸8.4000 |
   | RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.elasticsearch.v2.ram.gold|string }} | ₸12.3000 |
   | **Intel Ice Lake**                                                          | |
   | 100% vCPU      | {{ sku|KZT|mdb.cluster.elasticsearch.v3.cpu.c100|string }} | ₸8.4000 |
   | RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.elasticsearch.v3.ram.gold|string }} | ₸12.3000 |

- PLATINUM

   | Resource       | Cost for 1 hour                                                | |
   | ----- | ----- | ----- |
   | | **Up until April 12, 2022** | **Starting April 13, 2022** |
   | **Intel Cascade Lake**                                                          | |
   | 100% vCPU      | {{ sku|KZT|mdb.cluster.elasticsearch.v2.cpu.c100|string }}     | ₸8.4000 |
   | RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.elasticsearch.v2.ram.platinum|string }} | ₸14.1500 |
   | **Intel Ice Lake**                                                              | |
   | 100% vCPU      | {{ sku|KZT|mdb.cluster.elasticsearch.v3.cpu.c100|string }}     | ₸8.4000 |
   | RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.elasticsearch.v3.ram.platinum|string }} | ₸14.1500 |

{% endlist %}

{% if audience == "cvos" %}

{% list tabs %}

- BASIC

   | Resource       | Cost for 1 hour                                             | Cost with CVoS for 1 year                                                  | Cost with CVoS for 3 years                                                 |
   |----------------|-------------------------------------------------------------|----------------------------------------------------------------------------|----------------------------------------------------------------------------|
   | **Intel Cascade Lake**                                                                                                                                                                                                                 |
   | 100% vCPU      | {{ sku|KZT|mdb.cluster.elasticsearch.v2.cpu.c100|string }}  | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v2|string }} (-29%) | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v2|string }} (-45%) |
   | RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.elasticsearch.v2.ram.basic|string }} | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.ram.v2.basic|string }} (-6%) | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.ram.v2.basic|string }} (-9%) |
   | **Intel Ice Lake**                                                                                                                                                                                                                     |
   | 100% vCPU      | {{ sku|KZT|mdb.cluster.elasticsearch.v3.cpu.c100|string }}  | ₸4.5000 (-29%)                                                             | ₸3.4800 (-45%)                                                             |
   | RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.elasticsearch.v3.ram.basic|string }} | ₸7.3800 (-6%)                                                              | ₸7.1400 (-9%)                                                              |

- GOLD

   | Resource       | Cost for 1 hour                                            | Cost with CVoS for 1 year                                                  | Cost with CVoS for 3 years                                                 |
   |----------------|------------------------------------------------------------|----------------------------------------------------------------------------|----------------------------------------------------------------------------|
   | **Intel Cascade Lake**                                                                                                                                                                                                                |
   | 100% vCPU      | {{ sku|KZT|mdb.cluster.elasticsearch.v2.cpu.c100|string }} | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v2|string }} (-29%) | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v2|string }} (-45%) |
   | RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.elasticsearch.v2.ram.gold|string }} | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.ram.v2.gold|string }} (-6%)  | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.ram.v2.gold|string }} (-9%)  |
   | **Intel Ice Lake**                                                                                                                                                                                                                    |
   | 100% vCPU      | {{ sku|KZT|mdb.cluster.elasticsearch.v3.cpu.c100|string }} | ₸4.5000 (-29%)                                                             | ₸3.4800 (-45%)                                                             |
   | RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.elasticsearch.v3.ram.gold|string }} | ₸8.7000 (-6%)                                                              | ₸8.4000 (-9%)                                                              |

- PLATINUM

   | Resource       | Cost for 1 hour                                                | Cost with CVoS for 1 year                                                     | Cost with CVoS for 3 years                                                    |
   |----------------|----------------------------------------------------------------|-------------------------------------------------------------------------------|-------------------------------------------------------------------------------|
   | **Intel Cascade Lake**                                                                                                                                                                                                                          |
   | 100% vCPU      | {{ sku|KZT|mdb.cluster.elasticsearch.v2.cpu.c100|string }}     | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v2|string }} (-29%)    | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v2|string }} (-45%)    |
   | RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.elasticsearch.v2.ram.platinum|string }} | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.ram.v2.platinum|string }} (-6%) | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.ram.v2.platinum|string }} (-9%) |
   | **Intel Ice Lake**                                                                                                                                                                                                                              |
   | 100% vCPU      | {{ sku|KZT|mdb.cluster.elasticsearch.v3.cpu.c100|string }}     | ₸4.5000 (-29%)                                                                | ₸3.4800 (-45%)                                                                |
   | RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.elasticsearch.v3.ram.platinum|string }} | ₸10.0200 (-6%)                                                                | ₸9.6600 (-9%)                                                                 |

{% endlist %}

{% endif %}

### Storage {#prices-storage}

{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

| Service                         | Cost of 1 GB per month                                                         | |
| ----- | ----- | ----- |
| | **Up until April 12, 2022** | **Starting April 13, 2022** |
| Standard network storage        | {{ sku|KZT|mdb.cluster.network-hdd.elasticsearch|month|string }}               | ₸16.0000 |
| Non-replicated network storage  | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.elasticsearch|month|string }} | ₸44.0000 |
| Fast network storage            | {{ sku|KZT|mdb.cluster.network-nvme.elasticsearch|month|string }}              | ₸65.0500 |
| Fast local storage              | {{ sku|KZT|mdb.cluster.local-nvme.elasticsearch|month|string }}                | ₸65.0500 |
| Backups beyond the storage size | ₸15.2544                                                                       | ₸9.6000 |
