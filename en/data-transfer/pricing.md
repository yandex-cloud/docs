---
editable: false
---

# {{ data-transfer-name }} pricing policy


## Current pricing policy {#effective-rules}

Currently, {{ data-transfer-name }} resources are free of charge.

Other {{ yandex-cloud }} resources you may use during transfer (e.g., managed database services) will be charged based on their [pricing plans]({{ link-cloud-calculator }}).

## Pricing policy as of August 1, 2024 {#service-plans}

From August 1, 2024, the cost of using {{ data-transfer-name }} depends on the amount of compute resources used and the number of data rows transferred for each transfer at the GA stage.

* [{{ PG }}](operations/endpoint/source/postgresql.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ PG }}](operations/endpoint/target/postgresql.md);
* [{{ PG }}](operations/endpoint/source/postgresql.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ CH }}](operations/endpoint/target/clickhouse.md);
* [{{ PG }}](operations/endpoint/source/postgresql.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ KF }}](operations/endpoint/target/kafka.md);
* [{{ MY }}](operations/endpoint/source/mysql.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ MY }}](operations/endpoint/target/mysql.md);
* [{{ MY }}](operations/endpoint/source/mysql.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ CH }}](operations/endpoint/target/clickhouse.md);
* [{{ MY }}](operations/endpoint/source/mysql.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ KF }}](operations/endpoint/target/kafka.md);
* [{{ MG }}](operations/endpoint/source/mongodb.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ MG }}](operations/endpoint/target/mongodb.md);
* [{{ CH }}](operations/endpoint/source/clickhouse.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ CH }}](operations/endpoint/target/clickhouse.md);
* [{{ GP }}](operations/endpoint/source/greenplum.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ CH }}](operations/endpoint/target/clickhouse.md).
* [{{ yds-name }}](operations/endpoint/source/data-streams.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ CH }}](operations/endpoint/target/clickhouse.md);
* [{{ yds-name }}](operations/endpoint/source/data-streams.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ ydb-name }}](operations/endpoint/target/yandex-database.md);
* [{{ yds-name }}](operations/endpoint/source/data-streams.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ KF }}](operations/endpoint/target/kafka.md);
* [{{ KF }}](operations/endpoint/source/kafka.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ ydb-name }}](operations/endpoint/target/yandex-database.md);
* [{{ KF }}](operations/endpoint/source/kafka.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ KF }}](operations/endpoint/target/kafka.md).

Transfers at the Preview stage are not charged. For a list of available transfers and their stages of readiness, see the [Available transfers](transfer-matrix.md) section.

### Prices {#prices}

#### Number of transferred rows {#data}



{% include [usd.md](../_pricing/data-transfer/usd.md) %}


#### Computing resources {#cpu-ram}



{% include [usd.md](../_pricing/data-transfer/usd-cpu.md) %}

{% include [usd.md](../_pricing/data-transfer/usd-ram.md) %}


### Example of calculating the cost {#price-example}

When calculating the cost, it is necessary to take into account that by default one worker uses 2 vCPUs and 2 GB of RAM.

#### One-time copying data from {{ PG }} to {{ CH }} {#copy}

During the reporting month, 500,000,000 rows of data were transferred from {{ PG }} to {{ CH }}. Copying was carried out using one worker, and it lasted 24 hours.



CPU cost:

> 24 * 2 * $0.01048 = $0.50304

RAM cost calculation:

> 24 * 2 * $0.0028 = $0.1344

Transfer cost calculation:
 
> (500 - 100) * $0.0216 = $8.64

**Total cost**:
 
> $0.50304 + $0.1344 + $8.64 = $9.27744


#### Replicating data from {{ PG }} to {{ PG }} {#replication}

During the reporting month, 50,000,000 rows of data were transferred from {{ PG }} to {{ PG }}. Replication was carried out continuously throughout the month using 6 workers.



CPU cost:

> 30 * 24 * 6 * $0.01048 = $45.2736

RAM cost:

> 30 * 24 * 6 * $0.0028 = $12.096

Transfer cost:

50,000,000 rows are included in the volume of free consumption and are not charged.

**Total cost**:

> $45.2736 + $12.096 = $57.3696



{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}
