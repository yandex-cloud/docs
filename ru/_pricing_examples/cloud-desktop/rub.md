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