---
title: Правила тарификации для {{ data-transfer-full-name }}
description: В статье содержатся правила тарификации сервиса {{ data-transfer-name }}.
editable: false
---

# Правила тарификации для {{ data-transfer-name }}



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

Стоимость использования {{ data-transfer-name }} зависит от объема использованных вычислительных ресурсов и количества переданных строк данных трансферами, которые находятся на стадии [GA](../overview/concepts/launch-stages.md): 

* [{{ PG }}](operations/endpoint/source/postgresql.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ PG }}](operations/endpoint/target/postgresql.md);
* [{{ PG }}](operations/endpoint/source/postgresql.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ CH }}](operations/endpoint/target/clickhouse.md);
* [{{ PG }}](operations/endpoint/source/postgresql.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ KF }}](operations/endpoint/target/kafka.md);
* [{{ MY }}](operations/endpoint/source/mysql.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ MY }}](operations/endpoint/target/mysql.md);
* [{{ MY }}](operations/endpoint/source/mysql.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ CH }}](operations/endpoint/target/clickhouse.md);
* [{{ MY }}](operations/endpoint/source/mysql.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ KF }}](operations/endpoint/target/kafka.md);
* [{{ MG }}](operations/endpoint/source/mongodb.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ MG }}](operations/endpoint/target/mongodb.md);
* [{{ CH }}](operations/endpoint/source/clickhouse.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ CH }}](operations/endpoint/target/clickhouse.md);
* [{{ GP }}](operations/endpoint/source/greenplum.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ CH }}](operations/endpoint/target/clickhouse.md);
* [{{ yds-name }}](operations/endpoint/source/data-streams.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ CH }}](operations/endpoint/target/clickhouse.md);
* [{{ yds-name }}](operations/endpoint/source/data-streams.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ ydb-name }}](operations/endpoint/target/yandex-database.md);
* [{{ yds-name }}](operations/endpoint/source/data-streams.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ KF }}](operations/endpoint/target/kafka.md);
* [{{ KF }}](operations/endpoint/source/kafka.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ ydb-name }}](operations/endpoint/target/yandex-database.md);
* [{{ KF }}](operations/endpoint/source/kafka.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [{{ KF }}](operations/endpoint/target/kafka.md).

{% note info %}

Оплата за потребление ресурсов списывается для трансферов в [статусах](concepts/transfer-lifecycle.md#statuses) {{ dt-status-repl }}(`RUNNING`), {{ dt-status-copy }} (`SNAPSHOTTING`) или {{ dt-status-stopping }} (`STOPPING`). Статус трансфера можно [посмотреть в списке трансферов](operations/transfer.md#list).

{% endnote %}

Передача данных для трансферов, находящихся на стадии Preview, не тарифицируется. Перечень доступных трансферов и стадий их готовности см. в разделе [Доступные трансферы](transfer-matrix.md).

## Цены для региона Россия {#prices}

{% include [vat.md](../_includes/vat.md) %}

### Количество строк, перенесенных трансфером {#data}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/data-transfer/rub.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/data-transfer/kzt.md) %}

{% endlist %}



### Вычислительные ресурсы {#cpu-ram}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/data-transfer/rub-cpu.md) %}

  {% include [rub.md](../_pricing/data-transfer/rub-ram.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/data-transfer/kzt-cpu.md) %}

  {% include [kzt.md](../_pricing/data-transfer/kzt-ram.md) %}

{% endlist %}



## Примеры расчета стоимости {#price-example}

При расчете стоимости учитывайте, что один [воркер](concepts/index.md#worker) может использовать следующие вычислительные ресурсы:

{% include [vm-computing-resources](../_includes/data-transfer/vm-computing-resources.md) %}

### Однократное копирование данных из {{ PG }} в {{ CH }} {#copy}

За отчетный месяц было перенесено 500 000 000 строк данных из {{ PG }} в {{ CH }}. Копирование осуществлялось с помощью одного воркера (2 vCPU и 4 ГБ RAM) и длилось 24 часа.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-copy](../_pricing_examples/data-transfer/rub-copy.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-copy](../_pricing_examples/data-transfer/kzt-copy.md) %}

{% endlist %}



### Репликация данных из {{ PG }} в {{ PG }} {#replication}

За отчетный месяц было перенесено 50 000 000 строк данных из {{ PG }} в {{ PG }}. Репликация была активна в течение всего месяца и осуществлялась с помощью 6 воркеров (12 vCPU и 24 ГБ RAM).


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-replication](../_pricing_examples/data-transfer/rub-replication.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-replication](../_pricing_examples/data-transfer/kzt-replication.md) %}

{% endlist %}



## См. также {#see-also}

* [Как оптимизировать поставку данных в {{ data-transfer-name }}](https://www.youtube.com/watch?v=1BJ9YEASOeU).

{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}