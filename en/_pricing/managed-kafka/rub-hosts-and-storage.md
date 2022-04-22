### {{ KF }} broker host computing resources {#prices-kafka-brokers}

| Resource       | Cost for 1 hour                                    |
|----------------|----------------------------------------------------|
| **Intel Cascade Lake**                                              |
| 50% vCPU       | {{ sku|RUB|mdb.cluster.kafka.v2.cpu.c50|string }}  |
| 100% vCPU      | {{ sku|RUB|mdb.cluster.kafka.v2.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.kafka.v2.ram|string }}      |
| **Intel Ice Lake**                                                  |
| 50% vCPU       | {{ sku|RUB|mdb.cluster.kafka.v3.cpu.c50|string }}  |
| 100% vCPU      | {{ sku|RUB|mdb.cluster.kafka.v3.cpu.c100|string }} |
| RAM (for 1 GB) | ₽0.2520                                            |

{% if audience == "cvos" %}

| Resource       | Cost for 1 hour                                    | Cost with CVoS for 1 year                                          | Cost with CVoS for 3 years                                         |
|----------------|----------------------------------------------------|--------------------------------------------------------------------|--------------------------------------------------------------------|
| **Intel Cascade Lake**                                                                                                                                                                                        |
| 50% vCPU       | {{ sku|RUB|mdb.cluster.kafka.v2.cpu.c50|string }}  | −                                                                  | −                                                                  |
| 100% vCPU      | {{ sku|RUB|mdb.cluster.kafka.v2.cpu.c100|string }} | {{ sku|RUB|v1.commitment.y1.mdb.kafka.cpu.c100.v2|string }} (-30%) | {{ sku|RUB|v1.commitment.y3.mdb.kafka.cpu.c100.v2|string }} (-46%) |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.kafka.v2.ram|string }}      | {{ sku|RUB|v1.commitment.y1.mdb.kafka.ram.v2|string }} (-36%)      | {{ sku|RUB|v1.commitment.y3.mdb.kafka.ram.v2|string }} (-50%)      |
| **Intel Ice Lake**                                                                                                                                                                                            |
| 50% vCPU       | {{ sku|RUB|mdb.cluster.kafka.v3.cpu.c50|string }}  | —                                                                  | —                                                                  |
| 100% vCPU      | {{ sku|RUB|mdb.cluster.kafka.v3.cpu.c100|string }} | ₽0.6670 (-29%)                                                     | ₽0.5130 (-46%)                                                     |
| RAM (for 1 GB) | ₽0.2520                                             | ₽0.1620 (-36%)                                                     | ₽0.1260 (-50%)                                                     |

{% endif %}

### {{ ZK }} host computing resources {#prices-zookeeper}

{% note info %}

You can't order {{ ZK }} host resources using a CVoS.

{% endnote %}

| Resource       | Cost for 1 hour                               |
|----------------|-----------------------------------------------|
| **Intel Cascade Lake**                                         |
| 50% vCPU       | {{ sku|RUB|mdb.zk.kafka.v2.cpu.c50|string }}  |
| 100% vCPU      | {{ sku|RUB|mdb.zk.kafka.v2.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|RUB|mdb.zk.kafka.v2.ram|string }}      |
| **Intel Ice Lake**                                             |
| 50% vCPU       | {{ sku|RUB|mdb.zk.kafka.v3.cpu.c50|string }}  |
| 100% vCPU      | {{ sku|RUB|mdb.zk.kafka.v3.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|RUB|mdb.zk.kafka.v3.ram|string }}      |

### Storage {#prices-storage}

{% include [local-ssd for Ice Lake only on request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service                        | Cost of 1 GB per month                                                 |
|--------------------------------|------------------------------------------------------------------------|
| Standard network storage       | {{ sku|RUB|mdb.cluster.network-hdd.kafka|month|string }}               |
| Non-replicated network storage | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.kafka|month|string }} |
| Fast network storage           | {{ sku|RUB|mdb.cluster.network-nvme.kafka|month|string }}              |
| Fast local storage             | {{ sku|RUB|mdb.cluster.local-nvme.kafka|month|string }}                |
