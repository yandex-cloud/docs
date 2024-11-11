---
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


Передача данных для трансферов, находящихся на стадии Preview, не тарифицируется. Перечень доступных трансферов и стадий их готовности см. в разделе [Доступные трансферы](transfer-matrix.md).

## Цены {#prices}

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

  Стоимость CPU:

  > 24 * 2 * 1,31 ₽ = 62,88 ₽

  Стоимость RAM:

  > 24 * 4 * 0,35 ₽ = 33,60 ₽

  Стоимость передачи данных:

  > (500 - 100) * 2,70 ₽ = 1 080,00 ₽

  **Общая стоимость**:

  > 62,88 ₽ + 33,60 ₽ + 1 080,00 ₽ = 1 176,48 ₽

- Расчет в тенге {#prices-kzt}

  Стоимость CPU:

  > 24 * 2 * 6,55 ₸ = 314,40 ₸

  Стоимость RAM:

  > 24 * 4 * 1,75 ₸ = 168,00 ₸

  Стоимость передачи данных:

  > (500 - 100) * 13,50 ₸ = 5 400,00 ₸

  **Общая стоимость**:

  > 314,40 ₸ + 168,00 ₸ + 5 400,00 ₸ = 5 882,40 ₸

{% endlist %}



### Репликация данных из {{ PG }} в {{ PG }} {#replication}

За отчетный месяц было перенесено 50 000 000 строк данных из {{ PG }} в {{ PG }}. Репликация была активна в течение всего месяца и осуществлялась с помощью 6 воркеров (12 vCPU и 24 ГБ RAM).


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  Стоимость CPU:

  > 30 * 24 * 12 * 1,31 ₽ = 11 318,40 ₽

  Стоимость RAM:

  > 30 * 24 * 24 * 0,35 ₽ = 6 048,00 ₽

  Стоимость передачи данных:

  50 000 000 строк входят в объем бесплатного потребления и не тарифицируются.

  **Общая стоимость**:

  > 11 318,40 ₽ + 6 048,00 ₽ = 17 366,40 ₽

- Расчет в тенге {#prices-kzt}

  Стоимость CPU:

  > 30 * 24 * 12 * 6,55 ₸ = 56 592,00 ₸

  Стоимость RAM:

  > 30 * 24 * 24 * 1,75 ₸ = 30 240,00 ₸

  Стоимость передачи данных:

  50 000 000 строк входят в объем бесплатного потребления и не тарифицируются.

  **Общая стоимость**:

  > 56 592,00 ₸ + 30 240,00 ₸ = 86 832,00 ₸

{% endlist %}



## См. также {#see-also}

* [Как оптимизировать поставку данных в {{ data-transfer-name }}](https://www.youtube.com/watch?v=1BJ9YEASOeU).

{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}