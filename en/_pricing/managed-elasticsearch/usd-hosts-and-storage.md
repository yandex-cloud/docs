### Host computing resources {#prices-hosts}

The cost for computing resources depends on the selected {{ ES }} edition.

{% list tabs %}

- Basic

   | Resource       | Cost for 1 hour                                             |
   |----------------|-------------------------------------------------------------|
   | **Intel Cascade Lake**                                                       |
   | 100% vCPU      | {{ sku|USD|mdb.cluster.elasticsearch.v2.cpu.c100|string }}  |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.elasticsearch.v2.ram.basic|string }} |
   | **Intel Ice Lake**                                                           |
   | 100% vCPU      | {{ sku|USD|mdb.cluster.elasticsearch.v3.cpu.c100|string }}  |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.elasticsearch.v3.ram.basic|string }} |


- Gold

   | Resource       | Cost for 1 hour                                            |
   |----------------|------------------------------------------------------------|
   | **Intel Cascade Lake**                                                      |
   | 100% vCPU      | {{ sku|USD|mdb.cluster.elasticsearch.v2.cpu.c100|string }} |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.elasticsearch.v2.ram.gold|string }} |
   | **Intel Ice Lake**                                                          |
   | 100% vCPU      | {{ sku|USD|mdb.cluster.elasticsearch.v3.cpu.c100|string }} |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.elasticsearch.v3.ram.gold|string }} |


- Platinum

   | Resource       | Cost for 1 hour                                                |
   |----------------|----------------------------------------------------------------|
   | **Intel Cascade Lake**                                                          |
   | 100% vCPU      | {{ sku|USD|mdb.cluster.elasticsearch.v2.cpu.c100|string }}     |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.elasticsearch.v2.ram.platinum|string }} |
   | **Intel Ice Lake**                                                              |
   | 100% vCPU      | {{ sku|USD|mdb.cluster.elasticsearch.v3.cpu.c100|string }}     |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.elasticsearch.v3.ram.platinum|string }} |


{% endlist %}

### Storage {#prices-storage}

{% include [local-ssd for Ice Lake only on request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service                        | Cost of 1 GB per month                                                         |
|--------------------------------|--------------------------------------------------------------------------------|
| Standard network storage       | {{ sku|USD|mdb.cluster.network-hdd.elasticsearch|month|string }}               |
| Non-replicated network storage | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.elasticsearch|month|string }} |
| Fast network storage           | {{ sku|USD|mdb.cluster.network-nvme.elasticsearch|month|string }}              |
| Fast local storage             | {{ sku|USD|mdb.cluster.local-nvme.elasticsearch|month|string }}                |
| Backup over storage size       | $0.032594                                                                      |
