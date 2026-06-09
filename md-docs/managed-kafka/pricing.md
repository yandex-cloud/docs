# Правила тарификации для {{ mkf-name }}

В этом разделе описаны [правила](#rules), по которым тарифицируется использование сервиса {{ mkf-name }}, и представлены [актуальные цены](#prices) на предоставляемые им ресурсы.

{% note tip %}


Чтобы рассчитать стоимость использования сервиса, воспользуйтесь [калькулятором](https://yandex.cloud/ru/prices?state=b51108af518a#calculator) на сайте {{ yandex-cloud }} или ознакомьтесь с тарифами в этом разделе.





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

## Из чего складывается стоимость использования {{ mkf-short-name }} {#rules}

Расчет стоимости использования {{ mkf-name }} учитывает:

* тип диска и размер хранилища;

* вычислительные ресурсы, выделенные хостам кластера (в том числе хостам {{ ZK }}), и тип хостов;

* объем исходящего трафика из {{ yandex-cloud }} в интернет.

Во всех расчетах 1 ГБ = 2<sup>30</sup> байт, 1 МБ = 2<sup>20</sup> байт.

### Использование хостов кластера {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы хоста в соответствии с выделенными для него вычислительными ресурсами. Поддерживаемые конфигурации ресурсов приведены в разделе [Классы хостов](concepts/instance-types.md), цены за использование vCPU и RAM — в разделе [Цены](#prices).

Вы можете выбрать класс хостов для хостов-брокеров {{ KF }}, хостов {{ ZK }} и {{ kraft-short-name }} в соответствии с ожидаемой нагрузкой реплицирования. Наличие хостов {{ ZK }} или {{ kraft-short-name }} зависит от конфигурации кластера:

* Хосты {{ ZK }} добавляются в кластер, если он содержит больше одного хоста {{ KF }} и в качестве сервиса координации выбран {{ ZK }}.
* Хосты {{ ZK }} не добавляются в кластер, если он содержит один хост-брокер.
* Хосты {{ kraft-short-name }} добавляются в кластер, если в кластере используется версия {{ KF }} 3.6 и выше, он содержит больше одного хоста {{ KF }} и в качестве сервиса координации выбран {{ kraft-short-name }} (на отдельных хостах).
* Хосты {{ kraft-short-name }} не добавляются в кластер, если в кластере используется версия {{ KF }} 3.6 и выше, и в качестве сервиса координации выбран {{ kraft-short-name }} (комбинированный режим). 

Минимальная единица тарификации — минута (например, стоимость 1,5 минут работы хоста равна стоимости 2 минут). Время, когда хост-брокер, {{ ZK }} или {{ kraft-short-name }} не может выполнять свои основные функции, не тарифицируется.

### Использование дискового пространства {#rules-storage}

Оплачивается объем хранилища, выделенный для кластеров.

* Хранилище на локальных SSD-дисках (`local-ssd`) можно заказывать только для кластеров с тремя хостами-брокерами и более:
    * для платформы Intel Cascade Lake — с шагом 100 ГБ;
    * для платформ Intel Ice Lake и AMD Zen 4 — с шагом {{ local-ssd-v3-step }}.
* Хранилище на нереплицируемых SSD-дисках (`network-ssd-nonreplicated`) можно заказывать только для кластеров с тремя хостами-брокерами и более, с шагом 93 ГБ.

Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).

### Пример расчета стоимости кластера {#example}

В приведенном примере цена за месяц использования указывается для справки из расчета 720 часов в месяц.

Стоимость использования кластера со следующими параметрами в течение 30 дней:

* **Хосты-брокеры {{ KF }}**: 3 хоста класса `s3-c2-m8`: Intel Ice Lake, 2 × 100% vCPU, 8 ГБ RAM.
* **Хранилище для хостов-брокеров {{ KF }}**: по 100 ГБ на сетевых HDD-дисках на каждый хост-брокер.
* **Хосты {{ ZK }}** (создаются автоматически): 3 хоста класса `b3-c1-m4`: Intel Ice Lake, 2 × 50% vCPU, 4 ГБ RAM. 
* **Хранилище для хостов {{ ZK }}**: по 10 ГБ на сетевых SSD-дисках на каждый хост.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  Расчет стоимости для хостов-брокеров {{ KF }}:
  
  > 3 × (2&nbsp;×&nbsp;{{ sku|RUB|mdb.cluster.kafka.v3.cpu.c100|string }} + 8&nbsp;×&nbsp;{{ sku|RUB|mdb.cluster.kafka.v3.ram|string }}) = {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.cluster.kafka.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.kafka.v3.ram|number }}) %}
  > 
  > Итого: {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.cluster.kafka.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.kafka.v3.ram|number }}) %} — стоимость часа работы хостов-брокеров {{ KF }}.
  
  Где:
  * 3 — количество хостов-брокеров {{ KF }}.
  * 2 — количество vCPU.
  * {{ sku|RUB|mdb.cluster.kafka.v3.cpu.c100|string }} — стоимость часа использования 100% vCPU.
  * 8 — объем RAM одного хоста (в гигабайтах).
  * {{ sku|RUB|mdb.cluster.kafka.v3.ram|string }} — стоимость часа использования 1 ГБ RAM на 100% vCPU.
  
  Расчет стоимости хранилища для хостов-брокеров {{ KF }}:
  
  > 3 × 100 × {{ sku|RUB|mdb.cluster.network-hdd.kafka|month|string }} = {% calc [currency=RUB] 3 × 100 × {{ sku|RUB|mdb.cluster.network-hdd.kafka|month|number }} %}
  >
  > Итого: {% calc [currency=RUB] 3 × 100 × {{ sku|RUB|mdb.cluster.network-hdd.kafka|month|number }} %} — стоимость хранилища для хостов-брокеров {{ KF }}.
  
  Где:
  * 3 — количество хостов-брокеров {{ KF }}.
  * 100 — объем хранилища на сетевых HDD-дисках (в гигабайтах).
  * {{ sku|RUB|mdb.cluster.network-hdd.kafka|month|string }} — стоимость месяца использования 1 ГБ хранилища на сетевых HDD-дисках.
  
  Расчет стоимости для хостов {{ ZK }}:
  
  > 3 × (2&nbsp;×&nbsp;{{ sku|RUB|mdb.zk.kafka.v3.cpu.c50|string }} + 4&nbsp;×&nbsp;{{ sku|RUB|mdb.zk.kafka.v3.ram|string }}) = {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.zk.kafka.v3.cpu.c50|number }} + 4 × {{ sku|RUB|mdb.zk.kafka.v3.ram|number }}) %}
  >
  > Итого: {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.zk.kafka.v3.cpu.c50|number }} + 4 × {{ sku|RUB|mdb.zk.kafka.v3.ram|number }}) %} — стоимость часа работы хостов {{ ZK }}.
  
  Где:
  * 3 — количество хостов {{ ZK }}.
  * 2 — количество vCPU.
  * {{ sku|RUB|mdb.zk.kafka.v3.cpu.c50|string }} — стоимость часа использования 50% vCPU.
  * 4 — объем RAM одного хоста (в гигабайтах).
  * {{ sku|RUB|mdb.zk.kafka.v3.ram|string }} — стоимость часа использования 1 ГБ RAM на 50% vCPU.
  
  Расчет стоимости хранилища для хостов {{ ZK }}:
  
  > 3 × 10 × {{ sku|RUB|mdb.cluster.network-nvme.kafka|month|string }} = {% calc [currency=RUB] 3 × 10 × {{ sku|RUB|mdb.cluster.network-nvme.kafka|month|number }} %}
  >
  > Итого: {% calc [currency=RUB] 3 × 10 × {{ sku|RUB|mdb.cluster.network-nvme.kafka|month|number }} %} — стоимость хранилища для хостов {{ ZK }}.
  
  Где:
  * 3 — количество хостов {{ ZK }}.
  * 10 — объем хранилища на сетевых SSD-дисках (в гигабайтах).
  * {{ sku|RUB|mdb.cluster.network-nvme.kafka|month|string }} — стоимость месяца использования 1 ГБ хранилища на сетевых SSD-дисках.
  
  Расчет итоговой стоимости:
  
  > 720 × ({% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.cluster.kafka.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.kafka.v3.ram|number }}) %} + {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.zk.kafka.v3.cpu.c50|number }} + 4 × {{ sku|RUB|mdb.zk.kafka.v3.ram|number }}) %}) + {% calc [currency=RUB] 3 × 100 × {{ sku|RUB|mdb.cluster.network-hdd.kafka|month|number }} %} + {% calc [currency=RUB] 3 × 10 × {{ sku|RUB|mdb.cluster.network-nvme.kafka|month|number }} %} = {% calc [currency=RUB] 720 × ((3 × (2 × {{ sku|RUB|mdb.cluster.kafka.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.kafka.v3.ram|number }})) + (3 × (2 × {{ sku|RUB|mdb.zk.kafka.v3.cpu.c50|number }} + 4 × {{ sku|RUB|mdb.zk.kafka.v3.ram|number }}))) + (3 × 100 × {{ sku|RUB|mdb.cluster.network-hdd.kafka|month|number }}) + (3 × 10 × {{ sku|RUB|mdb.cluster.network-nvme.kafka|month|number }}) %}
  >
  > Итого: {% calc [currency=RUB] 720 × ((3 × (2 × {{ sku|RUB|mdb.cluster.kafka.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.kafka.v3.ram|number }})) + (3 × (2 × {{ sku|RUB|mdb.zk.kafka.v3.cpu.c50|number }} + 4 × {{ sku|RUB|mdb.zk.kafka.v3.ram|number }}))) + (3 × 100 × {{ sku|RUB|mdb.cluster.network-hdd.kafka|month|number }}) + (3 × 10 × {{ sku|RUB|mdb.cluster.network-nvme.kafka|month|number }}) %} — стоимость использования кластера в течение 30 дней.
  
  Где:
  * 720 — количество часов в 30 днях.
  * {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.cluster.kafka.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.kafka.v3.ram|number }}) %} — стоимость часа работы хостов-брокеров {{ KF }}.
  * {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.zk.kafka.v3.cpu.c50|number }} + 4 × {{ sku|RUB|mdb.zk.kafka.v3.ram|number }}) %} — стоимость часа работы хостов {{ ZK }}.
  * {% calc [currency=RUB] 3 × 100 × {{ sku|RUB|mdb.cluster.network-hdd.kafka|month|number }} %} — стоимость хранилища для хостов-брокеров {{ KF }}.
  * {% calc [currency=RUB] 3 × 10 × {{ sku|RUB|mdb.cluster.network-nvme.kafka|month|number }} %} — стоимость хранилища для хостов {{ ZK }}.

- Расчет в тенге {#prices-kzt}

  Расчет стоимости для хостов-брокеров {{ KF }}:
  
  > 3 × (2&nbsp;×&nbsp;{{ sku|KZT|mdb.cluster.kafka.v3.cpu.c100|string }} + 8&nbsp;×&nbsp;{{ sku|KZT|mdb.cluster.kafka.v3.ram|string }}) = {% calc [currency=KZT] 3 × (2 × {{ sku|KZT|mdb.cluster.kafka.v3.cpu.c100|number }} + 8 × {{ sku|KZT|mdb.cluster.kafka.v3.ram|number }}) %}
  > 
  > Итого: {% calc [currency=KZT] 3 × (2 × {{ sku|KZT|mdb.cluster.kafka.v3.cpu.c100|number }} + 8 × {{ sku|KZT|mdb.cluster.kafka.v3.ram|number }}) %} — стоимость часа работы хостов-брокеров {{ KF }}.
  
  Где:
  * 3 — количество хостов-брокеров {{ KF }}.
  * 2 — количество vCPU.
  * {{ sku|KZT|mdb.cluster.kafka.v3.cpu.c100|string }} — стоимость часа использования 100% vCPU.
  * 8 — объем RAM одного хоста (в гигабайтах).
  * {{ sku|KZT|mdb.cluster.kafka.v3.ram|string }} — стоимость часа использования 1 ГБ RAM на 100% vCPU.
  
  Расчет стоимости хранилища для хостов-брокеров {{ KF }}:
  
  > 3 × 100 × {{ sku|KZT|mdb.cluster.network-hdd.kafka|month|string }} = {% calc [currency=KZT] 3 × 100 × {{ sku|KZT|mdb.cluster.network-hdd.kafka|month|number }} %}
  >
  > Итого: {% calc [currency=KZT] 3 × 100 × {{ sku|KZT|mdb.cluster.network-hdd.kafka|month|number }} %} — стоимость хранилища для хостов-брокеров {{ KF }}.
  
  Где:
  * 3 — количество хостов-брокеров {{ KF }}.
  * 100 — объем хранилища на сетевых HDD-дисках (в гигабайтах).
  * {{ sku|KZT|mdb.cluster.network-hdd.kafka|month|string }} — стоимость месяца использования 1 ГБ хранилища на сетевых HDD-дисках.
  
  Расчет стоимости для хостов {{ ZK }}:
  
  > 3 × (2&nbsp;×&nbsp;{{ sku|KZT|mdb.zk.kafka.v3.cpu.c50|string }} + 4&nbsp;×&nbsp;{{ sku|KZT|mdb.zk.kafka.v3.ram|string }}) = {% calc [currency=KZT] 3 × (2 × {{ sku|KZT|mdb.zk.kafka.v3.cpu.c50|number }} + 4 × {{ sku|KZT|mdb.zk.kafka.v3.ram|number }}) %}
  >
  > Итого: {% calc [currency=KZT] 3 × (2 × {{ sku|KZT|mdb.zk.kafka.v3.cpu.c50|number }} + 4 × {{ sku|KZT|mdb.zk.kafka.v3.ram|number }}) %} — стоимость часа работы хостов {{ ZK }}.
  
  Где:
  * 3 — количество хостов {{ ZK }}.
  * 2 — количество vCPU.
  * {{ sku|KZT|mdb.zk.kafka.v3.cpu.c50|string }} — стоимость часа использования 50% vCPU.
  * 4 — объем RAM одного хоста (в гигабайтах).
  * {{ sku|KZT|mdb.zk.kafka.v3.ram|string }} — стоимость часа использования 1 ГБ RAM на 50% vCPU.
  
  Расчет стоимости хранилища для хостов {{ ZK }}:
  
  > 3 × 10 × {{ sku|KZT|mdb.cluster.network-nvme.kafka|month|string }} = {% calc [currency=KZT] 3 × 10 × {{ sku|KZT|mdb.cluster.network-nvme.kafka|month|number }} %}
  >
  > Итого: {% calc [currency=KZT] 3 × 10 × {{ sku|KZT|mdb.cluster.network-nvme.kafka|month|number }} %} — стоимость хранилища для хостов {{ ZK }}.
  
  Где:
  * 3 — количество хостов {{ ZK }}.
  * 10 — объем хранилища на сетевых SSD-дисках (в гигабайтах).
  * {{ sku|KZT|mdb.cluster.network-nvme.kafka|month|string }} — стоимость месяца использования 1 ГБ хранилища на сетевых SSD-дисках.
  
  Расчет итоговой стоимости:
  
  > 720 × ({% calc [currency=KZT] 3 × (2 × {{ sku|KZT|mdb.cluster.kafka.v3.cpu.c100|number }} + 8 × {{ sku|KZT|mdb.cluster.kafka.v3.ram|number }}) %} + {% calc [currency=KZT] 3 × (2 × {{ sku|KZT|mdb.zk.kafka.v3.cpu.c50|number }} + 4 × {{ sku|KZT|mdb.zk.kafka.v3.ram|number }}) %}) + {% calc [currency=KZT] 3 × 100 × {{ sku|KZT|mdb.cluster.network-hdd.kafka|month|number }} %} + {% calc [currency=KZT] 3 × 10 × {{ sku|KZT|mdb.cluster.network-nvme.kafka|month|number }} %} = {% calc [currency=KZT] 720 × ((3 × (2 × {{ sku|KZT|mdb.cluster.kafka.v3.cpu.c100|number }} + 8 × {{ sku|KZT|mdb.cluster.kafka.v3.ram|number }})) + (3 × (2 × {{ sku|KZT|mdb.zk.kafka.v3.cpu.c50|number }} + 4 × {{ sku|KZT|mdb.zk.kafka.v3.ram|number }}))) + (3 × 100 × {{ sku|KZT|mdb.cluster.network-hdd.kafka|month|number }}) + (3 × 10 × {{ sku|KZT|mdb.cluster.network-nvme.kafka|month|number }}) %}
  >
  > Итого: {% calc [currency=KZT] 720 × ((3 × (2 × {{ sku|KZT|mdb.cluster.kafka.v3.cpu.c100|number }} + 8 × {{ sku|KZT|mdb.cluster.kafka.v3.ram|number }})) + (3 × (2 × {{ sku|KZT|mdb.zk.kafka.v3.cpu.c50|number }} + 4 × {{ sku|KZT|mdb.zk.kafka.v3.ram|number }}))) + (3 × 100 × {{ sku|KZT|mdb.cluster.network-hdd.kafka|month|number }}) + (3 × 10 × {{ sku|KZT|mdb.cluster.network-nvme.kafka|month|number }}) %} — стоимость использования кластера в течение 30 дней.
  
  Где:
  * 720 — количество часов в 30 днях.
  * {% calc [currency=KZT] 3 × (2 × {{ sku|KZT|mdb.cluster.kafka.v3.cpu.c100|number }} + 8 × {{ sku|KZT|mdb.cluster.kafka.v3.ram|number }}) %} — стоимость часа работы хостов-брокеров {{ KF }}.
  * {% calc [currency=KZT] 3 × (2 × {{ sku|KZT|mdb.zk.kafka.v3.cpu.c50|number }} + 4 × {{ sku|KZT|mdb.zk.kafka.v3.ram|number }}) %} — стоимость часа работы хостов {{ ZK }}.
  * {% calc [currency=KZT] 3 × 100 × {{ sku|KZT|mdb.cluster.network-hdd.kafka|month|number }} %} — стоимость хранилища для хостов-брокеров {{ KF }}.
  * {% calc [currency=KZT] 3 × 10 × {{ sku|KZT|mdb.cluster.network-nvme.kafka|month|number }} %} — стоимость хранилища для хостов {{ ZK }}.

{% endlist %}




## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

Вы можете получить гарантированную скидку за потребление ресурсов сервиса, запланированное на 6 месяцев или 1 год вперед. Чтобы посмотреть ресурсы, для которых можно получить такую скидку:

1. Перейдите в раздел [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}).
1. Нажмите на нужный платежный аккаунт.
1. Выберите раздел ![image](../_assets/console-icons/lock.svg) **{{ ui-key.yacloud_billing.billing.account.switch_offers }}** в меню слева.

Механизм CVoS гарантирует скидку на потребление, но не гарантирует наличие заказанного объема ресурсов.  Подробнее о механизме работы CVoS читайте в [документации сервиса {{ billing-name }}](../billing/concepts/cvos.md).

Сервис {{ mkf-name }} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

По схеме CVoS можно заказать только ресурсы определенного вида: для недоступных видов ресурсов в колонках CVoS в разделе [Цены для региона Россия](#prices) стоят прочерки. Объем хранилища и интернет-трафика заказать таким образом пока невозможно.

{% endnote %}


## Цены для региона Россия {#prices}



{% note info %}

Цены на ресурсы {{ yandex-cloud }} в разных регионах различаются. Подробнее о доступных регионах см. [{#T}](../overview/concepts/region.md).

Валюта, которой можно оплачивать ресурсы, зависит от юридического лица, с которым пользователь заключил договор. Подробнее о регистрации аккаунта см. [{#T}](../billing/quickstart/index.md).

{% endnote %}

Цены за месяц использования формируются из расчета 720 часов в месяц.


{% note info %}

Доступ к платформе **Intel Ice Lake (Compute Optimized)** предоставляется по запросу. Обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.

{% endnote %}


Заказать ресурсы хостов {{ ZK }} с помощью механизма CVoS невозможно.

{% note info %}

Доступ к хранилищу на локальных SSD-дисках при использовании стандартных хостов на платформе **Intel Ice Lake** предоставляется по запросу. Обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.

{% endnote %}


| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |





### Исходящий трафик {#prices-traffic}

При использовании сервиса оплачивается исходящий трафик из {{ yandex-cloud }} в интернет. Передача трафика между сервисами {{ yandex-cloud }} по внутренним адресам, как и входящий трафик из интернета, не тарифицируется.

Каждый месяц не тарифицируются первые 100 ГБ исходящего трафика.

Минимальная единица тарификации — 1 МБ.


| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |