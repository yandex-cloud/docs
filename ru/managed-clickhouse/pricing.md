---
editable: false
---

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

# Правила тарификации для Managed Service for ClickHouse


## Из чего складывается стоимость использования Managed Service for ClickHouse {#rules}

Расчет стоимости использования Managed Service for ClickHouse учитывает:

* тип и объем хранилища (дискового пространства);

* [класс хостов](concepts/instance-types.md), выбранный для кластера;

* количество хостов БД в кластерах (в том числе хостов ZooKeeper для кластеров ClickHouse);

* настройки и количество резервных копий;

* объем исходящего трафика.


{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}


### Использование хостов БД {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы хоста в соответствии с его классом. Точные характеристики классов приведены в разделе [#T](concepts/instance-types.md).

{% note important %}

Для каждого кластера ClickHouse с 2 и более хостами ClickHouse автоматически создается 3 хоста ZooKeeper.

{% endnote %}

Минимальная единица тарификации — час (например, стоимость 1,5 часов работы хоста равна стоимости 2 часов). Время, когда хост СУБД или ZooKeeper не может выполнять свои основные функции, не тарифицируется.


### Использование дискового пространства {#rules-storage}

Оплачивается:

* Объем хранилища, выделенный для кластеров БД.

    * Хранилище на быстрых локальных дисках (NVMe) можно заказывать только для кластеров более чем с 2 хостами, с шагом 100 ГБ.


* Объем, занимаемый резервными копиями баз данных сверх заданного хранилища для кластера.

    * Хранение резервных копий не тарифицируется пока сумма размера БД и всех резервных копий остается меньше выбранного объема хранилища.

    * При автоматическом резервном копировании Managed Service for ClickHouse не создает новую копию, а сохраняет изменения БД по сравнению с предыдущей копией. Поэтому потребление хранилища автоматическими резервными копиями растет только пропорционально объему изменений.

    * Количество хостов кластера не влияет на объем хранилища и, соответственно, на бесплатный объем резервных копий.



Цена указывается за 1 месяц использования.  Минимальная единица тарификации — ГБ в час (например, стоимость хранения 1 ГБ в течение 1,5 часов равна стоимости хранения в течение 2 часов).


### ClickHouse и ZooKeeper {#clickhouse-zookeeper}

Вы можете выбрать класс хостов как для хостов ClickHouse, так и для хостов ZooKeeper (в соответствии с ожидаемой нагрузкой реплицирования).

Например, вы создали кластер ClickHouse из 3 хостов, с классом хостов `s1.micro`, и не указали класс для хостов ZooKeeper. Managed Service for ClickHouse автоматически создаст 3 хоста ZooKeeper класса `s1.nano`.

Цена за час будет рассчитана по приведенным ниже тарифам (включая НДС): `3 × 5,5119 ₽ + 3 × 1,7492 ₽ = 21,78 ₽`.


## Цены {#prices}


### Хосты ClickHouse {#prices-clickhouse}

{% list tabs %}

- За месяц работы хоста
  
  Класс хостов | Цена за месяц, вкл. НДС
  ----- | -----
  **Intel Broadwell** |
  b1.nano (2 vCPU × 5%, 2 ГБ) | 508 ₽
  b1.micro (2 vCPU × 20%, 2 ГБ) | 858 ₽
  b1.medium (2 vCPU × 50%, 4 ГБ)  | 1 581 ₽
  m1.micro (2 vCPU, 16 ГБ) | 5 540 ₽
  m1.small (4 vCPU, 32 ГБ) | 11 080 ₽
  m1.medium (6 vCPU, 48 ГБ)| 16 620 ₽
  m1.large (8 vCPU, 64 ГБ) | 22 160 ₽
  m1.xlarge (12 vCPU, 96 ГБ) | 33 240 ₽
  m1.2xlarge (16 vCPU, 128 ГБ) | 44 320 ₽
  m1.3xlarge (24 vCPU, 192 ГБ) | 66 479 ₽
  m1.4xlarge (32 vCPU, 256 ГБ) | 88 639 ₽
  s1.nano (1 vCPU, 4 ГБ) | 1 984 ₽
  s1.micro (2 vCPU, 8 ГБ) | 3 969 ₽
  s1.small (4 vCPU, 16 ГБ) | 7 930 ₽
  s1.medium (8 vCPU, 32 ГБ)| 15 860 ₽
  s1.large (16 vCPU, 64 ГБ) | 31 719 ₽
  s1.xlarge (32 vCPU, 128 ГБ) | 63 431 ₽
  **Intel Cascade Lake** |
  b2.nano (2 vCPU × 5%, 2 ГБ)| 508 ₽
  b2.micro (2 vCPU × 20%, 2 ГБ) | 858 ₽
  b2.medium (2 vCPU × 50%, 4 ГБ) | 1 581 ₽
  m2.micro (2 vCPU, 16 ГБ) | 5 540 ₽
  m2.small (4 vCPU, 32 ГБ) | 11 080 ₽
  m2.medium (6 vCPU, 48 ГБ)| 16 620 ₽
  m2.large (8 vCPU, 64 ГБ) | 22 160 ₽
  m2.xlarge (12 vCPU, 96 ГБ) | 33 240 ₽
  m2.2xlarge (16 vCPU, 128 ГБ) | 44 320 ₽
  m2.3xlarge (24 vCPU, 192 ГБ) | 66 479 ₽
  m2.4xlarge (32 vCPU, 256 ГБ) | 88 639 ₽
  m2.5xlarge (40 vCPU, 320 ГБ) | 110 798 ₽
  m2.6xlarge (48 vCPU, 384 ГБ) | 132 958 ₽
  s2.micro (2 vCPU, 8 ГБ) | 3 658 ₽
  s2.small (4 vCPU, 16 ГБ) | 7 316 ₽
  s2.medium (8 vCPU, 32 ГБ) | 14 633 ₽
  s2.large (12 vCPU, 48 ГБ) | 21 948 ₽
  s2.xlarge (16 vCPU, 64 ГБ) | 29 265 ₽
  s2.2xlarge (24 vCPU, 96 ГБ) | 43 896 ₽
  s2.3xlarge (32 vCPU, 128 ГБ) | 58 529 ₽
  s2.4xlarge (40 vCPU, 160 ГБ) | 73 162 ₽
  s2.5xlarge (48 vCPU, 192 ГБ) | 87 794 ₽
  
- За 1 час работы хоста
  
  Класс хостов | Цена за 1 час, вкл. НДС
  ----- | -----
  **Intel Broadwell** |
  b1.nano (2 vCPU × 5%, 2 ГБ)| 0,7056 ₽
  b1.micro (2 vCPU × 20%, 2 ГБ) | 1,1916 ₽
  b1.medium (2 vCPU × 50%, 4 ГБ) | 2,1960 ₽
  m1.micro (2 vCPU, 16 ГБ) | 7,6944 ₽
  m1.small (4 vCPU, 32 ГБ) | 15,3888 ₽
  m1.medium (6 vCPU, 48 ГБ)| 23,0832 ₽
  m1.large (8 vCPU, 64 ГБ) | 30,7776 ₽
  m1.xlarge (12 vCPU, 96 ГБ) | 46,1664 ₽
  m1.2xlarge (16 vCPU, 128 ГБ) | 61,5552 ₽
  m1.3xlarge (24 vCPU, 192 ГБ) | 92,3316 ₽
  m1.4xlarge (32 vCPU, 256 ГБ) | 123,1092 ₽
  s1.nano (1 vCPU, 4 ГБ) | 2,7559 ₽
  s1.micro (2 vCPU, 8 ГБ) | 5,5119 ₽
  s1.small (4 vCPU, 16 ГБ) | 11,0136 ₽
  s1.medium (8 vCPU, 32 ГБ) | 22,0271 ₽ |
  s1.large (16 vCPU, 64 ГБ) | 44,0542 ₽ |
  s1.xlarge (32 vCPU, 128 ГБ) | 88,0983 ₽ |
  **Intel Cascade Lake** | |
  b2.nano (2 vCPU × 5%, 2 ГБ)| 0,7056 ₽
  b2.micro (2 vCPU × 20%, 2 ГБ) | 1,1916 ₽
  b2.medium (2 vCPU × 50%, 4 ГБ) | 2,1960 ₽
  m2.micro (2 vCPU, 16 ГБ) | 7,6944 ₽
  m2.small (4 vCPU, 32 ГБ) | 15,3888 ₽
  m2.medium (6 vCPU, 48 ГБ)| 23,0832 ₽
  m2.large (8 vCPU, 64 ГБ) | 30,7776 ₽
  m2.xlarge (12 vCPU, 96 ГБ) | 46,1664 ₽
  m2.2xlarge (16 vCPU, 128 ГБ) | 61,5552 ₽
  m2.3xlarge (24 vCPU, 192 ГБ) | 92,3316 ₽
  m2.4xlarge (32 vCPU, 256 ГБ) | 123,1092 ₽
  m2.5xlarge (40 vCPU, 320 ГБ) | 153,8856 ₽
  m2.6xlarge (48 vCPU, 384 ГБ) | 184,6632 ₽
  s2.micro (2 vCPU, 8 ГБ) | 5,0808 ₽
  s2.small (4 vCPU, 16 ГБ) | 10,1616 ₽
  s2.medium (8 vCPU, 32 ГБ) | 20,3232 ₽
  s2.large (12 vCPU, 48 ГБ) | 30,4836 ₽
  s2.xlarge (16 vCPU, 64 ГБ) | 40,6452 ₽
  s2.2xlarge (24 vCPU, 96 ГБ) | 60,9672 ₽
  s2.3xlarge (32 vCPU, 128 ГБ) | 81,2904 ₽
  s2.4xlarge (40 vCPU, 160 ГБ) | 101,6136 ₽
  s2.5xlarge (48 vCPU, 192 ГБ) | 121,9356 ₽
  
{% endlist %}


### Хосты ZooKeeper {#prices-zookeeper}

{% list tabs %}

- За месяц работы хоста
  
  Класс хостов | Цена за месяц, вкл. НДС
  ----- | -----
  **Intel Broadwell** |
  b1.nano (2 vCPU × 5%, 2 ГБ) | 505 ₽
  b1.micro (2 vCPU × 20%, 2 ГБ)  | 798 ₽
  b1.medium (2 vCPU × 50%, 4 ГБ)  | 1 289 ₽
  m1.micro (2 vCPU, 16 ГБ) | 3 593 ₽
  m1.small (4 vCPU, 32 ГБ) | 7 185 ₽
  m1.medium (6 vCPU, 48 ГБ)| 10 778 ₽
  m1.large (8 vCPU, 64 ГБ) | 14 370 ₽
  m1.xlarge (12 vCPU, 96 ГБ) | 21 555 ₽
  m1.2xlarge (16 vCPU, 128 ГБ) | 28 740 ₽
  m1.3xlarge (24 vCPU, 192 ГБ) | 43 110 ₽
  m1.4xlarge (32 vCPU, 256 ГБ) | 57 479 ₽
  s1.nano (1 vCPU, 4 ГБ) | 1 259 ₽
  s1.micro (2 vCPU, 8 ГБ)  | 2 460 ₽
  s1.small (4 vCPU, 16 ГБ)  | 4 862 ₽
  s1.medium (8 vCPU, 32 ГБ)  | 9 665 ₽
  s1.large (16 vCPU, 64 ГБ)  | 19 286 ₽
  s1.xlarge (32 vCPU, 128 ГБ)  | 38 507 ₽
  **Intel Cascade Lake** |
  b2.nano (2 vCPU × 5%, 2 ГБ) | 505 ₽
  b2.micro (2 vCPU × 20%, 2 ГБ)  | 798 ₽
  b2.medium (2 vCPU × 50%, 4 ГБ)  | 1 289 ₽
  m2.micro (2 vCPU, 16 ГБ) | 3 593 ₽
  m2.small (4 vCPU, 32 ГБ) | 7 185 ₽
  m2.medium (6 vCPU, 48 ГБ)| 10 778 ₽
  m2.large (8 vCPU, 64 ГБ) | 14 370 ₽
  m2.xlarge (12 vCPU, 96 ГБ) | 21 555 ₽
  m2.2xlarge (16 vCPU, 128 ГБ) | 28 740 ₽
  m2.3xlarge (24 vCPU, 192 ГБ) | 43 110 ₽
  m2.4xlarge (32 vCPU, 256 ГБ) | 57 479 ₽
  m2.5xlarge (40 vCPU, 320 ГБ) | 71 849 ₽
  m2.6xlarge (48 vCPU, 384 ГБ) | 86 219 ₽
  s2.micro (2 vCPU, 8 ГБ)  | 2 290 ₽
  s2.small (4 vCPU, 16 ГБ)  | 4 507 ₽
  s2.medium (8 vCPU, 32 ГБ)  | 8 942 ₽
  s2.large (12 vCPU, 48 ГБ)  | 13 376 ₽
  s2.xlarge (16 vCPU, 64 ГБ)  | 17 810 ₽
  s2.2xlarge (24 vCPU, 96 ГБ)  | 26 678 ₽
  s2.3xlarge (32 vCPU, 128 ГБ)  | 35 546 ₽
  s2.4xlarge (40 vCPU, 160 ГБ) | 44 414 ₽
  s2.5xlarge (48 vCPU, 192 ГБ) | 53 282 ₽
  
- За 1 час работы хоста
  
  Класс хостов | Цена за 1 час, вкл. НДС
  ----- | -----
  **Intel Broadwell** |
  b1.nano (2 vCPU × 5%, 2 ГБ) | 0,7008 ₽
  b1.micro (2 vCPU × 20%, 2 ГБ)  | 1,1088 ₽
  b1.medium (2 vCPU × 50%, 4 ГБ)  | 1,7904 ₽
  m1.micro (2 vCPU, 16 ГБ) | 4,9896 ₽
  m1.small (4 vCPU, 32 ГБ) | 9,9792 ₽
  m1.medium (6 vCPU, 48 ГБ)| 14,9688 ₽
  m1.large (8 vCPU, 64 ГБ) | 19,9584 ₽
  m1.xlarge (12 vCPU, 96 ГБ) | 29,9376 ₽
  m1.2xlarge (16 vCPU, 128 ГБ) | 39,9168 ₽
  m1.3xlarge (24 vCPU, 192 ГБ) | 59,8752 ₽
  m1.4xlarge (32 vCPU, 256 ГБ) | 79,8324 ₽
  s1.nano (1 vCPU, 4 ГБ)  | 1,7492 ₽ |
  s1.micro (2 vCPU, 8 ГБ)  | 3,4169 ₽ |
  s1.small (4 vCPU, 16 ГБ)  | 6,7525 ₽ |
  s1.medium (8 vCPU, 32 ГБ)  | 13,4237 ₽ |
  s1.large (16 vCPU, 64 ГБ)  | 26,7864 ₽ |
  s1.xlarge (32 vCPU, 128 ГБ)  | 53,4814 ₽ |
  **Intel Cascade Lake** |
  b2.nano (2 vCPU × 5%, 2 ГБ) | 0,7008 ₽
  b2.micro (2 vCPU × 20%, 2 ГБ)  | 1,1088 ₽
  b2.medium (2 vCPU × 50%, 4 ГБ)  | 1,7904 ₽
  m2.micro (2 vCPU, 16 ГБ) | 4,9896 ₽
  m2.small (4 vCPU, 32 ГБ) | 9,9792 ₽
  m2.medium (6 vCPU, 48 ГБ)| 14,9688 ₽
  m2.large (8 vCPU, 64 ГБ) | 19,9584 ₽
  m2.xlarge (12 vCPU, 96 ГБ) | 29,9376 ₽
  m2.2xlarge (16 vCPU, 128 ГБ) | 39,9168 ₽
  m2.3xlarge (24 vCPU, 192 ГБ) | 59,8752 ₽
  m2.4xlarge (32 vCPU, 256 ГБ) | 79,8324 ₽
  m2.5xlarge (40 vCPU, 320 ГБ) | 99,7908 ₽
  m2.6xlarge (48 vCPU, 384 ГБ) | 119,7492 ₽
  s2.micro (2 vCPU, 8 ГБ)  | 3,1812 ₽
  s2.small (4 vCPU, 16 ГБ)  | 6,2604 ₽
  s2.medium (8 vCPU, 32 ГБ)  | 12,4188 ₽
  s2.large (12 vCPU, 48 ГБ)  | 18,5772 ₽
  s2.xlarge (16 vCPU, 64 ГБ)  | 24,7356 ₽
  s2.2xlarge (24 vCPU, 96 ГБ)  | 37,0524 ₽
  s2.3xlarge (32 vCPU, 128 ГБ)  | 49,3692 ₽
  s2.4xlarge (40 vCPU, 160 ГБ) | 61,6860 ₽
  s2.5xlarge (48 vCPU, 192 ГБ) | 74,0028 ₽
  
{% endlist %}


### Хранилище и резервные копии {#prices-storage}

Услуга | Цена за ГБ в месяц, вкл. НДС
----- | -----
Стандартное сетевое хранилище  | 2,2881 ₽ |
Быстрое сетевое хранилище  | 8,1356 ₽ |
Быстрое локальное хранилище  | 8,1356 ₽ |
Резервные копии сверх размера хранилища  | 2,5424 ₽


### Исходящий трафик {#prices-traffic}

{% include notitle [pricing-egress-traffic](../_includes/pricing/pricing-egress-traffic.md) %}
