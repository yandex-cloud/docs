
### Вычислительные ресурсы хостов-брокеров {{ KF }} {#prices-kafka-brokers}

Ресурс | Цена за 1 час | Цена с CVoS на 1 год | Цена с CVoS на 3 года
----- | ----- | ----- | -----
**Intel Cascade Lake** |
50% vCPU | {{ sku|KZT|mdb.cluster.kafka.v2.cpu.c50|string }} | − | −
100% vCPU | {{ sku|KZT|mdb.cluster.kafka.v2.cpu.c100|string }} | {{ sku|KZT|v1.commitment.y1.mdb.kafka.cpu.c100.v2|string }} (-30%) | {{ sku|KZT|v1.commitment.y3.mdb.kafka.cpu.c100.v2|string }} (-46%)
RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.kafka.v2.ram|string }} | {{ sku|KZT|v1.commitment.y1.mdb.kafka.ram.v2|string }} (-36%) | {{ sku|KZT|v1.commitment.y3.mdb.kafka.ram.v2|string }} (-50%)

### Вычислительные ресурсы хостов {{ ZK }} {#prices-zookeeper}

{% note info %}

Заказать ресурсы хостов {{ ZK }} с помощью механизма CVoS невозможно.

{% endnote %}

Ресурс | Цена за 1 час
----- | -----
**Intel Cascade Lake** |
50% vCPU | {{ sku|KZT|mdb.zk.kafka.v2.cpu.c50|string }}
100% vCPU | {{ sku|KZT|mdb.zk.kafka.v2.cpu.c100|string }}
RAM (за 1 ГБ) | {{ sku|KZT|mdb.zk.kafka.v2.ram|string }}

### Хранилище {#prices-storage}

Услуга | Цена за ГБ в месяц
----- | -----
Стандартное сетевое хранилище | {{ sku|KZT|mdb.cluster.network-hdd.kafka|month|string }}
Нереплицируемое сетевое хранилище | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.kafka|month|string }}
Быстрое сетевое хранилище | {{ sku|KZT|mdb.cluster.network-nvme.kafka|month|string }}
Быстрое локальное хранилище | {{ sku|KZT|mdb.cluster.local-nvme.kafka|month|string }}
