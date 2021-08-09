### Licenses {#licence}

For the following products, funds are debited once for the calendar month in advance when a VM is started, regardless of the actual amount of time the VM runs for:

| Resource | Cost per month , with VAT|
| ----- | ----- |
| Windows Server Standard* | ₸36120 per host |
| Microsoft SQL Server Standard | ₸141516 for every 4 vCPUs |
| Microsoft SQL Server Enterprise | ₸483912 for every 4 vCPUs |

\* Windows Server Standard is provided at a fixed price that doesn't depend on VM configurations.

### Host computing resources {#prices-hosts}

| Resource | Cost for 1 hour, with VAT |
| ----- | ----- |
| **Intel Cascade Lake** |
| 100% vCPU | {{ sku|KZT|mdb.cluster.mssql.v2.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.mssql.v2.ram|string }} |

### Storage and backups {#prices-storage}

| Service | Cost of 1 GB per month, with VAT |
| ----- | ----- |
| Standard network storage | {{sku|KZT|mdb.cluster.network-hdd.mssql|month|string }} |
| Non-replicated network storage | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.mssql|month|string }} |
| Fast network storage | {{sku|KZT|mdb.cluster.network-nvme.mssql|month|string }} |
| Fast local storage | {{ sku|KZT|mdb.cluster.local-nvme.mssql|month|string }} |
| Backups beyond the storage size | ₸15.2544 |

