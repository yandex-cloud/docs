Расчет стоимости вычислительных ресурсов:

> (4,15 ₸ × 2 + 2,15 ₸ × 2) × 1000 = {% calc [currency=KZT] (4,15 × 2 + 2,15 × 2) × 1000 %}
>
> Итого: {% calc [currency=KZT] (4,15 × 2 + 2,15 × 2) × 1000 %} — стоимость 1 000 часов работы вычислительных ресурсов.

Где:
* 4,15 ₸ — стоимость часа использования 50% vCPU.
* 2 — количество vCPU.
* 2,15 ₸ — стоимость часа использования 1 ГБ RAM.
* 2 — объем RAM (в гигабайтах).
* 1 000 — общее время работы всех рабочих столов в группе в течении месяца.

Расчет стоимости загрузочных дисков:

> {% calc [currency=KZT] 0,11 × 720 %} × 50 × 10 = {% calc [currency=KZT] 0,11 × 720 × 50 × 10 %}
>
> Итого: {% calc [currency=KZT] 0,11 × 720 × 50 × 10 %} — стоимость работы загрузочных дисков.

Где:
* {% calc [currency=KZT] 0,11 × 720 %} — стоимость месяца использования загрузочного SSD-диска за 1 ГБ.
* 50 — объем загрузочного диска (в гигабайтах).
* 10 — количество рабочих столов в группе.

Расчет стоимости рабочих дисков:

> {% calc [currency=KZT] 0,03 * 720 %} × 30 × 10 = {% calc [currency=KZT] 0,03 × 720 × 30 × 10 %}
>
> Итого: {% calc [currency=KZT] 0,03 × 720 × 30 × 10 %} — стоимость работы рабочих дисков.

Где:
* {% calc [currency=KZT] 0,03 * 720 %} — стоимость месяца использования рабочего HDD-диска за 1 ГБ.
* 30 — объем рабочего диска (в гигабайтах).
* 10 — количество рабочих столов в группе.

Расчет итоговой стоимости:

> {% calc [currency=KZT] (4,15 × 2 + 2,15 × 2) × 1000 %} + {% calc [currency=KZT] 0,11 × 720 × 50 × 10 %} + {% calc [currency=KZT] 0,03 × 720 × 30 × 10 %} = {% calc [currency=KZT] ((4,15 × 2 + 2,15 × 2) × 1000) + (0,11 × 720 × 50 × 10) + (0,03 × 720 × 30 × 10) %}
>
> Итого: {% calc [currency=KZT] ((4,15 × 2 + 2,15 × 2) × 1000) + (0,11 × 720 × 50 × 10) + (0,03 × 720 × 30 × 10) %} — стоимость использования {{ cloud-desktop-name }} за месяц.

Где:
* {% calc [currency=KZT] (4,15 × 2 + 2,15 × 2) × 1000 %} — стоимость вычислительных ресурсов.
* {% calc [currency=KZT] 0,11 × 720 × 50 × 10 %} — стоимость загрузочных дисков.
* {% calc [currency=KZT] 0,03 × 720 × 30 × 10 %} — стоимость рабочих дисков.