### Licenses {#licence}

For the following products, funds are debited once for the calendar month in advance when a VM is started, regardless of the actual amount of time the VM runs for:

| Resource | Cost per vCPU per month, with VAT |
| ----- | ----- |
| Windows Server Datacenter | ₽1202.40
| Microsoft SQL Server Standard | ₽6792.00
| Microsoft SQL Server Enterprise | ₽23227.35


### Host computing resources {#prices-hosts}

| Resource       | Cost for 1 hour, with VAT                          |
|----------------|----------------------------------------------------|
| **Intel Cascade Lake**                                              |
| 100% vCPU      | {{ sku|RUB|mdb.cluster.mssql.v2.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.mssql.v2.ram|string }}      |
| **Intel Ice Lake**                                                  |
| 100% vCPU      | {{ sku|RUB|mdb.cluster.mssql.v3.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.mssql.v3.ram|string }}      |

### Storage and backups {#prices-storage}

{% include [local-ssd for Ice Lake only by request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service                         | Cost of 1 GB per month, with VAT                                       |
|---------------------------------|------------------------------------------------------------------------|
| Standard network storage        | {{ sku|RUB|mdb.cluster.network-hdd.mssql|month|string }}               |
| Non-replicated network storage  | ₽5.5000                                                                |
| Fast network storage            | {{ sku|RUB|mdb.cluster.network-nvme.mssql|month|string }}              |
| Fast local storage              | {{ sku|RUB|mdb.cluster.local-nvme.mssql|month|string }}                |
| Backups beyond the storage size | ₽2.5424                                                                |
