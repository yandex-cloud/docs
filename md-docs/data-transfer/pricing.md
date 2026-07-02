[Документация Yandex Cloud](../index.md) > [Yandex Data Transfer](index.md) > Правила тарификации

# Правила тарификации для Data Transfer



Чтобы рассчитать стоимость использования сервиса, ознакомьтесь с тарифами в этом разделе.

Цены на продукты сервиса также доступны в [Прайс-листе](https://yandex.cloud/ru/price-list).


Все цены в рублях и тенге указаны с НДС, все цены в долларах — без НДС.

Стоимость использования Data Transfer зависит от объема использованных вычислительных ресурсов и количества переданных строк данных трансферами, которые находятся на стадии [GA](../overview/concepts/launch-stages.md): 

* [PostgreSQL](operations/endpoint/source/postgresql.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [PostgreSQL](operations/endpoint/target/postgresql.md);
* [PostgreSQL](operations/endpoint/source/postgresql.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [ClickHouse®](operations/endpoint/target/clickhouse.md);
* [PostgreSQL](operations/endpoint/source/postgresql.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [Apache Kafka®](operations/endpoint/target/kafka.md);
* [MySQL®](operations/endpoint/source/mysql.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [MySQL®](operations/endpoint/target/mysql.md);
* [MySQL®](operations/endpoint/source/mysql.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [ClickHouse®](operations/endpoint/target/clickhouse.md);
* [MySQL®](operations/endpoint/source/mysql.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [Apache Kafka®](operations/endpoint/target/kafka.md);
* [MongoDB](operations/endpoint/source/mongodb.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [MongoDB](operations/endpoint/target/mongodb.md);
* [ClickHouse®](operations/endpoint/source/clickhouse.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [ClickHouse®](operations/endpoint/target/clickhouse.md);
* [Greenplum®](operations/endpoint/source/greenplum.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [ClickHouse®](operations/endpoint/target/clickhouse.md);
* [Data Streams](operations/endpoint/source/data-streams.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [ClickHouse®](operations/endpoint/target/clickhouse.md);
* [Data Streams](operations/endpoint/source/data-streams.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [Managed Service for YDB](operations/endpoint/target/yandex-database.md);
* [Data Streams](operations/endpoint/source/data-streams.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [Apache Kafka®](operations/endpoint/target/kafka.md);
* [Apache Kafka®](operations/endpoint/source/kafka.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [Managed Service for YDB](operations/endpoint/target/yandex-database.md);
* [Apache Kafka®](operations/endpoint/source/kafka.md) ![arrow_right](../_assets/console-icons/arrow-right.svg) [Apache Kafka®](operations/endpoint/target/kafka.md).

{% note info %}

Оплата за потребление ресурсов списывается для трансферов в [статусах](concepts/transfer-lifecycle.md#statuses) **Реплицируется**(`RUNNING`), **Копируется** (`SNAPSHOTTING`) или **Останавливается** (`STOPPING`). Статус трансфера можно [посмотреть в списке трансферов](operations/transfer.md#list).

{% endnote %}

Передача данных для трансферов, находящихся на стадии Preview, не тарифицируется. Перечень доступных трансферов и стадий их готовности читайте в разделе [Доступные трансферы](transfer-matrix.md).

## Цены для региона Россия {#prices}

{% note info %}

Цены на ресурсы Yandex Cloud в разных регионах различаются. Подробнее о доступных регионах в разделе [Регионы](../overview/concepts/region.md).

Валюта, которой можно оплачивать ресурсы, зависит от юридического лица, с которым пользователь заключил договор. Подробнее о регистрации аккаунта в разделе [Регистрация аккаунта в Yandex Cloud](../billing/quickstart/index.md).

{% endnote %}


| Услуга                                                                                | Цена              | Ед. тарификации | Действует с    | Действует до |
| ------------------------------------------------------------------------------------- | ----------------- | --------------- | -------------- | ------------ |
| Data Transfer. Oбъём памяти (RAM)                                                     | 0,4035 ₽          | ГБ × час        | 30 апреля 2026 | —            |
| Data Transfer. Количество перенесённых строк, от 0 до 100 единицы тарификации в месяц | Не тарифицируется | 1 млн строк     | 30 апреля 2026 | —            |
| Data Transfer. Количество перенесённых строк, от 100 единицы тарификации в месяц      | 3,11 ₽            | 1 млн строк     | 30 апреля 2026 | —            |
| Data Transfer. Количество ядер                                                        | 1,51 ₽            | vCPU × час      | 30 апреля 2026 | —            |




## Примеры расчета стоимости {#price-example}

При расчете стоимости учитывайте, что один [воркер](concepts/index.md#worker) может использовать следующие вычислительные ресурсы:

* 2 виртуальных процессора (vCPU) и 4 гигабайта оперативной памяти (RAM). Эта конфигурация используется по умолчанию.
* 4 vCPU и 8 ГБ RAM.
* 8 vCPU и 16 ГБ RAM.

### Однократное копирование данных из PostgreSQL в ClickHouse® {#copy}

За отчетный месяц было перенесено 500 000 000 строк данных из PostgreSQL в ClickHouse®. Копирование осуществлялось с помощью одного воркера (2 vCPU и 4 ГБ RAM) и длилось 24 часа.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  Стоимость CPU:
  
  > 24 * 2 * 1,51 ₽ = 72,48 ₽
  
  Стоимость RAM:
  
  > 24 * 4 * 0,4035 ₽ = 38,736 ₽
  
  Стоимость передачи данных:
  
  > (500 - 100) * 3,11 ₽ = 1 244 ₽
  
  **Общая стоимость**:
  
  > 72,48 ₽ + 38,736 ₽ + 1 244 ₽ = 1 355,216 ₽

- Расчет в тенге {#prices-kzt}

  Стоимость CPU:
  
  > 24 * 2 * 7,55 ₸ = 362,4 ₸
  
  Стоимость RAM:
  
  > 24 * 4 * 2,0175 ₸ = 193,68 ₸
  
  Стоимость передачи данных:
  
  > (500 - 100) * 15,55 ₸ = 6 220 ₸
  
  **Общая стоимость**:
  
  > 362,4 ₸ + 193,68 ₸ + 6 220 ₸ = 6 776,08 ₸

{% endlist %}



### Репликация данных из PostgreSQL в PostgreSQL {#replication}

За отчетный месяц было перенесено 50 000 000 строк данных из PostgreSQL в PostgreSQL. Репликация была активна в течение всего месяца и осуществлялась с помощью 6 воркеров (12 vCPU и 24 ГБ RAM).


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  Стоимость CPU:
  
  > 30 * 24 * 12 * 1,51 ₽ = 13 046,4 ₽
  
  Стоимость RAM:
  
  > 30 * 24 * 24 * 0,4035 ₽ = 6 972,48 ₽
  
  Стоимость передачи данных:
  
  50 000 000 строк входят в объем бесплатного потребления и не тарифицируются.
  
  **Общая стоимость**:
  
  > 13 046,4 ₽ + 6 972,48 ₽ = 20 018,88 ₽

- Расчет в тенге {#prices-kzt}

  Стоимость CPU:
  
  > 30 * 24 * 12 * 7,55 ₸ = 65 232 ₸
  
  Стоимость RAM:
  
  > 30 * 24 * 24 * 2,0175 ₸ = 34 862,4 ₸
  
  Стоимость передачи данных:
  
  50 000 000 строк входят в объем бесплатного потребления и не тарифицируются.
  
  **Общая стоимость**:
  
  > 65 232 ₸ + 34 862,4 ₸ = 100 094,4 ₸

{% endlist %}



## Полезные ссылки {#see-also}

* [Как оптимизировать поставку данных в Data Transfer](https://www.youtube.com/watch?v=1BJ9YEASOeU).

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._