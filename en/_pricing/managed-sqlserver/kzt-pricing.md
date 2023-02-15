### Licenses {#licence}

For the following products, funds are debited once [for an entire calendar month](../../managed-sqlserver/pricing/index.md#license) when a cluster is launched, regardless of the actual amount of time the cluster runs for and the launch date:

| Product | Cost of 1 vCPU per month |
| --- | --- |
| Windows Server Datacenter | ₸9615 |
| Microsoft SQL Server Standard | ₸54335 |
| Microsoft SQL Server Enterprise | ₸185815 |

### Host computing resources {#prices-hosts}

| Resource | Cost per hour |
| --- | --- |
| **Intel Cascade Lake** |
| 100% vCPU | {{ sku|KZT|mdb.cluster.mssql.v2.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.mssql.v2.ram|string }} |
| **Intel Ice Lake** |
| 100% vCPU | {{ sku|KZT|mdb.cluster.mssql.v3.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.mssql.v3.ram|string }} |

### Storage and backups {#prices-storage}

{% include [local-ssd for Ice Lake only on request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service | Cost of 1 GB per month |
| --- | --- |
| HDD network storage | {{ sku|KZT|mdb.cluster.network-hdd.mssql|month|string }} |
| Non-replicated SSD storage | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.mssql|month|string }} |
| SSD network storage | {{ sku|KZT|mdb.cluster.network-nvme.mssql|month|string }} |
| Local SSD storage | {{ sku|KZT|mdb.cluster.local-nvme.mssql|month|string }} |
| Backups beyond the storage size | ₸9.6000 |
