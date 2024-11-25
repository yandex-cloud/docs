---
editable: false
---

# {{ data-transfer-name }} pricing policy



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{{ data-transfer-name }} cost depends on the amount of computing resources you use and the number of data rows delivered by transfers that are at the [GA](../overview/concepts/launch-stages.md) stage: 

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

When calculating the cost, note that one [worker](concepts/index.md#worker) can use the following computing resources:

{% include [vm-computing-resources](../_includes/data-transfer/vm-computing-resources.md) %}

### Single data copying from {{ PG }} to {{ CH }} {#copy}

The number of data rows transferred from {{ PG }} to {{ CH }} during the reporting month is 500,000,000. The copying was performed by one worker (2 vCPUs and 4 GB RAM) and took 24 hours.



{% include [usd-copy](../_pricing_examples/data-transfer/usd-copy.md) %}


### Replicating data from {{ PG }} to {{ PG }} {#replication}

The number of data rows transferred from {{ PG }} to {{ PG }} during the reporting month is 50,000,000. The replication was active throughout the month, and was performed by 6 workers (12 vCPUs and 24 GB RAM).



{% include [usd-replication](../_pricing_examples/data-transfer/usd-replication.md) %}


## See also {#see-also}

* [How to optimize data delivery in {{ data-transfer-name }}](https://www.youtube.com/watch?v=1BJ9YEASOeU).

{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}