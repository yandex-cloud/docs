---
title: Чарты
description: На странице представлены вопросы и ответы про чарты.
---

# Чарты



{% include [show-top-100-values](../../_qa/datalens/show-top-100-values.md) %}

{% include [create-labels-in-pie-chart](../../_qa/datalens/create-labels-in-pie-chart.md) %}

{% include [hide-legend-in-chart](../../_qa/datalens/hide-legend-in-chart.md) %}

{% include [add-two-indicators](../../_qa/datalens/add-two-indicators.md) %}

{% include [add-columns-signatures](../../_qa/datalens/add-columns-signatures.md) %}

{% include [create-grouped-column-chart](../../_qa/datalens/create-grouped-column-chart.md) %}

{% include [add-column-grouped](../../_qa/datalens/add-column-grouped.md) %}

{% include [number-of-indicators-in-color-section](../../_qa/datalens/number-of-indicators-in-color-section.md) %}

{% include [add-all-fields](../../_qa/datalens/add-all-fields.md) %}

{% include [creating-line-chart-with-columns](../../_qa/datalens/creating-line-chart-with-columns.md) %}

{% include [pie-chart-note](../../_qa/datalens/pie-chart-note.md) %}

{% include [making-logarithmic-scale](../../_qa/datalens/making-logarithmic-scale.md) %}

{% include [sign-last-point](../../_qa/datalens/sign-last-point.md) %}

{% include [sign-multiple-lines](../../_qa/datalens/sign-multiple-lines.md) %}

{% include [resize-column](../../_qa/datalens/resize-column.md) %}

{% include [rename-column](../../_qa/datalens/rename-column.md) %}

{% include [null-setting-in-charts](../../_qa/datalens/null-setting-in-charts.md) %}




### Почему при создании мультидатасетного чарта выводится «null»? {#null-in-multidataset-chart}

Возможные причины:

* Значение `null` сохранено в таблице БД.
* При объединении таблиц значения `null` отображаются, если в одной из таблиц отсутствуют записи, которые соответствуют по условию соединения записям в другой таблице.

Если для каждого датасета должны отображаться значения, отличные от `null`, проверьте:

* Правильно ли выбраны поля при настройке связей между датасетами.
* Не установлены ли фильтры в чарте или датасете, которые могут ограничить итоговую выборку данными только из одного датасета. Удалите фильтры и проверьте отображение записей.
* Условия, которые ограничивают выборку (если для построения датасета используется SQL-запрос).
* Соответствие записей в разных датасетах. Для этого выберите запись из одного датасета и найдите соответствующую по условию соединения запись во втором датасете. Убедитесь, что в каждом датасете в полях, которые используются при построении [мультидатасетного чарта](../../datalens/operations/chart/create-multidataset-chart.md), отображаются значения, отличные от `null`.