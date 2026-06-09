# Правила тарификации для {{ mgp-name }}

В этом разделе описаны [правила](#rules), по которым тарифицируется использование сервиса {{ mgp-name }}, и представлены [актуальные цены](#prices) на предоставляемые им ресурсы.


{% note tip %}


Чтобы рассчитать стоимость использования сервиса, воспользуйтесь [калькулятором](https://yandex.cloud/ru/prices?state=c55f805e6ef5#calculator) на сайте {{ yandex-cloud }} или ознакомьтесь с тарифами в этом разделе.




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

## Из чего складывается стоимость использования {{ mgp-short-name }} {#rules}

Расчет стоимости использования {{ mgp-name }} учитывает:

* тип диска и размер хранилища;
* вычислительные ресурсы, выделенные хостам кластера, и тип хостов;
* настройки и количество резервных копий;
* объем исходящего трафика из {{ yandex-cloud }} в интернет.

Во всех расчетах 1 ГБ = 2<sup>30</sup> байт, 1 МБ = 2<sup>20</sup> байт.

### Использование хостов кластера {#rules-hosts-uptime}


В зависимости от [типа хоста](../concepts/index.md) стоимость вычисляется по-разному:

* Стандартные хосты

  Стоимость начисляется за каждый час работы хоста в соответствии с выделенными для него вычислительными ресурсами.

* Выделенные хосты

  Стоимость начисляется из двух компонентов: [цены за вычислительные ресурсы {{ compute-full-name }}](../../compute/pricing.md#prices) и наценки {{ mgp-name }} на эти ресурсы.



Поддерживаемые конфигурации ресурсов приведены в разделе [Классы хостов](../concepts/instance-types.md), цены за использование vCPU и RAM — в разделе [Цены](#prices).

Минимальная единица тарификации — минута (например, стоимость 1,5 минут работы хоста равна стоимости 2 минут). Время, когда хост {{ mgp-name }} не может выполнять свои основные функции, не тарифицируется.

### Использование дискового пространства {#rules-storage}

Оплачивается:

* Объем хранилища, выделенный для кластеров.

  
  * Хранилище на локальных SSD-дисках (`local-ssd`) можно заказывать только для кластеров с двумя хостами-мастерами:

    * для платформы Intel Cascade Lake — с шагом 100 ГБ;
    * для платформ Intel Ice Lake и AMD Zen 4 — с шагом {{ local-ssd-v3-step }}.



  * Хранилище на нереплицируемых SSD-дисках (`network-ssd-nonreplicated`) можно заказывать только для кластеров с двумя хостами-мастерами, с шагом 93 ГБ.

  Чтобы сэкономить, вы можете [выгрузить таблицы AO и AOCO](../tutorials/yezzey.md) с дисков кластера {{ mgp-name }} в холодное хранилище {{ objstorage-full-name }}. Данные будут храниться в служебном бакете в сжатом и зашифрованном виде, так хранить данные дешевле. Стоимость хранения рассчитывается по [правилам тарификации {{ objstorage-name }}](../../storage/pricing.md).

* Объем, занимаемый резервными копиями баз данных сверх заданного хранилища для кластера.

  * Хранение резервных копий не тарифицируется, пока сумма размера БД и всех резервных копий остается меньше выбранного объема хранилища.

  * При автоматическом резервном копировании {{ mgp-name }} не создает новую копию, а сохраняет изменения БД по сравнению с предыдущей копией. Поэтому потребление хранилища автоматическими резервными копиями растет только пропорционально объему изменений.

  * Количество хостов кластера не влияет на объем хранилища и, соответственно, на бесплатный объем резервных копий.

Цена указывается за 1 месяц использования и формируется из расчета 720 часов в месяц. Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).

### Пример расчета стоимости кластера {#example}

Стоимость использования кластера со следующими параметрами в течение 30 дней:


* **Стандартные хосты**: 3 хоста класса `s3-c8-m32`: Intel Ice Lake, 8 × 100% vCPU, 32 ГБ RAM.
* **Хранилище для стандартных хостов**: 100 ГБ на сетевых HDD-дисках.
* **Выделенные хосты**: 3 хоста класса `s2.medium`: Intel Cascade Lake, 8 × 100% vCPU, 32 ГБ RAM.
* **Хранилище для выделенных хостов**: 50 ГБ на локальных SSD-дисках.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  Расчет стоимости для стандартных хостов:
  
  > 3 × (8&nbsp;×&nbsp;{{ sku|RUB|mdb.cluster.greenplum.v3.cpu.c100|string }} + 32&nbsp;×&nbsp;{{ sku|RUB|mdb.cluster.greenplum.v3.ram|string }}) = {% calc [currency=RUB] 3 * (8 * {{ sku|RUB|mdb.cluster.greenplum.v3.cpu.c100|number }} + 32 * {{ sku|RUB|mdb.cluster.greenplum.v3.ram|number }}) %}
  >
  > Итого: {% calc [currency=RUB] 3 * (8 * {{ sku|RUB|mdb.cluster.greenplum.v3.cpu.c100|number }} + 32 * {{ sku|RUB|mdb.cluster.greenplum.v3.ram|number }}) %} — стоимость часа работы стандартных хостов.
  
    Где:
  
    * 3 — количество стандартных хостов.
    * 8 — количество vCPU.
    * {{ sku|RUB|mdb.cluster.greenplum.v3.cpu.c100|string }} — стоимость часа использования 100% vCPU.
    * 32 — объем RAM одного стандартного хоста (в гигабайтах).
    * {{ sku|RUB|mdb.cluster.greenplum.v3.ram|string }} — стоимость часа использования 1 ГБ RAM на 100% vCPU.
  
  Расчет стоимости для выделенных хостов:
  
  > 3 × (8&nbsp;×&nbsp;{{ sku|RUB|mdb.cluster.greenplum.v2.cpu.c100.dedicated|string }} + 32&nbsp;×&nbsp;{{ sku|RUB|mdb.cluster.greenplum.v2.ram.dedicated|string }}) = {% calc [currency=RUB] 3 * (8 * {{ sku|RUB|mdb.cluster.greenplum.v2.cpu.c100.dedicated|number }} + 32 * {{ sku|RUB|mdb.cluster.greenplum.v2.ram.dedicated|number }}) %}
  >
  > Итого: {% calc [currency=RUB] 3 * (8 * {{ sku|RUB|mdb.cluster.greenplum.v2.cpu.c100.dedicated|number }} + 32 * {{ sku|RUB|mdb.cluster.greenplum.v2.ram.dedicated|number }}) %} — стоимость часа работы выделенных хостов.
  
    Где:
  
    * 3 — количество выделенных хостов.
    * 8 — количество vCPU.
    * {{ sku|RUB|mdb.cluster.greenplum.v2.cpu.c100.dedicated|string }} — стоимость часа использования 100% vCPU.
    * 32 — объем RAM одного выделенного хоста (в гигабайтах).
    * {{ sku|RUB|mdb.cluster.greenplum.v2.ram.dedicated|string }} — стоимость часа использования 1 ГБ RAM на 100% vCPU.
  
  Расчет стоимости хранилища и итоговой стоимости:
  
  > (720 × {% calc [currency=RUB] 3 * (8 * {{ sku|RUB|mdb.cluster.greenplum.v3.cpu.c100|number }} + 32 * {{ sku|RUB|mdb.cluster.greenplum.v3.ram|number }}) %} + 3 × (100 × {{ sku|RUB|mdb.cluster.network-hdd.greenplum|month|string }})) + (720 × {% calc [currency=RUB] 3 * (8 * {{ sku|RUB|mdb.cluster.greenplum.v2.cpu.c100.dedicated|number }} + 32 * {{ sku|RUB|mdb.cluster.greenplum.v2.ram.dedicated|number }}) %} + 3 × (50 × {{ sku|RUB|mdb.cluster.local-nvme.greenplum|month|string }})) = {% calc [currency=RUB] (720 * (3 * (8 * {{ sku|RUB|mdb.cluster.greenplum.v3.cpu.c100|number }} + 32 * {{ sku|RUB|mdb.cluster.greenplum.v3.ram|number }})) + 3 * 100 * {{ sku|RUB|mdb.cluster.network-hdd.greenplum|month|number }}) + (720 * (3 * (8 * {{ sku|RUB|mdb.cluster.greenplum.v2.cpu.c100.dedicated|number }} + 32 * {{ sku|RUB|mdb.cluster.greenplum.v2.ram.dedicated|number }})) + 3 * 50 * {{ sku|RUB|mdb.cluster.local-nvme.greenplum|month|number }}) %}
  >
  > Итого: {% calc [currency=RUB] (720 * (3 * (8 * {{ sku|RUB|mdb.cluster.greenplum.v3.cpu.c100|number }} + 32 * {{ sku|RUB|mdb.cluster.greenplum.v3.ram|number }})) + 3 * 100 * {{ sku|RUB|mdb.cluster.network-hdd.greenplum|month|number }}) + (720 * (3 * (8 * {{ sku|RUB|mdb.cluster.greenplum.v2.cpu.c100.dedicated|number }} + 32 * {{ sku|RUB|mdb.cluster.greenplum.v2.ram.dedicated|number }})) + 3 * 50 * {{ sku|RUB|mdb.cluster.local-nvme.greenplum|month|number }}) %} — стоимость использования кластера в течение 30 дней.
  
    Где:
  
    * 720 — количество часов в 30 днях.
    * {% calc [currency=RUB] 3 * (8 * {{ sku|RUB|mdb.cluster.greenplum.v3.cpu.c100|number }} + 32 * {{ sku|RUB|mdb.cluster.greenplum.v3.ram|number }}) %} — стоимость часа работы стандартных хостов.
    * 3 — количество хостов.
    * 100 — объем хранилища на сетевых HDD-дисках (в гигабайтах) для стандартных хостов.
    * {{ sku|RUB|mdb.cluster.network-hdd.greenplum|month|string }} — стоимость месяца использования 1 ГБ хранилища на сетевых HDD-дисках.
    * {% calc [currency=RUB] 3 * (8 * {{ sku|RUB|mdb.cluster.greenplum.v2.cpu.c100.dedicated|number }} + 32 * {{ sku|RUB|mdb.cluster.greenplum.v2.ram.dedicated|number }}) %} — стоимость часа работы выделенных хостов.
    * 50 — объем хранилища на локальных SSD-дисках (в гигабайтах) для выделенных хостов.
    * {{ sku|RUB|mdb.cluster.local-nvme.greenplum|month|string }} — стоимость месяца использования 1 ГБ хранилища на локальных SSD-дисках.

- Расчет в тенге {#prices-kzt}

  Расчет стоимости для стандартных хостов:
  
  > 3 × (8&nbsp;×&nbsp;{{ sku|KZT|mdb.cluster.greenplum.v3.cpu.c100|string }} + 32&nbsp;×&nbsp;{{ sku|KZT|mdb.cluster.greenplum.v3.ram|string }}) = {% calc [currency=KZT] 3 * (8 * {{ sku|KZT|mdb.cluster.greenplum.v3.cpu.c100|number }} + 32 * {{ sku|KZT|mdb.cluster.greenplum.v3.ram|number }}) %}
  >
  > Итого: {% calc [currency=KZT] 3 * (8 * {{ sku|KZT|mdb.cluster.greenplum.v3.cpu.c100|number }} + 32 * {{ sku|KZT|mdb.cluster.greenplum.v3.ram|number }}) %} — стоимость часа работы стандартных хостов.
  
    Где:
    
    * 3 — количество стандартных хостов.
    * 8 — количество vCPU.
    * {{ sku|KZT|mdb.cluster.greenplum.v3.cpu.c100|string }} — стоимость часа использования 100% vCPU.
    * 32 — объем RAM одного стандартного хоста (в гигабайтах).
    * {{ sku|KZT|mdb.cluster.greenplum.v3.ram|string }} — стоимость часа использования 1 ГБ RAM на 100% vCPU.
  
  Расчет стоимости для выделенных хостов:
  
  > 3 × (8&nbsp;×&nbsp;{{ sku|KZT|mdb.cluster.greenplum.v2.cpu.c100.dedicated|string }} + 32&nbsp;×&nbsp;{{ sku|KZT|mdb.cluster.greenplum.v2.ram.dedicated|string }}) = {% calc [currency=KZT] 3 * (8 * {{ sku|KZT|mdb.cluster.greenplum.v2.cpu.c100.dedicated|number }} + 32 * {{ sku|KZT|mdb.cluster.greenplum.v2.ram.dedicated|number }}) %}
  >
  > Итого: {% calc [currency=KZT] 3 * (8 * {{ sku|KZT|mdb.cluster.greenplum.v2.cpu.c100.dedicated|number }} + 32 * {{ sku|KZT|mdb.cluster.greenplum.v2.ram.dedicated|number }}) %} — стоимость часа работы выделенных хостов.
  
    Где:
    
    * 3 — количество выделенных хостов.
    * 8 — количество vCPU.
    * {{ sku|KZT|mdb.cluster.greenplum.v2.cpu.c100.dedicated|string }} — стоимость часа использования 100% vCPU.
    * 32 — объем RAM одного выделенного хоста (в гигабайтах).
    * {{ sku|KZT|mdb.cluster.greenplum.v2.ram.dedicated|string }} — стоимость часа использования 1 ГБ RAM на 100% vCPU.
  
  Расчет стоимости хранилища и итоговой стоимости:
  
  > (720 × {% calc [currency=KZT] 3 * (8 * {{ sku|KZT|mdb.cluster.greenplum.v3.cpu.c100|number }} + 32 * {{ sku|KZT|mdb.cluster.greenplum.v3.ram|number }}) %} + 3 × (100 × {{ sku|KZT|mdb.cluster.network-hdd.greenplum|month|string }})) + (720 × {% calc [currency=KZT] 3 * (8 * {{ sku|KZT|mdb.cluster.greenplum.v2.cpu.c100.dedicated|number }} + 32 * {{ sku|KZT|mdb.cluster.greenplum.v2.ram.dedicated|number }}) %} + 3 × (50 × {{ sku|KZT|mdb.cluster.local-nvme.greenplum|month|string }})) = {% calc [currency=KZT] (720 * (3 * (8 * {{ sku|KZT|mdb.cluster.greenplum.v3.cpu.c100|number }} + 32 * {{ sku|KZT|mdb.cluster.greenplum.v3.ram|number }})) + 3 * 100 * {{ sku|KZT|mdb.cluster.network-hdd.greenplum|month|number }}) + (720 * (3 * (8 * {{ sku|KZT|mdb.cluster.greenplum.v2.cpu.c100.dedicated|number }} + 32 * {{ sku|KZT|mdb.cluster.greenplum.v2.ram.dedicated|number }})) + 3 * 50 * {{ sku|KZT|mdb.cluster.local-nvme.greenplum|month|number }}) %}
  >
  > Итого: {% calc [currency=KZT] (720 * (3 * (8 * {{ sku|KZT|mdb.cluster.greenplum.v3.cpu.c100|number }} + 32 * {{ sku|KZT|mdb.cluster.greenplum.v3.ram|number }})) + 3 * 100 * {{ sku|KZT|mdb.cluster.network-hdd.greenplum|month|number }}) + (720 * (3 * (8 * {{ sku|KZT|mdb.cluster.greenplum.v2.cpu.c100.dedicated|number }} + 32 * {{ sku|KZT|mdb.cluster.greenplum.v2.ram.dedicated|number }})) + 3 * 50 * {{ sku|KZT|mdb.cluster.local-nvme.greenplum|month|number }}) %} — стоимость использования кластера в течение 30 дней.
  
    Где:
    
    * 720 — количество часов в 30 днях.
    * {% calc [currency=KZT] 3 * (8 * {{ sku|KZT|mdb.cluster.greenplum.v3.cpu.c100|number }} + 32 * {{ sku|KZT|mdb.cluster.greenplum.v3.ram|number }}) %} — стоимость часа работы стандартных хостов.
    * 3 — количество хостов.
    * 100 — объем хранилища на сетевых HDD-дисках (в гигабайтах) для стандартных хостов.
    * {{ sku|KZT|mdb.cluster.network-hdd.greenplum|month|string }} — стоимость месяца использования 1 ГБ хранилища на сетевых HDD-дисках.
    * {% calc [currency=KZT] 3 * (8 * {{ sku|KZT|mdb.cluster.greenplum.v2.cpu.c100.dedicated|number }} + 32 * {{ sku|KZT|mdb.cluster.greenplum.v2.ram.dedicated|number }}) %} — стоимость часа работы выделенных хостов.
    * 50 — объем хранилища на локальных SSD-дисках (в гигабайтах) для выделенных хостов.
    * {{ sku|KZT|mdb.cluster.local-nvme.greenplum|month|string }} — стоимость месяца использования 1 ГБ хранилища на локальных SSD-дисках.

{% endlist %}





## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

Вы можете получить гарантированную скидку за потребление ресурсов сервиса, запланированное на 6 месяцев или 1 год вперед. Чтобы посмотреть ресурсы, для которых можно получить такую скидку:

1. Перейдите в раздел [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}).
1. Нажмите на нужный платежный аккаунт.
1. Выберите раздел ![image](../../_assets/console-icons/lock.svg) **{{ ui-key.yacloud_billing.billing.account.switch_offers }}** в меню слева.

Механизм CVoS гарантирует скидку на потребление, но не гарантирует наличие заказанного объема ресурсов.  Подробнее о механизме работы CVoS читайте в [документации сервиса {{ billing-name }}](../../billing/concepts/cvos.md).

Сервис {{ mgp-name }} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

По схеме CVoS можно заказать только ресурсы определенного вида: для недоступных видов ресурсов в колонках CVoS в разделе [Цены](#prices) стоят прочерки. Размер хранилища и интернет-трафика, а также вычислительные ресурсы выделенных хостов заказать таким образом пока невозможно.

{% endnote %}


## Цены для региона Россия {#prices}



{% note info %}

Цены на ресурсы {{ yandex-cloud }} в разных регионах различаются. Подробнее о доступных регионах см. [{#T}](../../overview/concepts/region.md).

Валюта, которой можно оплачивать ресурсы, зависит от юридического лица, с которым пользователь заключил договор. Подробнее о регистрации аккаунта см. [{#T}](../../billing/quickstart/index.md).

{% endnote %}


Цены на хосты [вычисляются по-разному](#rules-hosts-uptime) в зависимости от выбранного типа хостов.

От типа хостов также зависит цена на хранилище на локальных SSD-дисках (`local-ssd`).


Цены за месяц использования формируются из расчета 720 часов в месяц.


{% note info %}

Доступ к платформе **Intel Ice Lake (Compute Optimized)** предоставляется по запросу. Обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.

{% endnote %}

Стоимость стандартных хостов вычисляется по-разному в зависимости от [конфигурации хостов](../concepts/instance-types.md):

* Для хостов i2 и i3 (`io-optimized`) стоимость складывается из цены за вычислительные ресурсы хостов {{ mgp-name }} и [цены за использование программно ускоренной сети](../../compute/pricing.md).
* Для хостов других конфигураций оплачиваются только их вычислительные ресурсы.

Стоимость выделенных хостов начисляется из двух компонентов: [цены за вычислительные ресурсы {{ compute-full-name }}](../../compute/pricing.md) и наценки {{ mgp-name }} на эти ресурсы.



| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |





### Исходящий трафик {#prices-traffic}

При использовании сервиса оплачивается исходящий трафик из {{ yandex-cloud }} в интернет. Передача трафика между сервисами {{ yandex-cloud }} по внутренним адресам, как и входящий трафик из интернета, не тарифицируется.

Каждый месяц не тарифицируются первые 100 ГБ исходящего трафика.

Минимальная единица тарификации — 1 МБ.


| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |