# Правила тарификации для {{ myt-full-name }}



В этом разделе описаны [правила](#rules), по которым тарифицируется использование сервиса {{ myt-name }}, и представлены [актуальные цены](#prices) на предоставляемые им ресурсы. За потребление других ресурсов {{ yandex-cloud }}, которые вы используете в процессе работы с сервисом, взимается плата в соответствии с их тарифами.


{% note tip %}

Чтобы рассчитать стоимость использования сервиса, воспользуйтесь [калькулятором](https://yandex.cloud/ru/prices?state=9845e5c24dd9#calculator) на сайте {{ yandex-cloud }} или ознакомьтесь с тарифами в этом разделе.

{% endnote %}


Цены на продукты сервиса также доступны в [Прайс-листе](https://yandex.cloud/ru/price-list).


Все цены в рублях и тенге указаны с НДС, все цены в долларах — без НДС.

## Статус кластера {#running-stopped}

В зависимости от статуса кластера тарифы применяются различным образом:

* Для запущенного кластера (`Running`) тарифицируются как вычислительные ресурсы, так и размер хранилища.
* Для остановленного кластера (`Stopped`) тарифицируется только размер хранилища.

## Из чего складывается стоимость использования {{ myt-name }} {#rules}

При работе с {{ myt-name }} вы оплачиваете:

* Тип диска и размер хранилища.
* Вычислительные ресурсы, выделенные компонентам кластера:
   * количество ядер (vCPU);
   * объем памяти (RAM).
* Объем исходящего трафика из {{ yandex-cloud }} в интернет.

Во всех расчетах 1 ГБ = 2<sup>30</sup> байт, 1 МБ = 2<sup>20</sup> байт.

### Использование компонентов кластера {#rules-components-uptime}

Стоимость начисляется за каждый час работы компонента в соответствии с выделенными для него вычислительными ресурсами. Поддерживаемые конфигурации компонентов приведены в разделе [Конфигурации компонентов кластера](concepts/component-types.md), цены за использование vCPU и RAM — в разделе [Цены](#prices).

Вы можете выбрать конфигурацию для exec-нод и tablet-нод в соответствии с ожидаемой нагрузкой. Количество служебных компонентов (master-ноды, storage-ноды, system-ноды и proxy-ноды) зависит от конфигурации кластера и добавляется автоматически. Ниже приведен минимальный набор служебных компонентов, который необходим для функционирования кластера {{ ytsaurus-name }}:
* **Master-нода**. 3 экземпляра конфигурации: 4 vCPU, 12 ГБ RAM.
* **System-нода**. 2 экземпляра конфигурации: 24 vCPU, 64 ГБ RAM.
* **Proxy-нода**. 2 экземпляра: 1 HTTP-прокси и 1 RPC-прокси.
* Служебная **tablet-нода**. 2 экземпляра конфигурации `c8-m16`: 8 vCPU, 16 ГБ RAM. Компонент используется для системных динамических таблиц.
* **Storage-нода**. Количество экземпляров зависит от конфигурации хранилища и добавляется по правилу ниже.

   **Правило расчета количества storage-нод в кластере**

   1. Для каждого диска с типом `HDD` добавляется одна storage-нода с конфигурацией: 4 vCPU, 8 ГБ RAM.
   1. Для каждого диска с типом `Нереплицируемый SSD` или `SSD` добавляется одна storage-нода с конфигурацией: 8 vCPU, 8 ГБ RAM. 

   Дополнительно добавляются три служебные storage-ноды с конфигурацией: 8 vCPU, 8 ГБ RAM, которые используются для хранения чанков и журналов системных динамических таблиц.

Минимальная единица тарификации — минута (например, стоимость 1,5 минут работы компонента равна стоимости 2 минут).

### Использование дискового пространства {#rules-storage}

Оплачивается:
* Размер хранилища для exec-ноды, где выполняются различные задачи (`jobs`). 
* Размер хранилища для служебных storage-нод, где хранятся чанки и журналы системных динамических таблиц. Задается автоматически со следующими параметрами: три диска с типом `Нереплицируемый SSD`, размер каждого диска — 93 ГБ.
* Размер хранилища для storage-ноды. В этом хранилище находятся данные всех объектов {{ ytsaurus-name }}, созданных в процессе работы. Хранилище может состоять из одного или двух дисков. Количество и размер определяются по правилу ниже.

   **Правило расчета количества дисков в storage-нодах**

   1. Для каждой storage-ноды создается основной диск выбранного типа и размера для хранения чанков.
   1. Для каждой storage-ноды, добавленной на основании диска с типом `Нереплицируемый SSD` или `SSD`, создается служебный диск с таким же типом для хранения журналов и снапшотов динамических таблиц.
   1. Размер служебного диска зависит от конфигурации хранилища и вычисляется по формуле:
      * Storage-нода добавлена для диска с типом `SSD` и размером диска `N`. Размер служебного диска: `0,1 × N` ГБ, округляется вверх до целого числа.
      * Storage-нода добавлена для диска с типом `Нереплицируемый SSD` и размером диска `N`. Размер служебного диска: `0,1 × N` ГБ, округляется вверх с шагом 93 ГБ.


Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).

### Пример расчета стоимости кластера {#example}

Стоимость использования кластера со следующими параметрами в течение 30 дней:

**Настраиваемые компоненты:**
* **Exec-нода**. 1 экземпляр конфигурации `c8-m32`: 8 vCPU, 32 ГБ RAM.
* **Tablet-нода**. 3 экземпляра конфигурации `c8-m16`: 8 vCPU, 16 ГБ RAM.
* **Хранилище**. Хранилища с конфигурациями:
   * хранилище с типом `HDD`, количество дисков — 3, размер каждого диска — 2048 ГБ;
   * хранилище с типом `Нереплицируемый SSD`, количество дисков — 3, размер каждого диска — 465 ГБ.

**Служебные компоненты:**
* **Master-нода**. 3 экземпляра конфигурации: 4 vCPU, 12 ГБ RAM.
* **System-нода**. 2 экземпляра конфигурации: 24 vCPU, 64 ГБ RAM.
* **Proxy-нода**. 2 экземпляра (1 HTTP-прокси и 1 RPC-прокси) конфигурации: 4 vCPU, 8 ГБ RAM.
* Служебная **tablet-нода**. 2 экземпляра конфигурации `c8-m16`: 8 vCPU, 16 ГБ RAM.
* **Хранилище**. Хранилища с конфигурациями:
   * хранилище для exec-ноды, тип — `Нереплицируемый SSD`, количество дисков — 1, размер диска — 93 ГБ;
   * хранилище для служебных storage-нод, тип — `Нереплицируемый SSD`, количество дисков — 3, размер каждого диска — 93 ГБ;
   * хранилище для storage-нод, тип — `Нереплицируемый SSD`, количество служебных дисков — 6, размер каждого диска — 93 ГБ.

      {% cut "Детали по служебным дискам для storage-нод" %}

      1. 3 storage-ноды добавлены для трех дисков с типом `Нереплицируемый SSD`, размер каждого диска — 93 ГБ. Создаются 3 служебных диска с типом `Нереплицируемый SSD`, размер каждого диска — 93 ГБ.
      1. 3 storage-ноды добавлены для трех дисков с типом `Нереплицируемый SSD`, размер каждого диска — 465 ГБ. Создаются 3 служебных диска с типом `Нереплицируемый SSD`, размер каждого диска — 93 ГБ.
   
      {% endcut %}

* **Storage-нода**. 6 storage-нод с конфигурацией: 8 vCPU, 8 ГБ RAM; 3 storage-ноды с конфигурацией: 4 vCPU, 8 ГБ RAM.

   {% cut "Детали по storage-нодам" %}
   
   1. Для хранилища с типом `Нереплицируемый SSD` и тремя дисками, размер каждого диска — 93 ГБ, используются 3 служебные storage-ноды с конфигурацией: 8 vCPU, 8 ГБ RAM.
   1. Для хранилища с типом `HDD` и тремя дисками, размер каждого диска — 2048 ГБ, добавляется 3 storage-ноды с конфигурацией: 4 vCPU, 8 ГБ RAM. 
   1. Для хранилища с типом `Нереплицируемый SSD` и тремя дисками, размер каждого диска — 465 ГБ, добавляется 3 storage-ноды с конфигурацией: 8 vCPU, 8 ГБ RAM.
   
   {% endcut %}


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  #### Настраиваемые компоненты
  
  Расчет стоимости для exec-ноды:
  
  > 8 × {% calc [currency=RUB] {{ sku|RUB|yt.compute-nodes.cpu.v3|number }} %} + 32 × {% calc [currency=RUB] {{ sku|RUB|yt.compute-nodes.ram.v3|number }} %} = {% calc [currency=RUB] 8 × {{ sku|RUB|yt.compute-nodes.cpu.v3|number }} + 32 × {{ sku|RUB|yt.compute-nodes.ram.v3|number }} %}
  >
  > Итого: {% calc [currency=RUB] 8 × {{ sku|RUB|yt.compute-nodes.cpu.v3|number }} + 32 × {{ sku|RUB|yt.compute-nodes.ram.v3|number }} %} — стоимость часа работы exec-ноды.
  
  Где:
  * 8 — количество vCPU одной exec-ноды.
  * {% calc [currency=RUB] {{ sku|RUB|yt.compute-nodes.cpu.v3|number }} %} — стоимость часа использования 1 vCPU.
  * 32 — объем RAM одной exec-ноды (в гигабайтах).
  * {% calc [currency=RUB] {{ sku|RUB|yt.compute-nodes.ram.v3|number }} %} — стоимость часа использования 1 ГБ RAM.
  
  Расчет стоимости для tablet-ноды:
  
  > 3 × (8 × {% calc [currency=RUB] {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} %} + 16 × {% calc [currency=RUB] {{ sku|RUB|yt.tablet-nodes.ram.v3|number }} %}) = {% calc [currency=RUB] 3 × (8 × {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|RUB|yt.tablet-nodes.ram.v3|number }}) %}
  >
  > Итого: {% calc [currency=RUB] 3 × (8 × {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|RUB|yt.tablet-nodes.ram.v3|number }}) %} — стоимость часа работы tablet-нод.
  
  Где:
  * 3 — количество tablet-нод.
  * 8 — количество vCPU одной tablet-ноды.
  * {% calc [currency=RUB] {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} %} — стоимость часа использования 1 vCPU.
  * 16 — объем RAM одной tablet-ноды (в гигабайтах).
  * {% calc [currency=RUB] {{ sku|RUB|yt.tablet-nodes.ram.v3|number }} %} — стоимость часа использования 1 ГБ RAM.
  
  Расчет стоимости хранилищ для кластера:
  
  > 3 × 2048 × {% calc [currency=RUB] {{ sku|RUB|yt.storage.hdd.v1|month|number }} %} + 3 × 465 × {% calc [currency=RUB] {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} = {% calc [currency=RUB] 3 × 2048 × {{ sku|RUB|yt.storage.hdd.v1|month|number }} + 3 × 465 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %}
  >
  > Итого: {% calc [currency=RUB] 3 × 2048 × {{ sku|RUB|yt.storage.hdd.v1|month|number }} + 3 × 465 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования хранилищ на нереплицируемых SSD-дисках и сетевых HDD-дисках.
  
  Где:
  * 3 — количество дисков с типом `HDD`.
  * 2048 — размер одного HDD-диска (в гигабайтах).
  * {% calc [currency=RUB] {{ sku|RUB|yt.storage.hdd.v1|month|number }} %} — стоимость месяца использования 1 ГБ хранилища на сетевых HDD-дисках.
  * 3 — количество дисков с типом `Нереплицируемый SSD`.
  * 465 — размер одного нереплицируемого SSD-диска (в гигабайтах).
  * {% calc [currency=RUB] {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования 1 ГБ хранилища на нереплицируемых SSD-дисках.
  
  #### Служебные компоненты
  
  Расчет стоимости для master-ноды:
  
  > 3 × (4 × {% calc [currency=RUB] {{ sku|RUB|yt.master-nodes.cpu.v3|number }} %} + 12 × {% calc [currency=RUB] {{ sku|RUB|yt.master-nodes.ram.v3|number }} %}) = {% calc [currency=RUB] 3 × (4 × {{ sku|RUB|yt.master-nodes.cpu.v3|number }} + 12 × {{ sku|RUB|yt.master-nodes.ram.v3|number }}) %}
  >
  > Итого: {% calc [currency=RUB] 3 × (4 × {{ sku|RUB|yt.master-nodes.cpu.v3|number }} + 12 × {{ sku|RUB|yt.master-nodes.ram.v3|number }}) %} — стоимость часа работы master-нод.
  
  Где:
  * 3 — количество master-нод.
  * 4 — количество vCPU одной master-ноды.
  * {% calc [currency=RUB] {{ sku|RUB|yt.master-nodes.cpu.v3|number }} %} — стоимость часа использования 1 vCPU.
  * 12 — объем RAM одной master-ноды (в гигабайтах).
  * {% calc [currency=RUB] {{ sku|RUB|yt.master-nodes.ram.v3|number }} %} — стоимость часа использования 1 ГБ RAM.
  
  Расчет стоимости для system-ноды:
  
  > 2 × (24 × {% calc [currency=RUB] {{ sku|RUB|yt.system-nodes.cpu.v3|number }} %} + 64 × {% calc [currency=RUB] {{ sku|RUB|yt.system-nodes.ram.v3|number }} %}) = {% calc [currency=RUB] 2 × (24 × {{ sku|RUB|yt.system-nodes.cpu.v3|number }} + 64 × {{ sku|RUB|yt.system-nodes.ram.v3|number }}) %}
  >
  > Итого: {% calc [currency=RUB] 2 × (24 × {{ sku|RUB|yt.system-nodes.cpu.v3|number }} + 64 × {{ sku|RUB|yt.system-nodes.ram.v3|number }}) %} — стоимость часа работы system-нод.
  
  Где:
  * 2 — количество system-нод.
  * 24 — количество vCPU одной system-ноды.
  * {% calc [currency=RUB] {{ sku|RUB|yt.system-nodes.cpu.v3|number }} %} — стоимость часа использования 1 vCPU.
  * 64 — объем RAM одной system-ноды (в гигабайтах).
  * {% calc [currency=RUB] {{ sku|RUB|yt.system-nodes.ram.v3|number }} %} — стоимость часа использования 1 ГБ RAM.
  
  Расчет стоимости для proxy-ноды:
  
  > 2 × (4 × {% calc [currency=RUB] {{ sku|RUB|yt.proxy-nodes.cpu.v3|number }} %} + 8 × {% calc [currency=RUB] {{ sku|RUB|yt.proxy-nodes.ram.v3|number }} %}) = {% calc [currency=RUB] 2 × (4 × {{ sku|RUB|yt.proxy-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.proxy-nodes.ram.v3|number }}) %}
  >
  > Итого: {% calc [currency=RUB] 2 × (4 × {{ sku|RUB|yt.proxy-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.proxy-nodes.ram.v3|number }}) %} — стоимость часа работы proxy-нод.
  
  Где:
  * 2 — количество proxy-нод.
  * 4 — количество vCPU одной proxy-ноды.
  * {% calc [currency=RUB] {{ sku|RUB|yt.proxy-nodes.cpu.v3|number }} %} — стоимость часа использования 1 vCPU.
  * 8 — объем RAM одной proxy-ноды (в гигабайтах).
  * {% calc [currency=RUB] {{ sku|RUB|yt.proxy-nodes.ram.v3|number }} %} — стоимость часа использования 1 ГБ RAM.
  
  Расчет стоимости для служебной tablet-ноды:
  
  > 2 × (8 × {% calc [currency=RUB] {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} %} + 16 × {% calc [currency=RUB] {{ sku|RUB|yt.tablet-nodes.ram.v3|number }} %}) = {% calc [currency=RUB] 2 × (8 × {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|RUB|yt.tablet-nodes.ram.v3|number }}) %}
  >
  > Итого: {% calc [currency=RUB] 2 × (8 × {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|RUB|yt.tablet-nodes.ram.v3|number }}) %} — стоимость часа работы служебных tablet-нод.
  
  Где:
  * 2 — количество tablet-нод.
  * 8 — количество vCPU одной tablet-ноды.
  * {% calc [currency=RUB] {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} %} — стоимость часа использования 1 vCPU.
  * 16 — объем RAM одной tablet-ноды (в гигабайтах).
  * {% calc [currency=RUB] {{ sku|RUB|yt.tablet-nodes.ram.v3|number }} %} — стоимость часа использования 1 ГБ RAM.
  
  Расчет стоимости хранилища для exec-ноды:
  
  > 93 × 1 × {% calc [currency=RUB] {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} = {% calc [currency=RUB] 93 × 1 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %}
  >
  > Итого: {% calc [currency=RUB] 93 × 1 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования хранилища на нереплицируемых SSD-дисках для exec-ноды.
  
  Где:
  * 93 — размер хранилища на нереплицируемых SSD-дисках (в гигабайтах).
  * 1 — количество нереплицируемых SSD-дисков.
  * {% calc [currency=RUB] {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования 1 ГБ хранилища на нереплицируемых SSD-дисках.
  
  Расчет стоимости хранилища для служебных storage-нод:
  
  > 3 × 93 × {% calc [currency=RUB] {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} = {% calc [currency=RUB] 3 × 93 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %}
  >
  > Итого: {% calc [currency=RUB] 3 × 93 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования хранилища на нереплицируемых SSD-дисках для служебных storage-нод.
  
  Где:
  * 3 — количество дисков.
  * 93 — размер одного нереплицируемого SSD-диска (в гигабайтах).
  * {% calc [currency=RUB] {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования 1 ГБ хранилища на нереплицируемых SSD-дисках.
  
  Расчет стоимости для storage-ноды:
  
  > 6 × (8 × {% calc [currency=RUB] {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} %} + 8 × {% calc [currency=RUB] {{ sku|RUB|yt.storage-nodes.ram.v3|number }} %}) + 3 × (4 × {% calc [currency=RUB] {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} %} + 8 × {% calc [currency=RUB] {{ sku|RUB|yt.storage-nodes.ram.v3|number }} %}) = {% calc [currency=RUB] 6 × (8 × {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.storage-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.storage-nodes.ram.v3|number }}) %}
  >
  > Итого: {% calc [currency=RUB] 6 × (8 × {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.storage-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.storage-nodes.ram.v3|number }}) %} — стоимость часа работы storage-нод.
  
  Где:
  * 6 — количество storage-нод для `SSD` / `Нереплицируемый SSD`.
  * 3 — количество storage-нод для `HDD`.
  * 8 — количество vCPU одной storage-ноды для `SSD` / `Нереплицируемый SSD`.
  * 4 — количество vCPU одной storage-ноды для `HDD`.
  * {% calc [currency=RUB] {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} %} — стоимость часа использования 1 vCPU.
  * 8 — объем RAM одной storage-ноды для `SSD` / `Нереплицируемый SSD` / `HDD` (в гигабайтах).
  * {% calc [currency=RUB] {{ sku|RUB|yt.storage-nodes.ram.v3|number }} %} — стоимость часа использования 1 ГБ RAM.
  
  Расчет стоимости хранилища со служебными дисками:
  
  > 93 × 6 × {% calc [currency=RUB] {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} = {% calc [currency=RUB] 93 × 6 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %}
  >
  > Итого: {% calc [currency=RUB] 93 × 6 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования хранилища на нереплицируемых SSD-дисках.
  
  Где:
  * 6 — количество служебных дисков.
  * 93 — размер одного нереплицируемого SSD-диска (в гигабайтах).
  * {% calc [currency=RUB] {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования 1 ГБ хранилища на нереплицируемых SSD-дисках.
  
  #### Расчет итоговой стоимости
  
  > 720 × ({% calc [currency=RUB] 8 × {{ sku|RUB|yt.compute-nodes.cpu.v3|number }} + 32 × {{ sku|RUB|yt.compute-nodes.ram.v3|number }} %} + {% calc [currency=RUB] 3 × (8 × {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|RUB|yt.tablet-nodes.ram.v3|number }}) %} + {% calc [currency=RUB] 3 × (4 × {{ sku|RUB|yt.master-nodes.cpu.v3|number }} + 12 × {{ sku|RUB|yt.master-nodes.ram.v3|number }}) %} + {% calc [currency=RUB] 2 × (24 × {{ sku|RUB|yt.system-nodes.cpu.v3|number }} + 64 × {{ sku|RUB|yt.system-nodes.ram.v3|number }}) %} + {% calc [currency=RUB] 2 × (4 × {{ sku|RUB|yt.proxy-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.proxy-nodes.ram.v3|number }}) %} + {% calc [currency=RUB] 2 × (8 × {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|RUB|yt.tablet-nodes.ram.v3|number }}) %} + {% calc [currency=RUB] 6 × (8 × {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.storage-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.storage-nodes.ram.v3|number }}) %}) + {% calc [currency=RUB] 3 × 2048 × {{ sku|RUB|yt.storage.hdd.v1|month|number }} + 3 × 465 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} + {% calc [currency=RUB] 93 × 1 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} + {% calc [currency=RUB] 3 × 93 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} + {% calc [currency=RUB] 93 × 6 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %}  = {% calc [currency=RUB] 720 × (8 × {{ sku|RUB|yt.compute-nodes.cpu.v3|number }} + 32 × {{ sku|RUB|yt.compute-nodes.ram.v3|number }} + 3 × (8 × {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|RUB|yt.tablet-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|RUB|yt.master-nodes.cpu.v3|number }} + 12 × {{ sku|RUB|yt.master-nodes.ram.v3|number }}) + 2 × (24 × {{ sku|RUB|yt.system-nodes.cpu.v3|number }} + 64 × {{ sku|RUB|yt.system-nodes.ram.v3|number }}) + 2 × (4 × {{ sku|RUB|yt.proxy-nodes.cpu.v3|number }} + 8 ×{{ sku|RUB|yt.proxy-nodes.ram.v3|number }}) + 2 × (8 × {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|RUB|yt.tablet-nodes.ram.v3|number }}) + 6 × (8 × {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.storage-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.storage-nodes.ram.v3|number }})) + 3 × 2048 × {{ sku|RUB|yt.storage.hdd.v1|month|number }} + 3 × 465 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} + 93 × 1 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} + 3 × 93 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} + 93 × 6 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %}
  >
  > Итого: {% calc [currency=RUB] 720 × (8 × {{ sku|RUB|yt.compute-nodes.cpu.v3|number }} + 32 × {{ sku|RUB|yt.compute-nodes.ram.v3|number }} + 3 × (8 × {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|RUB|yt.tablet-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|RUB|yt.master-nodes.cpu.v3|number }} + 12 × {{ sku|RUB|yt.master-nodes.ram.v3|number }}) + 2 × (24 × {{ sku|RUB|yt.system-nodes.cpu.v3|number }} + 64 × {{ sku|RUB|yt.system-nodes.ram.v3|number }}) + 2 × (4 × {{ sku|RUB|yt.proxy-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.proxy-nodes.ram.v3|number }}) + 2 × (8 × {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|RUB|yt.tablet-nodes.ram.v3|number }}) + 6 × (8 × {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} + 8 ×{{ sku|RUB|yt.storage-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.storage-nodes.ram.v3|number }})) + 3 × 2048 × {{ sku|RUB|yt.storage.hdd.v1|month|number }} + 3 × 465 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} + 93 × 1 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} + 3 × 93 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} + 93 × 6 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость использования кластера в течение 30 дней.
  
  Где:
  * 720 — количество часов в 30 днях.
  * {% calc [currency=RUB] 8 × {{ sku|RUB|yt.compute-nodes.cpu.v3|number }} + 32 × {{ sku|RUB|yt.compute-nodes.ram.v3|number }} %} — стоимость часа работы exec-ноды.
  * {% calc [currency=RUB] 3 × (8 × {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|RUB|yt.tablet-nodes.ram.v3|number }}) %} — стоимость часа работы tablet-нод.
  * {% calc [currency=RUB] 3 × (4 × {{ sku|RUB|yt.master-nodes.cpu.v3|number }} + 12 × {{ sku|RUB|yt.master-nodes.ram.v3|number }}) %} — стоимость часа работы master-нод.
  * {% calc [currency=RUB] 2 × (24 × {{ sku|RUB|yt.system-nodes.cpu.v3|number }} + 64 × {{ sku|RUB|yt.system-nodes.ram.v3|number }}) %} — стоимость часа работы system-нод.
  * {% calc [currency=RUB] 2 × (4 × {{ sku|RUB|yt.proxy-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.proxy-nodes.ram.v3|number }}) %} — стоимость часа работы proxy-нод.
  * {% calc [currency=RUB] 2 × (8 × {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|RUB|yt.tablet-nodes.ram.v3|number }}) %} — стоимость часа работы служебных tablet-нод.
  * {% calc [currency=RUB] 6 × (8 × {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.storage-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.storage-nodes.ram.v3|number }}) %} — стоимость часа работы storage-нод.
  * {% calc [currency=RUB] 3 × 2048 × {{ sku|RUB|yt.storage.hdd.v1|month|number }} + 3 × 465 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования хранилищ на нереплицируемых SSD-дисках и сетевых HDD-дисках.
  * {% calc [currency=RUB] 93 × 1 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования хранилища на нереплицируемых SSD-дисках для exec-ноды.
  * {% calc [currency=RUB] 3 × 93 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования хранилища на нереплицируемых SSD-дисках для служебных storage-нод.
  * {% calc [currency=RUB] 93 × 6 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования хранилища на нереплицируемых SSD-дисках.

- Расчет в тенге {#prices-kzt}

  #### Настраиваемые компоненты
  
  Расчет стоимости для exec-ноды:
  
  > 8 × {% calc [currency=KZT] {{ sku|KZT|yt.compute-nodes.cpu.v3|number }} %} + 32 × {% calc [currency=KZT] {{ sku|KZT|yt.compute-nodes.ram.v3|number }} %} = {% calc [currency=KZT] 8 × {{ sku|KZT|yt.compute-nodes.cpu.v3|number }} + 32 × {{ sku|KZT|yt.compute-nodes.ram.v3|number }} %}
  >
  > Итого: {% calc [currency=KZT] 8 × {{ sku|KZT|yt.compute-nodes.cpu.v3|number }} + 32 × {{ sku|KZT|yt.compute-nodes.ram.v3|number }} %} — стоимость часа работы exec-ноды.
  
  Где:
  * 8 — количество vCPU одной exec-ноды.
  * {% calc [currency=KZT] {{ sku|KZT|yt.compute-nodes.cpu.v3|number }} %} — стоимость часа использования 1 vCPU.
  * 32 — объем RAM одной exec-ноды (в гигабайтах).
  * {% calc [currency=KZT] {{ sku|KZT|yt.compute-nodes.ram.v3|number }} %} — стоимость часа использования 1 ГБ RAM.
  
  Расчет стоимости для tablet-ноды:
  
  > 3 × (8 × {% calc [currency=KZT] {{ sku|KZT|yt.tablet-nodes.cpu.v3|number }} %} + 16 × {% calc [currency=KZT] {{ sku|KZT|yt.tablet-nodes.ram.v3|number }} %}) = {% calc [currency=KZT] 3 × (8 × {{ sku|KZT|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|KZT|yt.tablet-nodes.ram.v3|number }}) %}
  >
  > Итого: {% calc [currency=KZT] 3 × (8 × {{ sku|KZT|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|KZT|yt.tablet-nodes.ram.v3|number }}) %} — стоимость часа работы tablet-нод.
  
  Где:
  * 3 — количество tablet-нод.
  * 8 — количество vCPU одной tablet-ноды.
  * {% calc [currency=KZT] {{ sku|KZT|yt.tablet-nodes.cpu.v3|number }} %} — стоимость часа использования 1 vCPU.
  * 16 — объем RAM одной tablet-ноды (в гигабайтах).
  * {% calc [currency=KZT] {{ sku|KZT|yt.tablet-nodes.ram.v3|number }} %} — стоимость часа использования 1 ГБ RAM.
  
  Расчет стоимости хранилищ для кластера:
  
  > 3 × 2048 × {% calc [currency=KZT] {{ sku|KZT|yt.storage.hdd.v1|month|number }} %} + 3 × 465 × {% calc [currency=KZT] {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} %} = {% calc [currency=KZT] 3 × 2048 × {{ sku|KZT|yt.storage.hdd.v1|month|number }} + 3 × 465 × {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} %}
  >
  > Итого: {% calc [currency=KZT] 3 × 2048 × {{ sku|KZT|yt.storage.hdd.v1|month|number }} + 3 × 465 × {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования хранилищ на нереплицируемых SSD-дисках и сетевых HDD-дисках.
  
  Где:
  * 3 — количество дисков с типом `HDD`.
  * 2048 — размер одного HDD-диска (в гигабайтах).
  * {% calc [currency=KZT] {{ sku|KZT|yt.storage.hdd.v1|month|number }} %} — стоимость месяца использования 1 ГБ хранилища на сетевых HDD-дисках.
  * 3 — количество дисков с типом `Нереплицируемый SSD`.
  * 465 — размер одного нереплицируемого SSD-диска (в гигабайтах).
  * {% calc [currency=KZT] {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования 1 ГБ хранилища на нереплицируемых SSD-дисках.
  
  #### Служебные компоненты
  
  Расчет стоимости для master-ноды:
  
  > 3 × (4 × {% calc [currency=KZT] {{ sku|KZT|yt.master-nodes.cpu.v3|number }} %} + 12 × {% calc [currency=KZT] {{ sku|KZT|yt.master-nodes.ram.v3|number }} %}) = {% calc [currency=KZT] 3 × (4 × {{ sku|KZT|yt.master-nodes.cpu.v3|number }} + 12 × {{ sku|KZT|yt.master-nodes.ram.v3|number }}) %}
  >
  > Итого: {% calc [currency=KZT] 3 × (4 × {{ sku|KZT|yt.master-nodes.cpu.v3|number }} + 12 × {{ sku|KZT|yt.master-nodes.ram.v3|number }}) %} — стоимость часа работы master-нод.
  
  Где:
  * 3 — количество master-нод.
  * 4 — количество vCPU одной master-ноды.
  * {% calc [currency=KZT] {{ sku|KZT|yt.master-nodes.cpu.v3|number }} %} — стоимость часа использования 1 vCPU.
  * 12 — объем RAM одной master-ноды (в гигабайтах).
  * {% calc [currency=KZT] {{ sku|KZT|yt.master-nodes.ram.v3|number }} %} — стоимость часа использования 1 ГБ RAM.
  
  Расчет стоимости для system-ноды:
  
  > 2 × (24 × {% calc [currency=KZT] {{ sku|KZT|yt.system-nodes.cpu.v3|number }} %} + 64 × {% calc [currency=KZT] {{ sku|KZT|yt.system-nodes.ram.v3|number }} %}) = {% calc [currency=KZT] 2 × (24 × {{ sku|KZT|yt.system-nodes.cpu.v3|number }} + 64 × {{ sku|KZT|yt.system-nodes.ram.v3|number }}) %}
  >
  > Итого: {% calc [currency=KZT] 2 × (24 × {{ sku|KZT|yt.system-nodes.cpu.v3|number }} + 64 × {{ sku|KZT|yt.system-nodes.ram.v3|number }}) %} — стоимость часа работы system-нод.
  
  Где:
  * 2 — количество system-нод.
  * 24 — количество vCPU одной system-ноды.
  * {% calc [currency=KZT] {{ sku|KZT|yt.system-nodes.cpu.v3|number }} %} — стоимость часа использования 1 vCPU.
  * 64 — объем RAM одной system-ноды (в гигабайтах).
  * {% calc [currency=KZT] {{ sku|KZT|yt.system-nodes.ram.v3|number }} %} — стоимость часа использования 1 ГБ RAM.
  
  Расчет стоимости для proxy-ноды:
  
  > 2 × (4 × {% calc [currency=KZT] {{ sku|KZT|yt.proxy-nodes.cpu.v3|number }} %} + 8 × {% calc [currency=KZT] {{ sku|KZT|yt.proxy-nodes.ram.v3|number }} %}) = {% calc [currency=KZT] 2 × (4 × {{ sku|KZT|yt.proxy-nodes.cpu.v3|number }} + 8 × {{ sku|KZT|yt.proxy-nodes.ram.v3|number }}) %}
  >
  > Итого: {% calc [currency=KZT] 2 × (4 × {{ sku|KZT|yt.proxy-nodes.cpu.v3|number }} + 8 × {{ sku|KZT|yt.proxy-nodes.ram.v3|number }}) %} — стоимость часа работы proxy-нод.
  
  Где:
  * 2 — количество proxy-нод.
  * 4 — количество vCPU одной proxy-ноды.
  * {% calc [currency=KZT] {{ sku|KZT|yt.proxy-nodes.cpu.v3|number }} %} — стоимость часа использования 1 vCPU.
  * 8 — объем RAM одной proxy-ноды (в гигабайтах).
  * {% calc [currency=KZT] {{ sku|KZT|yt.proxy-nodes.ram.v3|number }} %} — стоимость часа использования 1 ГБ RAM.
  
  Расчет стоимости для служебной tablet-ноды:
  
  > 2 × (8 × {% calc [currency=KZT] {{ sku|KZT|yt.tablet-nodes.cpu.v3|number }} %} + 16 × {% calc [currency=KZT] {{ sku|KZT|yt.tablet-nodes.ram.v3|number }} %}) = {% calc [currency=KZT] 2 × (8 × {{ sku|KZT|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|KZT|yt.tablet-nodes.ram.v3|number }}) %}
  >
  > Итого: {% calc [currency=KZT] 2 × (8 × {{ sku|KZT|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|KZT|yt.tablet-nodes.ram.v3|number }}) %} — стоимость часа работы служебных tablet-нод.
  
  Где:
  * 2 — количество tablet-нод.
  * 8 — количество vCPU одной tablet-ноды.
  * {% calc [currency=KZT] {{ sku|KZT|yt.tablet-nodes.cpu.v3|number }} %} — стоимость часа использования 1 vCPU.
  * 16 — объем RAM одной tablet-ноды (в гигабайтах).
  * {% calc [currency=KZT] {{ sku|KZT|yt.tablet-nodes.ram.v3|number }} %} — стоимость часа использования 1 ГБ RAM.
  
  Расчет стоимости хранилища для exec-ноды:
  
  > 93 × 1 × {% calc [currency=KZT] {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} %} = {% calc [currency=KZT] 93 × 1 × {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} %}
  >
  > Итого: {% calc [currency=KZT] 93 × 1 × {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования хранилища на нереплицируемых SSD-дисках для exec-ноды.
  
  Где:
  * 93 — размер хранилища на нереплицируемых SSD-дисках (в гигабайтах).
  * 1 — количество нереплицируемых SSD-дисков.
  * {% calc [currency=KZT] {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования 1 ГБ хранилища на нереплицируемых SSD-дисках.
  
  Расчет стоимости хранилища для служебных storage-нод:
  
  > 3 × 93 × {% calc [currency=KZT] {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} %} = {% calc [currency=KZT] 3 × 93 × {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} %}
  >
  > Итого: {% calc [currency=KZT] 3 × 93 × {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования хранилища на нереплицируемых SSD-дисках для служебных storage-нод.
  
  Где:
  * 3 — количество дисков.
  * 93 — размер одного нереплицируемого SSD-диска (в гигабайтах).
  * {% calc [currency=KZT] {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования 1 ГБ хранилища на нереплицируемых SSD-дисках.
  
  Расчет стоимости для storage-ноды:
  
  > 6 × (8 × {% calc [currency=KZT] {{ sku|KZT|yt.storage-nodes.cpu.v3|number }} %} + 8 × {% calc [currency=KZT] {{ sku|KZT|yt.storage-nodes.ram.v3|number }} %}) + 3 × (4 × {% calc [currency=KZT] {{ sku|KZT|yt.storage-nodes.cpu.v3|number }} %} + 8 × {% calc [currency=KZT] {{ sku|KZT|yt.storage-nodes.ram.v3|number }} %}) = {% calc [currency=KZT] 6 × (8 × {{ sku|KZT|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|KZT|yt.storage-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|KZT|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|KZT|yt.storage-nodes.ram.v3|number }}) %}
  >
  > Итого: {% calc [currency=KZT] 6 × (8 × {{ sku|KZT|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|KZT|yt.storage-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|KZT|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|KZT|yt.storage-nodes.ram.v3|number }}) %} — стоимость часа работы storage-нод.
  
  Где:
  * 6 — количество storage-нод для `SSD` / `Нереплицируемый SSD`.
  * 3 — количество storage-нод для `HDD`.
  * 8 — количество vCPU одной storage-ноды для `SSD` / `Нереплицируемый SSD`.
  * 4 — количество vCPU одной storage-ноды для `HDD`.
  * {% calc [currency=KZT] {{ sku|KZT|yt.storage-nodes.cpu.v3|number }} %} — стоимость часа использования 1 vCPU.
  * 8 — объем RAM одной storage-ноды для `SSD` / `Нереплицируемый SSD` / `HDD` (в гигабайтах).
  * {% calc [currency=KZT] {{ sku|KZT|yt.storage-nodes.ram.v3|number }} %} — стоимость часа использования 1 ГБ RAM.
  
  Расчет стоимости хранилища со служебными дисками:
  
  > 93 × 6 × {% calc [currency=KZT] {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} %} = {% calc [currency=KZT] 93 × 6 × {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} %}
  >
  > Итого: {% calc [currency=KZT] 93 × 6 × {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования хранилища на нереплицируемых SSD-дисках.
  
  Где:
  * 6 — количество служебных дисков.
  * 93 — размер одного нереплицируемого SSD-диска (в гигабайтах).
  * {% calc [currency=KZT] {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования 1 ГБ хранилища на нереплицируемых SSD-дисках.
  
  #### Расчет итоговой стоимости
  
  > 720 × ({% calc [currency=KZT] 8 × {{ sku|KZT|yt.compute-nodes.cpu.v3|number }} + 32 × {{ sku|KZT|yt.compute-nodes.ram.v3|number }} %} + {% calc [currency=KZT] 3 × (8 × {{ sku|KZT|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|KZT|yt.tablet-nodes.ram.v3|number }}) %} + {% calc [currency=KZT] 3 × (4 × {{ sku|KZT|yt.master-nodes.cpu.v3|number }} + 12 × {{ sku|KZT|yt.master-nodes.ram.v3|number }}) %} + {% calc [currency=KZT] 2 × (24 × {{ sku|KZT|yt.system-nodes.cpu.v3|number }} + 64 × {{ sku|KZT|yt.system-nodes.ram.v3|number }}) %} + {% calc [currency=KZT] 2 × (4 × {{ sku|KZT|yt.proxy-nodes.cpu.v3|number }} + 8 × {{ sku|KZT|yt.proxy-nodes.ram.v3|number }}) %} + {% calc [currency=KZT] 2 × (8 × {{ sku|KZT|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|KZT|yt.tablet-nodes.ram.v3|number }}) %} + {% calc [currency=KZT] 6 × (8 × {{ sku|KZT|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|KZT|yt.storage-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|KZT|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|KZT|yt.storage-nodes.ram.v3|number }}) %}) + {% calc [currency=KZT] 3 × 2048 × {{ sku|KZT|yt.storage.hdd.v1|month|number }} + 3 × 465 × {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} %} + {% calc [currency=KZT] 93 × 1 × {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} %} + {% calc [currency=KZT] 3 × 93 × {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} %} + {% calc [currency=KZT] 93 × 6 × {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} %}  = {% calc [currency=KZT] 720 × (8 × {{ sku|KZT|yt.compute-nodes.cpu.v3|number }} + 32 × {{ sku|KZT|yt.compute-nodes.ram.v3|number }} + 3 × (8 × {{ sku|KZT|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|KZT|yt.tablet-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|KZT|yt.master-nodes.cpu.v3|number }} + 12 × {{ sku|KZT|yt.master-nodes.ram.v3|number }}) + 2 × (24 × {{ sku|KZT|yt.system-nodes.cpu.v3|number }} + 64 × {{ sku|KZT|yt.system-nodes.ram.v3|number }}) + 2 × (4 × {{ sku|KZT|yt.proxy-nodes.cpu.v3|number }} + 8 ×{{ sku|KZT|yt.proxy-nodes.ram.v3|number }}) + 2 × (8 × {{ sku|KZT|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|KZT|yt.tablet-nodes.ram.v3|number }}) + 6 × (8 × {{ sku|KZT|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|KZT|yt.storage-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|KZT|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|KZT|yt.storage-nodes.ram.v3|number }})) + 3 × 2048 × {{ sku|KZT|yt.storage.hdd.v1|month|number }} + 3 × 465 × {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} + 93 × 1 × {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} + 3 × 93 × {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} + 93 × 6 × {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} %}
  >
  > Итого: {% calc [currency=KZT] 720 × (8 × {{ sku|KZT|yt.compute-nodes.cpu.v3|number }} + 32 × {{ sku|KZT|yt.compute-nodes.ram.v3|number }} + 3 × (8 × {{ sku|KZT|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|KZT|yt.tablet-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|KZT|yt.master-nodes.cpu.v3|number }} + 12 × {{ sku|KZT|yt.master-nodes.ram.v3|number }}) + 2 × (24 × {{ sku|KZT|yt.system-nodes.cpu.v3|number }} + 64 × {{ sku|KZT|yt.system-nodes.ram.v3|number }}) + 2 × (4 × {{ sku|KZT|yt.proxy-nodes.cpu.v3|number }} + 8 × {{ sku|KZT|yt.proxy-nodes.ram.v3|number }}) + 2 × (8 × {{ sku|KZT|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|KZT|yt.tablet-nodes.ram.v3|number }}) + 6 × (8 × {{ sku|KZT|yt.storage-nodes.cpu.v3|number }} + 8 ×{{ sku|KZT|yt.storage-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|KZT|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|KZT|yt.storage-nodes.ram.v3|number }})) + 3 × 2048 × {{ sku|KZT|yt.storage.hdd.v1|month|number }} + 3 × 465 × {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} + 93 × 1 × {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} + 3 × 93 × {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} + 93 × 6 × {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость использования кластера в течение 30 дней.
  
  Где:
  * 720 — количество часов в 30 днях.
  * {% calc [currency=KZT] 8 × {{ sku|KZT|yt.compute-nodes.cpu.v3|number }} + 32 × {{ sku|KZT|yt.compute-nodes.ram.v3|number }} %} — стоимость часа работы exec-ноды.
  * {% calc [currency=KZT] 3 × (8 × {{ sku|KZT|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|KZT|yt.tablet-nodes.ram.v3|number }}) %} — стоимость часа работы tablet-нод.
  * {% calc [currency=KZT] 3 × (4 × {{ sku|KZT|yt.master-nodes.cpu.v3|number }} + 12 × {{ sku|KZT|yt.master-nodes.ram.v3|number }}) %} — стоимость часа работы master-нод.
  * {% calc [currency=KZT] 2 × (24 × {{ sku|KZT|yt.system-nodes.cpu.v3|number }} + 64 × {{ sku|KZT|yt.system-nodes.ram.v3|number }}) %} — стоимость часа работы system-нод.
  * {% calc [currency=KZT] 2 × (4 × {{ sku|KZT|yt.proxy-nodes.cpu.v3|number }} + 8 × {{ sku|KZT|yt.proxy-nodes.ram.v3|number }}) %} — стоимость часа работы proxy-нод.
  * {% calc [currency=KZT] 2 × (8 × {{ sku|KZT|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|KZT|yt.tablet-nodes.ram.v3|number }}) %} — стоимость часа работы служебных tablet-нод.
  * {% calc [currency=KZT] 6 × (8 × {{ sku|KZT|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|KZT|yt.storage-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|KZT|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|KZT|yt.storage-nodes.ram.v3|number }}) %} — стоимость часа работы storage-нод.
  * {% calc [currency=KZT] 3 × 2048 × {{ sku|KZT|yt.storage.hdd.v1|month|number }} + 3 × 465 × {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования хранилищ на нереплицируемых SSD-дисках и сетевых HDD-дисках.
  * {% calc [currency=KZT] 93 × 1 × {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования хранилища на нереплицируемых SSD-дисках для exec-ноды.
  * {% calc [currency=KZT] 3 × 93 × {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования хранилища на нереплицируемых SSD-дисках для служебных storage-нод.
  * {% calc [currency=KZT] 93 × 6 × {{ sku|KZT|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования хранилища на нереплицируемых SSD-дисках.

{% endlist %}



## Цены для региона Россия {#prices}

{% note info %}

Цены на ресурсы {{ yandex-cloud }} в разных регионах различаются. Подробнее о доступных регионах см. [{#T}](../overview/concepts/region.md).

Валюта, которой можно оплачивать ресурсы, зависит от юридического лица, с которым пользователь заключил договор. Подробнее о регистрации аккаунта см. [{#T}](../billing/quickstart/index.md).

{% endnote %}

Цены за месяц использования формируются из расчета 720 часов в месяц.


| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |



### Исходящий трафик {#prices-traffic}

При использовании сервиса оплачивается исходящий трафик из {{ yandex-cloud }} в интернет. Передача трафика между сервисами {{ yandex-cloud }} по внутренним адресам, как и входящий трафик из интернета, не тарифицируется.

Каждый месяц не тарифицируются первые 100 ГБ исходящего трафика.

Минимальная единица тарификации — 1 МБ.


| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |