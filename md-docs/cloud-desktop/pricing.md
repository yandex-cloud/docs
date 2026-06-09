# Правила тарификации для {{ cloud-desktop-full-name }}



Чтобы рассчитать стоимость использования сервиса, ознакомьтесь с тарифами в этом разделе.

Цены на продукты сервиса также доступны в [Прайс-листе](https://yandex.cloud/ru/price-list).


Все цены в рублях и тенге указаны с НДС, все цены в долларах — без НДС.

## Из чего складывается стоимость использования {{ cloud-desktop-name }} {#rules}

Расчет стоимости использования {{ cloud-desktop-name }} учитывает:

* Вычислительные ресурсы:
  * количество ядер (vCPU);
  * объем памяти (RAM).
* Тип и объем диска.
* Объем исходящего трафика.

Во всех расчетах 1 ГБ = 2<sup>30</sup> байт, 1 МБ = 2<sup>20</sup> байт.

### Использование вычислительных ресурсов {#use-resources}

Стоимость выделенных вычислительных ресурсов рассчитывается за время использования рабочих столов, начиная с перехода в статус `CREATING` (при создании) или `STARTING` (при запуске) и до полной остановки. Время, которое рабочие столы были выключены, не тарифицируется.

Рабочий стол запускается автоматически после создания.

### Использование дисков {#use-storage}

Диски тарифицируются независимо от того, запущены рабочие столы или нет.

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

## Пример расчета стоимости {#price-example}

Пример расчета стоимости {{ cloud-desktop-name }} за один месяц для группы из десяти рабочих столов следующей конфигурации:

* Вычислительные ресурсы: 2 × 50% vCPU и 2 ГБ RAM.
* Загрузочный диск: 50 ГБ SSD.
* Рабочий диск: 30 ГБ HDD.
* Общее время работы всех рабочих столов в течение месяца: 1 000 часов.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  Расчет стоимости вычислительных ресурсов:
  
  > ({{ sku|RUB|cloud_desktop.vcpu.c50.v1|string }} × 2 + {{ sku|RUB|cloud_desktop.ram.v1|string }} × 2) × 1000 = {% calc [currency=RUB] ({{ sku|RUB|cloud_desktop.vcpu.c50.v1|number }} × 2 + {{ sku|RUB|cloud_desktop.ram.v1|number }} × 2) × 1000 %}
  >
  > Итого: {% calc [currency=RUB] ({{ sku|RUB|cloud_desktop.vcpu.c50.v1|number }} × 2 + {{ sku|RUB|cloud_desktop.ram.v1|number }} × 2) × 1000 %} — стоимость 1 000 часов работы вычислительных ресурсов.
  
  Где:
  * {{ sku|RUB|cloud_desktop.vcpu.c50.v1|string }} — стоимость часа использования 50% vCPU.
  * 2 — количество vCPU.
  * {{ sku|RUB|cloud_desktop.ram.v1|string }} — стоимость часа использования 1 ГБ RAM.
  * 2 — объем RAM (в гигабайтах).
  * 1 000 — общее время работы всех рабочих столов в группе в течении месяца.
  
  Расчет стоимости загрузочных дисков:
  
  > {{ sku|RUB|cloud_desktop.ssd.v1|month|string }} × 50 × 10 = {% calc [currency=RUB] {{ sku|RUB|cloud_desktop.ssd.v1|month|number }} × 50 × 10 %}
  >
  > Итого: {% calc [currency=RUB] {{ sku|RUB|cloud_desktop.ssd.v1|month|number }} × 50 × 10 %} — стоимость работы загрузочных дисков.
  
  Где:
  * {{ sku|RUB|cloud_desktop.ssd.v1|month|string }} — стоимость месяца использования загрузочного SSD-диска за 1 ГБ.
  * 50 — объем загрузочного диска (в гигабайтах).
  * 10 — количество рабочих столов в группе.
  
  Расчет стоимости рабочих дисков:
  
  > {{ sku|RUB|cloud_desktop.hdd.v1|month|string }} × 30 × 10 = {% calc [currency=RUB] {{ sku|RUB|cloud_desktop.hdd.v1|month|number }} × 30 × 10 %}
  >
  > Итого: {% calc [currency=RUB] {{ sku|RUB|cloud_desktop.hdd.v1|month|number }} × 30 × 10 %} — стоимость работы рабочих дисков.
  
  Где:
  * {{ sku|RUB|cloud_desktop.hdd.v1|month|string }} — стоимость месяца использования рабочего HDD-диска за 1 ГБ.
  * 30 — объем рабочего диска (в гигабайтах).
  * 10 — количество рабочих столов в группе.
  
  Расчет итоговой стоимости:
  
  > {% calc [currency=RUB] ({{ sku|RUB|cloud_desktop.vcpu.c50.v1|number }} × 2 + {{ sku|RUB|cloud_desktop.ram.v1|number }} × 2) × 1000 %} + {% calc [currency=RUB] {{ sku|RUB|cloud_desktop.ssd.v1|month|number }} × 50 × 10 %} + {% calc [currency=RUB] {{ sku|RUB|cloud_desktop.hdd.v1|month|number }} × 30 × 10 %} = {% calc [currency=RUB] (({{ sku|RUB|cloud_desktop.vcpu.c50.v1|number }} × 2 + {{ sku|RUB|cloud_desktop.ram.v1|number }} × 2) × 1000) + ({{ sku|RUB|cloud_desktop.ssd.v1|month|number }} × 50 × 10) + ({{ sku|RUB|cloud_desktop.hdd.v1|month|number }} × 30 × 10) %}
  >
  > Итого: {% calc [currency=RUB] (({{ sku|RUB|cloud_desktop.vcpu.c50.v1|number }} × 2 + {{ sku|RUB|cloud_desktop.ram.v1|number }} × 2) × 1000) + ({{ sku|RUB|cloud_desktop.ssd.v1|month|number }} × 50 × 10) + ({{ sku|RUB|cloud_desktop.hdd.v1|month|number }} × 30 × 10) %} — стоимость использования {{ cloud-desktop-name }} за месяц.
  
  Где:
  * {% calc [currency=RUB] ({{ sku|RUB|cloud_desktop.vcpu.c50.v1|number }} × 2 + {{ sku|RUB|cloud_desktop.ram.v1|number }} × 2) × 1000 %} — стоимость вычислительных ресурсов.
  * {% calc [currency=RUB] {{ sku|RUB|cloud_desktop.ssd.v1|month|number }} × 50 × 10 %} — стоимость загрузочных дисков.
  * {% calc [currency=RUB] {{ sku|RUB|cloud_desktop.hdd.v1|month|number }} × 30 × 10 %} — стоимость рабочих дисков.

- Расчет в тенге {#prices-kzt}

  Расчет стоимости вычислительных ресурсов:
  
  > ({{ sku|KZT|cloud_desktop.vcpu.c50.v1|string }} × 2 + {{ sku|KZT|cloud_desktop.ram.v1|string }} × 2) × 1000 = {% calc [currency=KZT] ({{ sku|KZT|cloud_desktop.vcpu.c50.v1|number }} × 2 + {{ sku|KZT|cloud_desktop.ram.v1|number }} × 2) × 1000 %}
  >
  > Итого: {% calc [currency=KZT] ({{ sku|KZT|cloud_desktop.vcpu.c50.v1|number }} × 2 + {{ sku|KZT|cloud_desktop.ram.v1|number }} × 2) × 1000 %} — стоимость 1 000 часов работы вычислительных ресурсов.
  
  Где:
  * {{ sku|KZT|cloud_desktop.vcpu.c50.v1|string }} — стоимость часа использования 50% vCPU.
  * 2 — количество vCPU.
  * {{ sku|KZT|cloud_desktop.ram.v1|string }} — стоимость часа использования 1 ГБ RAM.
  * 2 — объем RAM (в гигабайтах).
  * 1 000 — общее время работы всех рабочих столов в группе в течении месяца.
  
  Расчет стоимости загрузочных дисков:
  
  > {{ sku|KZT|cloud_desktop.ssd.v1|month|string }} × 50 × 10 = {% calc [currency=KZT] {{ sku|KZT|cloud_desktop.ssd.v1|month|number }} × 50 × 10 %}
  >
  > Итого: {% calc [currency=KZT] {{ sku|KZT|cloud_desktop.ssd.v1|month|number }} × 50 × 10 %} — стоимость работы загрузочных дисков.
  
  Где:
  * {{ sku|KZT|cloud_desktop.ssd.v1|month|string }} — стоимость месяца использования загрузочного SSD-диска за 1 ГБ.
  * 50 — объем загрузочного диска (в гигабайтах).
  * 10 — количество рабочих столов в группе.
  
  Расчет стоимости рабочих дисков:
  
  > {{ sku|KZT|cloud_desktop.hdd.v1|month|string }} × 30 × 10 = {% calc [currency=KZT] {{ sku|KZT|cloud_desktop.hdd.v1|month|number }} × 30 × 10 %}
  >
  > Итого: {% calc [currency=KZT] {{ sku|KZT|cloud_desktop.hdd.v1|month|number }} × 30 × 10 %} — стоимость работы рабочих дисков.
  
  Где:
  * {{ sku|KZT|cloud_desktop.hdd.v1|month|string }} — стоимость месяца использования рабочего HDD-диска за 1 ГБ.
  * 30 — объем рабочего диска (в гигабайтах).
  * 10 — количество рабочих столов в группе.
  
  Расчет итоговой стоимости:
  
  > {% calc [currency=KZT] ({{ sku|KZT|cloud_desktop.vcpu.c50.v1|number }} × 2 + {{ sku|KZT|cloud_desktop.ram.v1|number }} × 2) × 1000 %} + {% calc [currency=KZT] {{ sku|KZT|cloud_desktop.ssd.v1|month|number }} × 50 × 10 %} + {% calc [currency=KZT] {{ sku|KZT|cloud_desktop.hdd.v1|month|number }} × 30 × 10 %} = {% calc [currency=KZT] (({{ sku|KZT|cloud_desktop.vcpu.c50.v1|number }} × 2 + {{ sku|KZT|cloud_desktop.ram.v1|number }} × 2) × 1000) + ({{ sku|KZT|cloud_desktop.ssd.v1|month|number }} × 50 × 10) + ({{ sku|KZT|cloud_desktop.hdd.v1|month|number }} × 30 × 10) %}
  >
  > Итого: {% calc [currency=KZT] (({{ sku|KZT|cloud_desktop.vcpu.c50.v1|number }} × 2 + {{ sku|KZT|cloud_desktop.ram.v1|number }} × 2) × 1000) + ({{ sku|KZT|cloud_desktop.ssd.v1|month|number }} × 50 × 10) + ({{ sku|KZT|cloud_desktop.hdd.v1|month|number }} × 30 × 10) %} — стоимость использования {{ cloud-desktop-name }} за месяц.
  
  Где:
  * {% calc [currency=KZT] ({{ sku|KZT|cloud_desktop.vcpu.c50.v1|number }} × 2 + {{ sku|KZT|cloud_desktop.ram.v1|number }} × 2) × 1000 %} — стоимость вычислительных ресурсов.
  * {% calc [currency=KZT] {{ sku|KZT|cloud_desktop.ssd.v1|month|number }} × 50 × 10 %} — стоимость загрузочных дисков.
  * {% calc [currency=KZT] {{ sku|KZT|cloud_desktop.hdd.v1|month|number }} × 30 × 10 %} — стоимость рабочих дисков.

{% endlist %}