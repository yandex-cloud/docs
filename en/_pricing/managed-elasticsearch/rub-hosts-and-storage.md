### Host computing resources {#prices-hosts}

The cost for computing resources depends on the selected {{ ES }} edition:

{% list tabs %}

- BASIC

   | Resource       | Cost for 1 hour                                            | |
   | ----- | ----- | ----- |
   | | **Up until April 12, 2022** | **Starting April 13, 2022** |
   | **Intel Cascade Lake**                                                      | |
   | 100% vCPU      | {{ sku|RUB|mdb.cluster.elasticsearch.v2.cpu.c100|string }} | ₽1.68 |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.elasticsearch.v2.ram.basic|string }}| ₽2.10 |
   | **Intel Ice Lake**                                                          | |
   | 100% vCPU      | {{ sku|RUB|mdb.cluster.elasticsearch.v3.cpu.c100|string }} | ₽1.68 |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.elasticsearch.v3.ram.basic|string }}| ₽2.10 |

{% if audience == "cvos" %}

   | Resource       | Cost for 1 hour                                             | Cost with CVoS for 1 year                                                  | Cost with CVoS for 3 years                                                 |
   |----------------|-------------------------------------------------------------|----------------------------------------------------------------------------|----------------------------------------------------------------------------|
   | **Intel Cascade Lake**                                                                                                                                                                                                                 |
   | 100% vCPU      | {{ sku|RUB|mdb.cluster.elasticsearch.v2.cpu.c100|string }}  | {{ sku|RUB|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v2|string }} (-29%) | {{ sku|RUB|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v2|string }} (-45%) |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.elasticsearch.v2.ram.basic|string }} | {{ sku|RUB|v1.commitment.y1.mdb.elasticsearch.ram.v2.basic|string }} (-6%) | {{ sku|RUB|v1.commitment.y3.mdb.elasticsearch.ram.v2.basic|string }} (-9%) |
   | **Intel Ice Lake** |
   | 100% vCPU | {{ sku|RUB|mdb.cluster.elasticsearch.v3.cpu.c100|string }} | ₽0.7500 (-29%) | ₽0.5800 (-45%) |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.elasticsearch.v3.ram.basic|string }} | ₽1.2300 (-6%) | ₽1.1900 (-9%) |

{% endif %}

- GOLD

   | Resource       | Cost for 1 hour                                            | |
   | ----- | ----- | ----- |
   | | **Up until April 12, 2022** | **Starting April 13, 2022** |
   | **Intel Cascade Lake**                                                      | |
   | 100% vCPU      | {{ sku|RUB|mdb.cluster.elasticsearch.v2.cpu.c100|string }} | ₽1.68 |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.elasticsearch.v2.ram.gold|string }} | ₽2.46 |
   | **Intel Ice Lake**                                                          | |
   | 100% vCPU      | {{ sku|RUB|mdb.cluster.elasticsearch.v3.cpu.c100|string }} | ₽1.68 |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.elasticsearch.v3.ram.gold|string }} | ₽2.46 |

{% if audience == "cvos" %}

   | Resource       | Cost for 1 hour                                            | Cost with CVoS for 1 year                                                  | Cost with CVoS for 3 years                                                 |
   |----------------|------------------------------------------------------------|----------------------------------------------------------------------------|----------------------------------------------------------------------------|
   | **Intel Cascade Lake**                                                                                                                                                                                                                |
   | 100% vCPU      | {{ sku|RUB|mdb.cluster.elasticsearch.v2.cpu.c100|string }} | {{ sku|RUB|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v2|string }} (-29%) | {{ sku|RUB|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v2|string }} (-45%) |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.elasticsearch.v2.ram.gold|string }} | {{ sku|RUB|v1.commitment.y1.mdb.elasticsearch.ram.v2.gold|string }} (-6%)  | {{ sku|RUB|v1.commitment.y3.mdb.elasticsearch.ram.v2.gold|string }} (-9%)  |
   | **Intel Ice Lake**                                                                                                                                                                                                                    |
   | 100% vCPU      | {{ sku|RUB|mdb.cluster.elasticsearch.v3.cpu.c100|string }} | ₽0.7500 (-29%)                                                             | ₽0.5800 (-45%)                                                             |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.elasticsearch.v3.ram.gold|string }} | ₽1.4500 (-6%)                                                              | ₽1.4000 (-9%)                                                              |

{% endif %}

- PLATINUM

   | Resource       | Cost for 1 hour                                                | |
   | ----- | ----- | ----- |
   | | **Up until April 12, 2022** | **Starting April 13, 2022** |
   | **Intel Cascade Lake**                                                          | |
   | 100% vCPU      | {{ sku|RUB|mdb.cluster.elasticsearch.v2.cpu.c100|string }}     | ₽1.68 |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.elasticsearch.v2.ram.platinum|string }} | ₽2.83 |
   | **Intel Ice Lake**                                                              | |
   | 100% vCPU      | {{ sku|RUB|mdb.cluster.elasticsearch.v3.cpu.c100|string }}     | ₽1.68 |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.elasticsearch.v3.ram.platinum|string }} | ₽2.83 |

{% if audience == "cvos" %}

   | Resource       | Cost for 1 hour                                                | Cost with CVoS for 1 year                                                     | Cost with CVoS for 3 years                                                    |
   |----------------|----------------------------------------------------------------|-------------------------------------------------------------------------------|-------------------------------------------------------------------------------|
   | **Intel Cascade Lake**                                                                                                                                                                                                                          |
   | 100% vCPU      | {{ sku|RUB|mdb.cluster.elasticsearch.v2.cpu.c100|string }}     | {{ sku|RUB|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v2|string }} (-29%)    | {{ sku|RUB|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v2|string }} (-45%)    |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.elasticsearch.v2.ram.platinum|string }} | {{ sku|RUB|v1.commitment.y1.mdb.elasticsearch.ram.v2.platinum|string }} (-6%) | {{ sku|RUB|v1.commitment.y3.mdb.elasticsearch.ram.v2.platinum|string }} (-9%) |
   | **Intel Ice Lake** |
   | 100% vCPU | {{ sku|RUB|mdb.cluster.elasticsearch.v3.cpu.c100|string }} | ₽0.7500 (-29%) | ₽0.5800 (-45%) |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.elasticsearch.v3.ram.platinum|string }} | ₽1.6700 (-6%) | ₽1.6100 (-9%) |

{% endif %}

{% endlist %}

### Storage {#prices-storage}

{% include [local-ssd for Ice Lake only on request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service                         | Cost of 1 GB per month                                                         | |
| ----- | ----- | ----- |
| | **Up until April 12, 2022** | **Starting April 13, 2022** |
| HDD network storage        | {{ sku|RUB|mdb.cluster.network-hdd.elasticsearch|month|string }}               | ₽3.2000 |
| Non-replicated SSD storage  | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.elasticsearch|month|string }} | ₽8.8000 |
| SSD network storage            | {{ sku|RUB|mdb.cluster.network-nvme.elasticsearch|month|string }}              | ₽13.0100 |
| Local SSD storage              | {{ sku|RUB|mdb.cluster.local-nvme.elasticsearch|month|string }}                | ₽13.0100 |
| Backups beyond the storage size | ₽2.5424                                                                        | ₽1.9200 |
