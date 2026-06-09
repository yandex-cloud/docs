# Правила тарификации для {{ data-transfer-name }}



Чтобы рассчитать стоимость использования сервиса, ознакомьтесь с тарифами в этом разделе.

Цены на продукты сервиса также доступны в [Прайс-листе](https://yandex.cloud/ru/price-list).


Все цены в рублях и тенге указаны с НДС, все цены в долларах — без НДС.

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

Передача данных для трансферов, находящихся на стадии Preview, не тарифицируется. Перечень доступных трансферов и стадий их готовности читайте в разделе [Доступные трансферы](transfer-matrix.md).

## Цены для региона Россия {#prices}

{% note info %}

Цены на ресурсы {{ yandex-cloud }} в разных регионах различаются. Подробнее о доступных регионах см. [{#T}](../overview/concepts/region.md).

Валюта, которой можно оплачивать ресурсы, зависит от юридического лица, с которым пользователь заключил договор. Подробнее о регистрации аккаунта см. [{#T}](../billing/quickstart/index.md).

{% endnote %}


| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |




## Примеры расчета стоимости {#price-example}

При расчете стоимости учитывайте, что один [воркер](concepts/index.md#worker) может использовать следующие вычислительные ресурсы:

* 2 виртуальных процессора (vCPU) и 4 гигабайта оперативной памяти (RAM). Эта конфигурация используется по умолчанию.
* 4 vCPU и 8 ГБ RAM.
* 8 vCPU и 16 ГБ RAM.

### Однократное копирование данных из {{ PG }} в {{ CH }} {#copy}

За отчетный месяц было перенесено 500 000 000 строк данных из {{ PG }} в {{ CH }}. Копирование осуществлялось с помощью одного воркера (2 vCPU и 4 ГБ RAM) и длилось 24 часа.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  Стоимость CPU:
  
  > 24 * 2 * {{ sku|RUB|datatransfer.compute.cpu.v1|string }} = {% calc [currency=RUB] 24 * 2 * {{ sku|RUB|datatransfer.compute.cpu.v1|number }} %}
  
  Стоимость RAM:
  
  > 24 * 4 * {{ sku|RUB|datatransfer.compute.ram.v1|string }} = {% calc [currency=RUB] 24 * 4 * {{ sku|RUB|datatransfer.compute.ram.v1|number }} %}
  
  Стоимость передачи данных:
  
  > (500 - 100) * {{ sku|RUB|datatransfer.rows.v1|pricingRate.100|string }} = {% calc [currency=RUB] (500 - 100) * {{ sku|RUB|datatransfer.rows.v1|pricingRate.100|number }} %}
  
  **Общая стоимость**:
  
  > {% calc [currency=RUB] 24 * 2 * {{ sku|RUB|datatransfer.compute.cpu.v1|number }} %} + {% calc [currency=RUB] 24 * 4 * {{ sku|RUB|datatransfer.compute.ram.v1|number }} %} + {% calc [currency=RUB] (500 - 100) * {{ sku|RUB|datatransfer.rows.v1|pricingRate.100|number }} %} = {% calc [currency=RUB] (24 * 2 * {{ sku|RUB|datatransfer.compute.cpu.v1|number }}) + (24 * 4 * {{ sku|RUB|datatransfer.compute.ram.v1|number }}) + ((500 - 100) * {{ sku|RUB|datatransfer.rows.v1|pricingRate.100|number }}) %}

- Расчет в тенге {#prices-kzt}

  Стоимость CPU:
  
  > 24 * 2 * {{ sku|KZT|datatransfer.compute.cpu.v1|string }} = {% calc [currency=KZT] 24 * 2 * {{ sku|KZT|datatransfer.compute.cpu.v1|number }} %}
  
  Стоимость RAM:
  
  > 24 * 4 * {{ sku|KZT|datatransfer.compute.ram.v1|string }} = {% calc [currency=KZT] 24 * 4 * {{ sku|KZT|datatransfer.compute.ram.v1|number }} %}
  
  Стоимость передачи данных:
  
  > (500 - 100) * {{ sku|KZT|datatransfer.rows.v1|pricingRate.100|string }} = {% calc [currency=KZT] (500 - 100) * {{ sku|KZT|datatransfer.rows.v1|pricingRate.100|number }} %}
  
  **Общая стоимость**:
  
  > {% calc [currency=KZT] 24 * 2 * {{ sku|KZT|datatransfer.compute.cpu.v1|number }} %} + {% calc [currency=KZT] 24 * 4 * {{ sku|KZT|datatransfer.compute.ram.v1|number }} %} + {% calc [currency=KZT] (500 - 100) * {{ sku|KZT|datatransfer.rows.v1|pricingRate.100|number }} %} = {% calc [currency=KZT] (24 * 2 * {{ sku|KZT|datatransfer.compute.cpu.v1|number }}) + (24 * 4 * {{ sku|KZT|datatransfer.compute.ram.v1|number }}) + ((500 - 100) * {{ sku|KZT|datatransfer.rows.v1|pricingRate.100|number }}) %}

{% endlist %}



### Репликация данных из {{ PG }} в {{ PG }} {#replication}

За отчетный месяц было перенесено 50 000 000 строк данных из {{ PG }} в {{ PG }}. Репликация была активна в течение всего месяца и осуществлялась с помощью 6 воркеров (12 vCPU и 24 ГБ RAM).


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  Стоимость CPU:
  
  > 30 * 24 * 12 * {{ sku|RUB|datatransfer.compute.cpu.v1|string }} = {% calc [currency=RUB] 30 * 24 * 12 * {{ sku|RUB|datatransfer.compute.cpu.v1|number }} %}
  
  Стоимость RAM:
  
  > 30 * 24 * 24 * {{ sku|RUB|datatransfer.compute.ram.v1|string }} = {% calc [currency=RUB] 30 * 24 * 24 * {{ sku|RUB|datatransfer.compute.ram.v1|number }} %}
  
  Стоимость передачи данных:
  
  50 000 000 строк входят в объем бесплатного потребления и не тарифицируются.
  
  **Общая стоимость**:
  
  > {% calc [currency=RUB] 30 * 24 * 12 * {{ sku|RUB|datatransfer.compute.cpu.v1|number }} %} + {% calc [currency=RUB] 30 * 24 * 24 * {{ sku|RUB|datatransfer.compute.ram.v1|number }} %} = {% calc [currency=RUB] (30 * 24 * 12 * {{ sku|RUB|datatransfer.compute.cpu.v1|number }}) + (30 * 24 * 24 * {{ sku|RUB|datatransfer.compute.ram.v1|number }}) %}

- Расчет в тенге {#prices-kzt}

  Стоимость CPU:
  
  > 30 * 24 * 12 * {{ sku|KZT|datatransfer.compute.cpu.v1|string }} = {% calc [currency=KZT] 30 * 24 * 12 * {{ sku|KZT|datatransfer.compute.cpu.v1|number }} %}
  
  Стоимость RAM:
  
  > 30 * 24 * 24 * {{ sku|KZT|datatransfer.compute.ram.v1|string }} = {% calc [currency=KZT] 30 * 24 * 24 * {{ sku|KZT|datatransfer.compute.ram.v1|number }} %}
  
  Стоимость передачи данных:
  
  50 000 000 строк входят в объем бесплатного потребления и не тарифицируются.
  
  **Общая стоимость**:
  
  > {% calc [currency=KZT] 30 * 24 * 12 * {{ sku|KZT|datatransfer.compute.cpu.v1|number }} %} + {% calc [currency=KZT] 30 * 24 * 24 * {{ sku|KZT|datatransfer.compute.ram.v1|number }} %} = {% calc [currency=KZT] (30 * 24 * 12 * {{ sku|KZT|datatransfer.compute.cpu.v1|number }}) + (30 * 24 * 24 * {{ sku|KZT|datatransfer.compute.ram.v1|number }}) %}

{% endlist %}



## См. также {#see-also}

* [Как оптимизировать поставку данных в {{ data-transfer-name }}](https://www.youtube.com/watch?v=1BJ9YEASOeU).

_{{ CH }} является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._