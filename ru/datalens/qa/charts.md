---
title: Чарты
description: На странице представлены вопросы и ответы про чарты.
alternate:
  - href: ru/datalens/qa/charts.md
    type: text/markdown
    title: Markdown version
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

### Почему в сводной таблице некорректно отображается поле «Итого»? {#incorrect-total-value}

Значения в строках сводной таблицы рассчитываются по тем же формулам, что и агрегация в показателе. В строке с итогами не отображаются расчеты с помощью LOD-выражений, оконных функций и функций для работы с временными рядами.

Подробнее об итогах в сводной таблице читайте в разделе [{#T}](../visualization-ref/pivot-table-chart.md#add-totals).

### Почему значения в полях «Итого» не совпадают с данными {{ metrika }}? {#metrika-total-values}

При запросе через API {{ metrika }} возвращает приблизительные результаты. На точность данных также влияет [сэмплирование](https://yandex.ru/dev/metrika/doc/api2/api_v1/sampling.html). Чтобы аддитивные величины показывали корректные значения в итогах, установите в настройках подключения точность 100%.

Прямое подключение имеет ряд ограничений. Для работы с сырыми данными выгрузите или реплицируйте их в промежуточную базу данных, например [{{ CH }}](../../managed-clickhouse/quickstart.md), а затем [подключите ее](../operations/connection/create-clickhouse.md) к {{ datalens-name }}.

### Что делать, если построение чарта завершается ошибкой `ERR.DS_API.REQUEST_TIMEOUT`? {#request-timeout}

Увеличить время ожидания данных на стороне {{ datalens-name }} нельзя. Разделите наиболее затратные задачи на части или сократите объем данных с помощью фильтров.



### Почему при создании мультидатасетного чарта выводится «null»? {#null-in-multidataset-chart}

Возможные причины:

* Значение `null` сохранено в таблице БД.
* При объединении таблиц значения `null` отображаются, если в одной из таблиц отсутствуют записи, которые соответствуют по условию соединения записям в другой таблице.

Если для каждого датасета должны отображаться значения, отличные от `null`, проверьте:

* Правильно ли выбраны поля при настройке связей между датасетами.
* Не установлены ли фильтры в чарте или датасете, которые могут ограничить итоговую выборку данными только из одного датасета. Удалите фильтры и проверьте отображение записей.
* Условия, которые ограничивают выборку (если для построения датасета используется SQL-запрос).
* Соответствие записей в разных датасетах. Для этого выберите запись из одного датасета и найдите соответствующую по условию соединения запись во втором датасете. Убедитесь, что в каждом датасете в полях, которые используются при построении [мультидатасетного чарта](../../datalens/operations/chart/create-multidataset-chart.md), отображаются значения, отличные от `null`.

### Как добавить регионы на карту? {#add-geodata}


{% include [geointellect-using](../../_includes/datalens/visualization-ref/geointellect-using.md) %}


Пример работы с геоданными можно посмотреть в [руководстве](../tutorials/data-from-csv-geo-visualization.md).


Вы можете приобрести предрассчитанные геослои от партнеров в [{{ datalens-gallery }}]({{ link-datalens-main }}/gallery/all?category=geo).

