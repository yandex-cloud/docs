### Licenses {#licence}

For the following products, funds are debited once for the calendar month in advance when a VM is started, regardless of the actual amount of time the VM runs for:

| Resource | Cost per vCPU per month
| --- | ---
| Windows Server Datacenter | $24.653846
| Microsoft SQL Server Standard | $139.320514
| Microsoft SQL Server Enterprise | $476.448724

### Host computing resources {#prices-hosts}

| Resource       | Cost for 1 hour                                    |
|----------------|----------------------------------------------------|
| **Intel Cascade Lake**                                              |
| 100% vCPU      | {{ sku|USD|mdb.cluster.mssql.v2.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|USD|mdb.cluster.mssql.v2.ram|string }}      |
| **Intel Ice Lake**                                                  |
| 100% vCPU      | {{ sku|USD|mdb.cluster.mssql.v3.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|USD|mdb.cluster.mssql.v3.ram|string }}      |

### Storage and backups {#prices-storage}

{% include [local-ssd for Ice Lake only by request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service                         | Cost of 1 GB per month                                                 |
|---------------------------------|------------------------------------------------------------------------|
| Standard network storage        | {{ sku|USD|mdb.cluster.network-hdd.mssql|month|string }}               |
| Non-replicated network storage  | $0.070512                                                              |
| Fast network storage            | {{ sku|USD|mdb.cluster.network-nvme.mssql|month|string }}              |
| Fast local storage              | {{ sku|USD|mdb.cluster.local-nvme.mssql|month|string }}                |
| Backups beyond the storage size | $0.032594                                                              |
