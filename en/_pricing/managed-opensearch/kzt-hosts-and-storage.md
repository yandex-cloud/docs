{% if stage == "preview" %}

### Host computing resources {#prices-hosts}

| Resource | Cost per hour |
|---------------|---------------|
| **Intel Cascade Lake** |
| 100% vCPU | ₸8.4000 |
| RAM (for 1 GB) | ₸3.5000 |
| **Intel Ice Lake** |
| 100% vCPU | ₸8.4000 |
| RAM (for 1 GB) | ₸3.5000 |

### Storage {#prices-storage}

{% include [local-ssd](../../_includes/ice-lake-local-ssd-note.md) %}

| Service | Cost of 1 GB per month |
|-----------------------------------------|--------------------|
| HDD network storage | ₸16.0000 |
| Non-replicated SSD storage | ₸44.0000 |
| SSD network storage | ₸65.0500 |
| Local SSD storage | ₸65.0500 |
| Backups beyond the storage size | ₸9.6000 |

{% else %}

### Host computing resources {#prices-hosts}

| Resource | Cost per hour |
|---------------|---------------------------------------------------------|
| **Intel Cascade Lake** |
| 100% vCPU | {{ sku|KZT|mdb.cluster.opensearch.v2.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.opensearch.v2.ram|string }} |
| **Intel Ice Lake** |
| 100% vCPU | {{ sku|KZT|mdb.cluster.opensearch.v3.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.opensearch.v3.ram|string }} |

### Storage {#prices-storage}

{% include [local-ssd for Intel Ice Lake only on request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service | Cost of 1 GB per month |
|-----------------------------------------|-----------------------------------------------------------------------------|
| HDD network storage | {{ sku|KZT|mdb.cluster.network-hdd.opensearch|month|string }} |
| Non-replicated SSD storage | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.opensearch|month|string }} |
| SSD network storage | {{ sku|KZT|mdb.cluster.network-nvme.opensearch|month|string }} |
| Local SSD storage | {{ sku|KZT|mdb.cluster.local-nvme.opensearch|month|string }} |
| Backups beyond the storage size | ₽1.92 |

{% endif %}
