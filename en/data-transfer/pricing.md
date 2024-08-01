---
editable: false
---

# {{ data-transfer-name }} pricing policy



{{ data-transfer-name }} usage cost depends on the amount of computing resources used and the number of data rows delivered by transfers that are at the [GA](../overview/concepts/launch-stages.md) stage:

* [{{ PG }}](operations/endpoint/source/postgresql.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ PG }}](operations/endpoint/target/postgresql.md)
* [{{ PG }}](operations/endpoint/source/postgresql.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ CH }}](operations/endpoint/target/clickhouse.md)
* [{{ PG }}](operations/endpoint/source/postgresql.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ KF }}](operations/endpoint/target/kafka.md)
* [{{ MY }}](operations/endpoint/source/mysql.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ MY }}](operations/endpoint/target/mysql.md)
* [{{ MY }}](operations/endpoint/source/mysql.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ CH }}](operations/endpoint/target/clickhouse.md)
* [{{ MY }}](operations/endpoint/source/mysql.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ KF }}](operations/endpoint/target/kafka.md)
* [{{ MG }}](operations/endpoint/source/mongodb.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ MG }}](operations/endpoint/target/mongodb.md)
* [{{ CH }}](operations/endpoint/source/clickhouse.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ CH }}](operations/endpoint/target/clickhouse.md)
* [{{ GP }}](operations/endpoint/source/greenplum.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ CH }}](operations/endpoint/target/clickhouse.md)
* [{{ yds-name }}](operations/endpoint/source/data-streams.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ CH }}](operations/endpoint/target/clickhouse.md)
* [{{ yds-name }}](operations/endpoint/source/data-streams.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ ydb-name }}](operations/endpoint/target/yandex-database.md)
* [{{ yds-name }}](operations/endpoint/source/data-streams.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ KF }}](operations/endpoint/target/kafka.md)
* [{{ KF }}](operations/endpoint/source/kafka.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ ydb-name }}](operations/endpoint/target/yandex-database.md)
* [{{ KF }}](operations/endpoint/source/kafka.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ KF }}](operations/endpoint/target/kafka.md)


Data delivery for transfers that are at the Preview stage is free of charge. For a list of available transfers and their release stages, see [Available transfers](transfer-matrix.md).

## Pricing {#prices}

### Number of transferred rows {#data}



{% include [usd.md](../_pricing/data-transfer/usd.md) %}


### Computing resources {#cpu-ram}



{% include [usd.md](../_pricing/data-transfer/usd-cpu.md) %}

{% include [usd.md](../_pricing/data-transfer/usd-ram.md) %}


## Examples of cost calculation {#price-example}

When calculating the cost, note that by default a single worker uses 2 vCPUs and 4 GB of RAM.

### Single data copying from {{ PG }} to {{ CH }} {#copy}

The number of data rows transferred from {{ PG }} to {{ CH }} during the reporting month is 500,000,000. The copying was handled by one worker and took 24 hours.



CPU cost:

> 24 * 2 * $0.01048 = $0.50304

RAM cost:

> 24 * 4 * $0.0028 = $0.2688

Data transfer cost:

> (500 - 100) * $0.0216 = $8.64

**Total cost**:
 
> $0.50304 + $0.2688 + $8.64 = $9.41184


### Replicating data from {{ PG }} to {{ PG }} {#replication}

The number of data rows transferred from {{ PG }} to {{ PG }} during the reporting month is 50,000,000. The replication went on continuously throughout the whole month with the help of 6 workers.



CPU cost:

> 30 * 24 * 12 * $0.01048 = $90.5472

RAM cost:

> 30 * 24 * 24 * $0.0028 = $48.384

Data transfer cost:

Free of charge, as 50,000,000 rows is less than the free usage quota.

**Total cost**:

> $90.5472 + $48.384 = $138.9312


## See also {#see-also}

* [How to optimize data delivery in {{ data-transfer-name }}](https://www.youtube.com/watch?v=1BJ9YEASOeU)


{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}