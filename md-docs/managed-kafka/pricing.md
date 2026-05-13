# Правила тарификации для Managed Service for Apache Kafka®


{% note warning %}

С 1 мая 2026 года изменится стоимость ряда сервисов Yandex Cloud. Подробнее в [блоге](https://yandex.cloud/ru/blog/pricing-update-2026).

{% endnote %}


В этом разделе описаны [правила](#rules), по которым тарифицируется использование сервиса Managed Service for Apache Kafka®, и представлены [актуальные цены](#prices) на предоставляемые им ресурсы.

{% note tip %}


Чтобы рассчитать стоимость использования сервиса, воспользуйтесь [калькулятором](https://yandex.cloud/ru/prices?state=b51108af518a#calculator) на сайте Yandex Cloud или ознакомьтесь с тарифами в этом разделе.





{% endnote %}

Цены на продукты сервиса также доступны в [Прайс-листе](https://yandex.cloud/ru/price-list).


Все цены в рублях и тенге указаны с НДС, все цены в долларах — без НДС.

## Статус кластера {#running-stopped}

В зависимости от статуса кластера тарифы применяются различным образом:

* Для запущенного кластера (`Running`) тарифицируются как вычислительные ресурсы, так и объем хранилища.
* Для остановленного кластера (`Stopped`) тарифицируется только объем хранилища.

{% note alert %}

Если кластер использует хранилище на локальных SSD-дисках (`local-ssd`), то вычислительные ресурсы кластера не освобождаются при его остановке. Поэтому даже остановленный кластер будет тарифицироваться в полном объеме.

{% endnote %}

## Из чего складывается стоимость использования Managed Service for Apache Kafka® {#rules}

Расчет стоимости использования Managed Service for Apache Kafka® учитывает:

* тип диска и размер хранилища;

* вычислительные ресурсы, выделенные хостам кластера (в том числе хостам ZooKeeper), и тип хостов;

* объем исходящего трафика из Yandex Cloud в интернет.

Во всех расчетах 1 ГБ = 2<sup>30</sup> байт, 1 МБ = 2<sup>20</sup> байт.

### Использование хостов кластера {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы хоста в соответствии с выделенными для него вычислительными ресурсами. Поддерживаемые конфигурации ресурсов приведены в разделе [Классы хостов](concepts/instance-types.md), цены за использование vCPU и RAM — в разделе [Цены](#prices).

Вы можете выбрать класс хостов для хостов-брокеров Apache Kafka®, хостов ZooKeeper и KRaft в соответствии с ожидаемой нагрузкой реплицирования. Наличие хостов ZooKeeper или KRaft зависит от конфигурации кластера:

* Хосты ZooKeeper добавляются в кластер, если он содержит больше одного хоста Apache Kafka® и в качестве сервиса координации выбран ZooKeeper.
* Хосты ZooKeeper не добавляются в кластер, если он содержит один хост-брокер.
* Хосты KRaft добавляются в кластер, если в кластере используется версия Apache Kafka® 3.6 и выше, он содержит больше одного хоста Apache Kafka® и в качестве сервиса координации выбран KRaft (на отдельных хостах).
* Хосты KRaft не добавляются в кластер, если в кластере используется версия Apache Kafka® 3.6 и выше, и в качестве сервиса координации выбран KRaft (комбинированный режим). 

Минимальная единица тарификации — минута (например, стоимость 1,5 минут работы хоста равна стоимости 2 минут). Время, когда хост-брокер, ZooKeeper или KRaft не может выполнять свои основные функции, не тарифицируется.

### Использование дискового пространства {#rules-storage}

Оплачивается объем хранилища, выделенный для кластеров.

* Хранилище на локальных SSD-дисках (`local-ssd`) можно заказывать только для кластеров с тремя хостами-брокерами и более:
    * для платформы Intel Cascade Lake — с шагом 100 ГБ;
    * для платформ Intel Ice Lake и AMD Zen 4 — с шагом 368 ГБ.
* Хранилище на нереплицируемых SSD-дисках (`network-ssd-nonreplicated`) можно заказывать только для кластеров с тремя хостами-брокерами и более, с шагом 93 ГБ.

Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).

### Пример расчета стоимости кластера {#example}

В приведенном примере цена за месяц использования указывается для справки из расчета 720 часов в месяц.

{% note info %}

Цены в примерах расчета могут отличаться от действующих.

{% endnote %}

Стоимость использования кластера со следующими параметрами в течение 30 дней:

* **Хосты-брокеры Apache Kafka®**: 3 хоста класса `s3-c2-m8`: Intel Ice Lake, 2 × 100% vCPU, 8 ГБ RAM.
* **Хранилище для хостов-брокеров Apache Kafka®**: по 100 ГБ на сетевых HDD-дисках на каждый хост-брокер.
* **Хосты ZooKeeper** (создаются автоматически): 3 хоста класса `b3-c1-m4`: Intel Ice Lake, 2 × 50% vCPU, 4 ГБ RAM. 
* **Хранилище для хостов ZooKeeper**: по 10 ГБ на сетевых SSD-дисках на каждый хост.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  Расчет стоимости для хостов-брокеров Apache Kafka®:
  
  > 3 × (2&nbsp;×&nbsp;1,74 ₽ + 8&nbsp;×&nbsp;0,46 ₽) = 21,48 ₽
  > 
  > Итого: 21,48 ₽ — стоимость часа работы хостов-брокеров Apache Kafka®.
  
  Где:
  * 3 — количество хостов-брокеров Apache Kafka®.
  * 2 — количество vCPU.
  * 1,74 ₽ — стоимость часа использования 100% vCPU.
  * 8 — объем RAM одного хоста (в гигабайтах).
  * 0,46 ₽ — стоимость часа использования 1 ГБ RAM на 100% vCPU.
  
  Расчет стоимости хранилища для хостов-брокеров Apache Kafka®:
  
  > 3 × 100 × 3,744 ₽ = 1 123,2 ₽
  >
  > Итого: 1 123,2 ₽ — стоимость хранилища для хостов-брокеров Apache Kafka®.
  
  Где:
  * 3 — количество хостов-брокеров Apache Kafka®.
  * 100 — объем хранилища на сетевых HDD-дисках (в гигабайтах).
  * 3,744 ₽ — стоимость месяца использования 1 ГБ хранилища на сетевых HDD-дисках.
  
  Расчет стоимости для хостов ZooKeeper:
  
  > 3 × (2&nbsp;×&nbsp;0,807 ₽ + 4&nbsp;×&nbsp;0,3228 ₽) = 8,7156 ₽
  >
  > Итого: 8,7156 ₽ — стоимость часа работы хостов ZooKeeper.
  
  Где:
  * 3 — количество хостов ZooKeeper.
  * 2 — количество vCPU.
  * 0,807 ₽ — стоимость часа использования 50% vCPU.
  * 4 — объем RAM одного хоста (в гигабайтах).
  * 0,3228 ₽ — стоимость часа использования 1 ГБ RAM на 50% vCPU.
  
  Расчет стоимости хранилища для хостов ZooKeeper:
  
  > 3 × 10 × 15,696 ₽ = 470,88 ₽
  >
  > Итого: 470,88 ₽ — стоимость хранилища для хостов ZooKeeper.
  
  Где:
  * 3 — количество хостов ZooKeeper.
  * 10 — объем хранилища на сетевых SSD-дисках (в гигабайтах).
  * 15,696 ₽ — стоимость месяца использования 1 ГБ хранилища на сетевых SSD-дисках.
  
  Расчет итоговой стоимости:
  
  > 720 × (21,48 ₽ + 8,7156 ₽) + 1 123,2 ₽ + 470,88 ₽ = 23 334,912 ₽
  >
  > Итого: 23 334,912 ₽ — стоимость использования кластера в течение 30 дней.
  
  Где:
  * 720 — количество часов в 30 днях.
  * 21,48 ₽ — стоимость часа работы хостов-брокеров Apache Kafka®.
  * 8,7156 ₽ — стоимость часа работы хостов ZooKeeper.
  * 1 123,2 ₽ — стоимость хранилища для хостов-брокеров Apache Kafka®.
  * 470,88 ₽ — стоимость хранилища для хостов ZooKeeper.

- Расчет в тенге {#prices-kzt}

  Расчет стоимости для хостов-брокеров Apache Kafka®:
  
  > 3 × (2&nbsp;×&nbsp;8,7 ₸ + 8&nbsp;×&nbsp;2,3 ₸) = 107,4 ₸
  > 
  > Итого: 107,4 ₸ — стоимость часа работы хостов-брокеров Apache Kafka®.
  
  Где:
  * 3 — количество хостов-брокеров Apache Kafka®.
  * 2 — количество vCPU.
  * 8,7 ₸ — стоимость часа использования 100% vCPU.
  * 8 — объем RAM одного хоста (в гигабайтах).
  * 2,3 ₸ — стоимость часа использования 1 ГБ RAM на 100% vCPU.
  
  Расчет стоимости хранилища для хостов-брокеров Apache Kafka®:
  
  > 3 × 100 × 18,72 ₸ = 5 616 ₸
  >
  > Итого: 5 616 ₸ — стоимость хранилища для хостов-брокеров Apache Kafka®.
  
  Где:
  * 3 — количество хостов-брокеров Apache Kafka®.
  * 100 — объем хранилища на сетевых HDD-дисках (в гигабайтах).
  * 18,72 ₸ — стоимость месяца использования 1 ГБ хранилища на сетевых HDD-дисках.
  
  Расчет стоимости для хостов ZooKeeper:
  
  > 3 × (2&nbsp;×&nbsp;4,035 ₸ + 4&nbsp;×&nbsp;1,614 ₸) = 43,578 ₸
  >
  > Итого: 43,578 ₸ — стоимость часа работы хостов ZooKeeper.
  
  Где:
  * 3 — количество хостов ZooKeeper.
  * 2 — количество vCPU.
  * 4,035 ₸ — стоимость часа использования 50% vCPU.
  * 4 — объем RAM одного хоста (в гигабайтах).
  * 1,614 ₸ — стоимость часа использования 1 ГБ RAM на 50% vCPU.
  
  Расчет стоимости хранилища для хостов ZooKeeper:
  
  > 3 × 10 × 78,48 ₸ = 2 354,4 ₸
  >
  > Итого: 2 354,4 ₸ — стоимость хранилища для хостов ZooKeeper.
  
  Где:
  * 3 — количество хостов ZooKeeper.
  * 10 — объем хранилища на сетевых SSD-дисках (в гигабайтах).
  * 78,48 ₸ — стоимость месяца использования 1 ГБ хранилища на сетевых SSD-дисках.
  
  Расчет итоговой стоимости:
  
  > 720 × (107,4 ₸ + 43,578 ₸) + 5 616 ₸ + 2 354,4 ₸ = 116 674,56 ₸
  >
  > Итого: 116 674,56 ₸ — стоимость использования кластера в течение 30 дней.
  
  Где:
  * 720 — количество часов в 30 днях.
  * 107,4 ₸ — стоимость часа работы хостов-брокеров Apache Kafka®.
  * 43,578 ₸ — стоимость часа работы хостов ZooKeeper.
  * 5 616 ₸ — стоимость хранилища для хостов-брокеров Apache Kafka®.
  * 2 354,4 ₸ — стоимость хранилища для хостов ZooKeeper.

{% endlist %}




## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

Вы можете получить гарантированную скидку за потребление ресурсов сервиса, запланированное на 6 месяцев или 1 год вперед. Чтобы посмотреть ресурсы, для которых можно получить такую скидку:

1. Перейдите в раздел [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts).
1. Нажмите на нужный платежный аккаунт.
1. Выберите раздел ![image](../_assets/console-icons/lock.svg) **Резервируемый объём** в меню слева.

Механизм CVoS гарантирует скидку на потребление, но не гарантирует наличие заказанного объема ресурсов.  Подробнее о механизме работы CVoS читайте в [документации сервиса Yandex Cloud Billing](../billing/concepts/cvos.md).

Сервис Managed Service for Apache Kafka® предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

По схеме CVoS можно заказать только ресурсы определенного вида: для недоступных видов ресурсов в колонках CVoS в разделе [Цены для региона Россия](#prices) стоят прочерки. Объем хранилища и интернет-трафика заказать таким образом пока невозможно.

{% endnote %}


## Цены для региона Россия {#prices}



{% note info %}

Цены на ресурсы Yandex Cloud в разных регионах различаются. Подробнее о доступных регионах см. [Регионы](../overview/concepts/region.md).

Валюта, которой можно оплачивать ресурсы, зависит от юридического лица, с которым пользователь заключил договор. Подробнее о регистрации аккаунта см. [Регистрация аккаунта в Yandex Cloud](../billing/quickstart/index.md).

{% endnote %}

Цены за месяц использования формируются из расчета 720 часов в месяц.


{% note info %}

Доступ к платформе **Intel Ice Lake (Compute Optimized)** предоставляется по запросу. Обратитесь в [техническую поддержку](https://center.yandex.cloud/support) или к вашему аккаунт-менеджеру.

{% endnote %}


Заказать ресурсы хостов ZooKeeper с помощью механизма CVoS невозможно.

{% note info %}

Доступ к хранилищу на локальных SSD-дисках при использовании стандартных хостов на платформе **Intel Ice Lake** предоставляется по запросу. Обратитесь в [техническую поддержку](https://center.yandex.cloud/support) или к вашему аккаунт-менеджеру.

{% endnote %}


| Услуга                                                                                                                                    | Цена     | Ед. тарификации | Действует с    | Действует до |
| ----------------------------------------------------------------------------------------------------------------------------------------- | -------- | --------------- | -------------- | ------------ |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов Apache Kafka® Raft, AMD Zen 4 HighFreq, 100% vCPU                        | 3,39 ₽   | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов Apache Kafka® Raft, AMD Zen 4 HighFreq, RAM                              | 0,6445 ₽ | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов Apache Kafka® Raft, AMD Zen 4, 100% vCPU                                 | 1,74 ₽   | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов Apache Kafka® Raft, AMD Zen 4, 100% vCPU, CVoS на 1 год                  | 1,4797 ₽ | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов Apache Kafka® Raft, AMD Zen 4, 100% vCPU, CVoS на 6 месяцев              | 1,56 ₽   | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов Apache Kafka® Raft, AMD Zen 4, RAM                                       | 0,46 ₽   | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов Apache Kafka® Raft, AMD Zen 4, RAM, CVoS на 1 год                        | 0,3918 ₽ | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов Apache Kafka® Raft, AMD Zen 4, RAM, CVoS на 6 месяцев                    | 0,4151 ₽ | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов Apache Kafka® Raft, Intel Cascade Lake, 100% vCPU                        | 1,93 ₽   | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов Apache Kafka® Raft, Intel Cascade Lake, 100% vCPU, CVoS на 1 год         | 1,64 ₽   | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов Apache Kafka® Raft, Intel Cascade Lake, 100% vCPU, CVoS на 6 месяцев     | 1,74 ₽   | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов Apache Kafka® Raft, Intel Cascade Lake, 50% vCPU                         | 1,1858 ₽ | vCPU × час      | 9 февраля 2026 | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов Apache Kafka® Raft, Intel Cascade Lake, RAM                              | 0,5188 ₽ | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов Apache Kafka® Raft, Intel Cascade Lake, RAM, CVoS на 1 год               | 0,44 ₽   | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов Apache Kafka® Raft, Intel Cascade Lake, RAM, CVoS на 6 месяцев           | 0,4669 ₽ | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов Apache Kafka® Raft, Intel Ice Lake (Compute Optimized), 100% vCPU        | 2,79 ₽   | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов Apache Kafka® Raft, Intel Ice Lake (Compute Optimized), RAM              | 0,53 ₽   | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов Apache Kafka® Raft, Intel Ice Lake, 100% vCPU                            | 1,74 ₽   | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов Apache Kafka® Raft, Intel Ice Lake, 100% vCPU, CVoS на 1 год             | 1,4797 ₽ | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов Apache Kafka® Raft, Intel Ice Lake, 100% vCPU, CVoS на 6 месяцев         | 1,56 ₽   | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов Apache Kafka® Raft, Intel Ice Lake, 50% vCPU                             | 1,0541 ₽ | vCPU × час      | 9 февраля 2026 | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов Apache Kafka® Raft, Intel Ice Lake, RAM                                  | 0,46 ₽   | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов Apache Kafka® Raft, Intel Ice Lake, RAM, CVoS на 1 год                   | 0,3918 ₽ | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов Apache Kafka® Raft, Intel Ice Lake, RAM, CVoS на 6 месяцев               | 0,4151 ₽ | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов ZooKeeper, AMD Zen 4 HighFreq, 100% vCPU                                 | 2,43 ₽   | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов ZooKeeper, AMD Zen 4 HighFreq, RAM                                       | 0,4483 ₽ | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов ZooKeeper, AMD Zen 4, 100% vCPU                                          | 1,2566 ₽ | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов ZooKeeper, AMD Zen 4, RAM                                                | 0,3228 ₽ | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов ZooKeeper, Intel Cascade Lake, 100% vCPU                                 | 1,39 ₽   | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов ZooKeeper, Intel Cascade Lake, 50% vCPU                                  | 0,8992 ₽ | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов ZooKeeper, Intel Cascade Lake, RAM                                       | 0,3689 ₽ | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов ZooKeeper, Intel Ice Lake (Compute Optimized), 100% vCPU                 | 2 ₽      | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов ZooKeeper, Intel Ice Lake (Compute Optimized), RAM                       | 0,3689 ₽ | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов ZooKeeper, Intel Ice Lake,  100% vCPU                                    | 1,2566 ₽ | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов ZooKeeper, Intel Ice Lake, 50% vCPU                                      | 0,807 ₽  | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов ZooKeeper, Intel Ice Lake, RAM                                           | 0,3228 ₽ | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов-брокеров Apache Kafka®, AMD Zen 4 HighFreq, 100% vCPU                    | 3,39 ₽   | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов-брокеров Apache Kafka®, AMD Zen 4 HighFreq, RAM                          | 0,6445 ₽ | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов-брокеров Apache Kafka®, AMD Zen 4, 100% vCPU                             | 1,74 ₽   | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов-брокеров Apache Kafka®, AMD Zen 4, 100% vCPU, CVoS на 1 год              | 1,3578 ₽ | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов-брокеров Apache Kafka®, AMD Zen 4, 100% vCPU, CVoS на 6 месяцев          | 1,4797 ₽ | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов-брокеров Apache Kafka®, AMD Zen 4, RAM                                   | 0,46 ₽   | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов-брокеров Apache Kafka®, AMD Zen 4, RAM, CVoS на 1 год                    | 0,3597 ₽ | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов-брокеров Apache Kafka®, AMD Zen 4, RAM, CVoS на 6 месяцев                | 0,3919 ₽ | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов-брокеров Apache Kafka®, Intel Cascade Lake, 100% vCPU                    | 1,93 ₽   | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов-брокеров Apache Kafka®, Intel Cascade Lake, 100% vCPU, CVoS на 1 год     | 1,51 ₽   | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов-брокеров Apache Kafka®, Intel Cascade Lake, 100% vCPU, CVoS на 6 месяцев | 1,64 ₽   | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов-брокеров Apache Kafka®, Intel Cascade Lake, 50% vCPU                     | 1,1858 ₽ | vCPU × час      | 9 февраля 2026 | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов-брокеров Apache Kafka®, Intel Cascade Lake, RAM                          | 0,5188 ₽ | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов-брокеров Apache Kafka®, Intel Cascade Lake, RAM, CVoS на 1 год           | 0,4046 ₽ | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов-брокеров Apache Kafka®, Intel Cascade Lake, RAM, CVoS на 6 месяцев       | 0,44 ₽   | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов-брокеров Apache Kafka®, Intel Ice Lake (Compute Optimized), 100% vCPU    | 2,79 ₽   | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов-брокеров Apache Kafka®, Intel Ice Lake (Compute Optimized), RAM          | 0,53 ₽   | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов-брокеров Apache Kafka®, Intel Ice Lake, 100% vCPU                        | 1,74 ₽   | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов-брокеров Apache Kafka®, Intel Ice Lake, 100% vCPU, CVoS на 1 год         | 1,3578 ₽ | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов-брокеров Apache Kafka®, Intel Ice Lake, 100% vCPU, CVoS на 6 месяцев     | 1,4797 ₽ | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов-брокеров Apache Kafka®, Intel Ice Lake, 50% vCPU                         | 1,0541 ₽ | vCPU × час      | 9 февраля 2026 | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов-брокеров Apache Kafka®, Intel Ice Lake, RAM                              | 0,46 ₽   | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов-брокеров Apache Kafka®, Intel Ice Lake, RAM, CVoS на 1 год               | 0,3597 ₽ | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Вычислительные ресурсы хостов-брокеров Apache Kafka®, Intel Ice Lake, RAM, CVoS на 6 месяцев           | 0,3919 ₽ | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Кластер с Kafka UI                                                                                     | 4 270 ₽  | Ресурс × месяц  | 1 января 2026  | —            |
| Managed Service for Apache Kafka®. Публичный IP-адрес                                                                                     | 0,2766 ₽ | IP-адрес × час  | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Сверхбыстрое сетевое хранилище с тремя репликами (SSD)                                                 | 0,0365 ₽ | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Хранилище на локальных SSD-дисках                                                                      | 0,0198 ₽ | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Хранилище на нереплицируемых SSD-дисках                                                                | 0,0147 ₽ | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Хранилище на сетевых HDD-дисках                                                                        | 0,0052 ₽ | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for Apache Kafka®. Хранилище на сетевых SSD-дисках                                                                        | 0,0218 ₽ | ГБ × час        | 1 мая 2026     | —            |





### Исходящий трафик {#prices-traffic}

При использовании сервиса оплачивается исходящий трафик из Yandex Cloud в интернет. Передача трафика между сервисами Yandex Cloud по внутренним адресам, как и входящий трафик из интернета, не тарифицируется.

Каждый месяц не тарифицируются первые 100 ГБ исходящего трафика.

Минимальная единица тарификации — 1 МБ.


| Услуга                                                    | Цена              | Ед. тарификации | Действует с | Действует до |
| --------------------------------------------------------- | ----------------- | --------------- | ----------- | ------------ |
| Исходящий трафик, от 0 до 100 единицы тарификации в месяц | Не тарифицируется | ГБ              | 1 мая 2026  | —            |
| Исходящий трафик, от 100 единицы тарификации в месяц      | 1,42 ₽            | ГБ              | 1 мая 2026  | —            |