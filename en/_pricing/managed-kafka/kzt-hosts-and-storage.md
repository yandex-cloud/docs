
### Host computing resources {{ KF }} {#prices-kafka-brokers}

Resource | Rate for 1 hour | With CVoS for 1 year | With CVoS for 3 years
----- | ----- | ----- | ----- |
**Intel Cascade Lake** |
50% vCPU | {{ sku|KZT|mdb.cluster.kafka.v2.cpu.c50|string }} | − | −
100% vCPU | {{ sku|KZT|mdb.cluster.kafka.v2.cpu.c100|string }} | {{ sku|KZT|v1.commitment.y1.mdb.kafka.cpu.c100.v2|string }} (-30%) | {{ sku|KZT|v1.commitment.y3.mdb.kafka.cpu.c100.v2|string }} (-46%)
RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.kafka.v2.ram|string }} | {{ sku|KZT|v1.commitment.y1.mdb.kafka.ram.v2|string }} (-36%) | {{ sku|KZT|v1.commitment.y3.mdb.kafka.ram.v2|string }} (-50%)

### Host computing resources {{ ZK }} {#prices-zookeeper}

{% note info %}

You can't order {{ ZK }} resources with CVoS discounts.

{% endnote %}

Resource | Rate for 1 hour |
----- | ----- |
**Intel Cascade Lake** |
50% vCPU | {{ sku|KZT|mdb.zk.kafka.v2.cpu.c50|string }} |
100% vCPU | {{ sku|KZT|mdb.zk.kafka.v2.cpu.c100|string }} |
RAM (for 1 GB) | {{ sku|KZT|mdb.zk.kafka.v2.ram|string }} |

### Storage {#prices-storage}

Service | Rate for 1 GB per month |
----- | ----- |
Standard network storage | {{ sku|KZT|mdb.cluster.network-hdd.kafka|month|string }} |
Fast network storage | {{ sku|KZT|mdb.cluster.network-nvme.kafka|month|string }} |
Fast local storage | {{ sku|KZT|mdb.cluster.local-nvme.kafka|month|string }} |
