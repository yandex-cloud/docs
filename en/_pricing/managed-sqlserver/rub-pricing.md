### Licenses {#licence}

| Resource | Cost per hour, with VAT
| ----- | -----
| Windows Server Datacenter for 100% vCPU | ₽1,2691

For the following products, funds are debited once for the calendar month in advance when a VM is started, regardless of the actual amount of time the VM runs for:

| Resource | Cost per vCPU per month, with VAT |
| ----- | ----- |
| Microsoft SQL Server Standard | ₽5896,5 |
| Microsoft SQL Server Enterprise | ₽20163 |


### Host computing resources {#prices-hosts}

| Resource | Cost for 1 hour, with VAT |
| ----- | ----- |
| **Intel Cascade Lake** |
| 100% vCPU | {{ sku|RUB|mdb.cluster.mssql.v2.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.mssql.v2.ram|string }} |

### Storage and backups {#prices-storage}

{% include [nrd-disks-preview](../../_includes/mdb/non-replicated-disks-preview.md) %}

| Service | Cost of 1 GB per month, with VAT |
| ----------------------------------------- | ------------------------------------------------------------------------ |
| Standard network storage | {{ sku|RUB|mdb.cluster.network-hdd.mssql|month|string }} |
| Non-replicated network storage | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.mssql|month|string }} |
| Fast network storage | {{ sku|RUB|mdb.cluster.network-nvme.mssql|month|string }} |
| Fast local storage | {{ sku|RUB|mdb.cluster.local-nvme.mssql|month|string }} |
| Backups beyond the storage size | ₽2.5424 |
