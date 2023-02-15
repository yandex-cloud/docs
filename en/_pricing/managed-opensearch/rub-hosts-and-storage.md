{% if stage == "preview" %}

### Host computing resources {#prices-hosts}

| Resource | Cost per hour |
|---------------|---------------|
| **Intel Cascade Lake** |
| 100% vCPU | ₽1.6800 |
| RAM (for 1 GB) | ₽0.7000 |
| **Intel Ice Lake** |
| 100% vCPU | ₽1.6800 |
| RAM (for 1 GB) | ₽0.7000 |

### Storage {#prices-storage}

{% include [local-ssd](../../_includes/ice-lake-local-ssd-note.md) %}

| Service | Cost of 1 GB per month |
|-----------------------------------------|--------------------|
| HDD network storage | ₽3.2000 |
| Non-replicated SSD storage | ₽8.8000 |
| SSD network storage | ₽13.0100 |
| Local SSD storage | ₽13.0100 |
| Backups beyond the storage size | ₽1.9200 |

{% else %}

### Host computing resources {#prices-hosts}

| Resource | Cost per hour |
|---------------|---------------------------------------------------------|
| **Intel Cascade Lake** |
| 100% vCPU | {{ sku|RUB|mdb.cluster.opensearch.v2.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.opensearch.v2.ram|string }} |
| **Intel Ice Lake** |
| 100% vCPU | {{ sku|RUB|mdb.cluster.opensearch.v3.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.opensearch.v3.ram|string }} |

### Storage {#prices-storage}

{% include [local-ssd for Intel Ice Lake only on request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service | Cost of 1 GB per month |
|-----------------------------------------|-----------------------------------------------------------------------------|
| HDD network storage | {{ sku|RUB|mdb.cluster.network-hdd.opensearch|month|string }} |
| Non-replicated SSD storage | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.opensearch|month|string }} |
| SSD network storage | {{ sku|RUB|mdb.cluster.network-nvme.opensearch|month|string }} |
| Local SSD storage | {{ sku|RUB|mdb.cluster.local-nvme.opensearch|month|string }} |
| Backups beyond the storage size | ₽1.92 |

{% endif %}
