### Licenses {#licence}

For the following products, funds are debited once for the calendar month in advance when a VM is started, regardless of the actual amount of time the VM runs for:

| Resource | Cost per vCPU per month |
| ----- | ----- |
| Windows Server Datacenter | ₽1923 |
| Microsoft SQL Server Standard | ₽10867 |
| Microsoft SQL Server Enterprise | ₽37163 |


### Host computing resources {#prices-hosts}

| Resource       | Cost for 1 hour                                    | |
| ----- | ----- | ----- |
| | **Up until April 12, 2022** | **Starting April 13, 2022** |
| **Intel Cascade Lake**                                              | |
| 100% vCPU      | {{ sku|RUB|mdb.cluster.mssql.v2.cpu.c100|string }} | ₽1.9200 |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.mssql.v2.ram|string }}      | ₽0.5100 |
| **Intel Ice Lake**                                                  | |
| 100% vCPU      | {{ sku|RUB|mdb.cluster.mssql.v3.cpu.c100|string }} | ₽1.7200 |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.mssql.v3.ram|string }}      | ₽0.4600 |

### Storage and backups {#prices-storage}

{% include [local-ssd for Ice Lake only by request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service                         | Cost of 1 GB per month                                                 | |
| ----- | ----- | ----- |
| | **Up until April 12, 2022** | **Starting April 13, 2022** |
| Standard network storage        | {{ sku|RUB|mdb.cluster.network-hdd.mssql|month|string }}               | ₽3.2000 |
| Non-replicated network storage  | ₽5.5000                                                                | ₽8.8000 |
| Fast network storage            | {{ sku|RUB|mdb.cluster.network-nvme.mssql|month|string }}              | ₽13.0100 |
| Fast local storage              | {{ sku|RUB|mdb.cluster.local-nvme.mssql|month|string }}                | ₽13.0100 |
| Backups beyond the storage size | ₽2.5424                                                                | ₽1.9200 |
