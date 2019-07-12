---
editable: false
---

# Правила тарификации для MongoDB

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## Из чего складывается стоимость использования Managed Service for MongoDB {#rules}

Расчет стоимости использования Managed Service for MongoDB учитывает:

* тип и объем хранилища (дискового пространства);

* [класс хостов](concepts/instance-types.md), выбранный для кластера;

* количество хостов БД в кластерах;

* настройки и количество резервных копий;

* объем исходящего трафика.


{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Использование хостов БД {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы хоста в соответствии с его классом. Точные характеристики классов приведены в разделе [#T](concepts/instance-types.md).

Минимальная единица тарификации — час (например, стоимость 1,5 часов работы хоста равна стоимости 2 часов). Время, когда хост MongoDB не может выполнять свои основные функции, не тарифицируется.

### Использование дискового пространства {#rules-storage}

Оплачивается:

* Объем хранилища, выделенный для кластеров БД.

    * Хранилище на быстрых локальных дисках (NVMe) можно заказывать только для кластеров более чем с 3 хостами, с шагом 100 ГБ.


* Объем, занимаемый резервными копиями баз данных сверх заданного хранилища для кластера.

    * Хранение резервных копий не тарифицируется пока сумма размера БД и всех резервных копий остается меньше выбранного объема хранилища.

    * При автоматическом резервном копировании Managed Service for MongoDB не создает новую копию, а сохраняет изменения БД по сравнению с предыдущей копией. Поэтому потребление хранилища автоматическими резервными копиями растет только пропорционально объему изменений.

    * Количество хостов кластера не влияет на объем хранилища и, соответственно, на бесплатный объем резервных копий.



Цена указывается за 1 месяц использования.  Минимальная единица тарификации — ГБ в час (например, стоимость хранения 1 ГБ в течение 1,5 часов равна стоимости хранения в течение 2 часов).

## Цены {#prices}

### Хосты MongoDB {#prices-mongodb-hosts}

{% list tabs %}

- За месяц работы хоста
  
  Класс хостов | Цена за месяц, вкл. НДС
  ----- | -----
  | **Intel Broadwell** |  |
  b1.nano (2 vCPU × 5%, 2 ГБ)| 775 ₽
  b1.micro (2 vCPU × 20%, 2 ГБ) | 1 138 ₽
  b1.medium (2 vCPU × 50%, 4 ГБ) | 2 124 ₽
  m1.micro (2 vCPU, 16 ГБ) | 7 221 ₽
  m1.small (4 vCPU, 32 ГБ) | 14 442 ₽
  m1.medium (6 vCPU, 48 ГБ)| 21 662 ₽
  m1.large (8 vCPU, 64 ГБ) | 28 883 ₽
  m1.xlarge (12 vCPU, 96 ГБ) | 43 324 ₽
  m1.2xlarge (16 vCPU, 128 ГБ) | 57 765 ₽
  m1.3xlarge (24 vCPU, 192 ГБ) | 86 648 ₽
  m1.4xlarge (32 vCPU, 256 ГБ) | 115 531 ₽
  s1.nano (1 vCPU, 4 ГБ)| 2 160 ₽
  s1.micro (2 vCPU, 8 ГБ) | 4 327 ₽
  s1.small (4 vCPU, 16 ГБ) | 8 647 ₽
  s1.medium (8 vCPU, 32 ГБ) | 17 302 ₽
  s1.large (16 vCPU, 64 ГБ) | 34 597 ₽
  s1.xlarge (32 vCPU, 128 ГБ) | 69 201 ₽
  **Intel Cascade Lake** | |
  b2.nano (2 vCPU × 5%, 2 ГБ)| 775 ₽
  b2.micro (2 vCPU × 20%, 2 ГБ) | 1 138 ₽
  b2.medium (2 vCPU × 50%, 4 ГБ) | 2 124 ₽
  m2.micro (2 vCPU, 16 ГБ) | 7 221 ₽
  m2.small (4 vCPU, 32 ГБ) | 14 442 ₽
  m2.medium (6 vCPU, 48 ГБ)| 21 662 ₽
  m2.large (8 vCPU, 64 ГБ) | 28 883 ₽
  m2.xlarge (12 vCPU, 96 ГБ) | 43 324 ₽
  m2.2xlarge (16 vCPU, 128 ГБ) | 57 765 ₽
  m2.3xlarge (24 vCPU, 192 ГБ) | 86 648 ₽
  m2.4xlarge (32 vCPU, 256 ГБ) | 115 531 ₽
  m2.5xlarge (40 vCPU, 320 ГБ) | 144 413 ₽
  m2.6xlarge (48 vCPU, 384 ГБ) | 173 296 ₽
  s2.micro (2 vCPU, 8 ГБ) | 4 327 ₽
  s2.small (4 vCPU, 16 ГБ) | 8 647 ₽
  s2.medium (8 vCPU, 32 ГБ) | 17 302 ₽
  s2.large (12 vCPU, 48 ГБ) | 26 095 ₽
  s2.xlarge (16 vCPU, 64 ГБ) | 34 597 ₽
  s2.2xlarge (24 vCPU, 96 ГБ) | 52 192 ₽
  s2.3xlarge (32 vCPU, 128 ГБ) | 69 201 ₽
  s2.4xlarge (40 vCPU, 160 ГБ)| 86 986 ₽
  s2.5xlarge (48 vCPU, 192 ГБ)| 104 382 ₽
  
- За 1 час работы хоста
  
  Класс хостов | Цена за час, вкл. НДС
  ----- | -----
  | **Intel Broadwell** |
  b1.nano (2 vCPU × 5%, 2 ГБ)| 1,0770 ₽
  b1.micro (2 vCPU × 20%, 2 ГБ) | 1,5800 ₽
  b1.medium (2 vCPU × 50%, 4 ГБ) | 2,9500 ₽
  m1.micro (2 vCPU, 16 ГБ) | 10,0296 ₽
  m1.small (4 vCPU, 32 ГБ) | 20,0580 ₽
  m1.medium (6 vCPU, 48 ГБ)| 30,0864 ₽
  m1.large (8 vCPU, 64 ГБ) | 40,1148 ₽
  m1.xlarge (12 vCPU, 96 ГБ) | 60,1728 ₽
  m1.2xlarge (16 vCPU, 128 ГБ) | 80,2296 ₽
  m1.3xlarge (24 vCPU, 192 ГБ) | 120,3444 ₽
  m1.4xlarge (32 vCPU, 256 ГБ) | 160,4592 ₽
  s1.nano (1 vCPU, 4 ГБ) | 3,0000 ₽ |
  s1.micro (2 vCPU, 8 ГБ) | 6,0102 ₽ |
  s1.small (4 vCPU, 16 ГБ) | 12,0102 ₽ |
  s1.medium (8 vCPU, 32 ГБ) | 24,0305 ₽ |
  s1.large (16 vCPU, 64 ГБ) | 48,0508 ₽ |
  s1.xlarge (32 vCPU, 128 ГБ) | 96,1119 ₽
  **Intel Cascade Lake** |
  b2.nano (2 vCPU × 5%, 2 ГБ)| 1,0770 ₽
  b2.small (2 vCPU × 20%, 4 ГБ) | 1,5800 ₽
  b2.medium (2 vCPU × 50%, 4 ГБ) | 2,9500 ₽
  m2.micro (2 vCPU, 16 ГБ) | 10,0296 ₽
  m2.small (4 vCPU, 32 ГБ) | 20,0580 ₽
  m2.medium (6 vCPU, 48 ГБ)| 30,0864 ₽
  m2.large (8 vCPU, 64 ГБ) | 40,1148 ₽
  m2.xlarge (12 vCPU, 96 ГБ) | 60,1728 ₽
  m2.2xlarge (16 vCPU, 128 ГБ) | 80,2296 ₽
  m2.3xlarge (24 vCPU, 192 ГБ) | 120,3444 ₽
  m2.4xlarge (32 vCPU, 256 ГБ) | 160,4592 ₽
  m2.5xlarge (40 vCPU, 320 ГБ) | 200,5740 ₽
  m2.6xlarge (48 vCPU, 384 ГБ) | 240,6888 ₽
  s2.micro (2 vCPU, 8 ГБ) | 6,0102 ₽
  s2.small (4 vCPU, 16 ГБ) | 12,0102 ₽
  s2.medium (8 vCPU, 32 ГБ) | 24,0305 ₽
  s2.large (12 vCPU, 48 ГБ) | 36,2436 ₽
  s2.xlarge (16 vCPU, 64 ГБ) | 48,0508 ₽
  s2.2xlarge (24 vCPU, 96 ГБ) | 72,4884 ₽
  s2.3xlarge (32 vCPU, 128 ГБ) | 96,1119 ₽
  s2.4xlarge (40 vCPU, 160 ГБ)| 120,8136 ₽
  s2.5xlarge (48 vCPU, 192 ГБ)| 144,9756 ₽
  
{% endlist %}


### Хосты mongocfg {#prices-mongocfg-hosts}

{% list tabs %}

- За месяц работы хоста
  
  Класс хостов | Цена за месяц, вкл. НДС
  ----- | -----
  | **Intel Broadwell** |  |
  b1.nano (2 vCPU × 5%, 2 ГБ)| 775 ₽
  b1.micro (2 vCPU × 20%, 2 ГБ) | 1 138 ₽
  b1.medium (2 vCPU × 50%, 4 ГБ) | 2 124 ₽
  s1.nano (1 vCPU, 4 ГБ)| 2 160 ₽
  s1.micro (2 vCPU, 8 ГБ) | 4 327 ₽
  s1.small (4 vCPU, 16 ГБ) | 8 647 ₽
  s1.medium (8 vCPU, 32 ГБ) | 17 302 ₽
  s1.large (16 vCPU, 64 ГБ) | 34 597 ₽
  s1.xlarge (32 vCPU, 128 ГБ) | 69 201 ₽
  **Intel Cascade Lake** | |
  b2.nano (2 vCPU × 5%, 2 ГБ)| 775 ₽
  b2.micro (2 vCPU × 20%, 2 ГБ) | 1 138 ₽
  b2.medium (2 vCPU × 50%, 4 ГБ) | 2 124 ₽
  s2.micro (2 vCPU, 8 ГБ) | 4 327 ₽
  s2.small (4 vCPU, 16 ГБ) | 8 647 ₽
  s2.medium (8 vCPU, 32 ГБ) | 17 302 ₽
  s2.large (12 vCPU, 48 ГБ) | 26 095 ₽
  s2.xlarge (16 vCPU, 64 ГБ) | 34 597 ₽
  s2.2xlarge (24 vCPU, 96 ГБ) | 52 192 ₽
  s2.3xlarge (32 vCPU, 128 ГБ) | 69 201 ₽
  s2.4xlarge (40 vCPU, 160 ГБ)| 86 986 ₽
  s2.5xlarge (48 vCPU, 192 ГБ)| 104 382 ₽
  
- За 1 час работы хоста
  
  Класс хостов | Цена за час, вкл. НДС
  ----- | -----
  | **Intel Broadwell** |
  b1.nano (2 vCPU × 5%, 2 ГБ)| 1,0770 ₽
  b1.micro (2 vCPU × 20%, 2 ГБ) | 1,5800 ₽
  b1.medium (2 vCPU × 50%, 4 ГБ) | 2,9500 ₽
  s1.nano (1 vCPU, 4 ГБ) | 3,0000 ₽ |
  s1.micro (2 vCPU, 8 ГБ) | 6,0102 ₽ |
  s1.small (4 vCPU, 16 ГБ) | 12,0102 ₽ |
  s1.medium (8 vCPU, 32 ГБ) | 24,0305 ₽ |
  s1.large (16 vCPU, 64 ГБ) | 48,0508 ₽ |
  s1.xlarge (32 vCPU, 128 ГБ) | 96,1119 ₽
  **Intel Cascade Lake** |
  b2.nano (2 vCPU × 5%, 2 ГБ)| 1,0770 ₽
  b2.small (2 vCPU × 20%, 4 ГБ) | 1,5800 ₽
  b2.medium (2 vCPU × 50%, 4 ГБ) | 2,9500 ₽
  s2.micro (2 vCPU, 8 ГБ) | 6,0102 ₽
  s2.small (4 vCPU, 16 ГБ) | 12,0102 ₽
  s2.medium (8 vCPU, 32 ГБ) | 24,0305 ₽
  s2.large (12 vCPU, 48 ГБ) | 36,2436 ₽
  s2.xlarge (16 vCPU, 64 ГБ) | 48,0508 ₽
  s2.2xlarge (24 vCPU, 96 ГБ) | 72,4884 ₽
  s2.3xlarge (32 vCPU, 128 ГБ) | 96,1119 ₽
  s2.4xlarge (40 vCPU, 160 ГБ)| 120,8136 ₽
  s2.5xlarge (48 vCPU, 192 ГБ)| 144,9756 ₽
  
{% endlist %}


### Хосты mongos {#prices-mongos-hosts}

{% list tabs %}

- За месяц работы хоста
  
  Класс хостов | Цена за месяц, вкл. НДС
  ----- | -----
  | **Intel Broadwell** |  |
  b1.nano (2 vCPU × 5%, 2 ГБ)| 775 ₽
  b1.micro (2 vCPU × 20%, 2 ГБ) | 1 138 ₽
  b1.medium (2 vCPU × 50%, 4 ГБ) | 2 124 ₽
  s1.nano (1 vCPU, 4 ГБ)| 2 160 ₽
  s1.micro (2 vCPU, 8 ГБ) | 4 327 ₽
  s1.small (4 vCPU, 16 ГБ) | 8 647 ₽
  s1.medium (8 vCPU, 32 ГБ) | 17 302 ₽
  s1.large (16 vCPU, 64 ГБ) | 34 597 ₽
  s1.xlarge (32 vCPU, 128 ГБ) | 69 201 ₽
  **Intel Cascade Lake** | |
  b2.nano (2 vCPU × 5%, 2 ГБ)| 775 ₽
  b2.micro (2 vCPU × 20%, 2 ГБ) | 1 138 ₽
  b2.medium (2 vCPU × 50%, 4 ГБ) | 2 124 ₽
  s2.micro (2 vCPU, 8 ГБ) | 4 327 ₽
  s2.small (4 vCPU, 16 ГБ) | 8 647 ₽
  s2.medium (8 vCPU, 32 ГБ) | 17 302 ₽
  s2.large (12 vCPU, 48 ГБ) | 26 095 ₽
  s2.xlarge (16 vCPU, 64 ГБ) | 34 597 ₽
  s2.2xlarge (24 vCPU, 96 ГБ) | 52 192 ₽
  s2.3xlarge (32 vCPU, 128 ГБ) | 69 201 ₽
  s2.4xlarge (40 vCPU, 160 ГБ)| 86 986 ₽
  s2.5xlarge (48 vCPU, 192 ГБ)| 104 382 ₽
  
- За 1 час работы хоста
  
  Класс хостов | Цена за час, вкл. НДС
  ----- | -----
  | **Intel Broadwell** |
  b1.nano (2 vCPU × 5%, 2 ГБ)| 1,0770 ₽
  b1.micro (2 vCPU × 20%, 2 ГБ) | 1,5800 ₽
  b1.medium (2 vCPU × 50%, 4 ГБ) | 2,9500 ₽
  s1.nano (1 vCPU, 4 ГБ) | 3,0000 ₽ |
  s1.micro (2 vCPU, 8 ГБ) | 6,0102 ₽ |
  s1.small (4 vCPU, 16 ГБ) | 12,0102 ₽ |
  s1.medium (8 vCPU, 32 ГБ) | 24,0305 ₽ |
  s1.large (16 vCPU, 64 ГБ) | 48,0508 ₽ |
  s1.xlarge (32 vCPU, 128 ГБ) | 96,1119 ₽
  **Intel Cascade Lake** |
  b2.nano (2 vCPU × 5%, 2 ГБ)| 1,0770 ₽
  b2.small (2 vCPU × 20%, 4 ГБ) | 1,5800 ₽
  b2.medium (2 vCPU × 50%, 4 ГБ) | 2,9500 ₽
  s2.micro (2 vCPU, 8 ГБ) | 6,0102 ₽
  s2.small (4 vCPU, 16 ГБ) | 12,0102 ₽
  s2.medium (8 vCPU, 32 ГБ) | 24,0305 ₽
  s2.large (12 vCPU, 48 ГБ) | 36,2436 ₽
  s2.xlarge (16 vCPU, 64 ГБ) | 48,0508 ₽
  s2.2xlarge (24 vCPU, 96 ГБ) | 72,4884 ₽
  s2.3xlarge (32 vCPU, 128 ГБ) | 96,1119 ₽
  s2.4xlarge (40 vCPU, 160 ГБ)| 120,8136 ₽
  s2.5xlarge (48 vCPU, 192 ГБ)| 144,9756 ₽
  
{% endlist %}


### Хранилище и резервные копии {#prices-storage}

Услуга | Цена за ГБ в месяц, вкл. НДС
----- | -----
Стандартное сетевое хранилище | 2,2881 ₽ |
Быстрое сетевое хранилище | 8,1356 ₽ |
Быстрое локальное хранилище | 8,1356 ₽ |
Резервные копии сверх размера хранилища | 2,5424 ₽

### Исходящий трафик {#prices-traffic}

{% include notitle [pricing-egress-traffic](../_includes/pricing/pricing-egress-traffic.md) %}
