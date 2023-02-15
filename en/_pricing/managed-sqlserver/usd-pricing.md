### Licenses {#licence}

For the following products, funds are debited [once for an entire calendar month](../../managed-sqlserver/pricing/index.md#license) when the cluster is running, regardless of the actual amount of time the cluster runs for or the date it was started:

| Resource | Cost per vCPU per month |
| --- | ---
| Windows Server Datacenter | $15.384000 |
| Microsoft SQL Server Standard | $86.936000 |
| Microsoft SQL Server Enterprise | $297.304000 |

### Host computing resources {#prices-hosts}

| Resource | Cost per hour |
|----------------|----------------------------------------------------|
| **Intel Cascade Lake** |
| 100% vCPU | {{ sku|USD|mdb.cluster.mssql.v2.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|USD|mdb.cluster.mssql.v2.ram|string }} |
| **Intel Ice Lake** |
| 100% vCPU | {{ sku|USD|mdb.cluster.mssql.v3.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|USD|mdb.cluster.mssql.v3.ram|string }} |

### Storage and backups {#prices-storage}

{% include [local-ssd for Ice Lake only on request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service | Cost of 1 GB per month |
|---------------------------------|------------------------------------------------------------------------|
| Standard network storage | {{ sku|USD|mdb.cluster.network-hdd.mssql|month|string }} |
| Non-replicated network storage | $0.070512 |
| Fast network storage | {{ sku|USD|mdb.cluster.network-nvme.mssql|month|string }} |
| Fast local storage | {{ sku|USD|mdb.cluster.local-nvme.mssql|month|string }} |
| Backups beyond the storage size | $0.032594 |
