# Правила тарификации для Managed Service for ClickHouse®

В этом разделе описаны [правила](#rules), по которым тарифицируется использование сервиса Managed Service for ClickHouse®, и представлены [актуальные цены](#prices) на предоставляемые им ресурсы.

{% note tip %}


Чтобы рассчитать стоимость использования сервиса, воспользуйтесь [калькулятором](https://yandex.cloud/ru/prices?state=decd09ac814c#calculator) на сайте Yandex Cloud или ознакомьтесь с тарифами в этом разделе.





{% endnote %}

Цены на продукты сервиса также доступны в [Прайс-листе](https://yandex.cloud/ru/price-list).


Все цены в рублях и тенге указаны с НДС, все цены в долларах — без НДС.

## Статус кластера {#running-stopped}

В зависимости от статуса кластера тарифы применяются различным образом:

* Для запущенного кластера (`Running`) тарифицируются как вычислительные ресурсы, так и объем хранилища и резервных копий.
* Для остановленного кластера (`Stopped`) тарифицируется только объем хранилища и резервных копий.

{% note alert %}

Если кластер использует хранилище на локальных SSD-дисках (`local-ssd`), то вычислительные ресурсы кластера не освобождаются при его остановке. Поэтому даже остановленный кластер будет тарифицироваться в полном объеме.

{% endnote %}


## Из чего складывается стоимость использования Managed Service for ClickHouse® {#rules}

Расчет стоимости использования Managed Service for ClickHouse® учитывает:

* тип диска и размер хранилища;

* вычислительные ресурсы, выделенные хостам кластера (в том числе хостам ZooKeeper);

* настройки и количество резервных копий;

* объем исходящего трафика из Yandex Cloud в интернет.

Входящий трафик и количество запросов к гибридному хранилищу не тарифицируются.

Во всех расчетах 1 ГБ = 2<sup>30</sup> байт, 1 МБ = 2<sup>20</sup> байт.


### Использование хостов БД {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы хоста в соответствии с выделенными для него вычислительными ресурсами. Поддерживаемые конфигурации ресурсов приведены в разделе [Классы хостов](concepts/instance-types.md), цены за использование vCPU и RAM — в разделе [Цены для региона Россия](#prices).

Вы можете выбрать класс хостов как для хостов ClickHouse®, так и для хостов ZooKeeper (в соответствии с ожидаемой нагрузкой реплицирования).

{% note warning %}

В кластерах с выключенной поддержкой [ClickHouse® Keeper](concepts/replication.md#ck) и с двумя или более хостами ClickHouse® автоматически создается 3 хоста ZooKeeper минимального класса, которые обеспечивают репликацию и [высокую доступность](concepts/high-availability.md).

{% endnote %}

Минимальная единица тарификации — минута (например, стоимость 1,5 минут работы хоста равна стоимости 2 минут). Время, когда хост СУБД или ZooKeeper не может выполнять свои основные функции, не тарифицируется.


### Использование дискового пространства {#rules-storage}

Оплачивается:

* Размер хранилища, выделенный для кластеров БД.

   * Хранилище на локальных SSD-дисках (`local-ssd`) можно заказывать только для кластеров с тремя хостами и более:
        * для платформ **Intel Broadwell** и **Intel Cascade Lake** — с шагом 100 ГБ;
        * для платформ **Intel Ice Lake** и **AMD Zen 4** — с шагом 368 ГБ.
   * Хранилище на нереплицируемых SSD-дисках (`network-ssd-nonreplicated`) можно заказывать только для кластеров с тремя или более хостами, с шагом 93 ГБ.

* Размер, занимаемый резервными копиями данных хранилища на [локальных](concepts/storage.md#local-storage-features) и [сетевых](concepts/storage.md) дисках:

    * Хранение резервных копий не тарифицируется, пока сумма размера БД и всех резервных копий остается меньше выбранного размера хранилища.

    * Если сумма размера БД и всех резервных копий становится больше размера хранилища кластера, тарифицируется только превышение этого размера.

   * При автоматическом резервном копировании Managed Service for ClickHouse® не создает новую копию, а сохраняет изменения БД по сравнению с предыдущей копией. Поэтому потребление хранилища автоматическими резервными копиями растет только пропорционально объему изменений.

   * Количество хостов кластера не влияет на размер хранилища и, соответственно, на бесплатный объем резервных копий.

    Например, если в кластере есть N свободных гигабайт места, то хранение первых N гигабайт резервных копий не тарифицируется.

* Размер, занимаемый резервными копиями холодных данных [гибридного хранилища](concepts/storage.md#hybrid-storage-features):

   * Резервные копии холодных данных хранятся в том же бакете Object Storage, что и сами данные.

   * Объем, который занимают резервные копии, учитывается при расчете стоимости использования Object Storage так же, как и объем самих данных.

   * При автоматическом резервном копировании Managed Service for ClickHouse® не создает новую копию, а сохраняет изменения БД по сравнению с предыдущей копией. Поэтому потребление хранилища автоматическими резервными копиями растет только пропорционально объему изменений.

Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).


### Пример расчета стоимости кластера {#example}

Стоимость использования кластера со следующими параметрами в течение 30 дней:

* **Хосты ClickHouse®**: 3 хоста класса `s3-c2-m8`: Intel Ice Lake, 2 × 100% vCPU, 8 ГБ RAM.
* **Хранилище для хостов ClickHouse®**: по 100 ГБ на сетевых HDD-дисках на каждый хост.
* **Хосты ZooKeeper** (создаются автоматически): 3 хоста класса `b3-c1-m4`: Intel Ice Lake, 2 × 50% vCPU, 4 ГБ RAM.
* **Хранилище для хостов ZooKeeper**: по 10 ГБ на сетевых SSD-дисках на каждый хост.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  Расчет стоимости для хостов ClickHouse®:
  
  > 3 × (2 × 1,98 ₽ + 8 × 0,54 ₽) = {% calc [currency=RUB] 3 × (2 × 1.98 + 8 × 0.54) %}
  >
  > Итого: {% calc [currency=RUB] 3 × (2 × 1.98 + 8 × 0.54) %} — стоимость часа работы хостов ClickHouse®.
  
  Где:
  * 3 — количество хостов ClickHouse®.
  * 2 — количество vCPU.
  * 1,98 ₽ — стоимость часа использования 100% vCPU.
  * 8 — объем RAM одного хоста ClickHouse® (в гигабайтах).
  * 0,54 ₽ — стоимость часа использования 1 ГБ RAM на 100% vCPU.
  
  Расчет стоимости хранилища для хостов ClickHouse®:
  
  > 3 × 100 × 3,744 ₽ = {% calc [currency=RUB] 3 × 100 × 3.744 %}
  >
  > Итого: {% calc [currency=RUB] 3 × 100 × 3.744 %} — стоимость использования кластера в течение 30 дней.
  
  Где:
  * 3 — количество хостов ClickHouse®.
  * 100 — объем хранилища на сетевых HDD-дисках (в гигабайтах).
  * 3,744 ₽ — стоимость месяца использования 1 ГБ хранилища на сетевых HDD-дисках.
  
  Расчет стоимости для хостов ZooKeeper:
  
  > 3 × (2 × 0,807 ₽ + 4 × 0,3228 ₽) = {% calc [currency=RUB] 3 × (2 × 0.807 + 4 × 0.3228) %}
  >
  > Итого: {% calc [currency=RUB] 3 × (2 × 0.807 + 4 × 0.3228) %} — стоимость часа работы хостов ZooKeeper.
  
  Где:
  * 3 — количество хостов ZooKeeper.
  * 2 — количество vCPU.
  * 0,807 ₽ — стоимость часа использования 50% vCPU.
  * 4 — объем RAM одного хоста ZooKeeper (в гигабайтах).
  * 0,3228 ₽ — стоимость часа использования 1 ГБ RAM на 50% vCPU.
  
  Расчет стоимости хранилища для хостов ZooKeeper:
  
  > 3 × 10 × 15,696 ₽ = {% calc [currency=RUB] 3 × 10 × 15.696 %}
  >
  > Итого: {% calc [currency=RUB] 3 × 10 × 15.696 %} — стоимость хранилища для хостов ZooKeeper.
  
  Где:
  * 3 — количество хостов ZooKeeper.
  * 10 — объем хранилища на сетевых SSD-дисках (в гигабайтах).
  * 15,696 ₽ — стоимость месяца использования 1 ГБ хранилища на сетевых SSD-дисках.
  
  Расчет итоговой стоимости:
  
  > 720 × ({% calc [currency=RUB] 3 × (2 × 1.98 + 8 × 0.54) %} + {% calc [currency=RUB] 3 × (2 × 0.807 + 4 × 0.3228) %}) + {% calc [currency=RUB] 3 × 100 × 3.744 %} + {% calc [currency=RUB] 3 × 10 × 15.696 %} = {% calc [currency=RUB] 720 × ((3 × (2 × 1.98 + 8 × 0.54)) + (3 × (2 × 0.807 + 4 × 0.3228))) + (3 × 100 × 3.744) + (3 × 10 × 15.696) %}
  >
  > Итого: {% calc [currency=RUB] 720 × ((3 × (2 × 1.98 + 8 × 0.54)) + (3 × (2 × 0.807 + 4 × 0.3228))) + (3 × 100 × 3.744) + (3 × 10 × 15.696) %} — стоимость использования кластера в течение 30 дней.
  
  Где:
  * 720 — количество часов в 30 днях.
  * {% calc [currency=RUB] 3 × (2 × 1.98 + 8 × 0.54) %} — стоимость часа работы хостов ClickHouse®.
  * {% calc [currency=RUB] 3 × (2 × 0.807 + 4 × 0.3228) %} — стоимость часа работы хостов ZooKeeper.
  * {% calc [currency=RUB] 3 × 100 × 3.744 %} — стоимость хранилища для хостов ClickHouse®.
  * {% calc [currency=RUB] 3 × 10 × 15.696 %} — стоимость хранилища для хостов ZooKeeper.

- Расчет в тенге {#prices-kzt}

  Расчет стоимости для хостов ClickHouse®:
  
  > 3 × (2 × 9,9 ₸ + 8 × 2,7 ₸) = {% calc [currency=KZT] 3 × (2 × 9.9 + 8 × 2.7) %}
  >
  > Итого: {% calc [currency=KZT] 3 × (2 × 9.9 + 8 × 2.7) %} — стоимость часа работы хостов ClickHouse®.
  
  Где:
  * 3 — количество хостов ClickHouse®.
  * 2 — количество vCPU.
  * 9,9 ₸ — стоимость часа использования 100% vCPU.
  * 8 — объем RAM одного хоста ClickHouse® (в гигабайтах).
  * 2,7 ₸ — стоимость часа использования 1 ГБ RAM на 100% vCPU.
  
  Расчет стоимости хранилища для хостов ClickHouse®:
  
  > 3 × 100 × 18,72 ₸ = {% calc [currency=KZT] 3 × 100 × 18.72 %}
  >
  > Итого: {% calc [currency=KZT] 3 × 100 × 18.72 %} — стоимость использования кластера в течение 30 дней.
  
  Где:
  * 3 — количество хостов ClickHouse®.
  * 100 — объем хранилища на сетевых HDD-дисках (в гигабайтах).
  * 18,72 ₸ — стоимость месяца использования 1 ГБ хранилища на сетевых HDD-дисках.
  
  Расчет стоимости для хостов ZooKeeper:
  
  > 3 × (2 × 4,035 ₸ + 4 × 1,614 ₸) = {% calc [currency=KZT] 3 × (2 × 4.035 + 4 × 1.614) %}
  >
  > Итого: {% calc [currency=KZT] 3 × (2 × 4.035 + 4 × 1.614) %} — стоимость часа работы хостов ZooKeeper.
  
  Где:
  * 3 — количество хостов ZooKeeper.
  * 2 — количество vCPU.
  * 4,035 ₸ — стоимость часа использования 50% vCPU.
  * 4 — объем RAM одного хоста ZooKeeper (в гигабайтах).
  * 1,614 ₸ — стоимость часа использования 1 ГБ RAM на 50% vCPU.
  
  Расчет стоимости хранилища для хостов ZooKeeper:
  
  > 3 × 10 × 78,48 ₸ = {% calc [currency=KZT] 3 × 10 × 78.48 %}
  >
  > Итого: {% calc [currency=KZT] 3 × 10 × 78.48 %} — стоимость хранилища для хостов ZooKeeper.
  
  Где:
  * 3 — количество хостов ZooKeeper.
  * 10 — объем хранилища на сетевых SSD-дисках (в гигабайтах).
  * 78,48 ₸ — стоимость месяца использования 1 ГБ хранилища на сетевых SSD-дисках.
  
  Расчет итоговой стоимости:
  
  > 720 × ({% calc [currency=KZT] 3 × (2 × 9.9 + 8 × 2.7) %} + {% calc [currency=KZT] 3 × (2 × 4.035 + 4 × 1.614) %}) + {% calc [currency=KZT] 3 × 100 × 18.72 %} + {% calc [currency=KZT] 3 × 10 × 78.48 %} = {% calc [currency=KZT] 720 × ((3 × (2 × 9.9 + 8 × 2.7)) + (3 × (2 × 4.035 + 4 × 1.614))) + (3 × 100 × 18.72) + (3 × 10 × 78.48) %}
  >
  > Итого: {% calc [currency=KZT] 720 × ((3 × (2 × 9.9 + 8 × 2.7)) + (3 × (2 × 4.035 + 4 × 1.614))) + (3 × 100 × 18.72) + (3 × 10 × 78.48) %} — стоимость использования кластера в течение 30 дней.
  
  Где:
  * 720 — количество часов в 30 днях.
  * {% calc [currency=KZT] 3 × (2 × 9.9 + 8 × 2.7) %} — стоимость часа работы хостов ClickHouse®.
  * {% calc [currency=KZT] 3 × (2 × 4.035 + 4 × 1.614) %} — стоимость часа работы хостов ZooKeeper.
  * {% calc [currency=KZT] 3 × 100 × 18.72 %} — стоимость хранилища для хостов ClickHouse®.
  * {% calc [currency=KZT] 3 × 10 × 78.48 %} — стоимость хранилища для хостов ZooKeeper.

{% endlist %}





## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

Вы можете получить гарантированную скидку за потребление ресурсов сервиса, запланированное на 6 месяцев или 1 год вперед. Чтобы посмотреть ресурсы, для которых можно получить такую скидку:

1. Перейдите в раздел [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts).
1. Нажмите на нужный платежный аккаунт.
1. Выберите раздел ![image](../_assets/console-icons/lock.svg) **Резервируемый объём** в меню слева.

Механизм CVoS гарантирует скидку на потребление, но не гарантирует наличие заказанного объема ресурсов.  Подробнее о механизме работы CVoS читайте в [документации сервиса Yandex Cloud Billing](../billing/concepts/cvos.md).

Сервис Managed Service for ClickHouse® предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах БД. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

По схеме CVoS можно заказать только ресурсы определенного вида: для недоступных видов ресурсов в колонках CVoS в разделе [Цены для региона Россия](#prices) стоят прочерки. Размер хранилища и интернет-трафика заказать таким образом пока невозможно.

{% endnote %}



## Цены для региона Россия {#prices}



{% note info %}

Цены на ресурсы Yandex Cloud в разных регионах различаются. Подробнее о доступных регионах в разделе [Регионы](../overview/concepts/region.md).

Валюта, которой можно оплачивать ресурсы, зависит от юридического лица, с которым пользователь заключил договор. Подробнее о регистрации аккаунта в разделе [Регистрация аккаунта в Yandex Cloud](../billing/quickstart/index.md).

{% endnote %}

Заказать ресурсы хостов ZooKeeper с помощью механизма CVoS невозможно.


{% note info %}

Доступ к платформе **Intel Ice Lake (Compute Optimized)** предоставляется по запросу. Обратитесь в [техническую поддержку](https://center.yandex.cloud/support) или к вашему аккаунт-менеджеру.

{% endnote %}



| Услуга                                                                                                                           | Цена      | Ед. тарификации | Действует с    | Действует до |
| -------------------------------------------------------------------------------------------------------------------------------- | --------- | --------------- | -------------- | ------------ |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse® Keeper, AMD Zen 4 HighFreq, 100% vCPU                 | 3,85 ₽    | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse® Keeper, AMD Zen 4 HighFreq, RAM                       | 0,7566 ₽  | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse® Keeper, AMD Zen 4, 100% vCPU                          | 1,98 ₽    | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse® Keeper, AMD Zen 4, 100% vCPU, CVoS на 1 год           | 1,54 ₽    | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse® Keeper, AMD Zen 4, RAM                                | 0,54 ₽    | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse® Keeper, AMD Zen 4, RAM, CVoS на 1 год                 | 0,4226 ₽  | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse® Keeper, Intel Broadwell, 100% vCPU                    | 2,38 ₽    | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse® Keeper, Intel Broadwell, 50% vCPU                     | 0,71 ₽    | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse® Keeper, Intel Broadwell, RAM                          | 0,5445 ₽  | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse® Keeper, Intel Cascade Lake, 100% vCPU                 | 2,1 ₽     | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse® Keeper, Intel Cascade Lake, 100% vCPU, CVoS на 1 год  | 1,64 ₽    | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse® Keeper, Intel Cascade Lake, 50% vCPU                  | 0,7466 ₽  | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse® Keeper, Intel Cascade Lake, RAM                       | 0,57 ₽    | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse® Keeper, Intel Cascade Lake, RAM, CVoS на 1 год        | 0,4453 ₽  | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse® Keeper, Intel Ice Lake (Compute Optimized), 100% vCPU | 3,01 ₽    | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse® Keeper, Intel Ice Lake (Compute Optimized), RAM       | 0,59 ₽    | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse® Keeper, Intel Ice Lake, 100% vCPU                     | 1,88 ₽    | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse® Keeper, Intel Ice Lake, 100% vCPU, CVoS на 1 год      | 1,47 ₽    | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse® Keeper, Intel Ice Lake, 100% vCPU, CVoS на 6 месяцев  | 1,6 ₽     | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse® Keeper, Intel Ice Lake, 50% vCPU                      | 0,6697 ₽  | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse® Keeper, Intel Ice Lake, RAM                           | 0,516 ₽   | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse® Keeper, Intel Ice Lake, RAM, CVoS на 1 год            | 0,4025 ₽  | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse® Keeper, Intel Ice Lake, RAM, CVoS на 6 месяцев        | 0,4386 ₽  | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, AMD Zen 4 HighFreq, 100% vCPU                        | 3,85 ₽    | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, AMD Zen 4 HighFreq, RAM                              | 0,7566 ₽  | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, AMD Zen 4, 100% vCPU                                 | 1,98 ₽    | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, AMD Zen 4, 100% vCPU, CVoS на 1 год                  | 1,54 ₽    | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, AMD Zen 4, RAM                                       | 0,54 ₽    | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, AMD Zen 4, RAM, CVoS на 1 год                        | 0,4226 ₽  | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, Intel Broadwell, 100% vCPU                           | 2,5 ₽     | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, Intel Broadwell, 20% vCPU                            | 1,1525 ₽  | vCPU × час      | 9 февраля 2026 | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, Intel Broadwell, 5% vCPU                             | 1,1525 ₽  | vCPU × час      | 9 февраля 2026 | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, Intel Broadwell, 50% vCPU                            | 1,1525 ₽  | vCPU × час      | 9 февраля 2026 | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, Intel Broadwell, RAM                                 | 0,57 ₽    | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, Intel Cascade Lake, 100% vCPU                        | 2,21 ₽    | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, Intel Cascade Lake, 100% vCPU, CVoS на 1 год         | 1,72 ₽    | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, Intel Cascade Lake, 100% vCPU, CVoS на 6 месяцев     | 1,88 ₽    | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, Intel Cascade Lake, 20% vCPU                         | 1,1525 ₽  | vCPU × час      | 9 февраля 2026 | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, Intel Cascade Lake, 5% vCPU                          | 1,1525 ₽  | vCPU × час      | 9 февраля 2026 | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, Intel Cascade Lake, 50% vCPU                         | 1,1525 ₽  | vCPU × час      | 9 февраля 2026 | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, Intel Cascade Lake, RAM                              | 0,5995 ₽  | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, Intel Cascade Lake, RAM, CVoS на 1 год               | 0,4676 ₽  | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, Intel Cascade Lake, RAM, CVoS на 6 месяцев           | 0,5095 ₽  | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, Intel Ice Lake (Compute Optimized), 100% vCPU        | 3,17 ₽    | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, Intel Ice Lake (Compute Optimized), RAM              | 0,62 ₽    | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, Intel Ice Lake, 100% vCPU                            | 1,98 ₽    | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, Intel Ice Lake, 100% vCPU, CVoS на 1 год             | 1,54 ₽    | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, Intel Ice Lake, 100% vCPU, CVoS на 6 месяцев         | 1,68 ₽    | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, Intel Ice Lake, 50% vCPU                             | 1,1525 ₽  | vCPU × час      | 9 февраля 2026 | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, Intel Ice Lake, RAM                                  | 0,54 ₽    | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, Intel Ice Lake, RAM, CVoS на 1 год                   | 0,4226 ₽  | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ClickHouse®, Intel Ice Lake, RAM, CVoS на 6 месяцев               | 0,46 ₽    | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ZooKeeper, AMD Zen 4 HighFreq, 100% vCPU                          | 2,43 ₽    | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ZooKeeper, AMD Zen 4 HighFreq, RAM                                | 0,4483 ₽  | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ZooKeeper, AMD Zen 4, 100% vCPU                                   | 1,2566 ₽  | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ZooKeeper, AMD Zen 4, RAM                                         | 0,3228 ₽  | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ZooKeeper, Intel Broadwell, 100% vCPU                             | 1,56 ₽    | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ZooKeeper, Intel Broadwell, 20% vCPU                              | 0,6157 ₽  | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ZooKeeper, Intel Broadwell, 5% vCPU                               | 0,2638 ₽  | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ZooKeeper, Intel Broadwell, 50% vCPU                              | 0,8576 ₽  | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ZooKeeper, Intel Broadwell, RAM                                   | 0,3518 ₽  | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ZooKeeper, Intel Cascade Lake, 100% vCPU                          | 1,39 ₽    | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ZooKeeper, Intel Cascade Lake, 20% vCPU                           | 0,6456 ₽  | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ZooKeeper, Intel Cascade Lake, 5% vCPU                            | 0,2766 ₽  | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ZooKeeper, Intel Cascade Lake, 50% vCPU                           | 0,8992 ₽  | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ZooKeeper, Intel Cascade Lake, RAM                                | 0,3689 ₽  | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ZooKeeper, Intel Ice Lake (Compute Optimized), 100% vCPU          | 2 ₽       | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ZooKeeper, Intel Ice Lake (Compute Optimized), RAM                | 0,3689 ₽  | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ZooKeeper, Intel Ice Lake, 100% vCPU                              | 1,2566 ₽  | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ZooKeeper, Intel Ice Lake, 50% vCPU                               | 0,807 ₽   | vCPU × час      | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Вычислительные ресурсы хостов ZooKeeper, Intel Ice Lake, RAM                                    | 0,3228 ₽  | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Публичный IP-адрес                                                                              | 0,2766 ₽  | IP-адрес × час  | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Резервные копии сверх размера хранилища                                                         | 0,00307 ₽ | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Сверхбыстрое сетевое хранилище с тремя репликами (SSD)                                          | 0,0365 ₽  | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Холодные данные гибридного хранилища и их резервные копии                                       | 0,0032 ₽  | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Хранилище на локальных SSD-дисках                                                               | 0,0198 ₽  | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Хранилище на нереплицируемых SSD-дисках                                                         | 0,0147 ₽  | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Хранилище на сетевых HDD-дисках                                                                 | 0,0052 ₽  | ГБ × час        | 1 мая 2026     | —            |
| Managed Service for ClickHouse®. Хранилище на сетевых SSD-дисках                                                                 | 0,0218 ₽  | ГБ × час        | 1 мая 2026     | —            |





### Исходящий трафик {#prices-traffic}

При использовании сервиса оплачивается исходящий трафик из Yandex Cloud в интернет. Передача трафика между сервисами Yandex Cloud по внутренним адресам, как и входящий трафик из интернета, не тарифицируется.

Каждый месяц не тарифицируются первые 100 ГБ исходящего трафика.

Минимальная единица тарификации — 1 МБ.


| Услуга                                                    | Цена              | Ед. тарификации | Действует с | Действует до |
| --------------------------------------------------------- | ----------------- | --------------- | ----------- | ------------ |
| Исходящий трафик, от 0 до 100 единицы тарификации в месяц | Не тарифицируется | ГБ              | 1 мая 2026  | —            |
| Исходящий трафик, от 100 единицы тарификации в месяц      | 1,42 ₽            | ГБ              | 1 мая 2026  | —            |