# Правила тарификации для {{ dataproc-name }}




Чтобы рассчитать стоимость использования сервиса, ознакомьтесь с тарифами в этом разделе.

Цены на продукты сервиса также доступны в [Прайс-листе](https://yandex.cloud/ru/price-list).

Все цены в рублях и тенге указаны с НДС, все цены в долларах — без НДС.

## Из чего складывается стоимость использования {{ dataproc-name }} {#rules}

Итоговый расчет стоимости использования {{ dataproc-name }} учитывает:

* использование вычислительных ресурсов виртуальных машин {{ compute-full-name }} для развертывания хостов;
* наценку на вычислительные ресурсы за использование управляемого сервиса {{ dataproc-name }};
* использование сетевых дисков {{ compute-name }};
* использование сервиса {{ cloud-logging-full-name }} для получения и хранения логов;
* объем исходящего трафика.

Во всех расчетах 1 ГБ = 2<sup>30</sup> байт, 1 МБ = 2<sup>20</sup> байт.

### Использование вычислительных ресурсов {#rules-compute}

Стоимость начисляется за каждый час работы виртуальной машины хоста в рамках сервиса {{ compute-name }} согласно [ценам за вычислительные ресурсы {{ compute-full-name }}](../compute/pricing.md#prices), с наценкой за использование управляемого сервиса {{ dataproc-name }}.
Информация о тарифах за использование внешнего IP-адреса в разделе [{#T}](../vpc/pricing.md) документации сервиса {{ vpc-full-name }}.


### Использование дискового пространства {#rules-storage}

Объем хранилища, запрошенный для каждого из хостов кластера, тарифицируется в рамках сервиса {{ compute-name }} согласно [ценам на дисковое пространство](../compute/pricing.md#prices-storage).

### Использование сервиса {{ cloud-logging-full-name }} {#rules-logs}

Получение и хранение логов оплачивается по [правилам тарификации](../logging/pricing.md) сервиса {{ cloud-logging-full-name }}.

### Пример расчета стоимости стандартных хостов {#price-example}

Стоимость часа использования кластера из двух подкластеров со следующими параметрами:

* Первый подкластер:
  * **Хост-мастер**: класс `m2.micro`, Intel Cascade Lake, 2 × 100% vCPU, 16 ГБ RAM.
  * **Хранилище хоста-мастера**: 20 ГБ `network-ssd`.

* Второй подкластер:
  * **Хост для хранения данных**: класс `s2.micro`, Intel Cascade Lake, 2 × 100% vCPU, 8 ГБ RAM.
  * **Хранилище хоста**: 100 ГБ `network-hdd`.

Расчет стоимости:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  > {% calc [currency=RUB] {{ sku|RUB|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|RUB|compute.vm.cpu.c100.v2|number }} %} × 2 + {% calc [currency=RUB] {{ sku|RUB|mdb.dataproc.v2.ram|number }} + {{ sku|RUB|compute.vm.ram.v2|number }} %} × 16 + {{ sku|RUB|compute.filesystem.ssd.v1|string }} × 20 = {% calc [currency=RUB] ({{ sku|RUB|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|RUB|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|RUB|mdb.dataproc.v2.ram|number }} + {{ sku|RUB|compute.vm.ram.v2|number }}) × 16 + {{ sku|RUB|compute.filesystem.ssd.v1|number }} × 20 %}
  >
  > Итого: {% calc [currency=RUB] ({{ sku|RUB|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|RUB|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|RUB|mdb.dataproc.v2.ram|number }} + {{ sku|RUB|compute.vm.ram.v2|number }}) × 16 + {{ sku|RUB|compute.filesystem.ssd.v1|number }} × 20 %} — стоимость часа использования первого подкластера.
  
  Где:
  
  * {% calc [currency=RUB] {{ sku|RUB|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|RUB|compute.vm.cpu.c100.v2|number }} %} — стоимость часа использования 100% vCPU.
  * 2 — количество vCPU в хосте-мастере.
  * {% calc [currency=RUB] {{ sku|RUB|mdb.dataproc.v2.ram|number }} + {{ sku|RUB|compute.vm.ram.v2|number }} %} — стоимость часа использования 1 ГБ RAM.
  * 16 — объем RAM хоста-мастера (в гигабайтах).
  * {{ sku|RUB|compute.filesystem.ssd.v1|string }}  — стоимость часа использования 1 ГБ `network-ssd`.
  * 20 — объем хранилища хоста-мастера (в гигабайтах).
  
  > {% calc [currency=RUB] {{ sku|RUB|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|RUB|compute.vm.cpu.c100.v2|number }} %} × 2 + {% calc [currency=RUB] {{ sku|RUB|mdb.dataproc.v2.ram|number }} + {{ sku|RUB|compute.vm.ram.v2|number }} %} × 8 + {{ sku|RUB|compute.filesystem.hdd.v1|string }} × 100 = {% calc [currency=RUB] ({{ sku|RUB|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|RUB|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|RUB|mdb.dataproc.v2.ram|number }} + {{ sku|RUB|compute.vm.ram.v2|number }}) × 8 + {{ sku|RUB|compute.filesystem.hdd.v1|number }} × 100 %}
  >
  > Итого: {% calc [currency=RUB] ({{ sku|RUB|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|RUB|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|RUB|mdb.dataproc.v2.ram|number }} + {{ sku|RUB|compute.vm.ram.v2|number }}) × 8 + {{ sku|RUB|compute.filesystem.hdd.v1|number }} × 100 %} — стоимость часа использования второго подкластера.
  
  Где:
  
  * {% calc [currency=RUB] {{ sku|RUB|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|RUB|compute.vm.cpu.c100.v2|number }} %} — стоимость часа использования 100% vCPU.
  * 2 — количество vCPU в хосте для хранения данных.
  * {% calc [currency=RUB] {{ sku|RUB|mdb.dataproc.v2.ram|number }} + {{ sku|RUB|compute.vm.ram.v2|number }} %} — стоимость часа использования 1 ГБ RAM.
  * 8 — объем RAM хоста для хранения данных (в гигабайтах).
  * {{ sku|RUB|compute.filesystem.hdd.v1|string }} — стоимость часа использования 1 ГБ `network-hdd`.
  * 100 — объем хранилища хоста для хранения данных (в гигабайтах).
  
  > {% calc [currency=RUB] ({{ sku|RUB|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|RUB|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|RUB|mdb.dataproc.v2.ram|number }} + {{ sku|RUB|compute.vm.ram.v2|number }}) × 16 + {{ sku|RUB|compute.filesystem.ssd.v1|number }} × 20 %} + {% calc [currency=RUB] ({{ sku|RUB|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|RUB|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|RUB|mdb.dataproc.v2.ram|number }} + {{ sku|RUB|compute.vm.ram.v2|number }}) × 8 + {{ sku|RUB|compute.filesystem.hdd.v1|number }} × 100 %} = {% calc [currency=RUB] (({{ sku|RUB|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|RUB|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|RUB|mdb.dataproc.v2.ram|number }} + {{ sku|RUB|compute.vm.ram.v2|number }}) × 16 + {{ sku|RUB|compute.filesystem.ssd.v1|number }} × 20) + (({{ sku|RUB|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|RUB|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|RUB|mdb.dataproc.v2.ram|number }} + {{ sku|RUB|compute.vm.ram.v2|number }}) × 8 + {{ sku|RUB|compute.filesystem.hdd.v1|number }} × 100) %}
  >
  > Итого: {% calc [currency=RUB] (({{ sku|RUB|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|RUB|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|RUB|mdb.dataproc.v2.ram|number }} + {{ sku|RUB|compute.vm.ram.v2|number }}) × 16 + {{ sku|RUB|compute.filesystem.ssd.v1|number }} × 20) + (({{ sku|RUB|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|RUB|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|RUB|mdb.dataproc.v2.ram|number }} + {{ sku|RUB|compute.vm.ram.v2|number }}) × 8 + {{ sku|RUB|compute.filesystem.hdd.v1|number }} × 100) %} — стоимость часа использования кластера из двух подкластеров.
  
  Где:
  
  * {% calc [currency=RUB] ({{ sku|RUB|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|RUB|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|RUB|mdb.dataproc.v2.ram|number }} + {{ sku|RUB|compute.vm.ram.v2|number }}) × 16 + {{ sku|RUB|compute.filesystem.ssd.v1|number }} × 20 %} — стоимость часа использования первого подкластера.
  * {% calc [currency=RUB] ({{ sku|RUB|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|RUB|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|RUB|mdb.dataproc.v2.ram|number }} + {{ sku|RUB|compute.vm.ram.v2|number }}) × 8 + {{ sku|RUB|compute.filesystem.hdd.v1|number }} × 100 %} — стоимость часа использования второго подкластера.

- Расчет в тенге {#prices-kzt}

  > {% calc [currency=KZT] {{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }} %} × 2 + {% calc [currency=KZT] {{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }} %} × 16 + {{ sku|KZT|compute.filesystem.ssd.v1|string }} × 20 = {% calc [currency=KZT] ({{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }}) × 16 + {{ sku|KZT|compute.filesystem.ssd.v1|number }} × 20 %}
  >
  > Итого: {% calc [currency=KZT] ({{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }}) × 16 + {{ sku|KZT|compute.filesystem.ssd.v1|number }} × 20 %} — стоимость часа использования первого подкластера.
  
  Где:
  
  * {% calc [currency=KZT] {{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }} %} — стоимость часа использования 100% vCPU.
  * 2 — количество vCPU в хосте-мастере.
  * {% calc [currency=KZT] {{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }} %} — стоимость часа использования 1 ГБ RAM.
  * 16 — объем RAM хоста-мастера (в гигабайтах).
  * {{ sku|KZT|compute.filesystem.ssd.v1|string }}  — стоимость часа использования 1 ГБ `network-ssd`.
  * 20 — объем хранилища хоста-мастера (в гигабайтах).
  
  > {% calc [currency=KZT] {{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }} %} × 2 + {% calc [currency=KZT] {{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }} %} × 8 + {{ sku|KZT|compute.filesystem.hdd.v1|string }} × 100 = {% calc [currency=KZT] ({{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }}) × 8 + {{ sku|KZT|compute.filesystem.hdd.v1|number }} × 100 %}
  >
  > Итого: {% calc [currency=KZT] ({{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }}) × 8 + {{ sku|KZT|compute.filesystem.hdd.v1|number }} × 100 %} — стоимость часа использования второго подкластера.
  
  Где:
  
  * {% calc [currency=KZT] {{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }} %} — стоимость часа использования 100% vCPU.
  * 2 — количество vCPU в хосте для хранения данных.
  * {% calc [currency=KZT] {{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }} %} — стоимость часа использования 1 ГБ RAM.
  * 8 — объем RAM хоста для хранения данных (в гигабайтах).
  * {{ sku|KZT|compute.filesystem.hdd.v1|string }} — стоимость часа использования 1 ГБ `network-hdd`.
  * 100 — объем хранилища хоста для хранения данных (в гигабайтах).
  
  > {% calc [currency=KZT] ({{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }}) × 16 + {{ sku|KZT|compute.filesystem.ssd.v1|number }} × 20 %} + {% calc [currency=KZT] ({{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }}) × 8 + {{ sku|KZT|compute.filesystem.hdd.v1|number }} × 100 %} = {% calc [currency=KZT] (({{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }}) × 16 + {{ sku|KZT|compute.filesystem.ssd.v1|number }} × 20) + (({{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }}) × 8 + {{ sku|KZT|compute.filesystem.hdd.v1|number }} × 100) %}
  >
  > Итого: {% calc [currency=KZT] (({{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }}) × 16 + {{ sku|KZT|compute.filesystem.ssd.v1|number }} × 20) + (({{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }}) × 8 + {{ sku|KZT|compute.filesystem.hdd.v1|number }} × 100) %} — стоимость часа использования кластера из двух подкластеров.
  
  Где:
  
  * {% calc [currency=KZT] ({{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }}) × 16 + {{ sku|KZT|compute.filesystem.ssd.v1|number }} × 20 %} — стоимость часа использования первого подкластера.
  * {% calc [currency=KZT] ({{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }}) × 8 + {{ sku|KZT|compute.filesystem.hdd.v1|number }} × 100 %} — стоимость часа использования второго подкластера.

{% endlist %}



## Цены для региона Россия {#prices} 

{% note info %}

Цены на ресурсы {{ yandex-cloud }} в разных регионах различаются. Подробнее о доступных регионах см. [{#T}](../overview/concepts/region.md).

Валюта, которой можно оплачивать ресурсы, зависит от юридического лица, с которым пользователь заключил договор. Подробнее о регистрации аккаунта см. [{#T}](../billing/quickstart/index.md).

{% endnote %}


| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |



### Исходящий трафик {#prices-traffic}

При использовании сервиса оплачивается исходящий трафик из {{ yandex-cloud }} в интернет. Передача трафика между сервисами {{ yandex-cloud }} по внутренним адресам, как и входящий трафик из интернета, не тарифицируется.

Каждый месяц не тарифицируются первые 100 ГБ исходящего трафика.

Минимальная единица тарификации — 1 МБ.


| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |