# Правила тарификации для {{ mch-short-name }}

В этом разделе описаны [правила](#rules), по которым тарифицируется использование сервиса {{ mch-name }}, и представлены [актуальные цены](#prices) на предоставляемые им ресурсы.

{% note tip %}


Чтобы рассчитать стоимость использования сервиса, воспользуйтесь [калькулятором](https://yandex.cloud/ru/prices?state=decd09ac814c#calculator) на сайте {{ yandex-cloud }} или ознакомьтесь с тарифами в этом разделе.





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


## Из чего складывается стоимость использования {{ mch-short-name }} {#rules}

Расчет стоимости использования {{ mch-name }} учитывает:

* тип диска и размер хранилища;

* вычислительные ресурсы, выделенные хостам кластера (в том числе хостам {{ ZK }});

* настройки и количество резервных копий;

* объем исходящего трафика из {{ yandex-cloud }} в интернет.

Входящий трафик и количество запросов к гибридному хранилищу не тарифицируются.

Во всех расчетах 1 ГБ = 2<sup>30</sup> байт, 1 МБ = 2<sup>20</sup> байт.


### Использование хостов БД {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы хоста в соответствии с выделенными для него вычислительными ресурсами. Поддерживаемые конфигурации ресурсов приведены в разделе [Классы хостов](concepts/instance-types.md), цены за использование vCPU и RAM — в разделе [Цены для региона Россия](#prices).

Вы можете выбрать класс хостов как для хостов {{ CH }}, так и для хостов {{ ZK }} (в соответствии с ожидаемой нагрузкой реплицирования).

{% note warning %}

В кластерах с выключенной поддержкой [{{ CK }}](concepts/replication.md#ck) и с двумя или более хостами {{ CH }} автоматически создается 3 хоста {{ ZK }} минимального класса, которые обеспечивают репликацию и [высокую доступность](concepts/high-availability.md).

{% endnote %}

Минимальная единица тарификации — минута (например, стоимость 1,5 минут работы хоста равна стоимости 2 минут). Время, когда хост СУБД или {{ ZK }} не может выполнять свои основные функции, не тарифицируется.


### Использование дискового пространства {#rules-storage}

Оплачивается:

* Размер хранилища, выделенный для кластеров БД.

   * Хранилище на локальных SSD-дисках (`local-ssd`) можно заказывать только для кластеров с тремя хостами и более:
        * для платформ **Intel Broadwell** и **Intel Cascade Lake** — с шагом 100 ГБ;
        * для платформ **Intel Ice Lake** и **AMD Zen 4** — с шагом {{ local-ssd-v3-step }}.
   * Хранилище на нереплицируемых SSD-дисках (`network-ssd-nonreplicated`) можно заказывать только для кластеров с тремя или более хостами, с шагом 93 ГБ.

* Размер, занимаемый резервными копиями данных хранилища на [локальных](concepts/storage.md#local-storage-features) и [сетевых](concepts/storage.md) дисках:

    * Хранение резервных копий не тарифицируется, пока сумма размера БД и всех резервных копий остается меньше выбранного размера хранилища.

    * Если сумма размера БД и всех резервных копий становится больше размера хранилища кластера, тарифицируется только превышение этого размера.

   * При автоматическом резервном копировании {{ mch-short-name }} не создает новую копию, а сохраняет изменения БД по сравнению с предыдущей копией. Поэтому потребление хранилища автоматическими резервными копиями растет только пропорционально объему изменений.

   * Количество хостов кластера не влияет на размер хранилища и, соответственно, на бесплатный объем резервных копий.

    Например, если в кластере есть N свободных гигабайт места, то хранение первых N гигабайт резервных копий не тарифицируется.

* Размер, занимаемый резервными копиями холодных данных [гибридного хранилища](concepts/storage.md#hybrid-storage-features):

   * Резервные копии холодных данных хранятся в том же бакете {{ objstorage-name }}, что и сами данные.

   * Объем, который занимают резервные копии, учитывается при расчете стоимости использования {{ objstorage-name }} так же, как и объем самих данных.

   * При автоматическом резервном копировании {{ mch-short-name }} не создает новую копию, а сохраняет изменения БД по сравнению с предыдущей копией. Поэтому потребление хранилища автоматическими резервными копиями растет только пропорционально объему изменений.

Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).


### Пример расчета стоимости кластера {#example}

Стоимость использования кластера со следующими параметрами в течение 30 дней:

* **Хосты {{ CH }}**: 3 хоста класса `s3-c2-m8`: Intel Ice Lake, 2 × 100% vCPU, 8 ГБ RAM.
* **Хранилище для хостов {{ CH }}**: по 100 ГБ на сетевых HDD-дисках на каждый хост.
* **Хосты {{ ZK }}** (создаются автоматически): 3 хоста класса `b3-c1-m4`: Intel Ice Lake, 2 × 50% vCPU, 4 ГБ RAM.
* **Хранилище для хостов {{ ZK }}**: по 10 ГБ на сетевых SSD-дисках на каждый хост.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  Расчет стоимости для хостов {{ CH }}:
  
  > 3 × (2 × {{ sku|RUB|mdb.cluster.clickhouse.v3.cpu.c100|string }} + 8 × {{ sku|RUB|mdb.cluster.clickhouse.v3.ram|string }}) = {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.cluster.clickhouse.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.clickhouse.v3.ram|number }}) %}
  >
  > Итого: {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.cluster.clickhouse.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.clickhouse.v3.ram|number }}) %} — стоимость часа работы хостов {{ CH }}.
  
  Где:
  * 3 — количество хостов {{ CH }}.
  * 2 — количество vCPU.
  * {{ sku|RUB|mdb.cluster.clickhouse.v3.cpu.c100|string }} — стоимость часа использования 100% vCPU.
  * 8 — объем RAM одного хоста {{ CH }} (в гигабайтах).
  * {{ sku|RUB|mdb.cluster.clickhouse.v3.ram|string }} — стоимость часа использования 1 ГБ RAM на 100% vCPU.
  
  Расчет стоимости хранилища для хостов {{ CH }}:
  
  > 3 × 100 × {{ sku|RUB|mdb.cluster.network-hdd.ch|month|string }} = {% calc [currency=RUB] 3 × 100 × {{ sku|RUB|mdb.cluster.network-hdd.ch|month|number }} %}
  >
  > Итого: {% calc [currency=RUB] 3 × 100 × {{ sku|RUB|mdb.cluster.network-hdd.ch|month|number }} %} — стоимость использования кластера в течение 30 дней.
  
  Где:
  * 3 — количество хостов {{ CH }}.
  * 100 — объем хранилища на сетевых HDD-дисках (в гигабайтах).
  * {{ sku|RUB|mdb.cluster.network-hdd.ch|month|string }} — стоимость месяца использования 1 ГБ хранилища на сетевых HDD-дисках.
  
  Расчет стоимости для хостов {{ ZK }}:
  
  > 3 × (2 × {{ sku|RUB|mdb.zk.clickhouse.v3.cpu.c50|string }} + 4 × {{ sku|RUB|mdb.zk.clickhouse.v3.ram|string }}) = {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|RUB|mdb.zk.clickhouse.v3.ram|number }}) %}
  >
  > Итого: {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|RUB|mdb.zk.clickhouse.v3.ram|number }}) %} — стоимость часа работы хостов {{ ZK }}.
  
  Где:
  * 3 — количество хостов {{ ZK }}.
  * 2 — количество vCPU.
  * {{ sku|RUB|mdb.zk.clickhouse.v3.cpu.c50|string }} — стоимость часа использования 50% vCPU.
  * 4 — объем RAM одного хоста {{ ZK }} (в гигабайтах).
  * {{ sku|RUB|mdb.zk.clickhouse.v3.ram|string }} — стоимость часа использования 1 ГБ RAM на 50% vCPU.
  
  Расчет стоимости хранилища для хостов {{ ZK }}:
  
  > 3 × 10 × {{ sku|RUB|mdb.cluster.network-nvme.ch|month|string }} = {% calc [currency=RUB] 3 × 10 × {{ sku|RUB|mdb.cluster.network-nvme.ch|month|number }} %}
  >
  > Итого: {% calc [currency=RUB] 3 × 10 × {{ sku|RUB|mdb.cluster.network-nvme.ch|month|number }} %} — стоимость хранилища для хостов {{ ZK }}.
  
  Где:
  * 3 — количество хостов {{ ZK }}.
  * 10 — объем хранилища на сетевых SSD-дисках (в гигабайтах).
  * {{ sku|RUB|mdb.cluster.network-nvme.ch|month|string }} — стоимость месяца использования 1 ГБ хранилища на сетевых SSD-дисках.
  
  Расчет итоговой стоимости:
  
  > 720 × ({% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.cluster.clickhouse.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.clickhouse.v3.ram|number }}) %} + {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|RUB|mdb.zk.clickhouse.v3.ram|number }}) %}) + {% calc [currency=RUB] 3 × 100 × {{ sku|RUB|mdb.cluster.network-hdd.ch|month|number }} %} + {% calc [currency=RUB] 3 × 10 × {{ sku|RUB|mdb.cluster.network-nvme.ch|month|number }} %} = {% calc [currency=RUB] 720 × ((3 × (2 × {{ sku|RUB|mdb.cluster.clickhouse.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.clickhouse.v3.ram|number }})) + (3 × (2 × {{ sku|RUB|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|RUB|mdb.zk.clickhouse.v3.ram|number }}))) + (3 × 100 × {{ sku|RUB|mdb.cluster.network-hdd.ch|month|number }}) + (3 × 10 × {{ sku|RUB|mdb.cluster.network-nvme.ch|month|number }}) %}
  >
  > Итого: {% calc [currency=RUB] 720 × ((3 × (2 × {{ sku|RUB|mdb.cluster.clickhouse.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.clickhouse.v3.ram|number }})) + (3 × (2 × {{ sku|RUB|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|RUB|mdb.zk.clickhouse.v3.ram|number }}))) + (3 × 100 × {{ sku|RUB|mdb.cluster.network-hdd.ch|month|number }}) + (3 × 10 × {{ sku|RUB|mdb.cluster.network-nvme.ch|month|number }}) %} — стоимость использования кластера в течение 30 дней.
  
  Где:
  * 720 — количество часов в 30 днях.
  * {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.cluster.clickhouse.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.clickhouse.v3.ram|number }}) %} — стоимость часа работы хостов {{ CH }}.
  * {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|RUB|mdb.zk.clickhouse.v3.ram|number }}) %} — стоимость часа работы хостов {{ ZK }}.
  * {% calc [currency=RUB] 3 × 100 × {{ sku|RUB|mdb.cluster.network-hdd.ch|month|number }} %} — стоимость хранилища для хостов {{ CH }}.
  * {% calc [currency=RUB] 3 × 10 × {{ sku|RUB|mdb.cluster.network-nvme.ch|month|number }} %} — стоимость хранилища для хостов {{ ZK }}.

- Расчет в тенге {#prices-kzt}

  Расчет стоимости для хостов {{ CH }}:
  
  > 3 × (2 × {{ sku|KZT|mdb.cluster.clickhouse.v3.cpu.c100|string }} + 8 × {{ sku|KZT|mdb.cluster.clickhouse.v3.ram|string }}) = {% calc [currency=KZT] 3 × (2 × {{ sku|KZT|mdb.cluster.clickhouse.v3.cpu.c100|number }} + 8 × {{ sku|KZT|mdb.cluster.clickhouse.v3.ram|number }}) %}
  >
  > Итого: {% calc [currency=KZT] 3 × (2 × {{ sku|KZT|mdb.cluster.clickhouse.v3.cpu.c100|number }} + 8 × {{ sku|KZT|mdb.cluster.clickhouse.v3.ram|number }}) %} — стоимость часа работы хостов {{ CH }}.
  
  Где:
  * 3 — количество хостов {{ CH }}.
  * 2 — количество vCPU.
  * {{ sku|KZT|mdb.cluster.clickhouse.v3.cpu.c100|string }} — стоимость часа использования 100% vCPU.
  * 8 — объем RAM одного хоста {{ CH }} (в гигабайтах).
  * {{ sku|KZT|mdb.cluster.clickhouse.v3.ram|string }} — стоимость часа использования 1 ГБ RAM на 100% vCPU.
  
  Расчет стоимости хранилища для хостов {{ CH }}:
  
  > 3 × 100 × {{ sku|KZT|mdb.cluster.network-hdd.ch|month|string }} = {% calc [currency=KZT] 3 × 100 × {{ sku|KZT|mdb.cluster.network-hdd.ch|month|number }} %}
  >
  > Итого: {% calc [currency=KZT] 3 × 100 × {{ sku|KZT|mdb.cluster.network-hdd.ch|month|number }} %} — стоимость использования кластера в течение 30 дней.
  
  Где:
  * 3 — количество хостов {{ CH }}.
  * 100 — объем хранилища на сетевых HDD-дисках (в гигабайтах).
  * {{ sku|KZT|mdb.cluster.network-hdd.ch|month|string }} — стоимость месяца использования 1 ГБ хранилища на сетевых HDD-дисках.
  
  Расчет стоимости для хостов {{ ZK }}:
  
  > 3 × (2 × {{ sku|KZT|mdb.zk.clickhouse.v3.cpu.c50|string }} + 4 × {{ sku|KZT|mdb.zk.clickhouse.v3.ram|string }}) = {% calc [currency=KZT] 3 × (2 × {{ sku|KZT|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|KZT|mdb.zk.clickhouse.v3.ram|number }}) %}
  >
  > Итого: {% calc [currency=KZT] 3 × (2 × {{ sku|KZT|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|KZT|mdb.zk.clickhouse.v3.ram|number }}) %} — стоимость часа работы хостов {{ ZK }}.
  
  Где:
  * 3 — количество хостов {{ ZK }}.
  * 2 — количество vCPU.
  * {{ sku|KZT|mdb.zk.clickhouse.v3.cpu.c50|string }} — стоимость часа использования 50% vCPU.
  * 4 — объем RAM одного хоста {{ ZK }} (в гигабайтах).
  * {{ sku|KZT|mdb.zk.clickhouse.v3.ram|string }} — стоимость часа использования 1 ГБ RAM на 50% vCPU.
  
  Расчет стоимости хранилища для хостов {{ ZK }}:
  
  > 3 × 10 × {{ sku|KZT|mdb.cluster.network-nvme.ch|month|string }} = {% calc [currency=KZT] 3 × 10 × {{ sku|KZT|mdb.cluster.network-nvme.ch|month|number }} %}
  >
  > Итого: {% calc [currency=KZT] 3 × 10 × {{ sku|KZT|mdb.cluster.network-nvme.ch|month|number }} %} — стоимость хранилища для хостов {{ ZK }}.
  
  Где:
  * 3 — количество хостов {{ ZK }}.
  * 10 — объем хранилища на сетевых SSD-дисках (в гигабайтах).
  * {{ sku|KZT|mdb.cluster.network-nvme.ch|month|string }} — стоимость месяца использования 1 ГБ хранилища на сетевых SSD-дисках.
  
  Расчет итоговой стоимости:
  
  > 720 × ({% calc [currency=KZT] 3 × (2 × {{ sku|KZT|mdb.cluster.clickhouse.v3.cpu.c100|number }} + 8 × {{ sku|KZT|mdb.cluster.clickhouse.v3.ram|number }}) %} + {% calc [currency=KZT] 3 × (2 × {{ sku|KZT|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|KZT|mdb.zk.clickhouse.v3.ram|number }}) %}) + {% calc [currency=KZT] 3 × 100 × {{ sku|KZT|mdb.cluster.network-hdd.ch|month|number }} %} + {% calc [currency=KZT] 3 × 10 × {{ sku|KZT|mdb.cluster.network-nvme.ch|month|number }} %} = {% calc [currency=KZT] 720 × ((3 × (2 × {{ sku|KZT|mdb.cluster.clickhouse.v3.cpu.c100|number }} + 8 × {{ sku|KZT|mdb.cluster.clickhouse.v3.ram|number }})) + (3 × (2 × {{ sku|KZT|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|KZT|mdb.zk.clickhouse.v3.ram|number }}))) + (3 × 100 × {{ sku|KZT|mdb.cluster.network-hdd.ch|month|number }}) + (3 × 10 × {{ sku|KZT|mdb.cluster.network-nvme.ch|month|number }}) %}
  >
  > Итого: {% calc [currency=KZT] 720 × ((3 × (2 × {{ sku|KZT|mdb.cluster.clickhouse.v3.cpu.c100|number }} + 8 × {{ sku|KZT|mdb.cluster.clickhouse.v3.ram|number }})) + (3 × (2 × {{ sku|KZT|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|KZT|mdb.zk.clickhouse.v3.ram|number }}))) + (3 × 100 × {{ sku|KZT|mdb.cluster.network-hdd.ch|month|number }}) + (3 × 10 × {{ sku|KZT|mdb.cluster.network-nvme.ch|month|number }}) %} — стоимость использования кластера в течение 30 дней.
  
  Где:
  * 720 — количество часов в 30 днях.
  * {% calc [currency=KZT] 3 × (2 × {{ sku|KZT|mdb.cluster.clickhouse.v3.cpu.c100|number }} + 8 × {{ sku|KZT|mdb.cluster.clickhouse.v3.ram|number }}) %} — стоимость часа работы хостов {{ CH }}.
  * {% calc [currency=KZT] 3 × (2 × {{ sku|KZT|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|KZT|mdb.zk.clickhouse.v3.ram|number }}) %} — стоимость часа работы хостов {{ ZK }}.
  * {% calc [currency=KZT] 3 × 100 × {{ sku|KZT|mdb.cluster.network-hdd.ch|month|number }} %} — стоимость хранилища для хостов {{ CH }}.
  * {% calc [currency=KZT] 3 × 10 × {{ sku|KZT|mdb.cluster.network-nvme.ch|month|number }} %} — стоимость хранилища для хостов {{ ZK }}.

{% endlist %}





## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

Вы можете получить гарантированную скидку за потребление ресурсов сервиса, запланированное на 6 месяцев или 1 год вперед. Чтобы посмотреть ресурсы, для которых можно получить такую скидку:

1. Перейдите в раздел [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}).
1. Нажмите на нужный платежный аккаунт.
1. Выберите раздел ![image](../_assets/console-icons/lock.svg) **{{ ui-key.yacloud_billing.billing.account.switch_offers }}** в меню слева.

Механизм CVoS гарантирует скидку на потребление, но не гарантирует наличие заказанного объема ресурсов.  Подробнее о механизме работы CVoS читайте в [документации сервиса {{ billing-name }}](../billing/concepts/cvos.md).

Сервис {{ mch-name }} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах БД. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

По схеме CVoS можно заказать только ресурсы определенного вида: для недоступных видов ресурсов в колонках CVoS в разделе [Цены для региона Россия](#prices) стоят прочерки. Размер хранилища и интернет-трафика заказать таким образом пока невозможно.

{% endnote %}



## Цены для региона Россия {#prices}



{% note info %}

Цены на ресурсы {{ yandex-cloud }} в разных регионах различаются. Подробнее о доступных регионах см. [{#T}](../overview/concepts/region.md).

Валюта, которой можно оплачивать ресурсы, зависит от юридического лица, с которым пользователь заключил договор. Подробнее о регистрации аккаунта см. [{#T}](../billing/quickstart/index.md).

{% endnote %}

Заказать ресурсы хостов {{ ZK }} с помощью механизма CVoS невозможно.


{% note info %}

Доступ к платформе **Intel Ice Lake (Compute Optimized)** предоставляется по запросу. Обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.

{% endnote %}



| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |





### Исходящий трафик {#prices-traffic}

При использовании сервиса оплачивается исходящий трафик из {{ yandex-cloud }} в интернет. Передача трафика между сервисами {{ yandex-cloud }} по внутренним адресам, как и входящий трафик из интернета, не тарифицируется.

Каждый месяц не тарифицируются первые 100 ГБ исходящего трафика.

Минимальная единица тарификации — 1 МБ.


| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |