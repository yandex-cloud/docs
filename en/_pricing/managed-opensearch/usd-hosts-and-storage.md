{% if stage == "preview" %}

### Host computing resources {#prices-hosts}

| Resource | Cost for 1 hour |
|----------------|-----------------|
| **Intel Cascade Lake** |
| 100% vCPU | $0.021538 |
| RAM (for 1 GB) | $0.008974 |
| **Intel Ice Lake** |
| 100% vCPU | $0.021538 |
| RAM (for 1 GB) | $0.008974 |

### Storage {#prices-storage}

{% include [local-ssd](../../_includes/ice-lake-local-ssd-note.md) %}

| Service | Cost of 1 GB per month |
|---------------------------------|------------------------|
| Standard network storage | $0.041025 |
| Non-replicated network storage | $0.112820 |
| Fast network storage | $0.166794 |
| Fast local storage | $0.166794 |
| Backups beyond the storage size | $0.024615 |

{% else %}

### Host computing resources {#prices-hosts}

| Resource | Cost for 1 hour |
|----------------|---------------------------------------------------------|
| **Intel Cascade Lake** |
| 100% vCPU | {{ sku|USD|mdb.cluster.opensearch.v2.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|USD|mdb.cluster.opensearch.v2.ram|string }} |
| **Intel Ice Lake** |
| 100% vCPU | {{ sku|USD|mdb.cluster.opensearch.v3.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|USD|mdb.cluster.opensearch.v3.ram|string }} |

### Storage {#prices-storage}

{% include [local-ssd for Intel Ice Lake only on request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service | Cost of 1 GB per month |
|---------------------------------|-----------------------------------------------------------------------------|
| Standard network storage | {{ sku|USD|mdb.cluster.network-hdd.opensearch|month|string }} |
| Non-replicated network storage | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.opensearch|month|string }} |
| Fast network storage | {{ sku|USD|mdb.cluster.network-nvme.opensearch|month|string }} |
| Fast local storage | {{ sku|USD|mdb.cluster.local-nvme.opensearch|month|string }} |
| Backups beyond the storage size | $0.024615 |

{% endif %}
