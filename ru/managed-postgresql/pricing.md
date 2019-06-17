---
editable: false
---

# Правила тарификации для [!KEYREF mpg-name]

[!INCLUDE [currency-choice](../_includes/pricing/currency-choice.md)]

## Из чего складывается стоимость использования [!KEYREF mpg-short-name] {#rules}

Расчет стоимости использования [!KEYREF mpg-name] учитывает:

* тип и объем хранилища (дискового пространства);

* [класс хостов](concepts/instance-types.md), выбранный для кластера;

* количество хостов БД в кластерах;

* настройки и количество резервных копий;

* объем исходящего трафика.


[!INCLUDE [pricing-gb-size](../_includes/pricing-gb-size.md)]

### Использование хостов БД {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы хоста в соответствии с его классом. Точные характеристики классов приведены в разделе [[!TITLE]](concepts/instance-types.md).

Минимальная единица тарификации — час (например, стоимость 1,5 часов работы хоста равна стоимости 2 часов). Время, когда хост [!KEYREF PG] не может выполнять свои основные функции, не тарифицируется.

### Использование дискового пространства {#rules-storage}

Оплачивается:

* Объем хранилища, выделенный для кластеров БД.

    * Хранилище на быстрых локальных дисках (NVMe) можно заказывать только для кластеров более чем с 3 хостами, с шагом 100 ГБ.


* Объем, занимаемый резервными копиями баз данных сверх заданного хранилища для кластера.

    * Хранение резервных копий не тарифицируется пока сумма размера БД и всех резервных копий остается меньше выбранного объема хранилища.

    * При автоматическом резервном копировании [!KEYREF mpg-short-name] не создает новую копию, а сохраняет изменения БД по сравнению с предыдущей копией. Поэтому потребление хранилища автоматическими резервными копиями растет только пропорционально объему изменений.

    * Количество хостов кластера не влияет на объем хранилища и, соответственно, на бесплатный объем резервных копий.

Цена указывается за 1 месяц использования. Минимальная единица тарификации — 1 ГБ в час (например, стоимость хранения 1 ГБ в течение 1,5 часов равна стоимости хранения в течение 2 часов).

## Цены {#prices}

### Хосты {prices-hosts}


---

**[!TAB За месяц работы хоста]**

Класс хостов | Цена за месяц, вкл. НДС 
----- | -----
**Intel Broadwell** | 
[!KEYREF b1.nano] | 508 ₽
[!KEYREF b1.micro] | 858 ₽
[!KEYREF b1.medium] | 1 581 ₽
[!KEYREF m1.micro] | 5 205 ₽
[!KEYREF m1.small] | 10 409 ₽
[!KEYREF m1.medium]| 15 612 ₽
[!KEYREF m1.large] | 20 817 ₽
[!KEYREF m1.xlarge] | 31 225 ₽
[!KEYREF m1.2xlarge] | 41 634 ₽
[!KEYREF m1.3xlarge] | 62 450 ₽
[!KEYREF m1.4xlarge] | 83 266 ₽
[!KEYREF s1.nano]| 1 867 ₽
[!KEYREF s1.micro] | 3 727 ₽
[!KEYREF s1.small] | 7 447 ₽
[!KEYREF s1.medium] | 14 900 ₽
[!KEYREF s1.large] | 29 793 ₽
[!KEYREF s1.xlarge] | 59 594 ₽
**Intel Cascade Lake** | 
[!KEYREF b2.nano]| 508 ₽
[!KEYREF b2.micro] | 858 ₽
[!KEYREF b2.medium] | 1 581 ₽
[!KEYREF m2.micro] | 5 205 ₽
[!KEYREF m2.small] | 10 409 ₽
[!KEYREF m2.medium]| 15 612 ₽
[!KEYREF m2.large] | 20 817 ₽
[!KEYREF m2.xlarge] | 31 225 ₽
[!KEYREF m2.2xlarge] | 41 634 ₽
[!KEYREF m2.3xlarge] | 62 450 ₽
[!KEYREF m2.4xlarge] | 83 266 ₽
[!KEYREF m2.5xlarge] | 104 083 ₽
[!KEYREF m2.6xlarge] | 124 900 ₽
[!KEYREF s2.micro] | 3 436 ₽
[!KEYREF s2.small] | 6 873 ₽
[!KEYREF s2.medium] | 13 745 ₽
[!KEYREF s2.large] | 20 618 ₽
[!KEYREF s2.xlarge] | 27 491 ₽
[!KEYREF s2.2xlarge] | 41 237 ₽
[!KEYREF s2.3xlarge] | 54 982 ₽
[!KEYREF s2.4xlarge]| 68 728 ₽
[!KEYREF s2.5xlarge]| 82 473 ₽

**[!TAB За 1 час работы хоста]**

Класс хостов | Цена за час, вкл. НДС 
----- | -----
**Intel Broadwell** |
[!KEYREF b1.nano]| 0,7056 ₽
[!KEYREF b1.micro] | 1,1916 ₽
[!KEYREF b1.medium] | 2,1960 ₽
[!KEYREF m1.micro] | 7,2288 ₽
[!KEYREF m1.small] | 14,4564 ₽
[!KEYREF m1.medium]| 21,6840 ₽
[!KEYREF m1.large] | 28,9128 ₽
[!KEYREF m1.xlarge] | 43,3680 ₽
[!KEYREF m1.2xlarge] | 57,8244 ₽
[!KEYREF m1.3xlarge] | 86,7360 ₽
[!KEYREF m1.4xlarge] | 115,6476 ₽
[!KEYREF s1.nano] | 2,5932 ₽ | 
[!KEYREF s1.micro] | 5,1763 ₽ | 
[!KEYREF s1.small] | 10,3424 ₽ | 
[!KEYREF s1.medium] | 20,6949 ₽ | 
[!KEYREF s1.large] | 41,3797 ₽ | 
[!KEYREF s1.xlarge] | 82,7695 ₽ 
**Intel Cascade Lake** | 
[!KEYREF b2.nano]| 0,7056 ₽
[!KEYREF b2.micro] | 1,1916 ₽
[!KEYREF b2.medium] | 2,1960 ₽
[!KEYREF m2.micro] | 7,2288 ₽
[!KEYREF m2.small] | 14,4564 ₽
[!KEYREF m2.medium]| 21,6840 ₽
[!KEYREF m2.large] | 28,9128 ₽
[!KEYREF m2.xlarge] | 43,3680 ₽
[!KEYREF m2.2xlarge] | 57,8244 ₽
[!KEYREF m2.3xlarge] | 86,7360 ₽
[!KEYREF m2.4xlarge] | 115,6476 ₽
[!KEYREF m2.5xlarge] | 144,5592 ₽
[!KEYREF m2.6xlarge] | 173,4720 ₽
[!KEYREF s2.micro] | 4,7724 ₽
[!KEYREF s2.small] | 9,5460 ₽
[!KEYREF s2.medium] | 19,0908 ₽
[!KEYREF s2.large] | 28,6356 ₽
[!KEYREF s2.xlarge] | 38,1816 ₽
[!KEYREF s2.2xlarge] | 57,2736 ₽
[!KEYREF s2.3xlarge] | 76,3644 ₽
[!KEYREF s2.4xlarge]| 95,4552 ₽
[!KEYREF s2.5xlarge]| 114,5460 ₽

---


### Хранилище и резервные копии {#prices-storage}

Услуга | Цена за ГБ в месяц, вкл. НДС 
----- | ----- 
Стандартное сетевое хранилище | 2,2881 ₽ | 
Быстрое сетевое хранилище | 8,1356 ₽ | 
Быстрое локальное хранилище | 8,1356 ₽ | 
Резервные копии сверх размера хранилища | 2,5424 ₽ 

### Исходящий трафик {#prices-traffic}

[!INCLUDE-NOTITLE [pricing-egress-traffic](../_includes/pricing/pricing-egress-traffic.md)]
