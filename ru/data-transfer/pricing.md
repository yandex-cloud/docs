---
editable: false
---

# Правила тарификации для {{ data-transfer-name }}



## Действующие правила тарификации {#effective-rules}

В настоящий момент потребление ресурсов {{ data-transfer-name }} не тарифицируется.

За потребление других ресурсов {{ yandex-cloud }}, которые вы будете использовать в процессе трансфера (например, сервисов управляемых баз данных), будет взиматься плата в соответствии с их [тарифами]({{ link-cloud-calculator }}).

## Правила тарификации с 1 августа 2024 года {#service-plans}

С 1 августа 2024 года стоимость использования {{ data-transfer-name }} будет зависеть от объема использованных вычислительных ресурсов и количества переданных строк данных трансферами, которые находятся на стадии [GA](../overview/concepts/launch-stages.md): 

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

### Цены {#prices}

#### Количество строк, перенесенных трансфером {#data}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/data-transfer/rub.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/data-transfer/kzt.md) %}

{% endlist %}



#### Вычислительные ресурсы {#cpu-ram}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/data-transfer/rub-cpu.md) %}

  {% include [rub.md](../_pricing/data-transfer/rub-ram.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/data-transfer/kzt-cpu.md) %}

  {% include [kzt.md](../_pricing/data-transfer/kzt-ram.md) %}

{% endlist %}



### Примеры расчета стоимости {#price-example}

При расчете стоимости необходимо учитывать, что по умолчанию один воркер использует 2 vCPU и 2 ГБ RAM. 

#### Однократное копирование данных из {{ PG }} в {{ CH }} {#copy}

За отчетный месяц было перенесено 500 000 000 строк данных из {{ PG }} в {{ CH }}. Копирование осуществлялось с помощью одного воркера и длилось 24 часа.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  Стоимость CPU:

  > 24 * 2 * 1,31 ₽ = 62,88 ₽

  Стоимость RAM:

  > 24 * 2 * 0,35 ₽ = 16,80 ₽

  Стоимость передачи данных:

  > (500 - 100) * 2,70 ₽ = 1080,00 ₽

  **Общая стоимость**:

  > 62,88 ₽ + 16,80 ₽ + 1080,00 ₽ = 1159,68 ₽

- Расчет в тенге {#prices-kzt}

  Стоимость CPU:

  > 24 * 2 * 6,55 ₸ = 314,40 ₸

  Стоимость RAM:

  > 24 * 2 * 1,75 ₸ = 84,00 ₸

  Стоимость передачи данных:

  > (500 - 100) * 13,50 ₸ = 5400,00 ₸

  **Общая стоимость**:

  > 314,40 ₸ + 84,00 ₸ + 5400,00 ₸ = 5798,40 ₸

{% endlist %}



#### Репликация данных из {{ PG }} в {{ PG }} {#replication}

За отчетный месяц было перенесено 50 000 000 строк данных из {{ PG }} в {{ PG }}. Репликация осуществлялась непрерывно в течение всего месяца с помощью 6 воркеров.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  Стоимость CPU:

  > 30 * 24 * 6 * 1,31 ₽ = 5659,20 ₽

  Стоимость RAM:

  > 30 * 24 * 6 * 0,35 ₽ = 1512,00 ₽

  Стоимость передачи данных:

  50 000 000 строк входят в объем бесплатного потребления и не тарифицируются.

  **Общая стоимость**:

  > 5659,20 ₽ + 1512,00 ₽ = 7171,20 ₽

- Расчет в тенге {#prices-kzt}

  Стоимость CPU:

  > 30 * 24 * 6 * 6,55 ₸ = 28 296,00 ₸

  Стоимость RAM:

  > 30 * 24 * 6 * 1,75 ₸ = 7560,00 ₸

  Стоимость передачи данных:

  50 000 000 строк входят в объем бесплатного потребления и не тарифицируются. 

  **Общая стоимость**:

  > 28 296,00 ₸ + 7560,00 ₸ = 35 856,00 ₸

{% endlist %}




{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}
