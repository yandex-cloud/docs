### {{ KF }} broker host computing resources {#prices-kafka-brokers}

| Resource | Cost for 1 hour | Cost with CVoS for 1 year | Cost with CVoS for 3 years |
| ----- | ----- | ----- | ----- |
| **Intel Cascade Lake** |
| 50% vCPU | {{ sku|RUB|mdb.cluster.kafka.v2.cpu.c50|string }} | − | − |
| 100% vCPU | {{ sku|RUB|mdb.cluster.kafka.v2.cpu.c100|string }} | {{ sku|RUB|v1.commitment.y1.mdb.kafka.cpu.c100.v2|string }} (-30%) | {{ sku|RUB|v1.commitment.y3.mdb.kafka.cpu.c100.v2|string }} (-46%) |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.kafka.v2.ram|string }} | {{ sku|RUB|v1.commitment.y1.mdb.kafka.ram.v2|string }} (-36%) | {{ sku|RUB|v1.commitment.y3.mdb.kafka.ram.v2|string }} (-50%) |

### {{ ZK }} host computing resources {#prices-zookeeper}

{% note info %}

You can't order {{ ZK }} host resources using a CVoS.

{% endnote %}

| Resource | Cost for 1 hour |
| ----- | ----- |
| **Intel Cascade Lake** |
| 50% vCPU | {{ sku|RUB|mdb.zk.kafka.v2.cpu.c50|string }} |
| 100% vCPU | {{ sku|RUB|mdb.zk.kafka.v2.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|RUB|mdb.zk.kafka.v2.ram|string }} |

### Storage {#prices-storage}

{% include [nrd-disks-preview](../../_includes/mdb/non-replicated-disks-preview.md) %}

| Service | Cost of 1 GB per month |
| ----------------------------------------- | ------------------------------------------------------------------------ |
| Standard network storage | {{ sku|RUB|mdb.cluster.network-hdd.kafka|month|string }} |
| Non-replicated network storage | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.kafka|month|string }} |
| Fast network storage | {{ sku|RUB|mdb.cluster.network-nvme.kafka|month|string }} |
| Fast local storage | {{ sku|RUB|mdb.cluster.local-nvme.kafka|month|string }} |
