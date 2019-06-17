---
editable: false
---

[!INCLUDE [currency-choice](../_includes/pricing/currency-choice.md)]

# Правила тарификации для [!KEYREF mch-short-name]


## Из чего складывается стоимость использования [!KEYREF mch-short-name] {#rules}

Расчет стоимости использования [!KEYREF mch-name] учитывает:

* тип и объем хранилища (дискового пространства);

* [класс хостов](concepts/instance-types.md), выбранный для кластера;

* количество хостов БД в кластерах (в том числе хостов ZooKeeper для кластеров [!KEYREF CH]);

* настройки и количество резервных копий;

* объем исходящего трафика.


[!INCLUDE [pricing-gb-size](../_includes/pricing-gb-size.md)]


### Использование хостов БД {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы хоста в соответствии с его классом. Точные характеристики классов приведены в разделе [[!TITLE]](concepts/instance-types.md).

> [!IMPORTANT]
>
> Для каждого кластера [!KEYREF CH] с 2 и более хостами [!KEYREF CH] автоматически создается 3 хоста ZooKeeper.

Минимальная единица тарификации — час (например, стоимость 1,5 часов работы хоста равна стоимости 2 часов). Время, когда хост СУБД или ZooKeeper не может выполнять свои основные функции, не тарифицируется.


### Использование дискового пространства {#rules-storage}

Оплачивается:

* Объем хранилища, выделенный для кластеров БД.

    * Хранилище на быстрых локальных дисках (NVMe) можно заказывать только для кластеров более чем с 2 хостами, с шагом 100 ГБ.


* Объем, занимаемый резервными копиями баз данных сверх заданного хранилища для кластера.

    * Хранение резервных копий не тарифицируется пока сумма размера БД и всех резервных копий остается меньше выбранного объема хранилища.

    * При автоматическом резервном копировании [!KEYREF mch-short-name] не создает новую копию, а сохраняет изменения БД по сравнению с предыдущей копией. Поэтому потребление хранилища автоматическими резервными копиями растет только пропорционально объему изменений.

    * Количество хостов кластера не влияет на объем хранилища и, соответственно, на бесплатный объем резервных копий.



Цена указывается за 1 месяц использования.  Минимальная единица тарификации — ГБ в час (например, стоимость хранения 1 ГБ в течение 1,5 часов равна стоимости хранения в течение 2 часов).


### [!KEYREF CH] и ZooKeeper {#clickhouse-zookeeper}

Вы можете выбрать класс хостов как для хостов [!KEYREF CH], так и для хостов ZooKeeper (в соответствии с ожидаемой нагрузкой реплицирования).

Например, вы создали кластер [!KEYREF CH] из 3 хостов, с классом хостов `s1.micro`, и не указали класс для хостов ZooKeeper. [!KEYREF mch-short-name] автоматически создаст 3 хоста ZooKeeper класса `s1.nano`.

Цена за час будет рассчитана по приведенным ниже тарифам (включая НДС): `3 × 5,5119 ₽ + 3 × 1,7492 ₽ = 21,78 ₽`.


## Цены {#prices}


### Хосты [!KEYREF CH] {#prices-clickhouse}

---

**[!TAB За месяц работы хоста]**

Класс хостов | Цена за месяц, вкл. НДС 
----- | -----
**Intel Broadwell** | 
[!KEYREF b1.nano] | 508 ₽
[!KEYREF b1.micro] | 858 ₽
[!KEYREF b1.medium]  | 1 581 ₽
[!KEYREF m1.micro] | 5 540 ₽
[!KEYREF m1.small] | 11 080 ₽
[!KEYREF m1.medium]| 16 620 ₽
[!KEYREF m1.large] | 22 160 ₽
[!KEYREF m1.xlarge] | 33 240 ₽
[!KEYREF m1.2xlarge] | 44 320 ₽
[!KEYREF m1.3xlarge] | 66 479 ₽
[!KEYREF m1.4xlarge] | 88 639 ₽
[!KEYREF s1.nano] | 1 984 ₽
[!KEYREF s1.micro] | 3 969 ₽
[!KEYREF s1.small] | 7 930 ₽
[!KEYREF s1.medium]| 15 860 ₽
[!KEYREF s1.large] | 31 719 ₽
[!KEYREF s1.xlarge] | 63 431 ₽
**Intel Cascade Lake** | 
[!KEYREF b2.nano]| 508 ₽
[!KEYREF b2.micro] | 858 ₽
[!KEYREF b2.medium] | 1 581 ₽
[!KEYREF m2.micro] | 5 540 ₽
[!KEYREF m2.small] | 11 080 ₽
[!KEYREF m2.medium]| 16 620 ₽
[!KEYREF m2.large] | 22 160 ₽
[!KEYREF m2.xlarge] | 33 240 ₽
[!KEYREF m2.2xlarge] | 44 320 ₽
[!KEYREF m2.3xlarge] | 66 479 ₽
[!KEYREF m2.4xlarge] | 88 639 ₽
[!KEYREF m2.5xlarge] | 110 798 ₽
[!KEYREF m2.6xlarge] | 132 958 ₽
[!KEYREF s2.micro] | 3 658 ₽
[!KEYREF s2.small] | 7 316 ₽
[!KEYREF s2.medium] | 14 633 ₽
[!KEYREF s2.large] | 21 948 ₽
[!KEYREF s2.xlarge] | 29 265 ₽
[!KEYREF s2.2xlarge] | 43 896 ₽
[!KEYREF s2.3xlarge] | 58 529 ₽
[!KEYREF s2.4xlarge] | 73 162 ₽
[!KEYREF s2.5xlarge] | 87 794 ₽

**[!TAB За 1 час работы хоста]**

Класс хостов | Цена за 1 час, вкл. НДС 
----- | -----
**Intel Broadwell** |  
[!KEYREF b1.nano]| 0,7056 ₽
[!KEYREF b1.micro] | 1,1916 ₽
[!KEYREF b1.medium] | 2,1960 ₽
[!KEYREF m1.micro] | 7,6944 ₽
[!KEYREF m1.small] | 15,3888 ₽
[!KEYREF m1.medium]| 23,0832 ₽
[!KEYREF m1.large] | 30,7776 ₽
[!KEYREF m1.xlarge] | 46,1664 ₽
[!KEYREF m1.2xlarge] | 61,5552 ₽
[!KEYREF m1.3xlarge] | 92,3316 ₽
[!KEYREF m1.4xlarge] | 123,1092 ₽
[!KEYREF s1.nano] | 2,7559 ₽ 
[!KEYREF s1.micro] | 5,5119 ₽ 
[!KEYREF s1.small] | 11,0136 ₽  
[!KEYREF s1.medium] | 22,0271 ₽ | 
[!KEYREF s1.large] | 44,0542 ₽ | 
[!KEYREF s1.xlarge] | 88,0983 ₽ | 
**Intel Cascade Lake** | | 
[!KEYREF b2.nano]| 0,7056 ₽
[!KEYREF b2.micro] | 1,1916 ₽
[!KEYREF b2.medium] | 2,1960 ₽
[!KEYREF m2.micro] | 7,6944 ₽
[!KEYREF m2.small] | 15,3888 ₽
[!KEYREF m2.medium]| 23,0832 ₽
[!KEYREF m2.large] | 30,7776 ₽
[!KEYREF m2.xlarge] | 46,1664 ₽
[!KEYREF m2.2xlarge] | 61,5552 ₽
[!KEYREF m2.3xlarge] | 92,3316 ₽
[!KEYREF m2.4xlarge] | 123,1092 ₽
[!KEYREF m2.5xlarge] | 153,8856 ₽
[!KEYREF m2.6xlarge] | 184,6632 ₽
[!KEYREF s2.micro] | 5,0808 ₽
[!KEYREF s2.small] | 10,1616 ₽
[!KEYREF s2.medium] | 20,3232 ₽
[!KEYREF s2.large] | 30,4836 ₽
[!KEYREF s2.xlarge] | 40,6452 ₽
[!KEYREF s2.2xlarge] | 60,9672 ₽
[!KEYREF s2.3xlarge] | 81,2904 ₽
[!KEYREF s2.4xlarge] | 101,6136 ₽
[!KEYREF s2.5xlarge] | 121,9356 ₽

---


### Хосты ZooKeeper {#prices-zookeeper}

---

**[!TAB За месяц работы хоста]**

Класс хостов | Цена за месяц, вкл. НДС 
----- | -----
**Intel Broadwell** | 
[!KEYREF b1.nano] | 505 ₽
[!KEYREF b1.micro]  | 798 ₽
[!KEYREF b1.medium]  | 1 289 ₽
[!KEYREF m1.micro] | 3 593 ₽
[!KEYREF m1.small] | 7 185 ₽
[!KEYREF m1.medium]| 10 778 ₽
[!KEYREF m1.large] | 14 370 ₽
[!KEYREF m1.xlarge] | 21 555 ₽
[!KEYREF m1.2xlarge] | 28 740 ₽
[!KEYREF m1.3xlarge] | 43 110 ₽
[!KEYREF m1.4xlarge] | 57 479 ₽
[!KEYREF s1.nano] | 1 259 ₽
[!KEYREF s1.micro]  | 2 460 ₽
[!KEYREF s1.small]  | 4 862 ₽
[!KEYREF s1.medium]  | 9 665 ₽
[!KEYREF s1.large]  | 19 286 ₽
[!KEYREF s1.xlarge]  | 38 507 ₽
**Intel Cascade Lake** | 
[!KEYREF b2.nano] | 505 ₽
[!KEYREF b2.micro]  | 798 ₽
[!KEYREF b2.medium]  | 1 289 ₽
[!KEYREF m2.micro] | 3 593 ₽
[!KEYREF m2.small] | 7 185 ₽
[!KEYREF m2.medium]| 10 778 ₽
[!KEYREF m2.large] | 14 370 ₽
[!KEYREF m2.xlarge] | 21 555 ₽
[!KEYREF m2.2xlarge] | 28 740 ₽
[!KEYREF m2.3xlarge] | 43 110 ₽
[!KEYREF m2.4xlarge] | 57 479 ₽
[!KEYREF m2.5xlarge] | 71 849 ₽
[!KEYREF m2.6xlarge] | 86 219 ₽
[!KEYREF s2.micro]  | 2 290 ₽
[!KEYREF s2.small]  | 4 507 ₽
[!KEYREF s2.medium]  | 8 942 ₽
[!KEYREF s2.large]  | 13 376 ₽
[!KEYREF s2.xlarge]  | 17 810 ₽
[!KEYREF s2.2xlarge]  | 26 678 ₽
[!KEYREF s2.3xlarge]  | 35 546 ₽
[!KEYREF s2.4xlarge] | 44 414 ₽
[!KEYREF s2.5xlarge] | 53 282 ₽

**[!TAB За 1 час работы хоста]**

Класс хостов | Цена за 1 час, вкл. НДС 
----- | -----
**Intel Broadwell** | 
[!KEYREF b1.nano] | 0,7008 ₽
[!KEYREF b1.micro]  | 1,1088 ₽
[!KEYREF b1.medium]  | 1,7904 ₽
[!KEYREF m1.micro] | 4,9896 ₽
[!KEYREF m1.small] | 9,9792 ₽
[!KEYREF m1.medium]| 14,9688 ₽
[!KEYREF m1.large] | 19,9584 ₽
[!KEYREF m1.xlarge] | 29,9376 ₽
[!KEYREF m1.2xlarge] | 39,9168 ₽
[!KEYREF m1.3xlarge] | 59,8752 ₽
[!KEYREF m1.4xlarge] | 79,8324 ₽
[!KEYREF s1.nano]  | 1,7492 ₽ | 
[!KEYREF s1.micro]  | 3,4169 ₽ | 
[!KEYREF s1.small]  | 6,7525 ₽ | 
[!KEYREF s1.medium]  | 13,4237 ₽ | 
[!KEYREF s1.large]  | 26,7864 ₽ | 
[!KEYREF s1.xlarge]  | 53,4814 ₽ | 
**Intel Cascade Lake** | 
[!KEYREF b2.nano] | 0,7008 ₽
[!KEYREF b2.micro]  | 1,1088 ₽
[!KEYREF b2.medium]  | 1,7904 ₽
[!KEYREF m2.micro] | 4,9896 ₽
[!KEYREF m2.small] | 9,9792 ₽
[!KEYREF m2.medium]| 14,9688 ₽
[!KEYREF m2.large] | 19,9584 ₽
[!KEYREF m2.xlarge] | 29,9376 ₽
[!KEYREF m2.2xlarge] | 39,9168 ₽
[!KEYREF m2.3xlarge] | 59,8752 ₽
[!KEYREF m2.4xlarge] | 79,8324 ₽
[!KEYREF m2.5xlarge] | 99,7908 ₽
[!KEYREF m2.6xlarge] | 119,7492 ₽
[!KEYREF s2.micro]  | 3,1812 ₽
[!KEYREF s2.small]  | 6,2604 ₽
[!KEYREF s2.medium]  | 12,4188 ₽
[!KEYREF s2.large]  | 18,5772 ₽
[!KEYREF s2.xlarge]  | 24,7356 ₽
[!KEYREF s2.2xlarge]  | 37,0524 ₽
[!KEYREF s2.3xlarge]  | 49,3692 ₽
[!KEYREF s2.4xlarge] | 61,6860 ₽
[!KEYREF s2.5xlarge] | 74,0028 ₽

---


### Хранилище и резервные копии {#prices-storage}

Услуга | Цена за ГБ в месяц, вкл. НДС 
----- | ----- 
Стандартное сетевое хранилище  | 2,2881 ₽ | 
Быстрое сетевое хранилище  | 8,1356 ₽ | 
Быстрое локальное хранилище  | 8,1356 ₽ | 
Резервные копии сверх размера хранилища  | 2,5424 ₽ 


### Исходящий трафик {#prices-traffic}

[!INCLUDE-NOTITLE [pricing-egress-traffic](../_includes/pricing/pricing-egress-traffic.md)]
